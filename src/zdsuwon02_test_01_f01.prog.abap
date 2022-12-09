*&---------------------------------------------------------------------*
*& Include          ZDSUWON02_TEST_01_F01
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
    FROM ZTSUWON02_HR
    WHERE ZCODE IN S_ZCODE.

*  SORT GT_DATA.

  LOOP AT GT_DATA INTO GS_DATA.
    LV_TABIX = SY-TABIX.
    GS_DATA-INT = LV_TABIX.
    IF LV_TABIX = 2.
      GS_DATA-INFO = 'C610'.
    ENDIF.

    IF LV_TABIX = 4.
      GS_SCOL-FNAME = 'ZNAME'.
      GS_SCOL-COLOR-COL = 5.
      GS_SCOL-COLOR-INT = 1.
      GS_SCOL-COLOR-INV = 0.
      APPEND GS_SCOL TO GS_DATA-CTAB.
      CLEAR GS_SCOL.
    ENDIF.
    IF LV_TABIX = 6.
      GS_STYLE-FIELDNAME = 'CHECK'.
*      GS_STYLE-STYLE = '00100000'.
*      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.
      APPEND GS_STYLE TO GS_DATA-STYLE.
      CLEAR GS_STYLE.
    ENDIF.
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
      container = GC_CONTAINER_1
      .

  CALL METHOD gc_splitter->get_container
    EXPORTING
      row       = 1
      column    = 2
    RECEIVING
      container = GC_CONTAINER_2
      .

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
*  GS_FCAT-KEY = 'X'.
*  GS_FCAT-JUST = 'C'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-COLTEXT = '코드명'.
*  GS_FCAT-HOTSPOT = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'CHECK'.
  GS_FCAT-COLTEXT = '체크박스'.
  GS_FCAT-CHECKBOX = 'X'.
*  GS_FCAT-EDIT = 'X'.
  GS_FCAT-OUTPUTLEN = 8.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'INT'.
  GS_FCAT-COLTEXT = '숫자'.
  GS_FCAT-NO_ZERO = 'X'.
*  GS_FCAT-DO_SUM = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR GS_FCAT.
 """""""""""""""""""""""""""""""""""""""
  GS_FCAT2-FIELDNAME = 'ZCODE'.
  GS_FCAT2-SELTEXT_L = '코드명롱롱롱'.
  GS_FCAT2-SELTEXT_M = '코드명미드'.
  GS_FCAT2-SELTEXT_S = '코드명숏'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'ZNAME'.
  GS_FCAT2-SELTEXT_L = '코드명롱롱롱'.
  GS_FCAT2-SELTEXT_M = '코드명미드'.
  GS_FCAT2-SELTEXT_S = '코드명숏'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.



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
  GS_SORT-UP = 'X'.
  GS_SORT-SPOS = 1.
  GS_SORT-SUBTOT = 'X'.
  APPEND GS_SORT TO GT_SORT.
  CLEAR GS_SORT.

  GS_VARIANT-REPORT = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME.
*  GS_VARIANT-variant = '/Z215'.

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
  GS_LAYOUT-ZEBRA = 'X'.
  GS_LAYOUT-CWIDTH_OPT = 'X'.
  GS_LAYOUT-GRID_TITLE = '그리드 첫번째'.
  GS_LAYOUT-SMALLTITLE = 'X'.
*  GS_LAYOUT-NO_TOOLBAR = 'X'.
  GS_LAYOUT-SEL_MODE = 'D'. "D > A > C > B = SPACE D:다중선택 가능

  GS_LAYOUT-INFO_FNAME = 'INFO'.
  GS_LAYOUT-CTAB_FNAME = 'CTAB'.
  GS_LAYOUT-STYLEFNAME = 'STYLE'.

  CALL METHOD gc_grid_1->set_ready_for_input
    EXPORTING
      i_ready_for_input = 1 "최 우선적임. GS_FCAT-EDIT보다 우선.
      .

*  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_TOOLBAR.
  APPEND '&LOCAL&DELETE_ROW' TO GT_TOOLBAR.


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
      i_save                        = 'A'
      i_default                     = 'X'
      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
      it_toolbar_excluding          = GT_TOOLBAR
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
*& Form REFRESH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh .
*  DATA : LS_STABLE TYPE LVC_S_STBL.
*  LS_STABLE-ROW = ''.
*  LS_STABLE-COL = ''.

  CALL METHOD gc_grid_1->refresh_table_display
*    EXPORTING
*      is_stable      = LS_STABLE
*      i_soft_refresh =
*    EXCEPTIONS
*      finished       = 1
*      others         = 2
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_FUNCTION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM call_function .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
     I_CALLBACK_PROGRAM                = 'SY-REPID'
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
     I_GRID_TITLE                      = 'CALL FINCTION'
*     I_GRID_SETTINGS                   =
     IS_LAYOUT                         = GS_LAYOUT2
     IT_FIELDCAT                       = GT_FCAT2
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT                           =
*     IT_FILTER                         =
*     IS_SEL_HIDE                       =
*     I_DEFAULT                         = 'X'
*     I_SAVE                            = ' '
*     IS_VARIANT                        =
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT                          =
*     IS_REPREP_ID                      =
     I_SCREEN_START_COLUMN             = 10
     I_SCREEN_START_LINE               = 10
     I_SCREEN_END_COLUMN               = 100
     I_SCREEN_END_LINE                 = 80
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER           =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab                          = GT_DATA
*   EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS                            = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
