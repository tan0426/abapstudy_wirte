*&---------------------------------------------------------------------*
*& Report ZRSUWON02_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_05.

*DATA : GT_ZTSUWON02_HR LIKE ZTSUWON02_HR OCCURS 0 .
*
*SELECT *
*  FROM ZTSUWON02_HR
*  INTO TABLE GT_ZTSUWON02_HR.
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR ).
*
*DATA : GS_ZTSUWON02_HR_02 LIKE ZTSUWON02_HR.
*
*SELECT SINGLE *
*  FROM ZTSUWON02_HR
*  INTO GS_ZTSUWON02_HR_02.
*
**CL_DEMO_OUTPUT=>DISPLAY( GS_ZTSUWON02_HR_02 ).
*
*SELECT MANDT ZCODE ZNAME ZGENDER ZPHONE ZADDRESS ZAGE ZHOBBY
*  FROM ZTSUWON02_HR
*  INTO TABLE GT_ZTSUWON02_HR.
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR ).
*
*DATA : BEGIN OF GS_ZTSUWON02_HR_03,
*        ZCODE LIKE ZTSUWON02_HR-ZCODE,
*        ZNAME LIKE ZTSUWON02_HR-ZNAME,
*        ZPHONE LIKE ZTSUWON02_HR-ZPHONE,
*        ZGENDER LIKE ZTSUWON02_HR-ZGENDER,
*       END OF GS_ZTSUWON02_HR_03.
*DATA : GT_ZTSUWON02_HR_03 LIKE TABLE OF GS_ZTSUWON02_HR_03.
*
*SELECT ZCODE ZNAME ZGENDER ZPHONE
*  FROM ZTSUWON02_HR
*  INTO TABLE GT_ZTSUWON02_HR_03.
*
*SELECT ZCODE ZNAME ZGENDER ZPHONE
*  FROM ZTSUWON02_HR
*  INTO CORRESPONDING FIELDS OF TABLE GT_ZTSUWON02_HR_03.
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_03 ).
*
*SELECT SINGLE ZCODE ZNAME ZGENDER ZPHONE "한 라인만
*  FROM ZTSUWON02_HR
*  INTO GS_ZTSUWON02_HR_03.
*
**CL_DEMO_OUTPUT=>DISPLAY( GS_ZTSUWON02_HR_03 ).
*
*SELECT SINGLE ZCODE ZNAME ZGENDER ZPHONE
*  FROM ZTSUWON02_HR
*  INTO CORRESPONDING FIELDS OF GS_ZTSUWON02_HR_03.
*
**CL_DEMO_OUTPUT=>DISPLAY( GS_ZTSUWON02_HR_03 ).
*
*SELECT *
*  INTO TABLE @GT_ZTSUWON02_HR
*  FROM ZTSUWON02_HR
*  WHERE ZCODE = '002'.
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR ).
*
*DATA : GV_ZCODE LIKE ZTSUWON02_HR-ZCODE.
*
*SELECT SINGLE ZCODE
*  INTO @GV_ZCODE
*  FROM ZTSUWON02_HR
*  WHERE ZCODE = '002'.
*
*DATA : GV_ZNAME LIKE ZTSUWON02_HR-ZNAME.
*
*SELECT SINGLE ZCODE ZNAME
*  INTO ( GV_ZCODE, GV_ZNAME )
*  FROM ZTSUWON02_HR
*  WHERE ZCODE = '002'.
*
*DATA : GT_ZTSUWON02_HR_04 LIKE ZTSUWON02_HR OCCURS 0.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZGENDER = '남'.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZGENDER EQ '남'.
**  WHERE ZGENDER <> '남'.
**  WHERE ZGENDER NE '남'.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZAGE BETWEEN '20' AND '30'.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZNAME LIKE '탄동%'.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZHOBBY IN ( '독서', '운동' ) AND ZGENDER IN ( '남', '여' ).
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ( ZHOBBY = '독서' OR ZHOBBY = '운동' ).
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_04 ).
*
*RANGES : GR_ZCODE FOR ZTSUWON02_HR-ZCODE.
*
*GR_ZCODE-SIGN = 'I'.
*GR_ZCODE-OPTION = 'EQ'.
*GR_ZCODE-LOW = '001'.
*APPEND GR_ZCODE TO GR_ZCODE.
*
*GR_ZCODE-SIGN = 'I'.
*GR_ZCODE-OPTION = 'EQ'.
*GR_ZCODE-LOW = '002'.
*APPEND GR_ZCODE.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZCODE IN GR_ZCODE.
*
*GR_ZCODE-SIGN = 'I'.
*GR_ZCODE-OPTION = 'BT'.
*GR_ZCODE-LOW = '20'.
*GR_ZCODE-HIGH = '30'.
*APPEND GR_ZCODE.
*
*SELECT *
*  INTO TABLE GT_ZTSUWON02_HR_04
*  FROM ZTSUWON02_HR
*  WHERE ZCODE IN GR_ZCODE.

