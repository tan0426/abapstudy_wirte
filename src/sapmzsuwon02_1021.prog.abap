*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSUWON02_1021
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzsuwon02_1021.

DATA : ok_code TYPE sy-ucomm,
       save_ok TYPE sy-ucomm.

DATA : BEGIN OF gs_itab,
        zempno TYPE zdsuwont02-zempno,
        zempnm TYPE zdsuwont02-zempnm,
        zgender TYPE zdsuwont02-zgender,
        zdept TYPE zdsuwont02-zdept,
        zsdate TYPE zdsuwont02-zsdate,
        zfamno TYPE zdsuwont02-zfamno,
        zdele TYPE zdsuwont02-zdele,
  "200스크린
        ZBIRTH TYPE zdsuwont02-ZBIRTH,
        ZHOME TYPE zdsuwont02-ZHOME,
        ZPHONE TYPE zdsuwont02-ZPHONE,
        ZOFFNO TYPE zdsuwont02-ZOFFNO,
        ZMARRID TYPE zdsuwont02-ZMARRID,
       END OF gs_itab,
       gt_itab LIKE TABLE OF gs_itab.

DATA : gv_zdsuwont02 TYPE zdsuwont02.

DATA : LV_GENTEXT TYPE C LENGTH 4.
DATA : LV_ZDTEXT TYPE C LENGTH 15.

INITIALIZATION.
START-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA : lv_zempno TYPE zdsuwont02-zempno,
       lv_error,
       lv_len TYPE i,
       lv_zdept TYPE zdsuwont02_3-zdept,
       lv_answer.

  save_ok = ok_code.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANC'.
      LEAVE PROGRAM.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'DISP'.
      SELECT SINGLE *
        INTO CORRESPONDING FIELDS OF gs_itab
        FROM zdsuwont02
        WHERE zempno = gs_itab-zempno.

      IF sy-subrc = 0.
        IF GS_ITAB-zgender = '남'.
          LV_GENTEXT = '남자'.
        ELSE.
          LV_GENTEXT = '여자'.
        ENDIF.
        CLEAR LV_ZDTEXT.
        SELECT SINGLE ZDNAME
          FROM zdsuwont02_3
          INTO LV_ZDTEXT
          WHERE ZDEPT = GS_ITAB-ZDEPT.

      ELSE.
        MESSAGE '없는 사원번호 입니다.' TYPE 'S' DISPLAY LIKE 'E'.
        CLEAR : gs_itab-zempnm, gs_itab-zgender, gs_itab-zdept, gs_itab-zsdate, gs_itab-zfamno, gs_itab-zdele.
      ENDIF.
    WHEN 'REFR'.
      CLEAR : gs_itab.


    WHEN 'DELE'.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
         titlebar                    = '주의하세요'
*         DIAGNOSE_OBJECT             = ' '
          text_question               = '정말 퇴사처리 하시겠습니까?'
*         TEXT_BUTTON_1               = 'Ja'(001)
*         ICON_BUTTON_1               = ' '
*         TEXT_BUTTON_2               = 'Nein'(002)
*         ICON_BUTTON_2               = ' '
*         DEFAULT_BUTTON              = '1'
*         DISPLAY_CANCEL_BUTTON       = 'X'
*         USERDEFINED_F1_HELP         = ' '
*         START_COLUMN                = 25
*         START_ROW                   = 6
*         POPUP_TYPE                  =
*         IV_QUICKINFO_BUTTON_1       = ' '
*         IV_QUICKINFO_BUTTON_2       = ' '
       IMPORTING
         answer                      = lv_answer
