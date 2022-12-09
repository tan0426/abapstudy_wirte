*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDSUWON02_TEST_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzdsuwon02_test_03.

CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 100.

DATA : BEGIN OF GS_DATA,
        ZCHK,
        ZEMPNO TYPE ZDSUWONT02-ZEMPNO,
        ZEMPNM TYPE ZDSUWONT02-ZEMPNM,
        ZGENDER TYPE ZDSUWONT02-ZGENDER,
        ZDEPT TYPE ZDSUWONT02-ZDEPT,
        ZSDATE TYPE ZDSUWONT02-ZSDATE,
        ZFAMNO TYPE ZDSUWONT02-ZFAMNO,
        ZDELE TYPE ZDSUWONT02-ZDELE,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

DATA : ZSDATE_LOW TYPE DATUM,
       ZSDATE_HIGH TYPE DATUM.

DATA : OK_CODE TYPE SY-UCOMM.

RANGES : R_ZSDATE FOR ZDSUWONT02-ZSDATE.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.


 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 DESCRIBE TABLE GT_DATA LINES TC100-LINES.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA : GT_ZDSUWONT02 LIKE TABLE OF ZDSUWONT02 WITH HEADER LINE.

  CASE OK_CODE.
    WHEN 'SAVE'.
      LOOP AT GT_DATA INTO GS_DATA.
        IF GS_DATA-ZCHK IS NOT INITIAL.
          SELECT SINGLE *
            INTO CORRESPONDING FIELDS OF GT_ZDSUWONT02
            FROM ZDSUWONT02
            WHERE ZEMPNO = GS_DATA-ZEMPNO.

          IF SY-SUBRC = 0.
            MOVE-CORRESPONDING GS_DATA TO GT_ZDSUWONT02.

            "변경 로그
            GT_ZDSUWONT02-AEDAT = SY-DATUM.
            GT_ZDSUWONT02-AEZET = SY-UZEIT.
            GT_ZDSUWONT02-AENAM = SY-UNAME.

            APPEND GT_ZDSUWONT02.
            CLEAR GT_ZDSUWONT02.
          ENDIF.

          IF GT_ZDSUWONT02[] IS NOT INITIAL.
            MODIFY ZDSUWONT02 FROM TABLE GT_ZDSUWONT02.
            COMMIT WORK.

            IF SY-SUBRC = 0.
              MESSAGE '저장 성공' TYPE 'S'.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.

    WHEN 'DISP'.
    CLEAR : R_ZSDATE, R_ZSDATE[].

    IF ZSDATE_LOW IS NOT INITIAL
    AND ZSDATE_HIGH IS NOT INITIAL.
      R_ZSDATE-SIGN = 'I'.
      R_ZSDATE-OPTION = 'BT'.
      R_ZSDATE-LOW = ZSDATE_LOW.
      R_ZSDATE-HIGH = ZSDATE_HIGH.
      APPEND R_ZSDATE.
    ELSEIF ZSDATE_LOW IS NOT INITIAL
    AND ZSDATE_HIGH IS INITIAL.
      R_ZSDATE-SIGN = 'I'.
      R_ZSDATE-OPTION = 'GE'.
      R_ZSDATE-LOW = ZSDATE_LOW.
      APPEND R_ZSDATE.
    ENDIF.

    IF R_ZSDATE[] IS NOT INITIAL.
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE GT_DATA
        FROM ZDSUWONT02
        WHERE ZSDATE IN R_ZSDATE[].

      SORT GT_DATA.
    ENDIF.

    WHEN 'REFR'.
      LOOP AT GT_DATA INTO GS_DATA.
        GS_DATA-ZCHK = ''.
        MODIFY GT_DATA FROM GS_DATA.
        CLEAR GS_DATA.
      ENDLOOP.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_TC100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_tc100 OUTPUT.
  LOOP AT SCREEN.

    "사원번호 칼럼 비활성화
    IF SCREEN-NAME = 'GS_DATA-ZEMPNO'.
      SCREEN-INPUT = 0.
    ENDIF.

    "퇴사자 라인 비활성화
    IF GS_DATA-ZDELE IS NOT INITIAL.
      IF SCREEN-GROUP1 = 'GR1'.
        SCREEN-INPUT = 0.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
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
*& Module INIT_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_screen OUTPUT.
  LOOP AT SCREEN.
    IF SCREEN-NAME = 'ZSDATE_LOW'.
      SCREEN-REQUIRED = 1.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
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
