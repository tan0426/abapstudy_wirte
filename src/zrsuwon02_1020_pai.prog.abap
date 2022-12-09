*&---------------------------------------------------------------------*
*& Include          ZRSUWON02_1020_PAI
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'APPEND'.
      READ TABLE GT_DATA INTO GS_DATA INDEX 1.
      APPEND GS_DATA TO GT_DATA.
    WHEN 'CALL'.
      CALL SCREEN 200.

      MESSAGE 'CALL SCREEN 200' TYPE 'I'.
    WHEN 'SET'.
      SET SCREEN 200.

      MESSAGE 'SET SCREEN 200' TYPE 'I'.

    WHEN 'SUBMIT'.
      SUBMIT ZRSUWON_17_11 WITH S_ZCODE IN S_ZCODE  "WITH 불러오는 프로그램 IN PARRENT 프로그램
      AND RETURN. "CUSTOMALV실습프로그램. RETURN을 하면 뒤로가기 했을때 이전 화면으로 돌아감.

    WHEN 'SUBMIT_N'. "새로운 창이 뜨게 함.
      CALL FUNCTION 'RS_TOOL_ACCESS'
        EXPORTING
          operation                 = 'TEST' "내역
         OBJECT_NAME               = 'ZRSUWON_17_11'
         OBJECT_TYPE               = 'PROG'
*         ENCLOSING_OBJECT          =
*         POSITION                  = ' '
*         DEVCLASS                  =
*         INCLUDE                   =
*         VERSION                   = ' '
*         MONITOR_ACTIVATION        = 'X'
*         WB_MANAGER                =
         IN_NEW_WINDOW             = 'X'
*         WITH_OBJECTLIST           = ' '
*         WITH_WORKLIST             = ' '
*       IMPORTING
*         NEW_NAME                  =
*         WB_TODO_REQUEST           =
*       TABLES
*         OBJLIST                   =
*       CHANGING
*         P_REQUEST                 = ' '
*       EXCEPTIONS
*         NOT_EXECUTED              = 1
*         INVALID_OBJECT_TYPE       = 2
*         OTHERS                    = 3
                .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      WHEN 'TRAN'.
*        CALL TRANSACTION 'ZRSUWON02_1019_4' AND SKIP FIRST SCREEN. "첫번째 조회화면 스킵

        LEAVE TO TRANSACTION 'ZRSUWON02_1019_4' AND SKIP FIRST SCREEN.

      WHEN 'TRAN_N'.
        CALL FUNCTION 'TH_CREATE_MODE'
         EXPORTING
           TRANSAKTION                 = 'ZRSUWON02_1019_4'
*           DEL_ON_EOT                  = 0
*           PARAMETERS                  =
           PROCESS_DARK                = 'X'
*           INHERIT_STAT_TRANS_ID       = 0
*         IMPORTING
*           MODE                        =
*         EXCEPTIONS
*           MAX_SESSIONS                = 1
*           INTERNAL_ERROR              = 2
*           NO_AUTHORITY                = 3
*           OTHERS                      = 4
                  .
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.


  ENDCASE.
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
*    WHEN 'CANC'.
*      LEAVE TO SCREEN 0.
*    WHEN 'EXIT'.
*      LEAVE PROGRAM.
*  	WHEN OTHERS.

  ENDCASE.
ENDMODULE.