*       TABLES
*         PARAMETER                   =
*       EXCEPTIONS
*         TEXT_NOT_FOUND              = 1
*         OTHERS                      = 2
                .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      IF lv_answer = '1'.
        "퇴사자 처리
        UPDATE zdsuwont02 SET zdele = 'X' WHERE zempno = gs_itab-zempno.
        COMMIT WORK.
        IF sy-subrc = 0.
          MESSAGE '퇴사자 처리가 완료되었습니다.' TYPE 'S'.
          gs_itab-zdele = 'X'. "값만 할당 하기때문에 MODIFY해줄필요 없다고 함.
        ENDIF.
      ENDIF.

    WHEN 'CREA'.
      "1) 필수값 체크
      IF gs_itab-zempno IS NOT INITIAL
      AND gs_itab-zempnm IS NOT INITIAL
      AND gs_itab-zdept IS NOT INITIAL
      AND gs_itab-zgender IS NOT INITIAL
      AND gs_itab-zsdate IS NOT INITIAL.
        CLEAR : lv_error.
        "2) 사원 번호 유무 체크
        SELECT SINGLE zempno
          INTO lv_zempno
          FROM zdsuwont02
          WHERE zempno = gs_itab-zempno.
          IF lv_zempno IS NOT INITIAL.
            MESSAGE '이미 등록된 사원번호 입니다.' TYPE 'S' DISPLAY LIKE 'E'.
            lv_error = 'X'.
            EXIT.
          ENDIF.
          "3) 사원번호 8자리 체크
          lv_len = strlen( gs_itab-zempno ).
          IF lv_len <> 8.
            MESSAGE '사원번호는 8자리로 입력해주세요.' TYPE 'S' DISPLAY LIKE 'E'.
            lv_error = 'X'.
            EXIT.
          ENDIF.
          "4) 성별 남/여만 입력 가능하도록.
          IF gs_itab-zgender <> '남'
          AND gs_itab-zgender <> '여'.
            MESSAGE '성별은 남/여만 입력 가능합니다.' TYPE 'S' DISPLAY LIKE 'E'.
            lv_error = 'X'.
            EXIT.
          ENDIF.
          "5) 사원번호 앞 4자리 = 입사일자 앞 4자리 체크
          IF gs_itab-zempno+0(4) <> gs_itab-zsdate+0(4).
            MESSAGE '사원번호 앞 4자리와 입사일자 앞4자리가 맞지 않습니다.' TYPE 'S' DISPLAY LIKE 'E'.
            lv_error = 'X'.
            EXIT.
          ENDIF.
          "6) 부서 코드 체크
          IF gs_itab-zdept IS INITIAL.
            SELECT SINGLE zdept
              INTO lv_zdept
              FROM zdsuwont02_3
              WHERE zdept = gs_itab-zdept.
            MESSAGE '부서 코드가 반드시 입력되어야 합니다.' TYPE 'S' DISPLAY LIKE 'E'.
            lv_error = 'X'.
            EXIT.
          ENDIF.

          "에러가 없으면 신규입사 생성
          IF lv_error IS INITIAL.
            CLEAR gv_zdsuwont02.
            MOVE-CORRESPONDING gs_itab TO gv_zdsuwont02.
            "생성로그
            gv_zdsuwont02-erdat = sy-datum.
            gv_zdsuwont02-erzet = sy-uzeit.
            gv_zdsuwont02-ernam = sy-uname.

            INSERT zdsuwont02 FROM gv_zdsuwont02.
            COMMIT WORK. "비로소 DB에 들어감
            IF sy-subrc = 0.
              MESSAGE '신규입사자 생성완료.' TYPE 'S'.
            ENDIF.
          ENDIF.
      ELSE.
        MESSAGE '필수값(사원번호, 사원명, 부서, 성별, 입사일자)을 입력하세요.' TYPE 'S' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.
    WHEN 'CHAG'.
      "1) 필수값 체크
      IF gs_itab-zempno IS NOT INITIAL
      AND gs_itab-zempnm IS NOT INITIAL
      AND gs_itab-zgender IS NOT INITIAL
      AND gs_itab-zdept IS NOT INITIAL
      AND gs_itab-zsdate IS NOT INITIAL.
        CLEAR : lv_error.

        "2) 변경할 사원번호가 테이블에 있는지 체크
        CLEAR lv_zempno.
        SELECT SINGLE zempno
          INTO lv_zempno
          FROM zdsuwont02
          WHERE zempno = gs_itab-zempno.

          IF lv_zempno IS NOT INITIAL.
            "수정 해도 됨

            "3) 퇴사자는 변경하면 안됨
            IF gs_itab-zdele = 'X'.
              MESSAGE '퇴사자는 변경 할 수 없습니다.' TYPE 'S' DISPLAY LIKE 'E'.
              lv_error = 'X'.
              EXIT.
            ENDIF.

            "4) 성별
            IF gs_itab-zgender <> '남'
            AND gs_itab-zgender <> '여'.
              MESSAGE '성별은 남/여 중에 입력하여야 합니다.' TYPE 'S' DISPLAY LIKE 'E'.
              lv_error = 'X'.
              EXIT.
            ENDIF.

            "5) 입사연도 4자리 = 사원번호 앞 4자리
            IF gs_itab-zempno+0(4) <> gs_itab-zsdate+0(4).
              MESSAGE '사원번호 앞 4자리와 입사일자 앞4자리가 맞지 않습니다.' TYPE 'S' DISPLAY LIKE 'E'.
              lv_error = 'X'.
              EXIT.
            ENDIF.

            "6) 부서코드 체크
            IF gs_itab-zdept IS INITIAL.
               SELECT SINGLE zdept
                 INTO lv_zdept
                 FROM zdsuwont02_3
                 WHERE zdept = gs_itab-zdept.
               IF sy-subrc = 0.
               ELSE.
                 MESSAGE '부서 코드가 반드시 입력되어야 합니다.' TYPE 'S' DISPLAY LIKE 'E'.
                 lv_error = 'X'.
                 EXIT.
               ENDIF.
            ENDIF.

            "에러 없으니 변경하자
            IF lv_error IS INITIAL.
              CLEAR gv_zdsuwont02.
              MOVE-CORRESPONDING gs_itab TO gv_zdsuwont02.
              "변경 로그
              gv_zdsuwont02-aedat = sy-datum.
              gv_zdsuwont02-aezet = sy-uzeit.
              gv_zdsuwont02-aenam = sy-uname.

              "업데이트
              UPDATE zdsuwont02 SET zempnm = gv_zdsuwont02-zempnm
                                    zgender = gv_zdsuwont02-zgender
                                    zdept = gv_zdsuwont02-zdept
                                    zsdate = gv_zdsuwont02-zsdate
                                    zfamno = gv_zdsuwont02-zfamno
                                    aedat = gv_zdsuwont02-aedat
                                    aezet = gv_zdsuwont02-aezet
                                    aenam = gv_zdsuwont02-aenam
                                    WHERE zempno = gv_zdsuwont02-zempno.
              COMMIT WORK.
              IF sy-subrc = 0.
                MESSAGE '변경 성공했습니다.' TYPE 'S'.
              ENDIF.
            ENDIF.


          ELSE.
            MESSAGE '입력한 사원번호는 존재하지 않습니다.' TYPE 'S' DISPLAY LIKE 'E'.
            EXIT.
            "수정하면 안됨


          ENDIF.


      ELSE.
        MESSAGE '필수값(사원번호, 사원명, 부서, 성별, 입사일자)을 입력하세요.' TYPE 'S' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.
    WHEN 'PUSH1'.
      CALL SCREEN 200.
    WHEN OTHERS.
  ENDCASE.

  CLEAR : ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_screen OUTPUT.
  LOOP AT SCREEN.
    IF save_ok = 'REFR'. "OK_CODE값을 계속 유지 하려고 옮긴것.
      IF screen-name = 'GS_ITAB-ZEMPNO'.
        screen-input = 1. "입력활성화
        screen-required = '1'. "필수값활성화
      ENDIF.

    ELSE.
      IF screen-name = 'GS_ITAB-ZEMPNO'.
        screen-input = 0.
        screen-required = 1.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  F4_ZEMPNO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE f4_zempno INPUT.
  DATA : BEGIN OF lt_zempno OCCURS 0,
          zempno TYPE zdsuwont02-zempno,
          zempnm TYPE zdsuwont02-zempnm,
         END OF lt_zempno.