"select 복습

DATA : GT_ZTSUWON02_HR_01 LIKE ZTSUWON02_HR OCCURS 0.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_01
  FROM ZTSUWON02_HR.
*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_01 ).

DATA : GS_ZTSUWON02_HR_02 LIKE ZTSUWON02_HR.

SELECT SINGLE * "DB에서 한 라인을 읽어 옴. READ TABLE은 INTERNAL TABLE에서.
  INTO GS_ZTSUWON02_HR_02
  FROM ZTSUWON02_HR.
*CL_DEMO_OUTPUT=>DISPLAY( GS_ZTSUWON02_HR_02 ).

DATA : BEGIN OF GS_ZTSUWON02_HR_03,
        ZCODE LIKE ZTSUWON02_HR-ZCODE,
        ZNAME LIKE ZTSUWON02_HR-ZNAME,
        ZPHONE LIKE ZTSUWON02_HR-ZPHONE,
        ZGENDER TYPE ZTSUWON02_HR-ZGENDER,
       END OF GS_ZTSUWON02_HR_03.
DATA : GT_ZTSUWON02_HR_03 LIKE TABLE OF GS_ZTSUWON02_HR_03.

SELECT ZCODE ZNAME ZGENDER ZPHONE
  INTO TABLE GT_ZTSUWON02_HR_03
  FROM ZTSUWON02_HR.

SELECT ZCODE ZNAME ZGENDER ZPHONE
  INTO CORRESPONDING FIELDS OF TABLE GT_ZTSUWON02_HR_03
  FROM ZTSUWON02_HR.
*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_03 ).

DATA : GT_ZTSUWON02_HR_04 LIKE ZTSUWON02_HR OCCURS 0.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_04
  FROM ZTSUWON02_HR
  WHERE ZCODE = '002'.
*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_04 ).

DATA : GV_ZCODE TYPE ZTSUWON02_HR-ZCODE.

SELECT SINGLE ZCODE
  INTO GV_ZCODE
  FROM ZTSUWON02_HR
  WHERE ZCODE = '002'.

DATA : GV_ZNAME TYPE ZTSUWON02_HR-ZNAME.

SELECT SINGLE ZCODE ZNAME
  INTO ( GV_ZCODE, GV_ZNAME )
  FROM ZTSUWON02_HR
  WHERE ZCODE = '002'.

DATA : GT_ZTSUWON02_HR_05 LIKE ZTSUWON02_HR OCCURS 0.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_05
  FROM ZTSUWON02_HR
  WHERE ZAGE BETWEEN 20 AND 40. " WHERE ~ AND로 교체 될 수 있음

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_05
  FROM ZTSUWON02_HR
  WHERE ZPHONE LIKE '0101%'.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_05
  FROM ZTSUWON02_HR
  WHERE ZHOBBY IN ( '독서', '잠자기' ). "WHERE (~ OR ~)로 교체 될 수 있음.
*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_05 ).

RANGES : GR_ZCODE FOR ZTSUWON02_HR-ZCODE.

GR_ZCODE-SIGN = 'I'.
GR_ZCODE-OPTION = 'EQ'.
GR_ZCODE-LOW = '001'.
APPEND GR_ZCODE.

