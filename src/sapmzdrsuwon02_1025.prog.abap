*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDRSUWON02_1025
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDRSUWON02_1025.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GS_DATA TYPE ZBALT_02.

DATA : RADI1_1,
       RADI1_2,
       RADI2_1,
       RADI2_2,
       RADI3_1,
       RADI3_2,
       RADI4_1,
       RADI4_2,
       RADI5_1,
       RADI5_2,
       RADI6_1,
       RADI6_2,
       RADI7_1,
       RADI7_2,
       RADI8_1,
       RADI8_2,
       RADI9_1,
       RADI9_2,
       RADI10_1,
       RADI10_2.
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
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANC' OR 'EXIT'.
      LEAVE TO SCREEN 0.
    WHEN 'PUSH'.
      IF GS_DATA-NAME IS NOT INITIAL.
        IF RADI1_1 = 'X'.
          GS_DATA-RADI1 = '1항상 나보다 일찍자서 코 시끄럽게 고는 룸메'.
        ELSEIF RADI1_2 = 'X'.
          GS_DATA-RADI1 = '2일주일에 한번만 씻는 룸메'.
        ENDIF.
        IF RADI2_1 = 'X'.
          GS_DATA-RADI2 = '1요구르트에 김치 말아먹기'.
        ELSEIF RADI2_2 = 'X'.
          GS_DATA-RADI2 = '2라면에 초콜릿 넣기'.
        ENDIF.
        IF RADI3_1 = 'X'.
          GS_DATA-RADI3 = '1평생 탄산 안 마시기'.
        ELSEIF RADI3_2 = 'X'.
          GS_DATA-RADI3 = '2평생 라면 못 먹기'.
        ENDIF.
        IF RADI4_1 = 'X'.
          GS_DATA-RADI4 = '1빚이 30억 있는 이상형 만나기'.
        ELSEIF RADI4_2 = 'X'.
          GS_DATA-RADI4 = '2부자지만 내가 싫어하는 사람과 연애'.
        ENDIF.
        IF RADI5_1 = 'X'.
          GS_DATA-RADI5 = '1월 500만원 백수 되기'.
        ELSEIF RADI5_2 = 'X'.
          GS_DATA-RADI5 = '2월 1000만원 직장인'.
        ENDIF.
        IF RADI6_1 = 'X'.
          GS_DATA-RADI6 = '1평소에 양치 절대 안하는 애인'.
        ELSEIF RADI6_2 = 'X'.
          GS_DATA-RADI6 = '2평소에 머리 절대 안감는 애인'.
        ENDIF.
        IF RADI7_1 = 'X'.
          GS_DATA-RADI7 = '11년동안 폰없이 살기'.
        ELSEIF RADI7_2 = 'X'.
          GS_DATA-RADI7 = '21년동안 친구 없이 살기'.
        ENDIF.
        IF RADI8_1 = 'X'.
          GS_DATA-RADI8 = '1여름에 히터틀고 자기'.
        ELSEIF RADI8_2 = 'X'.
          GS_DATA-RADI8 = '2겨울에 에어컨틀고 자기'.
        ENDIF.
        IF RADI9_1 = 'X'.
          GS_DATA-RADI9 = '110년전 과거로 가기'.
        ELSEIF RADI9_2 = 'X'.
          GS_DATA-RADI9 = '210년 후 미래로 가기'.
        ENDIF.
        IF RADI10_1 = 'X'.
          GS_DATA-RADI10 = '1자는데 모기소리 들리기(물리지는 않음)'.
        ELSEIF RADI10_2 = 'X'.
          GS_DATA-RADI10 = '2소리는 없는데 모기물기기'.
        ENDIF.

        IF GS_DATA-RADI1 IS NOT INITIAL
        AND GS_DATA-RADI2 IS NOT INITIAL
        AND GS_DATA-RADI3 IS NOT INITIAL
        AND GS_DATA-RADI4 IS NOT INITIAL
        AND GS_DATA-RADI5 IS NOT INITIAL
        AND GS_DATA-RADI6 IS NOT INITIAL
        AND GS_DATA-RADI7 IS NOT INITIAL
        AND GS_DATA-RADI8 IS NOT INITIAL
        AND GS_DATA-RADI9 IS NOT INITIAL
        AND GS_DATA-RADI10 IS NOT INITIAL.

          GS_DATA-ERDAT = SY-DATUM.
          GS_DATA-ERZET = SY-UZEIT.
          GS_DATA-ERNAM = SY-UNAME.

          INSERT ZBALT_02 FROM GS_DATA.
          CLEAR GS_DATA.
          COMMIT WORK.
          IF SY-SUBRC = 0.
            MESSAGE '밸런스 게임 저장되었습니다.' TYPE 'S'.
          ENDIF.

        ENDIF.

      ENDIF.
      WHEN 'DISP'.
        IF GS_DATA-NAME IS NOT INITIAL.
          SELECT SINGLE *
            INTO CORRESPONDING FIELDS OF GS_DATA
            FROM ZBALT_02
            WHERE NAME = GS_DATA-NAME.

          CLEAR : RADI1_1, RADI1_2,
                  RADI2_1, RADI2_2,
                  RADI3_1, RADI3_2,
                  RADI4_1, RADI4_2,
                  RADI5_1, RADI5_2,
                  RADI6_1, RADI6_2,
                  RADI7_1, RADI7_2,
                  RADI8_1, RADI8_2,
                  RADI9_1, RADI9_2,
                  RADI10_1, RADI10_2.

            IF GS_DATA-RADI1+0(1) = '1'.
              RADI1_1 = 'X'.
            ELSEIF GS_DATA-RADI1+0(1) = '2'.
              RADI1_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI2+0(1) = '1'.
              RADI2_1 = 'X'.
            ELSEIF GS_DATA-RADI2+0(1) = '2'.
              RADI2_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI3+0(1) = '1'.
              RADI3_1 = 'X'.
            ELSEIF GS_DATA-RADI3+0(1) = '2'.
              RADI3_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI4+0(1) = '1'.
              RADI4_1 = 'X'.
            ELSEIF GS_DATA-RADI4+0(1) = '2'.
              RADI4_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI5+0(1) = '1'.
              RADI5_1 = 'X'.
            ELSEIF GS_DATA-RADI5+0(1) = '2'.
              RADI5_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI6+0(1) = '1'.
              RADI6_1 = 'X'.
            ELSEIF GS_DATA-RADI6+0(1) = '2'.
              RADI6_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI7+0(1) = '1'.
              RADI7_1 = 'X'.
            ELSEIF GS_DATA-RADI7+0(1) = '2'.
              RADI7_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI8+0(1) = '1'.
              RADI8_1 = 'X'.
            ELSEIF GS_DATA-RADI8+0(1) = '2'.
              RADI8_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI9+0(1) = '1'.
              RADI9_1 = 'X'.
            ELSEIF GS_DATA-RADI9+0(1) = '2'.
              RADI9_2 = 'X'.
            ENDIF.
            IF GS_DATA-RADI10+0(1) = '1'.
              RADI10_1 = 'X'.
            ELSEIF GS_DATA-RADI10+0(1) = '2'.
              RADI10_2 = 'X'.
            ENDIF.

        ENDIF.
*   WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.
ENDMODULE.
