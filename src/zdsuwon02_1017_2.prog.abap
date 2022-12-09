*&---------------------------------------------------------------------*
*& Report ZDSUWON02_1017_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDSUWON02_1017_2 LINE-COUNT 10(2) NO STANDARD PAGE HEADING.

TABLES : ZDSUWONT02.

"사원관리 조회 프로그램
DATA : GT_ZDSUWONT02 TYPE TABLE OF ZDSUWONT02 WITH HEADER LINE.

"사원번호 서치헬프 선언
DATA : BEGIN OF LT_ZEMPNO OCCURS 0,
        ZEMPNO LIKE ZDSUWONT02-ZEMPNO,
        ZEMPNM  LIKE ZDSUWONT02-ZEMPNM,
       END OF LT_ZEMPNO.
DATA : LT_RETURN TYPE TABLE OF DDSHRETVAL WITH HEADER LINE.

"입사일자, 사원번호, 부서
SELECT-OPTIONS : S_ZSDATE FOR ZDSUWONT02-ZSDATE,
                 S_ZEMPNO FOR ZDSUWONT02-ZEMPNO,
                 S_ZDEPT FOR ZDSUWONT02-ZDEPT.
"사원명, 성별, 체크박스
SELECT-OPTIONS : S_ZEMPNM FOR ZDSUWONT02-ZEMPNM MODIF ID ID1,
                 S_ZGEN FOR ZDSUWONT02-ZGENDER MODIF ID ID1. "8자리 이하로 선언해줘어야 함
PARAMETERS : P_CHK AS CHECKBOX USER-COMMAND CHK1.

"입사일자 HIGH에 오늘일자 -> INITIALIZATION.
INITIALIZATION.
  S_ZSDATE-HIGH = SY-DATUM. "첫번째 조건. 오늘날짜 값
  APPEND S_ZSDATE.

AT SELECTION-SCREEN.

"두번째 조건. 입사일자 HIGH값을 필수로.
AT SELECTION-SCREEN ON S_ZSDATE.
  IF S_ZSDATE-HIGH IS INITIAL.
    MESSAGE '입사일자 HIGH값을 입력해주세요' TYPE 'E'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.
  "LOOP AT SCREEN. -> MODIFY SCREEN
  "3. CHECKBOX 체크시 사원명, 성별 SELECT-OPTIONS 필드가 비활성화
  LOOP AT SCREEN.
    IF P_CHK = 'X'. "USER-COMMAND를 설정 해주었기때문에 먹힘
        IF SCREEN-GROUP1 = 'ID1'.
          SCREEN-INPUT = 0. "해당 그룹 필드들 비활성화
        ELSE.
          SCREEN-INTENSIFIED = 1.
        ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR S_ZEMPNO-LOW.
  PERFORM F4_ZEMPNO USING S_ZEMPNO-LOW.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR S_ZEMPNO-HIGH.
  PERFORM F4_ZEMPNO USING S_ZEMPNO-HIGH.

TOP-OF-PAGE.
  WRITE : 50 '페이지NO : ', SY-PAGNO.

END-OF-PAGE.
  WRITE : 50 '페이지NO : ', SY-PAGNO.
  ULINE.

START-OF-SELECTION.

SET PF-STATUS 'STATUS1000'. "출력 화면에서도 버튼을 생성하려고 STATUS이름 생성.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_ZDSUWONT02
    FROM ZDSUWONT02
    WHERE ZEMPNO IN S_ZEMPNO
    AND ZEMPNM IN S_ZEMPNM
    AND ZSDATE IN S_ZSDATE
    AND ZDEPT IN S_ZDEPT
    AND ZGENDER IN S_ZGEN.

END-OF-SELECTION.

SORT GT_ZDSUWONT02.
LOOP AT GT_ZDSUWONT02.
  WRITE : / GT_ZDSUWONT02-ZEMPNO,
            GT_ZDSUWONT02-ZEMPNM.
ENDLOOP.

AT USER-COMMAND.
  CASE SY-UCOMM.
    WHEN 'LEAV'.
      LEAVE PROGRAM.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.




*&---------------------------------------------------------------------*
*& Form F4_ZEMPNO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f4_zempno USING PARA.
  SELECT ZEMPNO ZEMPNM
    INTO CORRESPONDING FIELDS OF TABLE LT_ZEMPNO
    FROM ZDSUWONT02.
  IF LT_ZEMPNO[] IS NOT INITIAL.
    SORT LT_ZEMPNO.

    "서치헬프 FUNCTION
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
       VALUE_ORG              = 'S'
*       MULTIPLE_CHOICE        = ' '
*       DISPLAY                = ' '
*       CALLBACK_PROGRAM       = ' '
*       CALLBACK_FORM          = ' '
*       CALLBACK_METHOD        =
*       MARK_TAB               =
*     IMPORTING
*       USER_RESET             =
      tables
        value_tab              = LT_ZEMPNO
*       FIELD_TAB              =
       RETURN_TAB             = LT_RETURN "선택하면 값이 필드에 들어감
*       DYNPFLD_MAPPING        =
     EXCEPTIONS
       PARAMETER_ERROR        = 1
       NO_VALUES_FOUND        = 2
       OTHERS                 = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    LOOP AT LT_RETURN.
      PARA = LT_RETURN-fieldval.
    ENDLOOP.

  ENDIF.
ENDFORM.