GR_ZCODE-SIGN = 'I'.
GR_ZCODE-OPTION = 'EQ'.
GR_ZCODE-LOW = '002'.
APPEND GR_ZCODE.

GR_ZCODE-SIGN = 'I'.
GR_ZCODE-OPTION = 'EQ'.
GR_ZCODE-LOW = '003'.
APPEND GR_ZCODE.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_05
  FROM ZTSUWON02_HR
  WHERE ZCODE IN GR_ZCODE.

*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_05 ).

CLEAR : GR_ZCODE, GR_ZCODE[].

GR_ZCODE-SIGN = 'I'.
GR_ZCODE-OPTION = 'BT'.
GR_ZCODE-LOW = '001'.
GR_ZCODE-HIGH = '002'.
APPEND GR_ZCODE.

SELECT *
  INTO TABLE GT_ZTSUWON02_HR_05
  FROM ZTSUWON02_HR
  WHERE ZCODE IN GR_ZCODE.
*CL_DEMO_OUTPUT=>DISPLAY( GT_ZTSUWON02_HR_05 ).

DATA : GV_ZCODE2 TYPE ZTSUWON02_HR-ZCODE.

SELECT SINGLE MAX( ZCODE )
  INTO GV_ZCODE2
  FROM ZTSUWON02_HR.

*WRITE : / GV_ZCODE2.

*DATA : BEGIN OF GS_DATA7,
*        ZCODE LIKE ZTTEST_215_HR-ZCODE,
*        ZNAME LIKE ZTTEST_215_HR-ZNAME,
*        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_DATA7.
*DATA : GT_DATA7 LIKE TABLE OF GS_DATA7.
*
*DATA : GS_HR LIKE GS_DATA7,
*       GT_HR LIKE TABLE OF GS_DATA7.
*
*DATA : BEGIN OF GS_UNI,
*        ZCODE TYPE ZTTEST_215_HR-ZCODE,
*        ZMAJOR TYPE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_UNI.
*DATA : GT_UNI LIKE TABLE OF GS_UNI.
*
*SELECT ZCODE ZNAME
*  INTO CORRESPONDING FIELDS OF TABLE GT_HR
*  FROM ZTTEST_215_HR.
*
*SELECT ZCODE ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_UNI
*  FROM ZTTEST_215_UNI.
*
*LOOP AT GT_HR INTO GS_HR.
*  CLEAR GS_UNI.
*  READ TABLE GT_UNI WITH KEY ZCODE = GS_HR-ZCODE INTO GS_UNI.
*  IF SY-SUBRC = 0.
*    GS_DATA7-ZCODE = GS_HR-ZCODE.
*    GS_DATA7-ZNAME = GS_HR-ZNAME.
*    GS_DATA7-ZMAJOR = GS_UNI-ZMAJOR.
*    APPEND GS_DATA7 TO GT_DATA7.
*    CLEAR GS_DATA7.
*  ENDIF.
*ENDLOOP.
*
*SORT GT_DATA7.
*CLEAR GT_DATA7.
*CL_DEMO_OUTPUT=>DISPLAY( GT_DATA7 ).
*
*SELECT ZTTEST_215_HR~ZCODE ZTTEST_215_HR~ZNAME ZTTEST_215_UNI~ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA7
*  FROM ZTTEST_215_HR
*  INNER JOIN ZTTEST_215_UNI
*  ON ZTTEST_215_HR~ZCODE = ZTTEST_215_UNI~ZCODE.
*
*SELECT HR~ZCODE HR~ZNAME UNI~ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA7
*  FROM ZTTEST_215_HR AS HR
*  JOIN ZTTEST_215_UNI AS UNI
*  ON HR~ZCODE = UNI~ZCODE.

*CL_DEMO_OUTPUT=>DISPLAY( GT_DATA7 ).

