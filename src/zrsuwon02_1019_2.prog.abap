*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1019_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1019_2.

CLASS C1 DEFINITION. "정의부
  PUBLIC SECTION. "누구나 사용 할 수 있는 CLASS.
  "PROTECTED는 부모와 자식 사이에서만 사용 가능
  "PRIVATE는 같은 클래스 안에서만 사용 가능
  METHODS M1.
ENDCLASS.

CLASS C1 IMPLEMENTATION. "실행부
  METHOD M1.
    WRITE : / 'CLASS TEST'.
  ENDMETHOD.
ENDCLASS.

DATA : GO_1 TYPE REF TO C1. "객체 참조 변수

START-OF-SELECTION.

CREATE OBJECT GO_1. "객체 생성
CALL METHOD GO_1->M1. "메소드 호출
