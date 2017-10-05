
/*------------------------------------------------------------------------
    File        : Ex4.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Oct 05 08:57:03 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

//Request:Transmiteti informatiile dintrun dataset intre 2 proceduri 
//prin scrierea si citirea de pe disk a unui .xml 

{dsCustomer.i}

DEFINE VAR cFileName AS CHAR INIT "dsCustomer.xml" NO-UNDO.

BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE,?,?).
BUFFER ttOrder:ATTACH-DATA-SOURCE    (DATA-SOURCE srcOrder:HANDLE,?,?).
BUFFER ttOrderLine:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrderLine:HANDLE,?,?).

QUERY qCustomer:QUERY-PREPARE("FOR EACH Customer WHERE Customer.name = 'Catalin Mates'").

DATASET dsCustomer:FILL().

BUFFER ttCustomer:DETACH-DATA-SOURCE().
BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOrderLine:DETACH-DATA-SOURCE().

//Just DIsplay some stuff to see if the dataset is passed correct between procedures
FIND ttCustomer WHERE ttCustomer.Custnum = 3030.
MESSAGE  "The City for curent customer is: " + ttCustomer.city VIEW-AS ALERT-BOX.

DATASET dsCustomer:WRITE-XML("file",cFileName, TRUE,?,?).

RUN update.p(INPUT cFileName).
















