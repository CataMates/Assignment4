
/*------------------------------------------------------------------------
    File        : dsCustomer.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 03 16:46:10 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */


DEFINE TEMP-TABLE ttCustomer  LIKE Customer BEFORE-TABLE ttCustomerBefore.
DEFINE TEMP-TABLE ttOrder     LIKE Order.
DEFINE TEMP-TABLE ttOrderLine LIKE OrderLine.
 
DEFINE QUERY qCustomer FOR Customer.
DEFINE QUERY qOrder    FOR Order, Customer.

DEFINE DATASET dsCustomer FOR ttCustomer, ttOrder, ttOrderLine.
/*    DATA-RELATION OrderLine FOR ttOrder, ttOrderLine*/
/*        RELATION-FIELDS (OrderNum, OrderNum)        */
/*    DATA-RELATION Order FOR ttCustomer, ttOrder     */
/*        RELATION-FIELDS(CustNum, CustNum).          */


DEFINE DATA-SOURCE srcOrderLine FOR OrderLine.
DEFINE DATA-SOURCE srcOrder     FOR Order.

DEFINE DATA-SOURCE srcCustomer  FOR QUERY qCustomer.