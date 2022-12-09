*&---------------------------------------------------------------------*
*& Include          ZRSUWON02_1020_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT ZCODE ZNAME
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM ztsuwon02_hr
    WHERE ZCODE IN S_ZCODE.

  LOOP AT GT_DATA INTO GS_DATA.
    LV_TABIX = SY-TABIX. "LOOP안에서 TABLE INDEX. LINE 수를 가지고 있음.

    GS_DATA-INT = LV_TABIX.

    MODIFY GT_DATA FROM GS_DATA.
    CLEAR GS_DATA.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object .
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
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CONTAINER_2
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
ENDFORM.
*&---------------------------------------------------------------------*
*& Form FIELD_CATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM field_catalog .
  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT = '코드'.
  GS_FCAT-KEY = 'X'. "ABAP에서는 TRUE/FULSE OR ON/OFF OR 1/0
  GS_FCAT-JUST = 'C'. "C, R, L 정렬
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
*  GS_FCAT-COLTEXT = '코드명'.
  GS_FCAT-SCRTEXT_L = 'LONGLONGLONG'.
  GS_FCAT-SCRTEXT_M = '중간중간'.
  GS_FCAT-SCRTEXT_S = 'S'. "길이에 따라 보이는 필드명이 달라짐
  GS_FCAT-EMPHASIZE = 'C300'. "C(COLOR) 3(노랑) 0(강조) 0(반전)
  GS_FCAT-HOTSPOT = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'CHECK'.
  GS_FCAT-COLTEXT = '체크박스'.
  GS_FCAT-CHECKBOX = 'X'. "체크박스
  GS_FCAT-EDIT = 'X'. "체크박스 에딧 설정
  GS_FCAT-OUTPUTLEN = 8.
*  GS_FCAT-NO_OUT = 'X'. "필드 숨김(HIDE)
*  GS_FCAT-TECH = 'X'. "아예 레이아웃에서도 숨김
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'INT'.
  GS_FCAT-COLTEXT = '숫자'.
  GS_FCAT-NO_ZERO = 'X'.
*  GS_FCAT-DO_SUM = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM layout .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

  CALL METHOD gc_grid_1->set_table_for_first_display
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      is_variant                    = GS_VARIANT
      i_save                        = 'A' "I_SAVE : A = X + U
      i_default                     = 'X' "X를 삭제하면 버튼이 빠짐
*      is_layout                     =
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          =
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA
      it_fieldcatalog               = GT_FCAT
      it_sort                       = GT_SORT
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

    CALL METHOD gc_grid_2->set_table_for_first_display
*    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
*      is_layout                     =
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          =
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA
      it_fieldcatalog               = GT_FCAT
*      it_sort                       =
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ETC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM etc .
  GS_SORT-FIELDNAME = 'ZNAME'.
  GS_SORT-UP = 'X'. "오름차순
  GS_SORT-SPOS = 1. "SORT ORDER
  GS_SORT-SUBTOT = 'X'. "부분합계
  APPEND GS_SORT TO GT_SORT.
  CLEAR GS_SORT.

  GS_VARIANT-REPORT = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME. "다양한 LAYOUT 설정가능
*  GS_VARIANT-VARIANT = '/Z215'. "DEFAULT LAYOUT
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh .
  DATA : LS_STABLE TYPE LVC_S_STBL.
  LS_STABLE-ROW = 'X'.
  LS_STABLE-COL = 'X'.

  CALL METHOD gc_grid_1->refresh_table_display
      EXPORTING
        is_stable      = LS_STABLE
*        i_soft_refresh =
*      EXCEPTIONS
*        finished       = 1
*        others         = 2
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.
ENDFORM.
