*&---------------------------------------------------------------------*
*& Include          ZRSUWON02_F01
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

  LOOP AT GT_DATA.
    LV_TABIX = SY-TABIX.
    GT_DATA-INT = LV_TABIX.

    IF LV_TABIX = 2.
      GT_DATA-INFO = 'C500'.
    ENDIF.

    IF LV_TABIX = 4.
      CLEAR GS_SCOL.
      GS_SCOL-FNAME = 'INT'.
      GS_SCOL-COLOR-COL = 7.
*      GS_SCOL-COLOR-INT = 1.
*      GS_SCOL-COLOR-INV = 1.
*      GS_SCOL-NOKEYCOL = 'X'. "키를 일반 컬럼으로 표시 / 그냥 이거 체크 안 해도 색상 넣어짐
*
*      INSERT GS_SCOL INTO TABLE GT_DATA-CTAB.
      APPEND GS_SCOL TO GT_DATA-CTAB.
    ENDIF.

    IF LV_TABIX = 6.
      GS_STYLE-FIELDNAME = 'CHECK'.
*      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
*      GS_STYLE-STYLE = '00100000'.

      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.
*      GS_STYLE-TYLE = '00080000'.

*      INSERT GS_STYLE INTO TABLE GT_DATA-STYLE.
      APPEND GS_STYLE TO GT_DATA-STYLE.
    ENDIF.

    MODIFY GT_DATA.
    CLEAR GT_DATA.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OBJECT
*&      --> E_INTERDACTIVE
*&---------------------------------------------------------------------*
FORM alv_handle_toolbar  USING    e_object TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                                  e_interdactive TYPE CHAR01.

  "E_OBJECT->MT_TOOLBAR
  "MT_TOOLBAR - TTB_BUTTON - STB_BUTTON
  "APPEND A TO b / APPEND A TO E_OBJECT->MY_TOOLBAR

  DATA : LS_TOOLBAR TYPE STB_BUTTON.

  LS_TOOLBAR-FUNCTION = 'MESSAGE'.
  LS_TOOLBAR-ICON = ICON_CHECKED. "NAME
*  LS_TOOLBAR-ICON = '@01@'.
  LS_TOOLBAR-QUICKINFO = '도움말'.
  LS_TOOLBAR-BUTN_TYPE = 0.
  LS_TOOLBAR-TEXT = '메세지'.

  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-BUTN_TYPE = 3.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'APPEND'.
  LS_TOOLBAR-ICON = '@01@'.
  LS_TOOLBAR-QUICKINFO = '퀵퀵'.
*  LS_TOOLBAR-BUTN_TYPE
  LS_TOOLBAR-TEXT = '라인추가'.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'MENU1'.
*  LS_TOOLBAR-ICON = '@01@'.
*  LS_TOOLBAR-QUICKINFO = '퀵퀵'.
*  LS_TOOLBAR-BUTN_TYPE
  LS_TOOLBAR-TEXT = '메뉴1'.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'MENU2'.
  LS_TOOLBAR-BUTN_TYPE = 2.
  LS_TOOLBAR-TEXT = '메뉴2'.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'NAME'.
  LS_TOOLBAR-TEXT = '네임'.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
  CLEAR LS_TOOLBAR.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_UCOMM
*&---------------------------------------------------------------------*
FORM alv_handle_user_command  USING e_ucomm TYPE SY-UCOMM.
  "DATA : OK_CODE TYPE SY-UCOMM

  DATA : LT_INDEX_ROWS TYPE LVC_T_ROW.
  DATA : LT_ROW_NO TYPE LVC_T_ROID.

  DATA : LS_ROW_NO TYPE LVC_S_ROID.

  CASE E_UCOMM. "CASE OK_CODE
    WHEN 'MESSAGE'.
      MESSAGE '대단히 반값습니다.' TYPE 'I'.
    WHEN 'APPEND'.
      READ TABLE GT_DATA INDEX 1.

      APPEND GT_DATA.

      PERFORM REFRESH.
    WHEN 'MENU1'.
      MESSAGE 'MENU1' TYPE 'I'.
    WHEN 'MENU2'.
      MESSAGE 'MENU2' TYPE 'I'.
    WHEN 'SUB_MENU1'.
      MESSAGE 'SUB_MENU1' TYPE 'I'.
    WHEN 'SUB_MENU2'.
      MESSAGE 'SUB_MENU2' TYPE 'I'.
    WHEN 'NAME'.
