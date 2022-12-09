*&---------------------------------------------------------------------*
*& Report ZDR02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDR02.
*
*TYPES : T_VAR TYPE C LENGTH 10.
*
*DATA : GV_VAR TYPE T_VAR.
*GV_VAR = '111'.
*
*WRITE : / GV_VAR.
*
*TYPES : BEGIN OF TY_STR,
*        COL1 TYPE C LENGTH 10,
*        COL2 TYPE C LENGTH 10,
*        COL3 TYPE C LENGTH 10,
*        END OF TY_STR. "구조체 타입 선언, 값할당
*
*DATA : GS_DATA TYPE TY_STR.
*
*GS_DATA-COL1 = '111'.
*GS_DATA-COL2 = '222'.
*GS_DATA-COL3 = '333'.
*
*WRITE : / GS_DATA-COL1,
*          GS_DATA-COL2,
*          GS_DATA-COL3.
*
*"구조체 TYPE 포함
*TYPES : BEGIN OF TY_STR2.
*  INCLUDE TYPE TY_STR.
*TYPES : COL4 TYPE C LENGTH 10,
*        COL5 TYPE C LENGTH 10,
*        END OF TY_STR2.
*
*DATA : GS_DATA2 TYPE TY_STR2.
*GS_DATA2-COL1 = '111'.
*GS_DATA2-COL2 = '222'.
*GS_DATA2-COL3 = '333'.
*GS_DATA2-COL4 = '444'.
*GS_DATA2-COL5 = '555'.
*
*WRITE : / GS_DATA2-COL1,
*          GS_DATA2-COL2,
*          GS_DATA2-COL3,
*          GS_DATA2-COL4,
*          GS_DATA2-COL5.
*
*"구조체 선언,할당
*
*DATA : BEGIN OF GS_DATA1,
*        COL1 TYPE C LENGTH 10,
*        COL2 TYPE C LENGTH 10,
*        COL3 TYPE C LENGTH 10,
*        END OF GS_DATA1. "구조체 선언,값 할당
*
*GS_DATA1-COL1 = 'AAA'.
*GS_DATA1-COL2 = 'BBB'.
*GS_DATA1-COL3 = 'CCC'.
*
*WRITE : / GS_DATA-COL1,
*          GS_DATA-COL2,
*          GS_DATA-COL3.
*
*"구조체 STRUCTURE 포함
*DATA : BEGIN OF GS_DATA3.
*  INCLUDE STRUCTURE GS_DATA1.
*DATA : COL4 TYPE C LENGTH 10,
*       COL5 TYPE C LENGTH 10,
*       END OF GS_DATA3.
*
*GS_DATA3-COL1 = 'AAA'.
*GS_DATA3-COL2 = 'BBB'.
*GS_DATA3-COL3 = 'CCC'.
*GS_DATA3-COL4 = 'DDD'.
*GS_DATA3-COL5 = 'EEE'.
*
*WRITE : / GS_DATA3-COL1,
*          GS_DATA3-COL2,
*          GS_DATA3-COL3,
*          GS_DATA3-COL4,
*          GS_DATA3-COL5.
*
*"EX) 사원번호(NO): (CHAR 4), 이름(NAME): (CHAR15), 부서(DEPT): (CHAR15)
*"1.구조체 TYPE - 구조체, 2 구조체
*"EX1)
*
*TYPES : BEGIN OF TAN_COM1,
*        NO TYPE C LENGTH 4,
*        NAME TYPE C LENGTH 15,
*        DEP TYPE C LENGTH 15,
*        END OF TAN_COM1.
*
*DATA : GS_TAN1 TYPE TAN_COM1.
*
*GS_TAN1-NO = '1234'.
*GS_TAN1-NAME = 'TANJUNG'.
*GS_TAN1-DEP = 'TANDEP'.
*
*WRITE : / GS_TAN1-NO,
*          GS_TAN1-NAME,
*          GS_TAN1-DEP.
*"EX2)
*DATA : BEGIN OF TAN_COM2,
*        NO TYPE C LENGTH 4,
*        NAME TYPE C LENGTH 15,
*        DEP TYPE C LENGTH 15,
*        END OF TAN_COM2.
*
*TAN_COM2-NO = '1234'.
*TAN_COM2-NAME = 'TANJUNG'.
*TAN_COM2-DEP = 'TANDEP'.
*
*WRITE : / TAN_COM2-NO,
*          TAN_COM2-NAME,
*          TAN_COM2-DEP.

