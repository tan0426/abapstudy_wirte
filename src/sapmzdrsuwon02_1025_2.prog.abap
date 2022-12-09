*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDRSUWON02_1025_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDRSUWON02_1025_2.

"테이블컨트롤 및 스크린 필드 강의
CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 100.

DATA : BEGIN OF GS_DATA,
        ZEMPNO TYPE ZDSUWONT02-ZEMPNO,
        ZEMPNM TYPE ZDSUWONT02-ZEMPNM,
        ZGENDER TYPE ZDSUWONT02-ZGENDER,
        ZDEPT LIKE ZDSUWONT02-ZDEPT,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

DATA : OK_CODE TYPE SY-UCOMM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 CLEAR GT_DATA.
 SELECT *
   INTO CORRESPONDING FIELDS OF TABLE GT_DATA
   FROM ZDSUWONT02.

 SORT GT_DATA.

 "테이블 컨트롤 스크롤 생성 -> 뿌려줄 인터널테이블 총 라인수
 DESCRIBE TABLE GT_DATA LINES TC100-LINES.

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
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MOVE_ABAP_TO_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_abap_to_screen OUTPUT.
  READ TABLE GT_DATA INTO GS_DATA INDEX TC100-CURRENT_LINE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MOVE_SCREEN_TO_ABAP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE move_screen_to_abap INPUT.
  MODIFY GT_DATA FROM GS_DATA INDEX TC100-CURRENT_LINE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_TC100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_tc100 OUTPUT.
  LOOP AT SCREEN.
    IF SCREEN-NAME = 'GS_DATA-ZEMPNO'.
      SCREEN-INPUT = 0.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.