*      CLEAR GT_DATA.
*      READ TABLE GT_DATA INDEX 1.
*
*      MESSAGE GT_DATA-NAME TYPE 'I'.

       CALL METHOD gc_grid_1->get_selected_rows
         IMPORTING
           et_index_rows = LT_INDEX_ROWS
           et_row_no     = LT_ROW_NO.

      LOOP AT LT_ROW_NO INTO LS_ROW_NO. "여러 라인 선택해도 수행 함. LOOP라서.
        CLEAR GT_DATA.
        READ TABLE GT_DATA INDEX LS_ROW_NO-ROW_ID.

        MESSAGE GT_DATA-ZNAME TYPE 'I'.

      ENDLOOP.

*  	WHEN OTHERS.

  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_MENU_BUTTON
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OOBJECT
*&      --> E_UCOMM
*&---------------------------------------------------------------------*
FORM alv_handle_menu_button  USING e_object TYPE REF TO CL_CTMENU
                                   e_ucomm TYPE SY-UCOMM.

  CASE E_UCOMM.
    WHEN 'MENU1' OR 'MENU2'.
      CALL METHOD e_object->add_function
        EXPORTING
          fcode             = 'SUB_MENU1'
          TEXT              = '첫번째'
*          icon              =
*          ftype             =
*          disabled          =
*          hidden            =
*          checked           =
*          accelerator       =
*          insert_at_the_top = SPACE
          .
    CALL METHOD e_object->add_function
      EXPORTING
        fcode             = 'SUB_MENU2'
        TEXT              = '두번째'
*        icon              =
*        ftype             =
*        disabled          =
*        hidden            =
*        checked           =
*        accelerator       =
*        insert_at_the_top = SPACE
        .
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.

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

  CALL METHOD gc_splitter->set_column_width
    EXPORTING
      id                = 1
      width             = 90
*    IMPORTING
*      result            =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

  CALL METHOD gc_splitter->set_column_width
    EXPORTING
      id                = 2
      width             = 10
*    IMPORTING
*      result            =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.


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
  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
   EXPORTING
     I_PROGRAM_NAME               = SY-REPID
     I_INTERNAL_TABNAME           = 'GT_DATA'
*     I_STRUCTURE_NAME             =
*     I_CLIENT_NEVER_DISPLAY       = 'X'
     I_INCLNAME                   = SY-REPID
     I_BYPASSING_BUFFER           = 'X'
     I_BUFFER_ACTIVE              = 'X'
    CHANGING
      ct_fieldcat                  = LT_FCAT "타입이 맞지 않으므로 아래 FUNCTION을 불러서 타입 바꿔줌
*   EXCEPTIONS
*     INCONSISTENT_INTERFACE       = 1
*     PROGRAM_ERROR                = 2
*     OTHERS                       = 3
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS' "LVC는 CLASS ALV쪽, SLIS는 FUNCTION ALV쪽.
    EXPORTING
      it_fieldcat_alv       = LT_FCAT
*     IT_SORT_ALV           =
*     IT_FILTER_ALV         =
*     IS_LAYOUT_ALV         =
   IMPORTING
     ET_FIELDCAT_LVC       = GT_FCAT
*     ET_SORT_LVC           =
*     ET_FILTER_LVC         =
*     ES_LAYOUT_LVC         =
    tables
      it_data               = GT_DATA[] "LVC형태로 바꾸겠다는 의미
*   EXCEPTIONS
*     IT_DATA_MISSING       = 1
*     OTHERS                = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT GT_FCAT INTO GS_FCAT.
    CASE GS_FCAT-FIELDNAME.
      WHEN 'ICON'.
        GS_FCAT-COLTEXT = '아이콘'.
        GS_FCAT-JUST = 'C'.
      WHEN 'ZCODE'.
        GS_FCAT-COLTEXT   = '코드'.

       GS_FCAT-KEY       = ''.

        GS_FCAT-JUST      = 'C'. "L, R, C
      WHEN 'ZNAME'.
        GS_FCAT-SCRTEXT_L = 'LONGLONGLONG'.
        GS_FCAT-SCRTEXT_M = '중간'.
        GS_FCAT-SCRTEXT_S = '짧'.

        GS_FCAT-EMPHASIZE = 'C300'.

        GS_FCAT-HOTSPOT   = 'X'. "미리 지정해주어야 함.
      WHEN 'CHECK'.
        GS_FCAT-COLTEXT   = '체크'.
        GS_FCAT-CHECKBOX  = 'X'.
        GS_FCAT-OUTPUTLEN = 3.
