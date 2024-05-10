*&---------------------------------------------------------------------*
*& Report ZVISH_FORALL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvish_forall.
INCLUDE zvish_vbak_vbap.

START-OF-SELECTION.
  SELECT  vbeln  ernam audat vbtyp netwr INTO TABLE l_vbak FROM vbak WHERE vbeln IN s_vbeln.
  IF l_vbak[] IS NOT INITIAL. "********
    SELECT  vbeln posnr matnr matwa INTO TABLE  l_vbap FROM vbap
      FOR ALL ENTRIES IN l_vbak "******
      WHERE vbeln = l_vbak-vbeln.
    DELETE ADJACENT DUPLICATES FROM l_vbak COMPARING vbeln.
    SORT l_vbap BY vbeln.
    LOOP AT l_vbak INTO wa_vbak.
      READ TABLE l_vbap INTO wa_vbap WITH KEY vbeln = wa_vbak-vbeln BINARY SEARCH.
      IF sy-subrc = 0.
        MOVE : wa_vbak-vbeln TO wa_final-vbeln,""""""
    wa_vbak-ernam TO wa_final-ernam,"""""""""""""""""""""""
    wa_vbak-audat TO wa_final-audat,""""""""""""""""""""""""""""" adding all the values in wa vbak into final
    wa_vbak-vbtyp TO wa_final-vbtyp,"""""""""""""""""""""""
    wa_vbak-netwr TO wa_final-netwr,"""""""""""""""""

    wa_vbap-posnr TO wa_final-posnr,"""""""
    wa_vbap-matnr TO wa_final-matnr,"""""""""""""" adding all values in n
    wa_vbap-matwa TO wa_final-matwa."""""""


        APPEND wa_final TO L_final.
      ELSE .
        CONTINUE.
      ENDIF.

    ENDLOOP.
    LOOP AT l_final INTO wa_final.
      WRITE :/ wa_final-vbeln,
      wa_final-ernam,
            wa_final-audat,
             wa_final-vbtyp,
             wa_final-netwr ,
             wa_final-posnr ,
             wa_final-matnr ,
             wa_final-matwa .
    ENDLOOP.
  ELSE.
    WRITE 'Records not found'.
  ENDIF.