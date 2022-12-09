FUNCTION ZFCSUWON02_CAL.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUM1) TYPE  I
*"     REFERENCE(IV_NUM2) TYPE  I
*"     REFERENCE(IV_CHAR) TYPE  C
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  I
*"  EXCEPTIONS
*"      DIVIDE0
*"----------------------------------------------------------------------
IF  IV_CHAR = '+'.
  EV_RESULT = IV_NUM1 + IV_NUM2.
ELSEIF IV_CHAR ='-'.
  EV_RESULT = IV_NUM1 - IV_NUM2.
ELSEIF IV_CHAR = '*'.
  EV_RESULT = IV_NUM1 * IV_NUM2.
ELSEIF IV_CHAR = '/'.

  IF IV_NUM2 = 0.
    RAISE DIVIDE0.
    EXIT.
  ENDIF.

  EV_RESULT = IV_NUM1 / IV_NUM2.

ENDIF.




ENDFUNCTION.
