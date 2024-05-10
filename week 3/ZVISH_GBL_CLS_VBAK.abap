*&---------------------------------------------------------------------*
*& Report ZVISH_GBL_CLS_VBAK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_GBL_CLS_VBAK.
data obj1 type REF TO ZCL_VISH_VBAK_DETAIL.
create OBJECT obj1.
data l_vbeln type vbeln.
select-options s_vbeln for l_vbeln.
data lt_tab type ZVISH_VBAK_tT.
CALL METHOD obj1->meth1
  EXPORTING
    lv_vbeln1 = s_vbeln-low
    lv_vbeln2 = s_vbeln-high
 IMPORTING
    gt_tab    = lt_tab
    .

CL_DEMO_OUTPUT=>display( lt_tab ).