*DATA : BEGIN OF GS_DATA8,
*        ZCODE TYPE ZTTEST_215_HR-ZCODE,
*        ZNAME TYPE ZTTEST_215_HR-ZNAME,
*        ZMAJOR TYPE ZTTEST_215_UNI-ZMAJOR,
*        ZTOEIC TYPE ZTTEST_215_COM-ZTOEIC,
*       END OF GS_DATA8.
*DATA : GT_DATA8 LIKE TABLE OF GS_DATA8.

*SELECT HR~ZCODE HR~ZNAME UNI~ZMAJOR COM~ZTOEIC
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA8
*  FROM ZTTEST_215_HR AS HR
*  JOIN ZTTEST_215_UNI AS UNI
*  ON HR~ZCODE = UNI~ZCODE
*  JOIN ZTTEST_215_COM AS COM
*  ON HR~ZCODE = COM~ZCODE.

*CL_DEMO_OUTPUT=>DISPLAY( GT_DATA8 ).

*DATA : BEGIN OF GS_DATA7,
*        ZCODE LIKE ZTTEST_215_HR-ZCODE,
*        ZNAME LIKE ZTTEST_215_HR-ZNAME,
*        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_DATA7.
*DATA : GT_DATA7 LIKE TABLE OF GS_DATA7.
*
*DATA : BEGIN OF GS_UNI,
*        ZCODE TYPE ZTTEST_215_HR-ZCODE,
*        ZMAJOR TYPE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_UNI.
*DATA : GT_UNI LIKE TABLE OF GS_UNI.
*
*SELECT ZCODE ZNAME
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA7
*  FROM ZTTEST_215_HR.
*
*SELECT ZCODE ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_UNI
*  FROM ZTTEST_215_UNI.
*
*LOOP AT GT_DATA7 INTO GS_DATA7.
*  CLEAR GS_UNI.
*  READ TABLE GT_UNI WITH KEY ZCODE = GS_DATA7-ZCODE INTO GS_UNI.
*  IF SY-SUBRC = 0.
*    GS_DATA7-ZMAJOR = GS_UNI-ZMAJOR.
*    MODIFY GT_DATA7 FROM GS_DATA7.
*    CLEAR GS_DATA7.
*  ENDIF.
*ENDLOOP.
*
*SORT GT_DATA7.
*CLEAR GT_DATA7.

*DATA : BEGIN OF GS_DATA7,
*        ZCODE LIKE ZTTEST_215_HR-ZCODE,
*        ZNAME LIKE ZTTEST_215_HR-ZNAME,
*        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_DATA7.
*DATA : GT_DATA7 LIKE TABLE OF GS_DATA7.
*
*DATA : GS_HR LIKE GS_DATA7,
*       GT_HR LIKE TABLE OF GS_DATA7.
*
*DATA : BEGIN OF GS_UNI,
*        ZCODE TYPE ZTTEST_215_HR-ZCODE,
*        ZMAJOR TYPE ZTTEST_215_UNI-ZMAJOR,
*       END OF GS_UNI.
*DATA : GT_UNI LIKE TABLE OF GS_UNI.
*
*SELECT ZCODE ZNAME
*  INTO CORRESPONDING FIELDS OF TABLE GT_HR
*  FROM ZTTEST_215_HR.
*
*SELECT ZCODE ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_UNI
*  FROM ZTTEST_215_UNI.
*
*SORT GT_HR.
*LOOP AT GT_HR INTO GS_HR.
*  CLEAR GS_UNI.
*  READ TABLE GT_UNI WITH KEY ZCODE = GS_HR-ZCODE INTO GS_UNI.
*  IF SY-SUBRC = 0.
*    GS_DATA7-ZCODE = GS_HR-ZCODE.
*    GS_DATA7-ZNAME = GS_HR-ZNAME.
*    GS_DATA7-ZMAJOR = GS_UNI-ZMAJOR.
*    APPEND GS_DATA7 TO GT_DATA7.
*    CLEAR GS_DATA7.
*  ELSE.
*    GS_DATA7-ZCODE = GS_HR-ZCODE.
*    GS_DATA7-ZNAME = GS_HR-ZNAME.
*    APPEND GS_DATA7 TO GT_DATA7.
*    CLEAR GS_DATA7.
*  ENDIF.
*ENDLOOP.

