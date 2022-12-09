*&---------------------------------------------------------------------*
*& Report ZRSUWON02_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_07.

"DATA 선언 -무조건
TABLES : ZTSUWON02_HR.

DATA : BEGIN OF GS_DATA,
        ZCODE TYPE ZTSUWON02_HR-ZCODE,
        ZNAME TYPE ZTSUWON02_HR-ZNAME,
       END OF GS_DATA.
DATA : GT_DATA LIKE TABLE OF GS_DATA.

SELECTION-SCREEN BEGIN OF BLOCK BLOCK1 WITH FRAME TITLE TEXT-B01.
  "조회 화면 -무조건
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN POSITION 1.
    SELECTION-SCREEN COMMENT (10) TEXT-S01.

    SELECTION-SCREEN POSITION 15.
    PARAMETERS : P_ZCODE TYPE ZTSUWON02_HR-ZCODE.
    SELECTION-SCREEN COMMENT (10) TEXT-S02 FOR FIELD P_ZCODE.

    SELECTION-SCREEN POSITION 30.
    PARAMETERS : P_ZCODE2 TYPE ZTSUWON02_HR-ZCODE.
    SELECTION-SCREEN COMMENT (10) TEXT-S03 FOR FIELD P_ZCODE2.

  SELECTION-SCREEN END OF LINE.

  SELECT-OPTIONS : S_ZCODE FOR ZTSUWON02_HR-ZCODE.

  PARAMETERS : RA_01 RADIOBUTTON GROUP GR1 DEFAULT 'X' USER-COMMAND UCOM1,
               RA_02 RADIOBUTTON GROUP GR1.

SELECTION-SCREEN END OF BLOCK BLOCK1.

"INITIALIZATION
INITIALIZATION.
  P_ZCODE = '002'.

*  S_ZCODE-SIGN = 'I'.
*  S_ZCODE-OPTION = 'EQ'.
*  S_ZCODE-LOW = '002'.
*  APPEND S_ZCODE TO S_ZCODE.
*
*  S_ZCODE-SIGN = 'I'.
*  S_ZCODE-OPTION = 'EQ'.
*  S_ZCODE-LOW = '004'.
*  APPEND S_ZCODE. "화살표 값에 여러개 들어감

  S_ZCODE-SIGN = 'I'.
  S_ZCODE-OPTION = 'BT'.
  S_ZCODE-LOW = '003'.
  S_ZCODE-HIGH = '005'.
  APPEND S_ZCODE. "~ TO ~로 들어감

"START-OF-SELECTION -무조건
AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN .
    IF RA_01 IS NOT INITIAL.
      IF SCREEN-NAME = 'P_ZCODE2'.
        SCREEN-INPUT = 0.
      ENDIF.

    ELSEIF RA_02 IS NOT INITIAL.
      IF SCREEN-NAME = 'P_ZCODE'.
        SCREEN-INPUT = 0.
*        SCREEN-ACTIVE = 0.
*        SCREEN-INVISIBLE = 1.
      ENDIF.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO TABLE GT_DATA
    FROM ZTSUWON02_HR
    WHERE ZCODE = P_ZCODE. "값을 안넣으면 안가지고 옴

  SELECT ZCODE ZNAME
    APPENDING TABLE GT_DATA
    FROM ZTSUWON02_HR
    WHERE ZCODE IN S_ZCODE. "값을 안넣으면 모두 가지고 옴

  LOOP AT GT_DATA INTO GS_DATA.
    WRITE : / GS_DATA.
  ENDLOOP.

"END-OF-SELECTION
*END-OF-SELECTION.
*  LOOP AT GT_DATA INTO GS_DATA.
*    WRITE : / GS_DATA.
*  ENDLOOP.
