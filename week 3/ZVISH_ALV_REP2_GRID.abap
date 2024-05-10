*&---------------------------------------------------------------------*
*& Report ZVISH_ALV_REP2_GRID
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_alv_rep2_grid   NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 500 MESSAGE-ID zvish_msg.
INCLUDE zvish_for_vbak_alvrep.
SELECT-OPTIONS s_vbeln FOR l_vbeln OBLIGATORY.
DATA lv_vbeln TYPE vbeln.

INITIALIZATION.
  CLEAR: l_tab,  l_fieldcat,  wa_FIELDCAT.
  s_vbeln-low = '0000000025'.
  s_vbeln-high = '0000000040'.
  APPEND s_vbeln.

AT SELECTION-SCREEN ON s_vbeln.

  SELECT SINGLE vbeln
    INTO lv_vbeln
     FROM vbak
  WHERE vbeln IN s_vbeln.

  IF sy-subrc EQ 0.
    MESSAGE s000.
  ELSE.
    MESSAGE e001.
  ENDIF.

START-OF-SELECTION.
  PERFORM select_data.
  PERFORM for_header.

END-OF-SELECTION.
  PERFORM calling_fm.

FORM select_data .
  SELECT vbeln ernam  audat vbtyp netwr INTO TABLE l_tab FROM vbak WHERE vbeln IN s_vbeln.

  IF sy-subrc EQ 0.
    MESSAGE s000.
  ELSE.
    MESSAGE e001.
  ENDIF.

ENDFORM.

FORM for_header .

  wa_fieldcat-col_pos = '1'.
  wa_fieldcat-seltext_l = 'Sales Document'.
  wa_fieldcat-fieldname = 'vbeln'.
  wa_fieldcat-tabname  = 'L_TAB'.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-col_pos = '2'.
  wa_fieldcat-seltext_l = 'Name of Person'.
  wa_fieldcat-fieldname = 'ernam'.
  wa_fieldcat-tabname  = 'L_TAB'.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-col_pos = '3'.
  wa_fieldcat-seltext_l = 'Document Date'.
  wa_fieldcat-fieldname = 'audat'.
  wa_fieldcat-tabname  = 'L_TAB'.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-col_pos = '4'.
  wa_fieldcat-seltext_l = 'Document Category'.
  wa_fieldcat-fieldname = 'vbtyp'.
  wa_fieldcat-tabname  = 'L_TAB'.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-col_pos = '5'.
  wa_fieldcat-seltext_l = 'Net Value'.
  wa_fieldcat-fieldname = 'netwr'.
  wa_fieldcat-tabname  = 'L_TAB'.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.
ENDFORM.

FORM calling_fm .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
      i_grid_title       = 'Sales order details'
*     I_GRID_SETTINGS    =
*     IS_LAYOUT          =
      it_fieldcat        = l_fieldcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER           =
*     O_COMMON_HUB       =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = l_tab
* EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.