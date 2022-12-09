*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1024_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1024_3.

"DATA 선언
"조회조건
"INITIALIZATION
"START-OF-SELECTION
"CALL SCREEN 100

TABLES : ztsuwon02_hr.

DATA : BEGIN OF GS_DATA,
        ZCODE TYPE ZTSUWON02_HR-ZCODE,
        ZNAME TYPE ztsuwon02_hr-ZNAME,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.
"DATA : GS_LAYOUT TYPE LVC_S_LAYO. 원래는..
DATA : GT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
       GS_FCAT TYPE slis_fieldcat_alv.

SELECT-OPTIONS : S_ZCODE FOR ztsuwon02_hr-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM ztsuwon02_hr
    WHERE ZCODE IN S_ZCODE.

*CALL SCREEN 100. "이것을 쓰지 않음

GS_LAYOUT-ZEBRA = 'X'.

GS_FCAT-fieldname = 'ZCODE'.
*GS_FCAT-COLTEXT = '코드'.
GS_FCAT-SELTEXT_L = '코드롱롱롱'.
GS_FCAT-SELTEXT_M = '코드미드'.
GS_FCAT-SELTEXT_S = '코드숏'.
APPEND GS_FCAT TO GT_FCAT.
CLEAR GS_FCAT.

GS_FCAT-fieldname = 'ZNAME'.
*GS_FCAT-COLTEXT = '코드'.
GS_FCAT-SELTEXT_L = '코드명롱롱롱'.
GS_FCAT-SELTEXT_M = '코드명미드'.
GS_FCAT-SELTEXT_S = '코드명숏'.
APPEND GS_FCAT TO GT_FCAT.
CLEAR GS_FCAT.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = 'SY-REPID'
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
   I_GRID_TITLE                      = '펑션 에이엘브이'
*   I_GRID_SETTINGS                   =
   IS_LAYOUT                         = GS_LAYOUT
   IT_FIELDCAT                       = GT_FCAT
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
   I_SCREEN_START_COLUMN             = 10
   I_SCREEN_START_LINE               = 10
   I_SCREEN_END_COLUMN               = 100
   I_SCREEN_END_LINE                 = 80
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = GT_DATA
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
