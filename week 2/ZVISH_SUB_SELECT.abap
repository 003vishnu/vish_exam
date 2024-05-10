*&---------------------------------------------------------------------*
*& Report ZVISH_SUB_SELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_SUB_SELECT.
INCLUDE ZVISH_DEC_FOR_KNA1.
WRITE : / 'ROW NO',
         10 'CUST NO',
         30 'CUST NAME',
         50 'CITY',
         75 'Region Key'.
ULINE.
PERFORM sub2.
perform sub3.
FORM sub2 .

select kunnr land1 name1 ort01
  into table lv_tab
  from kna1
  where kunnr in s_kunnr and land1 eq p_land.

  IF sy-subrc EQ 0.
    WRITE : / 'records are found in kna1 table ', sy-dbcnt.
  ELSE.
    WRITE : / 'records are not found in kna1 table ', sy-dbcnt.
  ENDIF.

ENDFORM.

FORM sub3 .
 loop at lv_tab INTO wa.
   write :/3 sy-tabix, 10 wa-kunnr,30 wa-land1 , 50 wa-name1 , 75 wa-ort01.
   ENDLOOP.

ENDFORM.