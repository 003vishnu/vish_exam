*&---------------------------------------------------------------------*
*& Report ZVISH_CLSCL_REPT_2_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_CLSCL_REPT_2_JOIN NO STANDARD PAGE HEADING LINE-COUNT 20(3) MESSAGE-ID zvish_msg .
INCLUDE zvish_ekk_join_ekp_in.

INITIALIZATION .
  CLEAR : wa, lt_tab.
s_ebeln-low = '4500000001'.
s_ebeln-high = '4500000020'.
append s_ebeln.

AT SELECTION-SCREEN ON s_ebeln.

  SELECT SINGLE ebeln
    INTO l_ebeln
     FROM ekko
  WHERE ebeln IN s_ebeln.

  IF sy-subrc EQ 0.
    MESSAGE s000.
*    * message i002.
  ELSE .
 MESSAGE e001.

 "   message x003.
  ENDIF.
START-OF-SELECTION.
  PERFORM sub1. "select statement
  end-of-SELECTION.

  PERFORM sub2. "looping and writing output
  data lv_count TYPE i.

lv_count = sy-linct - sy-linno.
skip lv_count.
TOP-OF-PAGE.
uline.
 WRITE :/ 'document no',
       20 'company code',
        30 'document ctgy',
        45 'Document Type',
        65 'change date',
        85 'desc'.

ULINE.
end-of-page.
uline.
write:/  'current list page no:' , sy-pagno,
        'Date: ', sy-datum,
        'Time:', sy-uzeit.

FORM sub2 .
  LOOP AT lt_tab INTO wa .
    WRITE :/ wa-ebeln ,
  20 wa-bukrs,
 30 wa-bstyp,
  45 wa-bsart,
  65 wa-AEDAT,
 85 wa-TXZ01.

  ENDLOOP.
ENDFORM.
FORM sub1 .

select ekko~EBELN
ekko~BUKRS
ekko~BSTYP
ekko~BSART
ekpo~STATU
ekpo~AEDAT
ekpo~TXZ01
  into table lt_tab
  from ekko
  inner join ekpo on ekko~ebeln eq ekpo~ebeln
   where ekko~ebeln in s_ebeln.
  IF sy-subrc EQ 0.
    write 'records are found'.

  ELSE .
write 'records are not found'.
ENDIF.
ENDFORM.