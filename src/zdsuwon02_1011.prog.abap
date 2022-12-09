*&---------------------------------------------------------------------*
*& Report ZDSUWON02_1011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDSUWON02_1011.

"실습

*DATA : BEGIN OF gs_sflight,
*        ZDATE TYPE SFLIGHT-FLDATE,
*        CARRID TYPE SFLIGHT-CARRID,
*        SEATSOCC TYPE SFLIGHT-SEATSOCC,
*       END OF gs_sflight,
*       gt_sflight like TABLE OF gs_sflight.
*
*SELECT FLDATE as ZDATE, CARRID, SEATSOCC
*  INTO CORRESPONDING FIELDS OF TABLE @gt_sflight
*  FROM SFLIGHT.
*
*DATA : gs_main LIKE gs_sflight,
*       gt_main LIKE TABLE OF gs_sflight.
*
*SORT gt_sflight.
*
*DELETE gt_sflight WHERE SEATSOCC = 0.
*
*LOOP AT gt_sflight INTO gs_sflight.
*  MOVE-CORRESPONDING gs_sflight TO gs_main.
*  gs_main-ZDATE = gs_sflight+0(6).
*  COLLECT gs_main INTO gt_main.
*  CLEAR gs_main.
*ENDLOOP.
*
*LOOP AT gt_main INTO gs_main.
*
*  AT NEW ZDATE.
*    WRITE : / '년월 : ', gs_main-ZDATE, '입니다.'.
*  ENDAT.
*
*  WRITE : / gs_main-ZDATE,
*            gs_main-CARRID,
*            gs_main-SEATSOCC.
*
*  AT END OF ZDATE.
*    SUM.
*    WRITE : / gs_main-ZDATE, '합계 : ', gs_main-SEATSOCC,
*              sy-uline.
*  ENDAT.
*
*ENDLOOP.

*"1) 구조체, 인터널테이블 변수 선언시 사용
*DATA : GS_LOG TYPE ZSLOG02.
*DATA : GT_LOG TYPE TABLE OF ZSLOG02.
*
*"2) 구조체 INCLUDE
*DATA : BEGIN OF GS_LOG_1,
*        ZEMPNO TYPE ZTTEST02-ZEMPNO,
*        ZEMPNM TYPE ZTTEST02-ZEMPNM.
*      INCLUDE STRUCTURE ZSLOG02.
*DATA : END OF GS_LOG_1.
*
*"3) 인터널 테이블 INCLUDE
*DATA : BEGIN OF GS_LOG_2 OCCURS 0,
*        ZEMPNO TYPE ZTTEST02-ZEMPNO,
*        ZEMPNM TYPE ZTTEST02-ZEMPNM.
*      INCLUDE STRUCTURE ZSLOG02.
*DATA : END OF GS_LOG_2.

*"VIEW SELECT
*
*DATA : gt_view TYPE TABLE OF ZDHRV02 WITH HEADER LINE.
*
*SELECT *
*  INTO CORRESPONDING FIELDS OF TABLE gt_view
*  FROM ZDHRV02.
*
*LOOP AT gt_view.
*  WRITE : / gt_view-ZEMPNO,
*            gt_view-ZEMPNM,
*            gt_view-ZCERTCD.
*ENDLOOP.
