*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1024
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1024.

"HR->HR_T
"1. HR SELECT
"2. HR_T DELETE
"3. MODIFY
"DATA 선언
"조회조건
"INITIALIZATION
"START-OF-SELECTION.
"출력 X

DATA : GT_ZTSUWON02_HR TYPE TABLE OF ZTSUWON02_HR.
DATA : GT_ZTSUWON02_HR_T TYPE TABLE OF ZTSUWON02_HR_T.

PARAMETERS : P_CHAR TYPE CHAR10.

INITIALIZATION.

START-OF-SELECTION.
  IF P_CHAR <> 'BACKGROUND'.
    MESSAGE 'CANT RUN' TYPE 'E'.
  ENDIF.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_ZTSUWON02_HR
    FROM ZTSUWON02_HR.

  DELETE FROM ZTSUWON02_HR_T.

  IF GT_ZTSUWON02_HR IS NOT INITIAL.
    "HR -> HR_T
    GT_ZTSUWON02_HR_T = GT_ZTSUWON02_HR.
    "GT_ZTSUWON02_HR_T[] = GT_ZTSUWON02_HR. 헤더가 있으면 이것도 지정해줘야함.

    MODIFY ZTSUWON02_HR_T FROM TABLE GT_ZTSUWON02_HR_T.
    IF SY-SUBRC = 0.
      IF SY-BATCH IS NOT INITIAL. "백그라운드 실행되고 있는지
        MESSAGE '[BATCH] SUCCESS' TYPE 'S'.
      ELSE.
        MESSAGE 'MODIFY SUCCESS' TYPE 'S'.
      ENDIF.
    ENDIF.
  ENDIF.
"출력 X