*    	WHEN OTHERS.
    ENDCASE.

    MODIFY GT_FCAT FROM GS_FCAT.
  ENDLOOP.


*  GS_FCAT-FIELDNAME = 'ICON'.
*  GS_FCAT-COLTEXT = '아이콘'.
*  GS_FCAT-JUST = 'C'.
*  APPEND GS_FCAT TO GT_FCAT.
*  CLEAR GS_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""

*  CLEAR : GS_FCAT.
*  GS_FCAT-FIELDNAME = 'ZCODE'.
*  GS_FCAT-COLTEXT   = '코드'.
*
**  GS_FCAT-KEY       = 'X'.
*
*  GS_FCAT-JUST      = 'C'. "L, R, C
*
*  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
*  CLEAR : GS_FCAT.
*  GS_FCAT-FIELDNAME = 'ZNAME'.
**  GS_FCAT-COLTEXT = '코드명'.
*  GS_FCAT-SCRTEXT_L = 'LONGLONGLONG'.
*  GS_FCAT-SCRTEXT_M = '중간'.
*  GS_FCAT-SCRTEXT_S = '짧'.
*
*  GS_FCAT-EMPHASIZE = 'C300'.
*
*  GS_FCAT-HOTSPOT   = 'X'. "미리 지정해주어야 함.
*
*  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
*  CLEAR : GS_FCAT.
*  GS_FCAT-FIELDNAME = 'CHECK'.
*  GS_FCAT-COLTEXT   = '체크'.
*  GS_FCAT-CHECKBOX  = 'X'.
*  GS_FCAT-OUTPUTLEN = 3.
**  GS_FCAT-EDIT      = 'X'. "EDIT 먹이면 라인 선택바 생김
**  GS_FCAT-NO_OUT    = 'X'.
**  GS_FCAT-TECH      = 'X'.
*  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
*  CLEAR : GS_FCAT.
*  GS_FCAT-FIELDNAME = 'INT'.
*  GS_FCAT-COLTEXT   = '숫자'.
*  GS_FCAT-NO_ZERO   = 'X'.
*  GS_FCAT-DO_SUM    = 'X'.
*  APPEND GS_FCAT TO GT_FCAT.
*
*  GS_FCAT-FIELDNAME = 'NAME'.
*  GS_FCAT-COLTEXT = '이름'.
*  GS_FCAT-EDIT = 'X'.
*  APPEND GS_FCAT TO GT_FCAT.
*  CLEAR GS_FCAT.
*
*  GS_FCAT-FIELDNAME = 'OK_NO'.
*  GS_FCAT-COLTEXT = '맞아틀려'.
*  APPEND GS_FCAT TO GT_FCAT.
*  CLEAR GS_FCAT.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM event .
  CREATE OBJECT GC_EVENT.

  SET HANDLER GC_EVENT->HANDLE_TOOLBAR FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_USER_COMMAND FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_MENU_BUTTON FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_DATA_CHANGED_FINISHED FOR GC_GRID_1.

  CALL METHOD gc_grid_1->register_edit_event
    EXPORTING
*      i_event_id = CL_GUI_ALV_GRID=>MC_EVT_ENTER "ENTER만
      i_event_id = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED "셀이 바뀔때 모두
*    EXCEPTIONS
*      error      = 1
*      others     = 2
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
  "툴바가 다 나온다.
  CALL METHOD gc_grid_1->set_ready_for_input
    EXPORTING
      i_ready_for_input = 1
      .

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'
*  APPEND '&LOCAL&DELETE_ROW' TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'

*  GS_SORT-FIELDNAME = 'ZNAME'.
*  GS_SORT-UP = 'X'.
*  GS_SORT-SUBTOT = 'X'.
*  APPEND GS_SORT TO GT_SORT.

  "이걸 먼저 먹여야 레이아웃 설정이 가능하다.
  GS_VARIANT-REPORT = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME.
*  GS_VARIANT-VARIANT = '/215'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LAYOYT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM layoyt .
  GS_LAYOUT-ZEBRA = 'X'.
  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-GRID_TITLE = 'GRID TITLE'.
  GS_LAYOUT-SMALLTITLE = 'X'.

