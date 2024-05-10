*&---------------------------------------------------------------------*
*& Report ZVISH_ALV_REP5_HEIRARCHY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_alv_rep5_heirarchy   NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 500 MESSAGE-ID zvish_msg.
INCLUDE zvish_for_vbak_alvrep_h.
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
  SELECT vbeln ernam  audat  INTO CORRESPONDING FIELDS OF  TABLE l_tab FROM vbak WHERE vbeln IN s_vbeln.

  IF sy-subrc EQ 0.
    MESSAGE s000.
  ELSE.
    MESSAGE e001.
  ENDIF.

  SELECT vbeln
   posnr
  matnr
  FROM vbap
  INTO TABLE l_tab2
  WHERE vbeln IN s_vbeln.

ENDFORM.

FORM for_header .
  PERFORM give_val1 USING lv_count t_name c1 c.
  PERFORM give_val1 USING lv_count t_name c2 c.
  PERFORM give_val1 USING lv_count t_name c3 c.

  lv_count = 1.

  PERFORM give_val1 USING lv_count t2_name c6 lc.
  PERFORM give_val1 USING lv_count t2_name c7 lc.
  PERFORM give_val1 USING lv_count t2_name c8 lc.

ENDFORM.

FORM calling_fm .
*  ty_layout-zebra = 'X'.
  it_key-header01 =  'VBELN'.
  ty_layout-expand_fieldname = 'BUTTON'.
*   ty_layout-no_colhead = 'X'.
*  ty_layout-no_vline = 'X' .
*  ty_layout-no_hline = 'X'.
  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
      is_layout          = ty_layout
     IT_FIELDCAT        = l_fieldcat[]
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE  = 0
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
      i_tabname_header   = 'L_TAB'
      i_tabname_item     = 'L_TAB2'
*     I_STRUCTURE_NAME_HEADER        =
*     I_STRUCTURE_NAME_ITEM          =
      is_keyinfo         = IT_KEY
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     IS_HIERSEQ_SETTINGS            =
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE    =
*     IR_SALV_HIERSEQ_ADAPTER        =
*     IT_EXCEPT_QINFO    =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*     I_LIST_DISPLAY_ONLY            = ABAP_FALSE
*     O_COMMON_HUB       =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    TABLES
      t_outtab_header    = L_TAB
      t_outtab_item      = L_TAB2
*   EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
FORM give_val1  USING    p_lv_count
                         p_t_name
                         p_c1
                         p_c.
  wa_fieldcat-col_pos = lv_count.
  lv_count = lv_count + 1.
  wa_fieldcat-fieldname = p_c1.
  wa_fieldcat-tabname  = p_c.
  wa_fieldcat-ref_fieldname = p_c1.
  wa_fieldcat-ref_tabname = p_t_name.

  APPEND wa_fieldcat TO l_fieldcat.
  CLEAR wa_fieldcat.


ENDFORM.