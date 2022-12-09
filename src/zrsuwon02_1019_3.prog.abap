*&---------------------------------------------------------------------*
*& Report ZRSUWON02_1019_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSUWON02_1019_3.

"DATA 선언
TABLES : ZTSUWON02_HR.

DATA : BEGIN OF GS_DATA,
        ZCODE LIKE ZTSUWON02_HR-ZCODE,
        ZNAME LIKE ZTSUWON02_HR-ZNAME,
       END OF GS_DATA,
       GT_DATA LIKE TABLE OF GS_DATA.
DATA : GS_DATA2 LIKE GS_DATA,
       GT_DATA2 LIKE TABLE OF GS_DATA2.
DATA : OK_CODE TYPE SY-UCOMM.

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.
DATA : GC_CUSTOM2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER.
DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.
DATA : GC_GRID2 TYPE REF TO CL_GUI_ALV_GRID.
DATA : GT_FCAT TYPE LVC_T_FCAT.
DATA : GS_FCAT TYPE LVC_S_FCAT.
DATA : GT_FCAT2 TYPE LVC_T_FCAT.
DATA : GS_FCAT2 TYPE LVC_S_FCAT.

SELECT-OPTIONS : S_ZCODE FOR ZTSUWON02_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION. "본격적으로 로직 시작

SELECT ZCODE ZNAME
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM ZTSUWON02_HR
  WHERE ZCODE IN S_ZCODE.

SELECT ZCODE ZNAME
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA2
  FROM ZTSUWON02_HR
  WHERE ZCODE = '001'
  OR ZCODE = '002'
  AND ZNAME = 'MODIFY'.

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
*& Module DISPLAY_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_alv OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  CREATE OBJECT GC_CUSTOM
    exporting
*      parent                      =
      container_name              = 'GC_CONTROL'
*      style                       =
*      lifetime                    = lifetime_default
*      repid                       =
*      dynnr                       =
*      no_autodef_progid_dynnr     =
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      others                      = 6
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID
    exporting
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CUSTOM
*      i_appl_events     = SPACE
*      i_parentdbg       =
*      i_applogparent    =
*      i_graphicsparent  =
*      i_name            =
*      i_fcat_complete   = SPACE
*      o_previous_sral_handler =
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT = '코드'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-COLTEXT = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.
  CALL METHOD gc_grid->set_table_for_first_display
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
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

"---------------------------------------------------------------
*  SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  CREATE OBJECT GC_CUSTOM2
    exporting
*      parent                      =
      container_name              = 'GC_CONTROL2'
*      style                       =
*      lifetime                    = lifetime_default
*      repid                       =
*      dynnr                       =
*      no_autodef_progid_dynnr     =
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      others                      = 6
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID2
    exporting
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CUSTOM2
*      i_appl_events     = SPACE
*      i_parentdbg       =
*      i_applogparent    =
*      i_graphicsparent  =
*      i_name            =
*      i_fcat_complete   = SPACE
*      o_previous_sral_handler =
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


  GS_FCAT2-FIELDNAME = 'ZCODE'.
  GS_FCAT2-COLTEXT = '코드'.
  APPEND GS_FCAT2 TO GT_FCAT2.

  GS_FCAT2-FIELDNAME = 'ZNAME'.
  GS_FCAT2-COLTEXT = '코드명'.
  APPEND GS_FCAT2 TO GT_FCAT2.


  CALL METHOD gc_grid2->set_table_for_first_display
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
      it_outtab                     = GT_DATA2
      it_fieldcatalog               = GT_FCAT2
*      it_sort                       =
*      it_filter                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.
ENDMODULE.
