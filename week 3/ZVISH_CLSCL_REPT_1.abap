*&---------------------------------------------------------------------*
*& Report ZVISH_CLSCL_REPT_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_clscl_rept_1 NO STANDARD PAGE HEADING LINE-COUNT 20(3).
INCLUDE zvish_ekko_in.

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
    MESSAGE s000(zvish_msg).
  ELSE .
    MESSAGE e001(zvish_msg).
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
       30 'company code',
        50 'document category',
        70 'Document Type'.

ULINE.
end-of-page.
uline.
write:/  'current list page no:' , sy-pagno,
        'Date: ', sy-datum,
        'Time:', sy-uzeit.
FORM sub1 .
  SELECT ebeln bukrs bstyp bsart
    INTO TABLE lt_tab
    FROM ekko
  WHERE ebeln IN s_ebeln .
ENDFORM.
FORM sub2 .
  LOOP AT lt_tab INTO wa .
    WRITE :/ wa-ebeln ,
  30 wa-bukrs,
 50 wa-bstyp,
  70 wa-bsart.
  ENDLOOP.
ENDFORM.