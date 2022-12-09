*&---------------------------------------------------------------------*
*& Report ZDSUWON02_TEST_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdsuwon02_test_01.

INCLUDE ZDSUWON02_TEST_01_TOP.
INCLUDE ZDSUWON02_TEST_01_SCR.
INCLUDE ZDSUWON02_TEST_01_PBO.
INCLUDE ZDSUWON02_TEST_01_PAI.
INCLUDE ZDSUWON02_TEST_01_F01.

START-OF-SELECTION.
  PERFORM GET_DATA.

CALL SCREEN 100.
PERFORM CALL_FUNCTION.