DATA : lt_return TYPE TABLE OF ddshretval WITH HEADER LINE.

  SELECT zempno zempnm
    INTO CORRESPONDING FIELDS OF TABLE lt_zempno
    FROM zdsuwont02.

  IF lt_zempno[] IS NOT INITIAL.
    SORT lt_zempno.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
*       DDIC_STRUCTURE         = ' '
        retfield               = 'ZEMPNO'
*       PVALKEY                = ' '
*       DYNPPROG               = ' '
*       DYNPNR                 = ' '
*       DYNPROFIELD            = ' '
*       STEPL                  = 0
*       WINDOW_TITLE           =
*       VALUE                  = ' '
       value_org              = 'S'
*       MULTIPLE_CHOICE        = ' '
*       DISPLAY                = ' '
*       CALLBACK_PROGRAM       = ' '
*       CALLBACK_FORM          = ' '
*       CALLBACK_METHOD        =
*       MARK_TAB               =
*     IMPORTING
*       USER_RESET             =
      TABLES
        value_tab              = lt_zempno
*       FIELD_TAB              =
       return_tab             = lt_return
*       DYNPFLD_MAPPING        =
     EXCEPTIONS
       parameter_error        = 1
       no_values_found        = 2
       OTHERS                 = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    IF lt_return[] IS NOT INITIAL.
      LOOP AT lt_return.
        gs_itab-zempno = lt_return-fieldval.
      ENDLOOP.
    ENDIF.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_command INPUT.
  save_ok = ok_code.
  CASE SAVE_OK.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANC'.
      LEAVE PROGRAM.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
