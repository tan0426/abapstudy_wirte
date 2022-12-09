*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1020_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1020_2.

TABLES : ztsuwon02_hr.
DATA : BEGIN OF GS_DATA,
        ZCODE LIKE ztsuwon02_hr-ZCODE,
        ZNAME LIKE ztsuwon02_hr-ZNAME,
        CHECK,
        INT TYPE I,
        INFO(4),
        CTAB TYPE LVC_T_SCOL,
        STYLE TYPE LVC_T_STYL,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.
DATA : GS_FCAT TYPE LVC_S_FCAT,
       GT_FCAT TYPE LVC_T_FCAT.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : LV_TABIX TYPE SY-TABIX.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.
DATA : GC_SPLITTER TYPE REF TO CL_GUI_SPLITTER_CONTAINER.
DATA : GC_CONTAINER_1 TYPE REF TO CL_GUI_CONTAINER.
DATA : GC_CONTAINER_2 TYPE REF TO CL_GUI_CONTAINER.
DATA : GC_GRID_1 TYPE REF TO CL_GUI_ALV_GRID.
DATA : GC_GRID_2 TYPE REF TO CL_GUI_ALV_GRID.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.
DATA : GT_TOOLBAR TYPE UI_FUNCTIONS.
DATA : GS_SCOL TYPE LVC_S_SCOL.
DATA : GS_STYLE TYPE LVC_S_STYL.

SELECT-OPTIONS S_ZCODE FOR ztsuwon02_hr-ZCODE.

INITIALIZATION.
START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM ztsuwon02_hr
    WHERE ZCODE IN S_ZCODE.

LOOP AT GT_DATA INTO GS_DATA.
  LV_TABIX = SY-TABIX.
  GS_DATA-INT = LV_TABIX.
  IF LV_TABIX = 2.
    GS_DATA-INFO = 'C610'.
  ENDIF.

  IF LV_TABIX = 4.
    GS_SCOL-FNAME = 'ZNAME'.
    GS_SCOL-COLOR-COL = 5.
    GS_SCOL-COLOR-INT = 0.
    GS_SCOL-COLOR-INV = 0.
    APPEND GS_SCOL TO GS_DATA-CTAB.
    CLEAR GS_SCOL.
  ENDIF.

  IF LV_TABIX = 6.
    GS_STYLE-FIELDNAME = 'CHECK'.
    GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.
    APPEND GS_STYLE TO GS_DATA-STYLE.
  ENDIF.
  MODIFY GT_DATA FROM GS_DATA.
  CLEAR GS_DATA.
ENDLOOP.

CALL SCREEN 100.
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
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_alv_0100 OUTPUT.
  CREATE OBJECT gc_docking
    EXPORTING
*      parent                      =
      repid                       = SY-REPID
      dynnr                       = SY-DYNNR
*      side                        = DOCK_AT_LEFT
      extension                   = 5000
*      style                       =
*      lifetime                    = lifetime_default
*      caption                     =
*      metric                      = 0
*      ratio                       =
*      no_autodef_progid_dynnr     =
*      name                        =
*    EXCEPTIONS
*      cntl_error                  = 1
*      cntl_system_error           = 2
*      create_error                = 3
*      lifetime_error              = 4
*      lifetime_dynpro_dynpro_link = 5
*      others                      = 6
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT gc_splitter
    EXPORTING
*      link_dynnr        =
*      link_repid        =
*      shellstyle        =
*      left              =
*      top               =
*      width             =
*      height            =
*      metric            = cntl_metric_dynpro
*      align             = 15
      parent            = GC_DOCKING
      rows              = 1
      columns           = 2
*      no_autodef_progid_dynnr =
*      name              =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CALL METHOD gc_splitter->get_container
    EXPORTING
      row       = 1
      column    = 1
    RECEIVING
      container = GC_CONTAINER_1.

  CALL METHOD gc_splitter->get_container
    EXPORTING
      row       = 1
      column    = 2
    RECEIVING
      container = GC_CONTAINER_2.

  CREATE OBJECT gc_grid_1
    EXPORTING
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CONTAINER_1
*      i_appl_events     = SPACE
*      i_parentdbg       =
*      i_applogparent    =
*      i_graphicsparent  =
*      i_name            =
*      i_fcat_complete   = SPACE
*      o_previous_sral_handler =
*    EXCEPTIONS
*      error_cntl_create = 1
*      error_cntl_init   = 2
*      error_cntl_link   = 3
*      error_dp_create   = 4
*      others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT gc_grid_2
      EXPORTING
*        i_shellstyle      = 0
*        i_lifetime        =
        i_parent          = GC_CONTAINER_2
*        i_appl_events     = SPACE
*        i_parentdbg       =
*        i_applogparent    =
*        i_graphicsparent  =
*        i_name            =
*        i_fcat_complete   = SPACE
*        o_previous_sral_handler =
*      EXCEPTIONS
*        error_cntl_create = 1
*        error_cntl_init   = 2
*        error_cntl_link   = 3
*        error_dp_create   = 4
*        others            = 5
        .
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT = '코드'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-COLTEXT = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'CHECK'.
*  GS_FCAT-EDIT = 'X'. "수정모드
  GS_FCAT-COLTEXT = '체크박스'.
  GS_FCAT-CHECKBOX = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'INT'.
  GS_FCAT-COLTEXT = '숫자'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_LAYOUT-ZEBRA = 'X'. "얼룩말 무늬로 표시
  GS_LAYOUT-CWIDTH_OPT = 'X'. "너비 최적화 OUTPUT LENGTH보다 우선순위
  GS_LAYOUT-GRID_TITLE = '그리드 첫번째 입니다.'. "주의사항 등 타이틀...
  GS_LAYOUT-SMALLTITLE = 'X'. "타이틀을 작게 만듦
*  GS_LAYOUT-NO_TOOLBAR = 'X'.
  GS_LAYOUT-SEL_MODE = 'D'. "D > A > C > B = SPACE D:다중선택 가능
  GS_LAYOUT-INFO_FNAME = 'INFO'.
  GS_LAYOUT-CTAB_FNAME = 'CTAB'.
  GS_LAYOUT-STYLEFNAME = 'STYLE'.

  CALL METHOD gc_grid_1->set_ready_for_input
    EXPORTING
      i_ready_for_input = 1
      .


*  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_TOOLBAR.
  APPEND '&LOCAL&DELETE_ROW' TO GT_TOOLBAR.
    CALL METHOD gc_grid_1->set_table_for_first_display
      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
*        i_structure_name              =
*        is_variant                    =
*        i_save                        =
*        i_default                     = 'X'
        is_layout                     = GS_LAYOUT
*        is_print                      =
*        it_special_groups             =
        it_toolbar_excluding          = GT_TOOLBAR
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = GT_DATA
        it_fieldcatalog               = GT_FCAT
*        it_sort                       =
*        it_filter                     =
*      EXCEPTIONS
*        invalid_parameter_combination = 1
*        program_error                 = 2
*        too_many_lines                = 3
*        others                        = 4
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

    CALL METHOD gc_grid_2->set_table_for_first_display
*      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
*        i_structure_name              =
*        is_variant                    =
*        i_save                        =
*        i_default                     = 'X'
*        is_layout                     =
*        is_print                      =
*        it_special_groups             =
*        it_toolbar_excluding          =
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = GT_DATA
        it_fieldcatalog               = GT_FCAT
*        it_sort                       =
*        it_filter                     =
*      EXCEPTIONS
*        invalid_parameter_combination = 1
*        program_error                 = 2
*        too_many_lines                = 3
*        others                        = 4
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.




ENDMODULE.