*LOOP AT GT_HR INTO GS_HR.
*   GS_DATA7-ZCODE = GS_HR-ZCODE.
*   GS_DATA7-ZNAME = GS_HR-ZNAME.
*  CLEAR GS_UNI.
*  READ TABLE GT_UNI WITH KEY ZCODE = GS_HR-ZCODE INTO GS_UNI.
*
*  IF SY-SUBRC = 0.
*    GS_DATA7-ZMAJOR = GS_UNI-ZMAJOR.
*  ENDIF.
*
*  APPEND GS_DATA7 TO GT_DATA7.
*  CLEAR GS_DATA7.
*ENDLOOP.

*CLEAR GT_DATA7.
*
*SELECT HR~ZCODE HR~ZNAME UNI~ZMAJOR
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA7
*  FROM ZTTEST_215_HR AS HR
*  LEFT OUTER JOIN ZTTEST_215_UNI AS UNI
*  ON HR~ZCODE = UNI~ZCODE.
*
**CL_DEMO_OUTPUT=>DISPLAY( GT_DATA7 ).
*
*DATA : GT_DATA9 LIKE ZTTEST_215_HR OCCURS 0,
*       GT_DATA9_2 LIKE ZTTEST_215_HR OCCURS 0,
*       GS_DATA9 LIKE ZTTEST_215_HR.

*SELECT *
*  INTO TABLE GT_DATA9
*  FROM ZTTEST_215_HR
*  WHERE ZGENDER = '남'
*  AND ZHOBBY = '탁구'.
*
*SELECT *
*  INTO TABLE GT_DATA9
*  FROM ZTTEST_215_HR
*  WHERE ZGENDER = '여'
*  AND ZHOBBY = '독서'.
*
*SELECT *
*  INTO TABLE GT_DATA9
*  FROM ZTTEST_215_HR
*  WHERE ( ZGENDER = '남' OR ZGENDER = '여' )
*  AND ( ZHOBBY = '탁구' OR ZHOBBY = '독서' ).

*DATA : BEGIN OF GS_PROMOTION,
*        ZGENDER LIKE ZTTEST_215_HR-ZGENDER,
*        ZHOBBY LIKE ZTTEST_215_HR-ZHOBBY,
*       END OF GS_PROMOTION.
*DATA : GT_PROMOTION LIKE TABLE OF GS_PROMOTION.
*
*GS_PROMOTION-ZGENDER = '남'.
*GS_PROMOTION-ZHOBBY = '탁구'.
*APPEND GS_PROMOTION TO GT_PROMOTION.
*
*GS_PROMOTION-ZGENDER = '여'.
*GS_PROMOTION-ZHOBBY = '독서'.
*APPEND GS_PROMOTION TO GT_PROMOTION.
*
*"조건이 두가지여서 RANGES를 쓸 수가 없다.
*"한개씩 남 OR 여 OR 탁구 OR 독서가 되어버려서 불가능.
*
*DATA : GT_DATA10 LIKE ZTTEST_215_HR OCCURS 0.
*
*SELECT *
*  INTO TABLE GT_DATA10
*  FROM ZTTEST_215_HR
*  FOR ALL ENTRIES IN GT_PROMOTION
*  WHERE ZGENDER = GT_PROMOTION-ZGENDER
*  AND ZHOBBY = GT_PROMOTION-ZHOBBY.

*CL_DEMO_OUTPUT=>DISPLAY( GT_DATA10 ).

DATA : GS_DATA11 LIKE ZTSUWON02_HR,
       GT_DATA11 LIKE TABLE OF GS_DATA11.

