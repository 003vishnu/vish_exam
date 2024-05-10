*&---------------------------------------------------------------------*
*& Report ZVISH_INT_REPO_EKKO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_int_repo_ekko NO STANDARD PAGE HEADING LINE-COUNT 20(3).
INCLUDE zvish_ekko_interact_inc.

INITIALIZATION .
  CLEAR : wa, lt_tab.
  s_ebeln-low = '4500000001'.
  s_ebeln-high = '4500000020'.
  APPEND s_ebeln.

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

END-OF-SELECTION.

  PERFORM sub2. "looping and writing output
  DATA lv_count TYPE i.

  lv_count = sy-linct - sy-linno.
  SKIP lv_count.

TOP-OF-PAGE.
  ULINE.
  WRITE :/ 'document no',
        30 'company code',
         50 'document category',
         70 'Document Type'.

  ULINE.

END-OF-PAGE.
  ULINE.
  WRITE:/  'current list page no:' , sy-pagno,
          'Date: ', sy-datum,
          'Time:', sy-uzeit.

AT LINE-SELECTION.

  CASE sy-lsind.
    WHEN 1.

      SELECT  ebeln bukrs bstyp
      INTO TABLE lt_Tab1
      FROM ekko
      WHERE ebeln EQ wa-ebeln.   " hide stmt

      LOOP AT lt_tab1 INTO wa1.
        WRITE : /3 wa1-ebeln HOTSPOT,
                 20 wa1-bukrs,
                 40 wa1-bstyp.
        HIDE wa1-ebeln.

      ENDLOOP.
       WHEN 2.

      SELECT  ebeln aedat matkl
      INTO TABLE lt_Tab2
      FROM ekpo
      WHERE ebeln EQ wa1-ebeln.   " hide stmt

      LOOP AT lt_tab2 INTO wa2.
        WRITE : /3 wa2-ebeln HOTSPOT,
                 30 wa2-aedat,
                 40 wa2-matkl.


      ENDLOOP.

  ENDCASE.

TOP-OF-PAGE DURING LINE-SELECTION.
  CASE sy-lsind.
when 1 .
 uline.
 WRITE :/3 'document no',
        30 'company code',
         40 'document category'.
  ENDCASE.

FORM sub1 .
  SELECT ebeln bukrs bstyp bsart
  INTO TABLE lt_tab
  FROM ekko
  WHERE ebeln IN s_ebeln .
ENDFORM.
FORM sub2 .
  LOOP AT lt_tab INTO wa .
    WRITE :/ wa-ebeln HOTSPOT ,
  30 wa-bukrs,
 50 wa-bstyp,
  70 wa-bsart.
    HIDE wa-ebeln.
  ENDLOOP.
ENDFORM.