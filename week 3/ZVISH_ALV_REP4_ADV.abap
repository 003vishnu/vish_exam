*&---------------------------------------------------------------------*
*& Report ZVISH_ALV_REP4_ADV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_ALV_REP4_ADV  NO STANDARD PAGE HEADING LINE-COUNT 20(3)
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
  perform give_val using lv_count text-001 c1 c.
  perform give_val using lv_count text-002 c2 c.
  perform give_val using lv_count text-003 c3 c.
  perform give_val using lv_count text-004 c4 c.
  perform give_val using lv_count text-005 c5 c.

ENDFORM.

FORM calling_fm .
  TY_LAYOUT-zebra = 'X'.
*   ty_layout-no_colhead = 'X'.
*  ty_layout-no_vline = 'X' .
*  ty_layout-no_hline = 'X'.
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
     IS_LAYOUT          = TY_LAYOUT
      it_fieldcat        = L_FIELDCAT
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
*&---------------------------------------------------------------------*
*& Form give_val
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_COUNT
*&      --> TEXT_001
*&      --> C1
*&      --> C
*&---------------------------------------------------------------------*
FORM give_val  USING    p_lv_count
                        p_text_001
                        p_c1
                        p_c.

  wa_fieldcat-col_pos = lv_count.
  lv_count = lv_count + 1.
  wa_fieldcat-seltext_l = p_text_001.
  wa_fieldcat-fieldname = p_c1.
  wa_fieldcat-tabname  = p_c.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.

ENDFORM.