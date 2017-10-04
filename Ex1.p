
/*------------------------------------------------------------------------
    File        : Ex1.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Oct 02 11:02:27 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */

//Request:Fill dataset with data from Customer, Order & Order lines for a specific customer using datasets
    
{dsCustomer.i}

BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE,?,?).
BUFFER ttOrder:ATTACH-DATA-SOURCE    (DATA-SOURCE srcOrder:HANDLE,?,?).
BUFFER ttOrderLine:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrderLine:HANDLE,?,?).

QUERY qCustomer:QUERY-PREPARE("FOR EACH Customer WHERE Customer.Name = " +  cName).

DATASET dsCustomer:FILL().

BUFFER ttCustomer:DETACH-DATA-SOURCE().
BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOrderLine:DETACH-DATA-SOURCE().

FOR EACH ttCustomer:
    DISPLAY 
        ttCustomer.Name
        ttCustomer.Custnum.
    FOR EACH ttOrder OF ttCustomer:
        DISPLAY 
            ttOrder.Custnum
            ttOrder.OrderNum.
        FOR EACH ttOrderLine OF ttOrder:
            DISPLAY
                ttOrderLine.OrderNum
                ttOrderLine.Linenum
                ttOrderLine.ExtendedPrice.
        END.
    END.
END.