*GS_DATA11-ZCODE = '004'.
*GS_DATA11-ZNAME = '이름'.
*GS_DATA11-ZGENDER = '남'.
*GS_DATA11-ZPHONE = '12345678'.
*GS_DATA11-ZADDRESS = '잠만보'.
*GS_DATA11-ZAGE = 50.
*GS_DATA11-ZHOBBY = '자전거'.
*GS_DATA11-ERDAT = SY-DATUM. "최초생성일
*GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
*GS_DATA11-ERNAM = SY-UNAME. "최초생성자
*GS_DATA11-AEDAT = SY-DATUM. "변경일
*GS_DATA11-AEZET = SY-UZEIT. "변경시간
*GS_DATA11-AENAM = SY-UNAME. "변경자
*
*INSERT ZTSUWON02_HR FROM GS_DATA11.
*
*GS_DATA11-ZCODE = '005'.
*GS_DATA11-ZNAME = '이름'.
*GS_DATA11-ZGENDER = '여'.
*GS_DATA11-ZPHONE = '12345678'.
*GS_DATA11-ZADDRESS = '잠만보'.
*GS_DATA11-ZAGE = 50.
*GS_DATA11-ZHOBBY = '자전거'.
*GS_DATA11-ERDAT = SY-DATUM. "최초생성일
*GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
*GS_DATA11-ERNAM = SY-UNAME. "최초생성자
*GS_DATA11-AEDAT = SY-DATUM. "변경일
*GS_DATA11-AEZET = SY-UZEIT. "변경시간
*GS_DATA11-AENAM = SY-UNAME. "변경자
*APPEND GS_DATA11 TO GT_DATA11.
*
*GS_DATA11-ZCODE = '006'.
*GS_DATA11-ZNAME = '이름'.
*GS_DATA11-ZGENDER = '여'.
*GS_DATA11-ZPHONE = '12345678'.
*GS_DATA11-ZADDRESS = '잠만보'.
*GS_DATA11-ZAGE = 50.
*GS_DATA11-ZHOBBY = '자전거'.
*GS_DATA11-ERDAT = SY-DATUM. "최초생성일
*GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
*GS_DATA11-ERNAM = SY-UNAME. "최초생성자
*GS_DATA11-AEDAT = SY-DATUM. "변경일
*GS_DATA11-AEZET = SY-UZEIT. "변경시간
*GS_DATA11-AENAM = SY-UNAME. "변경자
*APPEND GS_DATA11 TO GT_DATA11.
*
*INSERT ZTSUWON02_HR FROM TABLE GT_DATA11.

*DATA : GV_ZCODE11 TYPE ZTSUWON02_HR-ZCODE.
*
*SELECT SINGLE MAX( ZCODE )
*  INTO GV_ZCODE11
*  FROM ZTSUWON02_HR.
*
*GV_ZCODE11 = GV_ZCODE11 + 1.
*CONDENSE GV_ZCODE11.
*
*CONCATENATE '00' GV_ZCODE11 INTO GV_ZCODE11.
*
*GS_DATA11-ZCODE = GV_ZCODE11.
*
*GS_DATA11-ZNAME = '이름'.
*GS_DATA11-ZGENDER = '여'.
*GS_DATA11-ZPHONE = '12345678'.
*GS_DATA11-ZADDRESS = '잠만보'.
*GS_DATA11-ZAGE = 50.
*GS_DATA11-ZHOBBY = '자전거'.
*GS_DATA11-ERDAT = SY-DATUM. "최초생성일
*GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
*GS_DATA11-ERNAM = SY-UNAME. "최초생성자
*GS_DATA11-AEDAT = SY-DATUM. "변경일
*GS_DATA11-AEZET = SY-UZEIT. "변경시간
*GS_DATA11-AENAM = SY-UNAME. "변경자
*
*INSERT ZTSUWON02_HR FROM GS_DATA11.

