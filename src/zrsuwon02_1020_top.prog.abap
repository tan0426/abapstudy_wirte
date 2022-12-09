*&---------------------------------------------------------------------*
*& Include          ZRSUWON02_1020_TOP
*&---------------------------------------------------------------------*

TABLES : ztsuwon02_hr.

DATA : BEGIN OF GS_DATA,
        ZCODE TYPE ZTSUWON02_HR-ZCODE,
        ZNAME TYPE ztsuwon02_hr-ZNAME,
        CHECK,
        INT TYPE I,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.

DATA : GS_FCAT TYPE LVC_S_FCAT,
       GT_FCAT TYPE LVC_T_FCAT.
DATA : GS_SORT TYPE LVC_S_SORT,
       GT_SORT TYPE LVC_T_SORT.
DATA : GS_VARIANT TYPE DISVARIANT.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.
DATA : GC_SPLITTER TYPE REF TO CL_GUI_SPLITTER_CONTAINER.
DATA : GC_CONTAINER_1 TYPE REF TO CL_GUI_CONTAINER.
DATA : GC_CONTAINER_2 TYPE REF TO CL_GUI_CONTAINER.
DATA : GC_GRID_1 TYPE REF TO CL_GUI_ALV_GRID.
DATA : GC_GRID_2 TYPE REF TO CL_GUI_ALV_GRID.

DATA : LV_TABIX TYPE SY-TABIX.

DATA : GV_CHAR(10).
