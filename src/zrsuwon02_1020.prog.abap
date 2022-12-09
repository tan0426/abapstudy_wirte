*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1020.

INCLUDE ZRSUWON02_1020_TOP. "TOP 선언부분 / GROBAL DATA
INCLUDE ZRSUWON02_1020_SCR. "조회조건
INCLUDE ZRSUWON02_1020_PBO. "PBO
INCLUDE ZRSUWON02_1020_PAI. "PAI
INCLUDE ZRSUWON02_1020_F01. "그밖에 모두 / 기능

INITIALIZATION.
START-OF-SELECTION.
  PERFORM GET_DATA. "SELECT + DATA 가공

CALL SCREEN 100.