*    WHEN OTHERS.
  ENDCASE.
  CLEAR : ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_FIELD_ZEMPNO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_field_zempno INPUT.
  DATA : LV_ZEMPNO2 TYPE zdsuwont02-ZEMPNO.

  IF GS_ITAB-ZEMPNO IS NOT INITIAL.
    CLEAR LV_ZEMPNO2.

    SELECT SINGLE ZEMPNO
      INTO LV_ZEMPNO2
      FROM ZDSUWONT02
      WHERE ZEMPNO = GS_ITAB-ZEMPNO.
      IF SY-SUBRC = 0.
        ELSE.
        MESSAGE '사원번호를 다시 입력하세요.' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_FIELD_ZDEPT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_field_zdept INPUT.
  IF GS_ITAB-ZDEPT IS NOT INITIAL.
    CLEAR : LV_ZDTEXT.
    SELECT SINGLE ZDNAME
      FROM zdsuwont02_3
      INTO LV_ZDTEXT
      WHERE ZDEPT = GS_ITAB-ZDEPT.

      IF SY-SUBRC = 0.
      ELSE.
        MESSAGE '부서코드 다시 입력하세요.' TYPE 'S' DISPLAY LIKE 'E'.
        CLEAR : LV_ZDTEXT.
      ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_FIELD_ZGENDER  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_field_zgender INPUT.
  IF GS_ITAB-zgender IS NOT INITIAL.
    IF GS_ITAB-zgender <> '남'
    AND GS_ITAB-zgender <> '여'.
      MESSAGE '성별을 다시 입력하세요.' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      IF GS_ITAB-zgender = '여'.
        LV_GENTEXT = '여자'.
      ELSE.
        LV_GENTEXT = '남자'.
      ENDIF.
    ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  SAVE_OK = OK_CODE.
  CASE SAVE_OK.
    WHEN 'SAVE'.
      IF GS_ITAB-ZEMPNO IS NOT INITIAL
      AND GS_ITAB-ZEMPNM IS NOT INITIAL.
        IF GS_ITAB-ZDELE IS INITIAL.
          UPDATE zdsuwont02 SET ZBIRTH = GS_ITAB-ZBIRTH
                                ZPHONE = GS_ITAB-ZPHONE
                                ZHOME = GS_ITAB-ZHOME
                                ZOFFNO = GS_ITAB-ZOFFNO
                                ZMARRID = GS_ITAB-ZMARRID
                            WHERE ZEMPNO = GS_ITAB-ZEMPNO.
          COMMIT WORK.
          IF SY-SUBRC = 0.
            MESSAGE '추가정보 저장 성공했습니다.' TYPE 'S'.
          ENDIF.
        ELSE.
          MESSAGE '퇴사자는 추가정보 저장 할 수 없습니다' TYPE 'S' DISPLAY LIKE 'E'.
          EXIT.
        ENDIF.
      ENDIF.

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.
  CLEAR OK_CODE.
ENDMODULE.
