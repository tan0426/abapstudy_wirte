*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDHRV02_M.......................................*
TABLES: ZDHRV02_M, *ZDHRV02_M. "view work areas
CONTROLS: TCTRL_ZDHRV02_M
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZDHRV02_M. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZDHRV02_M.
* Table for entries selected to show on screen
DATA: BEGIN OF ZDHRV02_M_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZDHRV02_M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDHRV02_M_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZDHRV02_M_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZDHRV02_M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDHRV02_M_TOTAL.

*...processing: ZDSUWONT02......................................*
DATA:  BEGIN OF STATUS_ZDSUWONT02                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDSUWONT02                    .
CONTROLS: TCTRL_ZDSUWONT02
            TYPE TABLEVIEW USING SCREEN '0006'.
*...processing: ZDSUWONT02_2....................................*
DATA:  BEGIN OF STATUS_ZDSUWONT02_2                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDSUWONT02_2                  .
CONTROLS: TCTRL_ZDSUWONT02_2
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZDSUWONT02_3....................................*
DATA:  BEGIN OF STATUS_ZDSUWONT02_3                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDSUWONT02_3                  .
CONTROLS: TCTRL_ZDSUWONT02_3
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZDSUWONT02_4....................................*
DATA:  BEGIN OF STATUS_ZDSUWONT02_4                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDSUWONT02_4                  .
CONTROLS: TCTRL_ZDSUWONT02_4
            TYPE TABLEVIEW USING SCREEN '0004'.
*...processing: ZTESTV_02.......................................*
TABLES: ZTESTV_02, *ZTESTV_02. "view work areas
CONTROLS: TCTRL_ZTESTV_02
TYPE TABLEVIEW USING SCREEN '0005'.
DATA: BEGIN OF STATUS_ZTESTV_02. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZTESTV_02.
* Table for entries selected to show on screen
DATA: BEGIN OF ZTESTV_02_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZTESTV_02.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTESTV_02_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZTESTV_02_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZTESTV_02.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTESTV_02_TOTAL.

*.........table declarations:.................................*
TABLES: *ZDSUWONT02                    .
TABLES: *ZDSUWONT02_2                  .
TABLES: *ZDSUWONT02_3                  .
TABLES: *ZDSUWONT02_4                  .
TABLES: ZDSUWONT02                     .
TABLES: ZDSUWONT02_2                   .
TABLES: ZDSUWONT02_3                   .
TABLES: ZDSUWONT02_4                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
