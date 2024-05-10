*&---------------------------------------------------------------------*
*& Report ZVISH_CLS_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_cls_1.
*data obj_1 type REF TO ZCL_VISH_GLBL_FIR.
*create object obj_1.
*
*START-OF-SELECTION.
*write :/ obj_1->l1,
*obj_1->l2.
*write zcl_vish_glbl_fir=>l3.

*
*CLASS class_1 DEFINITION.
*  PUBLIC SECTION.
*    DATA l_1 TYPE i VALUE 500.
*    CLASS-DATA S_1 TYPE i VALUE 600.
*ENDCLASS.
*
*DATA obj_1 TYPE REF TO Class_1.
*CREATE OBJECT obj_1.  " INST CONST
*
*START-OF-SELECTION.
*
*  WRITE : / obj_1->l_1,
*  class_1=>s_1.
*
*

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    DATA l1 TYPE i VALUE 20.
    METHODS m1.
    METHODS m2." Declaring methods
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD m1.
    WRITE 'first method'.
  ENDMETHOD.
  METHOD m2.
    WRITE 'second method'.
  ENDMETHOD.
  ENDCLASS.
  START-OF-SELECTION.
  data obj1 type REF TO c1.
  create OBJECT obj1.
  obj1->m1( ).skip 3.
  obj1->m2( ).