*  GS_LAYOUT-NO_TOOLBAR = 'X'.

  GS_LAYOUT-SEL_MODE = 'D'. "D > A > C > B = SPACE

  GS_LAYOUT-INFO_FNAME = 'INFO'.
  GS_LAYOUT-CTAB_FNAME = 'CTAB'.
  GS_LAYOUT-STYLEFNAME = 'STYLE'.

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
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
      it_toolbar_excluding          = GT_TOOLBAR
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA[]
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

  "I_SAVE
  "X - GLOBAL 레이아웃 세팅만 가능함
  "U - 특정 사용자에 한해서 레이아웃 세팅만 가능함
  "A - X와 U 둘 다 가능함
  "SPACE - 레이아웃 저장을 하지 않음

  CALL METHOD gc_grid_2->set_table_for_first_display
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      is_variant                    = GS_VARIANT
      i_save                        = 'A' "A, U, X, SPACE
      i_default                     = 'X' "X, SPACE
*      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          = GT_TOOLBAR
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA[]
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



ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM alv_handle_double_click  USING    e_row TYPE LVC_S_ROW
                                       e_column TYPE LVC_S_COL
                                       es_row_no TYPE LVC_S_ROID.

  DATA : LV_CHAR(10).

  CASE E_COLUMN-FIELDNAME.
    WHEN 'INT'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX ES_ROW_NO-ROW_ID.

      LV_CHAR = GT_DATA-INT.
      MESSAGE LV_CHAR TYPE 'I'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM alv_handle_hotspot_click  USING    E_ROW_ID TYPE LVC_S_ROW
                                     E_COLUMN_ID TYPE LVC_S_COL
                                     ES_ROW_NO TYPE LVC_S_ROID.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV.
  DATA : LS_FCAT TYPE SLIS_FIELDCAT_ALV.

  DATA : LT_DATA LIKE TABLE OF GT_DATA.

  CASE E_COLUMN_ID-FIELDNAME.
    WHEN 'ZNAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX ES_ROW_NO-ROW_ID.

      APPEND GT_DATA TO LT_DATA.

      LS_FCAT-FIELDNAME = 'ZCODE'.
      LS_FCAT-SELTEXT_L = '코드'.
      LS_FCAT-SELTEXT_M = '코드'.
      LS_FCAT-SELTEXT_S = '코드'.
      APPEND LS_FCAT TO LT_FCAT.

      LS_FCAT-FIELDNAME = 'ZNAME'.
      LS_FCAT-SELTEXT_L = '코드명'.
      LS_FCAT-SELTEXT_M = '코드명'.
      LS_FCAT-SELTEXT_S = '코드명'.
      APPEND LS_FCAT TO LT_FCAT.

      LS_FCAT-FIELDNAME = 'INT'.
      LS_FCAT-SELTEXT_L = '숫자'.
      LS_FCAT-SELTEXT_M = '숫자'.
      LS_FCAT-SELTEXT_S = '숫자'.
      APPEND LS_FCAT TO LT_FCAT.

      "REUSE_ALV_GRID_DISPLAY
      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
       EXPORTING
*         I_INTERFACE_CHECK                 = ' '
*         I_BYPASSING_BUFFER                = ' '
*         I_BUFFER_ACTIVE                   = ' '
*         I_CALLBACK_PROGRAM                = ' '
*         I_CALLBACK_PF_STATUS_SET          = ' '
*         I_CALLBACK_USER_COMMAND           = ' '
*         I_CALLBACK_TOP_OF_PAGE            = ' '
*         I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*         I_CALLBACK_HTML_END_OF_LIST       = ' '
*         I_STRUCTURE_NAME                  =
*         I_BACKGROUND_ID                   = ' '
*         I_GRID_TITLE                      =
*         I_GRID_SETTINGS                   =
*         IS_LAYOUT                         =
         IT_FIELDCAT                       = LT_FCAT
*         IT_EXCLUDING                      =
*         IT_SPECIAL_GROUPS                 =
*         IT_SORT                           =
*         IT_FILTER                         =
*         IS_SEL_HIDE                       =
*         I_DEFAULT                         = 'X'
*         I_SAVE                            = ' '
*         IS_VARIANT                        =
*         IT_EVENTS                         =
*         IT_EVENT_EXIT                     =
*         IS_PRINT                          =
*         IS_REPREP_ID                      =
         I_SCREEN_START_COLUMN             = 10
         I_SCREEN_START_LINE               = 80
         I_SCREEN_END_COLUMN               = 10
         I_SCREEN_END_LINE                 = 80
