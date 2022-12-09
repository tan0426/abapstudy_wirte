*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDSUWON02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDSUWON02.

TABLES : ZDSUWONT02.

DATA : TEXT1 TYPE C LENGTH 10,
       TEXT2 TYPE C LENGTH 10,
       TEXT3 TYPE C LENGTH 20.

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
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
    WHEN 'CANCLE'.
      LEAVE PROGRAM.
    WHEN 'CROS'.
      CONCATENATE TEXT1 TEXT2 INTO TEXT3.
    WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'PF200'.
 SET TITLEBAR '부서 검색'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CROS'.
      SELECT SINGLE ZEMPNM ZDEPT ZSDATE
        INTO ( ZDSUWONT02-ZEMPNM, ZDSUWONT02-ZDEPT, ZDSUWONT02-ZSDATE )
        FROM ZDSUWONT02
        WHERE ZEMPNO = ZDSUWONT02-ZEMPNO.
*  	WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.
ENDMODULE.
