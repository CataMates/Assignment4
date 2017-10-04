
/*------------------------------------------------------------------------
    File        : Ex2.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 03 17:06:33 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

//Request: Creati o functie care primeste ca si input un temp-table Customer 
//apoi parcurce recordurile care au fost sterse din temp-table , pentru 
//fiecare customer sters sa se verifice daca exista recorduri in tabela 
//Order pentru acel customer , daca exista sa se puna un mesaj de eroare 
//pe ecran:  Customer “X” has active orders and cannot be deleted

{dsCustomer.i}

DEFINE VAR ordersNull AS LOGICAL NO-UNDO.


DEFINE TEMP-TABLE ttCustomer2 LIKE Customer BEFORE-TABLE ttCustomerBefore2.



BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE,?,?).
BUFFER ttOrder:ATTACH-DATA-SOURCE    (DATA-SOURCE srcOrder:HANDLE,?,?).
BUFFER ttOrderLine:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrderLine:HANDLE,?,?).

QUERY qCustomer:QUERY-PREPARE("FOR EACH Customer").

DATASET dsCustomer:FILL().

BUFFER ttCustomer:DETACH-DATA-SOURCE().
BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOrderLine:DETACH-DATA-SOURCE().

TEMP-TABLE ttCustomer:TRACKING-CHANGES = TRUE.

FOR EACH ttCustomer WHERE ttCustomer.Name = "Catalin Mates":
    IF AVAILABLE ttCustomer THEN DO:
        DELETE ttCustomer.
    END.
END.
TEMP-TABLE ttCustomer:TRACKING-CHANGES = FALSE.

FUNCTION canBeDeleted RETURN LOGICAL(INPUT TABLE ttCustomer2, INPUT TABLE ttCustomerBefore2):

    FOR EACH ttCustomerBefore2:
        FIND FIRST ttCustomer2 WHERE ROWID(ttCustomer2) = BUFFER ttCustomerBefore2:AFTER-ROWID NO-ERROR.
        
       IF NOT AVAILABLE ttCustomer2 THEN DO: 
            ASSIGN ordersNull = TRUE.                                  
            FOR EACH ttOrder:
                IF ttOrder.CustNum = ttCustomerBefore2.Custnum THEN DO:
                    ASSIGN ordersNull = FALSE.
                    LEAVE.
                END.                
            END.
            IF ordersNull = FALSE THEN DO:
                MESSAGE "Customer " + STRING(ttCustomerBefore2.Name) + " has active orders and cannot be deleted!" VIEW-AS ALERT-BOX.
            END.
            ELSE DO:
                MESSAGE "Customer has been deleted" VIEW-AS ALERT-BOX.
            END.
        END.
    END.
END FUNCTION.

canBeDeleted(TABLE ttCustomer, TABLE ttCustomerBefore).