*"EX1,2 INCLUDE 성별(GEND) : (CHAR5), 입사일자(DATE) : (CHAR8)
*"EX1)
*TYPES : BEGIN OF TAN_COM3.
*        INCLUDE TYPE TAN_COM1.
*TYPES : GEND TYPE C LENGTH 5,
*        DATE TYPE C LENGTH 8,
*        END OF TAN_COM3.
*
*DATA : GS_TAN3 TYPE TAN_COM3.
*
*GS_TAN3-NO = '1234'.
*GS_TAN3-NAME = 'TANJUNG'.
*GS_TAN3-DEP = 'TANDEP'.
*GS_TAN3-GEND = 'GIRL'.
*GS_TAN3-DATE = '22.09.30'.
*
*WRITE : / GS_TAN3-NO,
*          GS_TAN3-NAME,
*          GS_TAN3-DEP,
*          GS_TAN3-GEND,
*          GS_TAN3-DATE.
*
*"EX2)
*DATA : BEGIN OF TAN_COM4.
*       INCLUDE STRUCTURE TAN_COM2.
*DATA : GEND TYPE C LENGTH 5,
*       DATE TYPE C LENGTH 8,
*        END OF TAN_COM4.
*
*TAN_COM4-NO = '1234'.
*TAN_COM4-NAME = 'TANJUNG'.
*TAN_COM4-DEP = 'TANDEP'.
*TAN_COM4-GEND = 'GIRL'.
*TAN_COM4-DATE = '22.09.30'.
*
*WRITE : / TAN_COM4-NO,
*          TAN_COM4-NAME,
*          TAN_COM4-DEP,
*          TAN_COM4-GEND,
*          TAN_COM4-DATE.
*
*"자릿수
*DATA : gv_char TYPE c LENGTH 10.
*
*gv_char = '12345678'.
* WRITE : / gv_char+0(1), gv_char+1(2). "왼쪽부터 0에서 ~1째 자리까지

*"인터널 테이블 선언
*"1. 구조체타입 - 인터널테이블 타입 - 인터널테이블
* TYPES : BEGIN OF ty_str,
*   col1 TYPE c LENGTH 10,
*   col2 TYPE c LENGTH 10,
*   col3 TYPE c LENGTH 10,
*   END OF TY_STR.
*
*TYPES : ty_itab TYPE table of TY_STR.
*
*DATA : gt_data TYPE ty_itab.
*DATA : gs_data10 TYPE TY_STR.

"ex)
*TYPES : BEGIN OF ty_tan,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF ty_tan.
*
*TYPES : ty_tan1 TYPE TABLE OF ty_tan.
*
*DATA : gt_data TYPE ty_tan1.
*DATA : gs_data10 TYPE ty_tan.

*"2. 구조체타입 - 인터널테이블
*
*TYPES : BEGIN OF ty_str2,
*  col1 TYPE c LENGTH 10,
*   col2 TYPE c LENGTH 10,
*   col3 TYPE c LENGTH 10,
*   END OF TY_STR2.
*
*DATA : gt_data2 TYPE TABLE OF TY_STR2.
*DATA : gs_data11 TYPE TY_STR2.

*TYPES : BEGIN OF ty_tan2,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF ty_tan2.
*
*DATA : gt_data2 TYPE TABLE OF ty_tan2.
*DATA : gs_data11 TYPE ty_tan2.


*"3. 구조체타입 - 구조체선언 - 인터널테이블
*TYPES : BEGIN OF ty_str3,
*  col1 TYPE c LENGTH 10,
*   col2 TYPE c LENGTH 10,
*   col3 TYPE c LENGTH 10,
*   END OF TY_STR3.
*
*DATA : gs_data3 TYPE TY_STR3.
*
*DATA : gt_data3 like TABLE OF GS_DATA3.

*TYPES : BEGIN OF ty_tan3,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF ty_tan3.
*
*DATA : gs_data3 TYPE TABLE OF ty_tan3.
*DATA : gt_data3 LIKE TABLE OF GS_DATA3.

*"4. 구조체선언 - 인터널테이블 선언
*
*DATA : BEGIN OF gs_data4,
*  col1 TYPE c LENGTH 10,
*   col2 TYPE c LENGTH 10,
*   col3 TYPE c LENGTH 10,
*   END OF GS_DATA4.
*
*DATA : gt_data4 like TABLE OF GS_DATA4.'

*DATA : BEGIN OF gs_tan4,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF gs_tan4.
*
*DATA : gt_tan4 LIKE TABLE OF gs_tan4.

*"5. 인터널 테이블 선언
*
*DATA : BEGIN OF gt_data5 occurs 0, "gt_data5가 테이블이면서 헤더가 됨
*  col1 TYPE c LENGTH 10,
*   col2 TYPE c LENGTH 10,
*   col3 TYPE c LENGTH 10,
*   END OF gt_data5. "occurs 0은 선언하려고 잠깐 메모리를 할당을 할것이라는 구문

*DATA : BEGIN OF gt_tan5 occurs 0,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF gt_tan5.

"global 선언 방식 (이전것이 local 선언 방식)
"1. 전체 필드 참조해서 인터널 테이블 선언 se11참조
*DATA : gt_scarr TYPE TABLE OF scarr WITH HEADER LINE. "gt_scarr가 헤더라인도 가지고 있는 인터널 테이블로 선언이됨
"구조체 이면서 헤더라인...

