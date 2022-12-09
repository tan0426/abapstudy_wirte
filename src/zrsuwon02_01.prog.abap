*&---------------------------------------------------------------------*
*& Report ZRSUWON02_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_01.

"명령어 / 변수명 / 명령어 연결 / 참조할 것

DATA GV_NUM1 TYPE I.

DATA GV_NUM2 TYPE I VALUE 3.

GV_NUM1 = 5.

WRITE GV_NUM1.
WRITE GV_NUM2.

"LIKE는 INT같은 것이 아닌것을 참조
DATA GV_NUM3 TYPE I.
DATA GV_NUM4 LIKE GV_NUM3.

GV_NUM3 = 1.
GV_NUM4 = 3.

NEW-LINE. "줄바꿈
WRITE GV_NUM3.
WRITE GV_NUM4.

DATA GV_NUM5 TYPE I.
DATA GV_NUM6 LIKE GV_NUM5.

GV_NUM6 = 30.
GV_NUM5 = GV_NUM6.

NEW-LINE.
WRITE : GV_NUM5, GV_NUM6. ": 은 다중 처리

DATA : GV_NUM7 TYPE I,
       GV_NUM8 LIKE GV_NUM7.

GV_NUM7 = 10.

MOVE GV_NUM7 TO GV_NUM8. "MOVE A TO B

WRITE : / GV_NUM7, GV_NUM8. "/하고 한칸 띄움

CLEAR : GV_NUM7, GV_NUM8. "값 초기화

WRITE : / 'CLEAR', GV_NUM7, GV_NUM8.

TYPES GV_NUM9 TYPE I. "TYPES로 선언한것은 DATA와같이 변수선언된? 것이 아니다. 타입으로만 들어감..
DATA GV_NUM10 TYPE GV_NUM9.

GV_NUM10 = 2.

WRITE : / GV_NUM10.

TYPES TY_NUM11 TYPE I. "변수X / 타입
DATA GV_NUM12 TYPE TY_NUM11.

CONSTANTS GV_NUM13 TYPE I VALUE 20. "CONSTANTS : 상수. 변하지 않는 값이기 때문에 VALUE를 넣어줘야함
*GV_NUM13 = 10. "상수를 변경시키기 때문에 오류

DATA : GV_NUM14 TYPE N. "NUMERIC TYPE
GV_NUM14 = 4.

WRITE : GV_NUM14.

DATA : GV_NUM15 TYPE N LENGTH 2."N등은 길이 지정 가능
GV_NUM15 = 4.

WRITE : / GV_NUM15.

DATA : GV_NUM16 TYPE N LENGTH 1 VALUE 1234,
       GV_NUM17 TYPE N LENGTH 2 VALUE 1234,
       GV_NUM18 TYPE N LENGTH 3 VALUE 1234,
       GV_NUM19 TYPE N LENGTH 4 VALUE 1234.

WRITE : / GV_NUM16,
          GV_NUM17,
          GV_NUM18,
          GV_NUM19.

"P 소숫점
DATA : GV_NUM20 TYPE P LENGTH 8 DECIMALS 2 VALUE '2.34'. "소숫점이기때문에 DECIMALS있어야 함.
DATA : GV_NUM21 TYPE P DECIMALS 2 VALUE '2.34'.

WRITE : / GV_NUM20, GV_NUM21.

GV_NUM21 = '5.78'.

DATA : GV_RESULT22 TYPE P DECIMALS 2.

GV_RESULT22 = GV_NUM20 - GV_NUM21.

WRITE : / GV_RESULT22.

GV_RESULT22 = ABS( GV_RESULT22 ). "괄호 사이에 스페이스가 두개 들어가야 함. ABS는 절대값

WRITE : / GV_RESULT22.

DATA : GV_NUM23 TYPE I, GV_NUM24 LIKE GV_NUM23, GV_RESULT25 LIKE GV_NUM24.

GV_NUM23 = 3.
GV_NUM24 = 5.

GV_RESULT25 = GV_NUM23 + GV_NUM24.

