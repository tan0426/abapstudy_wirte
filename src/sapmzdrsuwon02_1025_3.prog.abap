*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDRSUWON02_1025_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDRSUWON02_1025_3.

CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 100.

DATA : BEGIN OF GS_DATA,
        ZEMPNO TYPE ZDSUWONT02_2-ZEMPNO,
        ZEMPNM TYPE ZDSUWONT02-ZEMPNM,
        ZCERTCD TYPE ZDSUWONT02_2-ZCERTCD,
        ZGDATE TYPE ZDSUWONT02_2-ZGDATE,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

DATA : OK_CODE TYPE SY-UCOMM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  DATA : LV_ZEMPNM LIKE ZDSUWONT02-ZEMPNM.

 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 SELECT *
   INTO CORRESPONDING FIELDS OF TABLE GT_DATA
   FROM ZDSUWONT02_2.

 IF GT_DATA[] IS NOT INITIAL.
   LOOP AT GT_DATA INTO GS_DATA.

     CLEAR LV_ZEMPNM.
     SELECT SINGLE ZEMPNM
       INTO LV_ZEMPNM
       FROM ZDSUWONT02
       WHERE ZEMPNO = GS_DATA-ZEMPNO.
     IF LV_ZEMPNM IS NOT INITIAL.
       GS_DATA-ZEMPNM = LV_ZEMPNM.
     ENDIF.

     MODIFY GT_DATA FROM GS_DATA.
     CLEAR GS_DATA.

   ENDLOOP.

   SORT GT_DATA.
 ENDIF.
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
    IF SCREEN-GROUP1 = 'GR1'.
      SCREEN-INPUT = 0.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.
