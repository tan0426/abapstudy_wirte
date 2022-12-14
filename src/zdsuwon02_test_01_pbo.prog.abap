*&---------------------------------------------------------------------*
*& Include          ZDSUWON02_TEST_01_PBO
*&---------------------------------------------------------------------*
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
*& Module DISPLAY OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE DISPLAY OUTPUT.
  IF GC_DOCKING IS INITIAL.
    PERFORM CREATE_OBJECT.
    PERFORM FIELD_CATALOG.
    PERFORM ETC.
    PERFORM LAYOUT.
    PERFORM DISPLAY_ALV.
  ELSE.
    PERFORM REFRESH.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.
ENDMODULE.