WRITE : / GV_RESULT25.

CLEAR : GV_RESULT25.
GV_RESULT25 = GV_NUM23 - GV_NUM24.

WRITE : / GV_RESULT25.

GV_RESULT25 = GV_NUM23 * GV_NUM24.

WRITE : / GV_RESULT25.

GV_RESULT25 = GV_NUM23 / GV_NUM24.

WRITE : / GV_RESULT25. "TYPE 지정이 I 이기때문에 반올림 하는듯.

GV_RESULT25 = GV_NUM23 DIV GV_NUM24. "DIV는 몫

WRITE : / 'DIV', GV_RESULT25.

GV_RESULT25 = GV_NUM23 MOD GV_NUM24. "MOD는 나머지

WRITE : / 'MOD', GV_RESULT25.

DATA : GV_DAY26 TYPE D.

*BREAK-POINT. "BREAK POINT

GV_DAY26 = '220929'.

WRITE : / GV_DAY26.

GV_DAY26 = SY-DATUM. "TYPE D, SY-DATUM은 시스템 날짜 인듯.

WRITE : / GV_DAY26.

DATA : GV_TIME27 TYPE T. " TYPE T, SY-UZEIT은 해당 날짜 시간인듯.

GV_TIME27 = SY-UZEIT.

WRITE : / GV_TIME27.

"왼쪽을 클릭하면 BREAKING POINT = 디버깅.브레이킹 포인트가 됨. 로직 실행부분만 설정 가능.

GV_DAY26 = GV_DAY26 - 1.
WRITE : / GV_DAY26.

GV_TIME27 = GV_TIME27 - 60.
WRITE : / GV_TIME27.

TYPES GV_CHAR TYPE C LENGTH 4.

DATA : GV_CHAR28 TYPE GV_CHAR.
GV_CHAR28 = 'ABC'.

WRITE : / GV_CHAR28.

DATA : GV_CHAR29 TYPE C LENGTH 3 VALUE 'DEF'.
DATA : GV_CHAR30 TYPE C. "한자리
DATA : GV_CHAR31. "CHAR, 자릿수 한자리
DATA : GV_CHAR32(3). "세자리
DATA : GV_CHAR33(4) TYPE C.

DATA : GV_NUM34 TYPE I.

WRITE : / GV_CHAR29.
GV_CHAR30 = '123'.
WRITE : / GV_CHAR30.

GV_CHAR33 = '333'.
WRITE : / GV_CHAR33.

GV_NUM34 = STRLEN( GV_CHAR33 ). "STRLEN : 문자의 길이
WRITE : GV_NUM34.

DATA : GV_CHAR35(2), GV_CHAR36(2), GV_CHAR37(4).

GV_CHAR35 = 'AB'.
GV_CHAR36 = 'AP'.

CONCATENATE GV_CHAR35 GV_CHAR36 INTO GV_CHAR37. "문자를 합쳐서 GV_CHACR37에 대입
WRITE : / GV_CHAR37.

DATA : GV_CHAR38(5),
       GV_CHAR39(5),
       GV_CHAR40(5).

GV_CHAR38 = '12/34'. "/는 쪼갠다는 의미로 쓰임

SPLIT GV_CHAR38 AT '/' INTO GV_CHAR39 GV_CHAR40. "38의 데이터를 /라는 기준으로 나눠서 각각 두 변수에 넣는다는 의미

WRITE : / GV_CHAR38, GV_CHAR39, GV_CHAR40.

DATA : GV_CHAR41(10),
       GV_CHAR42(10).

GV_CHAR41 = 'A        B'.
GV_CHAR42 = GV_CHAR41.

WRITE : / GV_CHAR41.

CONDENSE GV_CHAR41. "최소 공백 하나를 남기고 공백을 없앰.
WRITE : / GV_CHAR41.

CONDENSE GV_CHAR42 NO-GAPS. "공백을 모두 없앰.
WRITE : / GV_CHAR42.

*---------------------------------------------------------------변수 선언 예제 끝