*         I_HTML_HEIGHT_TOP                 = 0
*         I_HTML_HEIGHT_END                 = 0
*         IT_ALV_GRAPHICS                   =
*         IT_HYPERLINK                      =
*         IT_ADD_FIELDCAT                   =
*         IT_EXCEPT_QINFO                   =
*         IR_SALV_FULLSCREEN_ADAPTER        =
*         O_PREVIOUS_SRAL_HANDLER           =
*       IMPORTING
*         E_EXIT_CAUSED_BY_CALLER           =
*         ES_EXIT_CAUSED_BY_USER            =
        TABLES
          T_OUTTAB                          = LT_DATA
*       EXCEPTIONS
*         PROGRAM_ERROR                     = 1
*         OTHERS                            = 2
                .
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.

  ENDCASE.

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
*& Form ALV_HANDLE_DATA_CHANGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM alv_handle_data_changed  USING er_data_changed
                              TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.
  "CL_ALV_CHANGED_DATA_PROTOCOL->MT_GOOD_CELLS
  "MT_GOOD_CELLS-LVC_T_MODI-LVC_S_MODI

  MESSAGE 'TEST' TYPE 'I'.

  DATA : LS_MODI TYPE LVC_S_MODI.

*  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*    IF LS_MODI-FIELDNAME = 'NAME'.
*      CLEAR GT_DATA.
*      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.
*
*      IF LS_MODI-VALUE = '탄동잉'.
*        GT_DATA-ICON = ICON_LED_GREEN.
*      ELSE.
*        GT_DATA-ICON = ICON_LED_RED.
*      ENDIF.
*
*      MODIFY GT_DATA INDEX LS_MODI-ROW_ID.
*    ENDIF.
*  ENDLOOP.
*
*  PERFORM REFRESH.

*  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*    IF LS_MODI-FIELDNAME = 'NAME'.
*      CLEAR GT_DATA.
*      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.
*
*      IF LS_MODI-VALUE = '탄동잉'.
*        "녹색 신호등
*        CALL METHOD er_data_changed->modify_cell
*          EXPORTING
*            i_row_id    = LS_MODI-ROW_ID
**            i_tabix     =
*            i_fieldname = 'ICON'
*            i_value     = ICON_LED_GREEN.
*      ELSE.
*        "빨간색 신호등
*        CALL METHOD er_data_changed->modify_cell
*          EXPORTING
*            i_row_id    = LS_MODI-ROW_ID
**            i_tabix     =
*            i_fieldname = 'ICON'
*            i_value     = ICON_LED_RED.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.

  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
    IF LS_MODI-FIELDNAME = 'NAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.

      IF LS_MODI-VALUE = '탄동잉'.
        GT_DATA-ICON = ICON_LED_GREEN.
      ELSE.
        GT_DATA-ICON = ICON_LED_RED.
      ENDIF.

      MODIFY GT_DATA INDEX LS_MODI-ROW_ID. "INDEX를 해 주어야 함.
    ENDIF.
  ENDLOOP.

  PERFORM REFRESH. "얘는 굳이 없어도 된다고 함

  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = 'TEMP'
*    IMPORTING
*      rc       =
      .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DATA_FINISHED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM alv_handle_data_finished  USING et_good_cells TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.

*  MESSAGE 'FINISHED' TYPE 'I'.
  LOOP AT ET_GOOD_CELLS INTO LS_MODI.
    IF LS_MODI-FIELDNAME = 'NAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.

      IF GT_DATA-ICON = ICON_LED_GREEN.
        GT_DATA-OK_NO = 'OK'.
      ELSEIF GT_DATA-ICON = ICON_LED_RED.
        GT_DATA-OK_NO = 'NO'.
      ENDIF.
      MODIFY GT_DATA INDEX LS_MODI-ROW_ID.
    ENDIF.
  ENDLOOP.

  CHECK ET_GOOD_CELLS IS NOT INITIAL."TRUE이면 아랫부분 수행. FALSE이면 수행X
  PERFORM REFRESH. "있어야 함.
ENDFORM.
