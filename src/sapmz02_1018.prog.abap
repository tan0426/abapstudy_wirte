*&---------------------------------------------------------------------*
*& Module Pool      SAPMZ02_1018
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZ02_1018.

TABLES : ZDSUWONT02.

DATA : OK_CODE TYPE SY-UCOMM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'PF100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'DISP'.

      SELECT SINGLE ZEMPNM ZDEPT ZSDATE
        INTO ( ZDSUWONT02-ZEMPNM, ZDSUWONT02-ZDEPT, ZDSUWONT02-ZSDATE )
        FROM ZDSUWONT02
        WHERE ZEMPNO = ZDSUWONT02-ZEMPNO.

*  	WHEN OTHERS.
  ENDCASE.
  CLEAR OK_CODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_DISPLAY OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_display OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  LOOP AT SCREEN.
    IF SCREEN-NAME = 'GV_ZCODE'.
      SCREEN-INPUT = 0.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.
