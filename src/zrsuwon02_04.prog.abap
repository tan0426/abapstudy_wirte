*&---------------------------------------------------------------------*
*& Report ZRSUWON02_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_04.

DATA : GV_RESULT TYPE I.

CALL FUNCTION 'ZFCSUWON02_CAL'
  EXPORTING
    iv_num1         = 2
    iv_num2         = 3
    iv_char         = '+' "TYPE 맞춰 줘야함. 그렇지 않으면 덤프
  IMPORTING  "FUNCTION 에서 EXPORTING 된 값을 IMPORT로 받는것
    EV_RESULT       = GV_RESULT.

WRITE : / GV_RESULT.

DATA : GV_NUM1 TYPE I,
       GV_NUM2 TYPE I,
       GV_CHAR.

GV_NUM1 = 5.
GV_NUM2 = 3.
GV_CHAR = '-'.

CALL FUNCTION 'ZFCSUWON02_CAL'
  EXPORTING
    iv_num1         = GV_NUM1
    iv_num2         = GV_NUM2
    iv_char         = GV_CHAR
  IMPORTING
    EV_RESULT       = GV_RESULT.

WRITE : / GV_RESULT.

GV_NUM1 = 3.
GV_NUM2 = 1.
GV_CHAR = '/'.

CALL FUNCTION 'ZFCSUWON02_CAL'
  EXPORTING
    iv_num1         = GV_NUM1
    iv_num2         = GV_NUM2
    iv_char         = GV_CHAR
  IMPORTING
    EV_RESULT       = GV_RESULT
  EXCEPTIONS
    DIVIDE0         = 1
    OTHERS          = 2 .

IF sy-subrc = 1.
* Implement suitable error handling here
  MESSAGE 'DIVIDE0 ERROR.' TYPE 'S' DISPLAY LIKE 'E'.
ELSEIF SY-subrc = 2.
  MESSAGE 'OTHER ERROR' TYPE 'S' DISPLAY LIKE 'E'.
ELSEIF SY-subrc = 0.
  MESSAGE 'CORRECT DIVIDE' TYPE 'S'.
ENDIF.

*
*IF sy-subrc <> 0.
** Implement suitable error handling here
*  MESSAGE 'DIVIDE0 ERROR.' TYPE 'S' DISPLAY LIKE 'E'.
*ENDIF.
