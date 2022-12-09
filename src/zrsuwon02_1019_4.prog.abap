*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1019_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsuwon02_1019_4.

TABLES : ztsuwon02_hr.
DATA : BEGIN OF gs_data,
        zcode TYPE ztsuwon02_hr-zcode,
        zname TYPE ztsuwon02_hr-zname,
       END OF gs_data,
       gt_data LIKE TABLE OF gs_data.

DATA : ok_code TYPE sy-ucomm.
DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.
DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.
DATA : GT_FCAT TYPE LVC_T_FCAT,
       GS_FCAT TYPE LVC_S_FCAT.

SELECT-OPTIONS : s_zcode FOR ztsuwon02_hr-zcode.

INITIALIZATION.

START-OF-SELECTION.
  SELECT zcode zname
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztsuwon02_hr
    WHERE zcode IN s_zcode.

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

CREATE OBJECT GC_DOCKING
  EXPORTING
*    parent                      =
    repid                       = SY-REPID
    dynnr                       = SY-DYNNR "화면번호 100번이 됨
    side                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM "1,2,4,8.. , LEFT...
    extension                   = 300
*    style                       =
*    lifetime                    = lifetime_default
*    caption                     =
*    metric                      = 0
*    ratio                       =
*    no_autodef_progid_dynnr     =
*    name                        =
  EXCEPTIONS
    cntl_error                  = 1
    cntl_system_error           = 2
    create_error                = 3
    lifetime_error              = 4
    lifetime_dynpro_dynpro_link = 5
    others                      = 6
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CREATE OBJECT GC_GRID
  exporting
*    i_shellstyle      = 0
*    i_lifetime        =
    i_parent          = GC_DOCKING
*    i_appl_events     = SPACE
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
*    o_previous_sral_handler =
  EXCEPTIONS
    error_cntl_create = 1
    error_cntl_init   = 2
    error_cntl_link   = 3
    error_dp_create   = 4
    others            = 5.
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

GS_FCAT-FIELDNAME = 'ZCODE'.
GS_FCAT-COLTEXT = '코드'.
APPEND GS_FCAT TO GT_FCAT.

GS_FCAT-FIELDNAME = 'ZNAME'.
GS_FCAT-COLTEXT = '코드명'.
APPEND GS_FCAT TO GT_FCAT.

CALL METHOD gc_grid->set_table_for_first_display
*  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
*    i_structure_name              =
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = GT_DATA
    it_fieldcatalog               = GT_FCAT
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


ENDMODULE.
