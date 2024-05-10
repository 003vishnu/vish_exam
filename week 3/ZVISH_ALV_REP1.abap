*&---------------------------------------------------------------------*
*& Report ZVISH_ALV_REP1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_alv_rep1  NO STANDARD PAGE HEADING LINE-COUNT 20(3)
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
  SELECT vbeln ernam  audat vbtyp netwr INTO TABLE l_tab FROM vbak WHERE vbeln IN s_vbeln.

  if sy-subrc eq 0.
    message s000.
  else.
    message e001.
  endif.

 wa_fieldcat-col_pos = '1'.
  wa_fieldcat-seltext_l = 'Sales Document'.
  wa_fieldcat-fieldname = 'vbeln'.
  wa_fieldcat-tabname  = 'L_TAB'.

  append wa_fieldcat to l_fieldcat.
  clear wa_fieldcat.

   wa_fieldcat-col_pos = '2'.
  wa_fieldcat-seltext_l = 'Name of Person'.
  wa_fieldcat-fieldname = 'ernam'.
  wa_fieldcat-tabname  = 'L_TAB'.

  append wa_fieldcat to l_fieldcat.
  clear wa_fieldcat.

 wa_fieldcat-col_pos = '3'.
  wa_fieldcat-seltext_l = 'Document Date'.
  wa_fieldcat-fieldname = 'audat'.
  wa_fieldcat-tabname  = 'L_TAB'.

  append wa_fieldcat to l_fieldcat.
  clear wa_fieldcat.

  wa_fieldcat-col_pos = '4'.
  wa_fieldcat-seltext_l = 'Document Category'.
  wa_fieldcat-fieldname = 'vbtyp'.
  wa_fieldcat-tabname  = 'L_TAB'.

  append wa_fieldcat to l_fieldcat.
  clear wa_fieldcat.

   wa_fieldcat-col_pos = '5'.
  wa_fieldcat-seltext_l = 'Net Value'.
  wa_fieldcat-fieldname = 'netwr'.
  wa_fieldcat-tabname  = 'L_TAB'.

  append wa_fieldcat to l_fieldcat.
  clear wa_fieldcat.
END-OF-SELECTION.

CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK              = ' '
*   I_BYPASSING_BUFFER             =
*   I_BUFFER_ACTIVE                = ' '
   I_CALLBACK_PROGRAM             = sy-repid
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   I_STRUCTURE_NAME               =
*   IS_LAYOUT                      =
   IT_FIELDCAT                    = l_fieldcat
*   IT_EXCLUDING                   =
*   IT_SPECIAL_GROUPS              =
*   IT_SORT                        =
*   IT_FILTER                      =
*   IS_SEL_HIDE                    =
*   I_DEFAULT                      = 'X'
*   I_SAVE                         = ' '
*   IS_VARIANT                     =
*   IT_EVENTS                      =
*   IT_EVENT_EXIT                  =
*   IS_PRINT                       =
*   IS_REPREP_ID                   =
*   I_SCREEN_START_COLUMN          = 0
*   I_SCREEN_START_LINE            = 0
*   I_SCREEN_END_COLUMN            = 0
*   I_SCREEN_END_LINE              = 0
*   IR_SALV_LIST_ADAPTER           =
*   IT_EXCEPT_QINFO                =
*   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IO_SALV_ADAPTER                =
*   O_COMMON_HUB                   =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER        =
*   ES_EXIT_CAUSED_BY_USER         =
  TABLES
    t_outtab                       = l_tab
 EXCEPTIONS
   PROGRAM_ERROR                  = 1
   OTHERS                         = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.