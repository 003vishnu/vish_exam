
*&---------------------------------------------------------------------*
*& Report ZVISH_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_join.
TYPES : BEGIN OF s_vtab,
          kunnr	TYPE kunnr,
          land1 TYPE  land1_gp,
          name1 TYPE  name1_gp,
          ort01	TYPE ort01_gp,
        END OF s_vtab.
data : lv_tab type STANDARD TABLE OF s_vtab,
      wa type s_vtab,
      l_kunnr type kunnr.
SELECT-OPTIONS s_kunnr for l_kunnr OBLIGATORY.
PARAMETERS p_land type  land1_gp.

START-OF-SELECTION.
select kunnr land1 name1 ort01
  into table lv_tab
  from kna1
  where kunnr in s_kunnr and land1 eq p_land.

  IF sy-subrc EQ 0.
    WRITE : / 'records are found in kna1 table ', sy-dbcnt.
  ELSE.
    WRITE : / 'records are not found in kna1 table ', sy-dbcnt.
  ENDIF.
  end-of-selection.

WRITE : / 'ROW NO',
         10 'CUST NO',
         30 'CUST NAME',
         50 'CITY',
         75 'Region Key'.

ULINE.
  loop at lv_tab INTO wa.
   write :/3 sy-tabix, 10 wa-kunnr,30 wa-land1 , 50 wa-name1 , 75 wa-ort01.
   ENDLOOP.