*&---------------------------------------------------------------------*
*& Report ZVISH_STRINGOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVISH_STRINGOP.
*PARAMETERS :P_A(20),
*P_B(20),
*p_c(30).
*
*TRANSLATE P_A TO UPPER CASE .
*
*TRANSLATE P_B TO LOWER CASE .
*
*WRITE P_A.
*WRITE P_B.
*
*CONCATENATE p_a p_b into p_c.
*WRITE P_c.
*data lv_dest(2).
*lv_dest = p_a+3(4).
*write / lv_dest.


PARAMETERS P_SRC(20).

DO.

 IF P_SRC CA ','.
 REPLACE ',' WITH '$' INTO P_SRC.
  ELSE.
    EXIT.
    ENDIF.
 ENDDO.

WRITE P_SRC.