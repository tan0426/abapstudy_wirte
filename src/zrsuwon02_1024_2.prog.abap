*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1024_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsuwon02_1024_2.

TABLES : ztsuwon02_hr.

"DATA 선언
DATA : BEGIN OF gs_data,
        zcode LIKE ztsuwon02_hr-zcode,
        zname LIKE ztsuwon02_hr-zname,
        check,
        STYLE TYPE LVC_T_STYL,
       END OF gs_data,
       gt_data LIKE TABLE OF gs_data.
DATA : gs_fcat TYPE lvc_s_fcat.
DATA : gt_fcat TYPE lvc_t_fcat.
DATA : GS_LAYOUT TYPE LVC_S_LAYO.
DATA : GS_STYLE TYPE LVC_S_STYL.
DATA : LV_TABIX TYPE SY-TABIX.

DATA : ok_code TYPE sy-ucomm.

DATA : gc_docking TYPE REF TO cl_gui_docking_container.
DATA : gc_splitter TYPE REF TO cl_gui_splitter_container.
DATA : gc_container_1 TYPE REF TO cl_gui_container.
DATA : gc_container_2 TYPE REF TO cl_gui_container.
DATA : gc_grid_1 TYPE REF TO cl_gui_alv_grid.
DATA : gc_grid_2 TYPE REF TO cl_gui_alv_grid.

DATA : GS_VARIANT TYPE disvariant.

"조회조건
SELECT-OPTIONS : s_zcode FOR ztsuwon02_hr-zcode.
"INITIALIZATION
INITIALIZATION.
"START-OF-SELECTION
START-OF-SELECTION.
  SELECT zcode zname
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztsuwon02_hr
    WHERE zcode IN s_zcode.

  LOOP AT GT_DATA INTO GS_DATA.
    LV_TABIX = SY-TABIX.
    IF LV_TABIX = 4.
      GS_STYLE-FIELDNAME = 'CHECK'.
*      GS_STYLE-STYLE = '00100000'.
*      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

      APPEND GS_STYLE TO GS_DATA-STYLE.
    ENDIF.
    MODIFY GT_DATA FROM GS_DATA.
  ENDLOOP.
"출력
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
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
*  	WHEN 'CANC'.
*      LEAVE PROGRAM.
*  	WHEN 'EXIT'.
*      LEAVE PROGRAM.
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
      repid                       = sy-repid
      dynnr                       = sy-dynnr
*      side                        = DOCK_AT_LEFT
      extension                   = 5000
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT gc_splitter
    EXPORTING

      parent            = gc_docking
      rows              = 1
      columns           = 2

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
      container = gc_container_1
      .

  CALL METHOD gc_splitter->get_container
    EXPORTING
      row       = 1
      column    = 2
    RECEIVING
      container = gc_container_2.

  CREATE OBJECT gc_grid_1
    EXPORTING

      i_parent          = gc_container_1.
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

    CREATE OBJECT gc_grid_2
    EXPORTING

      i_parent          = gc_container_2.
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  gs_fcat-fieldname = 'ZCODE'.
  gs_fcat-coltext = '코드'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'ZNAME'.
  gs_fcat-coltext = '코드명'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'CHECK'.
  gs_fcat-coltext = '체크박스'.
*  gs_fcat-edit = 'X'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  GS_LAYOUT-STYLEFNAME = 'STYLE'.

  CALL METHOD gc_grid_1->set_ready_for_input
    EXPORTING
      i_ready_for_input = 1 "최 우선적임. GS_FCAT-EDIT보다 우선.
      .

  GS_VARIANT-REPORT = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME.

  CALL METHOD GC_GRID_1->set_table_for_first_display
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      is_variant                    = GS_VARIANT
*      i_save                        =
*      i_default                     = 'X'
      is_layout                     = GS_LAYOUT
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

  CALL METHOD gc_grid_2->set_table_for_first_display

    CHANGING
      it_outtab                     = gt_data
      it_fieldcatalog               = gt_fcat.
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.




ENDMODULE.
