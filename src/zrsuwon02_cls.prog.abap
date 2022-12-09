*&---------------------------------------------------------------------*
*& Include          ZRSUWON02_CLS
*&---------------------------------------------------------------------*

CLASS EVENT DEFINITION.
  PUBLIC SECTION. "접근성 설정

  METHODS HANDLE_TOOLBAR FOR EVENT TOOLBAR
                         OF CL_GUI_ALV_GRID
                         IMPORTING E_OBJECT
                                   E_INTERACTIVE.

  METHODS HANDLE_USER_COMMAND FOR EVENT USER_COMMAND
                              OF CL_GUI_ALV_GRID
                              IMPORTING E_UCOMM.

  METHODS HANDLE_MENU_BUTTON FOR EVENT MENU_BUTTON
                             OF CL_GUI_ALV_GRID
                             IMPORTING E_OBJECT
                                       E_UCOMM.

  METHODS HANDLE_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK
                              OF CL_GUI_ALV_GRID
                              IMPORTING E_ROW
                                        E_COLUMN
                                        ES_ROW_NO.

  METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK
                               OF CL_GUI_ALV_GRID
                               IMPORTING E_ROW_ID
                                         E_COLUMN_ID
                                         ES_ROW_NO.

  METHODS HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED
                              OF CL_GUI_ALV_GRID
                              IMPORTING ER_DATA_CHANGED.

  METHODS HANDLE_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED
                                       OF CL_GUI_ALV_GRID
                                       IMPORTING ET_GOOD_CELLS.
ENDCLASS.

CLASS EVENT IMPLEMENTATION.
  METHOD HANDLE_TOOLBAR.
  "로직
    PERFORM ALV_HANDLE_TOOLBAR USING E_OBJECT
                                     E_INTERACTIVE.
  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.
    "로직
    PERFORM ALV_HANDLE_USER_COMMAND USING E_UCOMM.
  ENDMETHOD.

  METHOD HANDLE_MENU_BUTTON.
    PERFORM ALV_HANDLE_MENU_BUTTON USING E_OBJECT
                                         E_UCOMM.
  ENDMETHOD.

  METHOD HANDLE_DOUBLE_CLICK.
    PERFORM ALV_HANDLE_DOUBLE_CLICK USING E_ROW
                                          E_COLUMN
                                          ES_ROW_NO.
  ENDMETHOD.

  METHOD HANDLE_HOTSPOT_CLICK.
    PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID
                                           E_COLUMN_ID
                                           ES_ROW_NO.
  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED.
    "로직
    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED.
  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED_FINISHED.
    PERFORM ALV_HANDLE_DATA_FINISHED USING ET_GOOD_CELLS.
  ENDMETHOD.
ENDCLASS.
