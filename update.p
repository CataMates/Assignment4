
/*------------------------------------------------------------------------
    File        : update.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Oct 05 09:23:14 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */


//Reading the XML file. accessing and printing ttCustomer's table fields

DEFINE INPUT PARAMETER cFile        AS CHAR NO-UNDO.
DEFINE VAR hdsCustomer2             AS HANDLE NO-UNDO.
DEFINE VAR customerBufferHandle     AS HANDLE NO-UNDO.
DEFINE VARIABLE queryHandleCustomer AS HANDLE NO-UNDO.

CREATE DATASET hdsCustomer2.
MESSAGE "Here" VIEW-AS ALERT-BOX.
hdsCustomer2:READ-XML("file",cFile,"empty","",?,?).
customerBufferHandle = hdsCustomer2:GET-BUFFER-HANDLE("ttcustomer").


CREATE QUERY queryHandleCustomer.
queryHandleCustomer:SET-BUFFERS(customerBufferHandle).
queryHandleCustomer:QUERY-PREPARE("for each ttcustomer").
queryHandleCustomer:FORWARD-ONLY = TRUE.
queryHandleCustomer:QUERY-OPEN() NO-ERROR.

REPEAT:
    queryHandleCustomer:GET-NEXT().
    IF queryHandleCustomer:QUERY-OFF-END THEN
      LEAVE.
    MESSAGE customerBufferHandle::NAME
    VIEW-AS ALERT-BOX.
END.
MESSAGE "start"
VIEW-AS ALERT-BOX.
/*FIND ttCustomer WHERE ttCustomer.Custnum = 3030.                                 */
/*MESSAGE  "The City for curent customer is: " + ttCustomer.city VIEW-AS ALERT-BOX.*/



