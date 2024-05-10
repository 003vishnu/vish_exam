*&---------------------------------------------------------------------*
*& Report ZVISH_FGRP1_FORSUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_FGRP1_FORSUM.
parameters : lv_a type I,
      lv_b type I.
data lv_sum type I.
CALL FUNCTION 'ZVISH_FIRST'
 EXPORTING
   P_A           = lv_a
   P_B           = lv_b
 IMPORTING
   P_SUM         = lv_sum
          .
write lV_sum.