*DATA : BEGIN OF gt_scarr1 occurs 0,
*  carrid TYPE scarr-carrid,
*  carrname TYPE scarr-carrname,
*  END OF gt_scarr1.

"append - 값 할당 + 추가
"3. 구조체 타입 - 구조체선언 - 인터널테이블

*TYPES : BEGIN OF ty_str,
*  no TYPE c LENGTH 4,
*  name TYPE c LENGTH 15,
*  dept TYPE c LENGTH 15,
*  END OF ty_str.
*
*DATA : gs_data TYPE ty_str.
*DATA : gt_data like TABLE OF gs_data.
*
*gs_data-no = '0001'.
*gs_data-name = 'tan'.
*gs_data-dept = 'dept'.
*
*APPEND GS_DATA to gt_data.
*clear GS_DATA. "정확히 clear까지 해줌
*
*gs_data-no = '0003'.
*gs_data-name = 'tan2'.
*gs_data-dept = 'dept2'.
*
*APPEND GS_DATA to gt_data.
*clear GS_DATA. "정확히 clear까지 해줌

"4. 구조체 선언 - 인터널테이블 선언
DATA : BEGIN OF gs_data3,
  no(4) TYPE c,
  name(15) TYPE c,
  dept(15) TYPE c,
  END OF GS_DATA3.

DATA : gt_data3 LIKE TABLE OF GS_DATA3.

GS_DATA3-no = '0001'.
GS_DATA3-name = '홍길동'.
GS_DATA3-dept = '구매'.

APPEND GS_DATA3 to gt_data3.
clear GS_DATA3.

GS_DATA3-no = '0002'.
GS_DATA3-name = '홍길동2'.
GS_DATA3-dept = '영업'.

APPEND GS_DATA3 to gt_data3.
clear GS_DATA3.

GS_DATA3-no = '0003'.
GS_DATA3-NAME = '김김김'.
GS_DATA3-dept = '생산'.

APPEND GS_DATA3 to gt_data3.
clear GS_DATA3.

LOOP AT gt_data3 INTO GS_DATA3.
  WRITE : /  gs_data3-no,
             gs_data3-NAME,
             gs_data3-dept.
ENDLOOP.
*BREAK-POINT.

"인터널테이블 선언
DATA : BEGIN OF gt_data8 occurs 0,
  no(10) type c,
  name(15) TYPE c,
  dept(15) TYPE c,
  END OF gt_data8.

gt_data8-no = '0001'.
gt_data8-NAME = '홍길동'.
gt_data8-dept = '구매'.

APPEND gt_data8 . "to gt_data8. 생략 가능.
CLEAR gt_data8.

gt_data8-no = '0002'.
gt_data8-NAME = '김김김'.
gt_data8-dept = '영업'.

APPEND gt_data8.
CLEAR gt_data8.

"추가로 loop

LOOP at gt_data8.
  WRITE : / gt_data8-no,
            gt_data8-NAME,
            gt_data8-dept.
endloop.

*BREAK-POINT.

"ex) 학번(no, char4) / 이름(name, char15) / 성별(gend, char5)
"1.인터널 테이블 선언 2.값 할당 3개씩 3.loop 출력
DATA : BEGIN OF gt_tan1 occurs 0,
  no(4) TYPE c,
  name(15) TYPE c,
  gend(5) TYPE c,
  END OF gt_tan1.

gt_tan1-no = '1234'.
gt_tan1-NAME = 'tan1'.
gt_tan1-GEND = 'girl'.

APPEND gt_tan1.
CLEAR gt_tan1.

gt_tan1-no = '1234'.
gt_tan1-NAME = 'tan2'.
gt_tan1-GEND = 'man'.

APPEND gt_tan1.
CLEAR gt_tan1.

gt_tan1-no = '1234'.
gt_tan1-NAME = 'tan3'.
gt_tan1-GEND = 'both'.

APPEND gt_tan1.
CLEAR gt_tan1.

LOOP AT gt_tan1.
  WRITE : / gt_tan1-no,
            gt_tan1-NAME,
            gt_tan1-GEND.
ENDLOOP.


"select
DATA : gt_scarr3 TYPE TABLE OF scarr. "WITH HEADER LINE. "gt_scarr3가 구조체이면서 헤더라인
DATA : gs_scarr3 TYPE scarr.

select *
  FROM scarr
  INTO TABLE gt_scarr3.

LOOP AT gt_scarr3 INTO gs_scarr3.
  WRITE : / gs_scarr3-carrid,
          gs_scarr3-carrname.
ENDLOOP.


DATA : BEGIN OF gt_scarr4 occurs 0,
       airlcd TYPE scarr-carrid,
       airlnm TYPE scarr-carrname,
       END OF gt_scarr4.

select carrid as airlcd
       carrname as airlnm
  FROM scarr
  INTO TABLE gt_scarr4.

LOOP AT gt_scarr4. "into gt_scarr4. 생략가능
  WRITE: / gt_scarr4-airlcd,
           gt_scarr4-airlnm.
ENDLOOP.

*  BREAK-POINT.
