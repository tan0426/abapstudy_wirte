*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSUWON02_1027
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZSUWON02_1027.

CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 100.

DATA : GV_ZEMPNO TYPE ZDSUWONT02-ZEMPNO,
       GV_ZEMPNM TYPE ZDSUWONT02-ZEMPNM.

DATA : BEGIN OF GS_DATA,
        ZEMPNO TYPE ZDSUWONT02_2-ZEMPNO,
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
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 "스크롤이 생성되기 위해서 몇줄 있는지 나타내 주어야 함.
 DESCRIBE TABLE GT_DATA LINES TC100-LINES.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA : LT_ZDSUWONT02_2 LIKE TABLE OF ZDSUWONT02_2 WITH HEADER LINE.
  DATA : LV_ZCERTCD LIKE ZDSUWONT02_2-ZCERTCD.

  CASE OK_CODE.
    WHEN 'DISP'.
      IF GV_ZEMPNO IS NOT INITIAL.
        CLEAR GV_ZEMPNM.
        SELECT SINGLE ZEMPNM
          INTO GV_ZEMPNM
          FROM ZDSUWONT02
          WHERE ZEMPNO = GV_ZEMPNO.

        CLEAR : GT_DATA[].
        SELECT *
          INTO CORRESPONDING FIELDS OF TABLE GT_DATA
          FROM ZDSUWONT02_2
          WHERE ZEMPNO = GV_ZEMPNO.
          IF GT_DATA[] IS NOT INITIAL.
          ELSE.
            MESSAGE '사원의 자격증이 없습니다.' TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
      ENDIF.
    WHEN 'SAVE'.
      IF GV_ZEMPNO IS NOT INITIAL
      AND GT_DATA IS NOT INITIAL.

        LOOP AT GT_DATA INTO GS_DATA WHERE ZCERTCD IS NOT INITIAL
                                     AND ZGDATE IS NOT INITIAL. "값이 있는애인지 더블체크

          CLEAR LV_ZCERTCD.
          SELECT SINGLE ZCERTCD
            INTO LV_ZCERTCD
            FROM ZDSUWONT02_2
            WHERE ZEMPNO = GV_ZEMPNO
            AND ZCERTCD = GS_DATA-ZCERTCD.
          IF LV_ZCERTCD IS NOT INITIAL.
          ELSE.
            MOVE-CORRESPONDING GS_DATA TO LT_ZDSUWONT02_2.
            LT_ZDSUWONT02_2-ZEMPNO = GV_ZEMPNO.
            "생성로그
            LT_ZDSUWONT02_2-ERDAT = SY-DATUM.
            LT_ZDSUWONT02_2-ERZET = SY-UZEIT.
            LT_ZDSUWONT02_2-ERNAM = SY-UNAME.
            APPEND LT_ZDSUWONT02_2. CLEAR LT_ZDSUWONT02_2.
          ENDIF.

        ENDLOOP.

        IF LT_ZDSUWONT02_2[] IS NOT INITIAL.
          INSERT ZDSUWONT02_2 FROM TABLE LT_ZDSUWONT02_2.

          COMMIT WORK.
          IF SY-SUBRC = 0.
            MESSAGE 'SAVE SUCCESS' TYPE 'S'.
          ENDIF.
        ENDIF.
      ENDIF.
    WHEN 'REFR'.
      CLEAR : GV_ZEMPNO, GV_ZEMPNM, GS_DATA, GT_DATA[].
*  	WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ABAP_TO_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE abap_to_screen OUTPUT.
  READ TABLE GT_DATA INTO GS_DATA INDEX TC100-CURRENT_LINE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SCREEN_TO_ABAP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE screen_to_abap INPUT.
  IF TC100-LINES < TC100-CURRENT_LINE.
    "추가
    INSERT GS_DATA INTO GT_DATA INDEX TC100-CURRENT_LINE.
  ELSE.
    "있는 값을 뿌려주는 것
    MODIFY GT_DATA FROM GS_DATA INDEX TC100-CURRENT_LINE.
  ENDIF.

  MODIFY GT_DATA FROM GS_DATA INDEX TC100-CURRENT_LINE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_command INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANC' OR 'EXIT'.
      LEAVE PROGRAM.
*  	WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.
ENDMODULE.
