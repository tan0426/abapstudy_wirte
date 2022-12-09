*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1026
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1026.

INCLUDE ZRSUWON02_CLS.
INCLUDE ZRSUWON02_TOP. "TOP 선언부분 / GROBAL DATA
INCLUDE ZRSUWON02_SCR. "조회조건
INCLUDE ZRSUWON02_PBO. "PBO
INCLUDE ZRSUWON02_PAI. "PAI
INCLUDE ZRSUWON02_F01. "그 밖에 모든 기능

INITIALIZATION.

START-OF-SELECTION.
  PERFORM GET_DATA. "SELECT + DATA 가공

CALL SCREEN 100.
