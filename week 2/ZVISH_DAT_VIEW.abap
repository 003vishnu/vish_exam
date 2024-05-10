*&---------------------------------------------------------------------*
*& Report ZVISH_DAT_VIEW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_DAT_VIEW.
data : lt_tab type STANDARD TABLE OF ZVISH_VI_VBRK_P,
      wa type ZVISH_VI_VBRK_P.
select * into table lt_tab from ZVISH_VI_VBRK_P.
  loop at lt_tab into wa.
    write :/ wa-VBELN,
wa-FKART,
wa-FKTYP,
wa-VBTYP,
wa-WAERK,
wa-VKORG,
wa-VTWEG,
wa-POSNR,
wa-FKIMG,
wa-VRKME,
wa-MEINS,
wa-SMENG,
wa-VGBEL.
    ENDLOOP.