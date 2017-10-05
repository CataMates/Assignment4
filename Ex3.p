
/*------------------------------------------------------------------------
    File        : Ex3.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Oct 04 12:55:21 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

//Request: Update/delete data on Customer, Order & Order lines using data-sets

{dsCustomer.i}

BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE,?,?).
BUFFER ttOrder:ATTACH-DATA-SOURCE    (DATA-SOURCE srcOrder:HANDLE,?,?).
BUFFER ttOrderLine:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrderLine:HANDLE,?,?).

QUERY qCustomer:QUERY-PREPARE("FOR EACH Customer").

DATASET dsCustomer:FILL().

BUFFER ttCustomer:DETACH-DATA-SOURCE().
BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOrderLine:DETACH-DATA-SOURCE().

//Update the dataset
FIND ttCustomer WHERE ttCustomer.Custnum = 3030.
MESSAGE  "The City for curent customer is: " + ttCustomer.city VIEW-AS ALERT-BOX.
ASSIGN ttCustomer.City = "Timisoara".
MESSAGE  "The City was updated to: " + ttCustomer.city VIEW-AS ALERT-BOX.

//Delete from dataset
FIND ttCustomer WHERE ttCustomer.Custnum = 3035.
DELETE ttCustomer.
IF NOT AVAILABLE ttCustomer THEN DO:
    MESSAGE "The Customer was deleted" VIEW-AS ALERT-BOX.
END.