*DATA : GV_SNRO TYPE ZTSUWON02_HR-ZCODE.
*
*CALL FUNCTION 'NUMBER_GET_NEXT'
*  EXPORTING
*    nr_range_nr                   = '01'
*    object                        = 'ZT_SU_02'
**   QUANTITY                      = '1'
**   SUBOBJECT                     = ' '
**   TOYEAR                        = '0000'
**   IGNORE_BUFFER                 = ' '
* IMPORTING
*   NUMBER                        = GV_SNRO
**   QUANTITY                      =
**   RETURNCODE                    =
** EXCEPTIONS
**   INTERVAL_NOT_FOUND            = 1
**   NUMBER_RANGE_NOT_INTERN       = 2
**   OBJECT_NOT_FOUND              = 3
**   QUANTITY_IS_0                 = 4
**   QUANTITY_IS_NOT_1             = 5
**   INTERVAL_OVERFLOW             = 6
**   BUFFER_OVERFLOW               = 7
**   OTHERS                        = 8
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*GS_DATA11-ZCODE = GV_SNRO.
*
*GS_DATA11-ZNAME = '이름'.
*GS_DATA11-ZGENDER = '여'.
*GS_DATA11-ZPHONE = '12345678'.
*GS_DATA11-ZADDRESS = '잠만보'.
*GS_DATA11-ZAGE = 50.
*GS_DATA11-ZHOBBY = '자전거'.
*GS_DATA11-ERDAT = SY-DATUM. "최초생성일
*GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
*GS_DATA11-ERNAM = SY-UNAME. "최초생성자
*GS_DATA11-AEDAT = SY-DATUM. "변경일
*GS_DATA11-AEZET = SY-UZEIT. "변경시간
*GS_DATA11-AENAM = SY-UNAME. "변경자
*INSERT ZTSUWON02_HR FROM GS_DATA11.

DATA : GS_DATA12 TYPE ZTSUWON02_HR.

SELECT SINGLE *
  INTO GS_DATA12
  FROM ZTSUWON02_HR
  WHERE ZCODE = '002'.

*GS_DATA12-ZHOBBY = 'ABAP'.
*GS_DATA12-ZADDRESS = '안녕하십니까'.
*
*UPDATE ZTSUWON02_HR FROM GS_DATA12. "KEY는 변경 불가
*
*UPDATE ZTSUWON02_HR SET ZPHONE = '77777777777'
*                    WHERE ZCODE = '002'.

GS_DATA12-ZPHONE = '11111111111'.
UPDATE ZTSUWON02_HR SET ZPHONE = GS_DATA12-ZPHONE
                        ZNAME = '끼요르힝'
                    WHERE ZCODE = '002'.

CLEAR : GS_DATA11.

GS_DATA11-ZCODE = '012'.
GS_DATA11-ZNAME = '이름'.
GS_DATA11-ZGENDER = '여'.
GS_DATA11-ZPHONE = '12345678'.
GS_DATA11-ZADDRESS = '끼요르힝'.
GS_DATA11-ZAGE = 50.
GS_DATA11-ZHOBBY = '자전거'.
GS_DATA11-ERDAT = SY-DATUM. "최초생성일
GS_DATA11-ERZET = SY-UZEIT. "최초생성시간
GS_DATA11-ERNAM = SY-UNAME. "최초생성자
GS_DATA11-AEDAT = SY-DATUM. "변경일
GS_DATA11-AEZET = SY-UZEIT. "변경시간
GS_DATA11-AENAM = SY-UNAME. "변경자

MODIFY ZTSUWON02_HR FROM GS_DATA11.
"MODIFY
DATA : GT_DATA13 TYPE TABLE OF ZTSUWON02_HR,
       GS_DATA13 TYPE ZTSUWON02_HR.

SELECT *
  INTO TABLE GT_DATA13
  FROM ZTSUWON02_HR.

LOOP AT GT_DATA13 INTO GS_DATA13.
  GS_DATA13-ZNAME = 'MODIFY'.
  MODIFY GT_DATA13 FROM GS_DATA13. "LOOP 안의 MODIFY는 변경만.
  CLEAR GS_DATA13.
ENDLOOP.

MODIFY ZTSUWON02_HR FROM TABLE GT_DATA13.

DATA : GS_DATA14 TYPE ZTSUWON02_HR.

GS_DATA14-ZCODE = '007'.

"DELETE
DELETE ZTSUWON02_HR FROM GS_DATA14.

DELETE FROM ZTSUWON02_HR WHERE ZCODE = '008'. "KEY 아니어도 됨
"DELETE는 삭제 정보가 담겨있지 않아 잘 쓰지 않음
