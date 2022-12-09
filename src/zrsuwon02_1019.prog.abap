*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1019
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1019.

"DATA 선언
"조회 화면
"INITIALIZATION
"AT SELECTION SCREEN
"START-OF-SELECTION
"END-OF-SELECTION

TABLES : ZTSUWON02_HR.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_ZCODE(10).

DATA : BEGIN OF GS_DATA,
        ZCODE LIKE ZTSUWON02_HR-ZCODE,
        ZNAME LIKE ZTSUWON02_HR-ZNAME,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

SELECT-OPTIONS : S_ZCODE FOR ZTSUWON02_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.

SELECT ZCODE ZNAME
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM ZTSUWON02_HR
  WHERE ZCODE IN S_ZCODE.

CALL SCREEN 100.
*CALL SCREEN 200.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 DATA : LT_UCOMM TYPE TABLE OF SY-UCOMM.

 APPEND 'BUT1' TO LT_UCOMM.

 SET PF-STATUS 'STATUS100' EXCLUDING LT_UCOMM. "버튼 세팅
 SET TITLEBAR 'T100'. "제목 세팅
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "이전 화면으로 넘어간다.
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.
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
