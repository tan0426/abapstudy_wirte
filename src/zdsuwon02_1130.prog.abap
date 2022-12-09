*&---------------------------------------------------------------------*
*& Report ZDSUWON02_1130
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDSUWON02_1130.

*DATA : GT_DATA LIKE TABLE OF ZTJ_BOM WITH HEADER LINE.
*DATA : GT_DATA2 LIKE TABLE OF ZTJ_BUFFER WITH HEADER LINE.
*DATA : GT_DATA3 LIKE TABLE OF ZTJ_INVENTORY_D WITH HEADER LINE.
*DATA : GT_DATA4 LIKE TABLE OF ZTJ_PART WITH HEADER LINE.
*DATA : GT_DATA5 LIKE TABLE OF ZTJ_PARTGROUP WITH HEADER LINE.
*DATA : GT_DATA6 LIKE TABLE OF ZTJ_RESOURCE WITH HEADER LINE.
*DATA : GT_DATA7 LIKE TABLE OF ZTJ_WORKORDER WITH HEADER LINE.
*
*DATA : LV_MSG TYPE STRING.
*DATA : LX_EXEC TYPE REF TO CX_ROOT.
*
*SELECT ITEMPARENT_CD ITEMCHILD_CD BOM_SQ JUST_QT
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
*  FROM ZTJ_BOM.
*
*SELECT BASELOC_CD BASELOC_NM BASELOC_DC USE_YN
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA2
*  FROM ZTJ_BUFFER.
*
*SELECT LC_CD ITEM_CD IOPEN_QT IRCV_QT IISU_QT ISUM_QT
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA3
*  FROM ZTJ_INVENTORY_D.
*
*SELECT ITEM_CD ITEM_NM ITEM_DC ITEMGRP_CD
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA4
*  FROM ZTJ_PART.
*
*SELECT ITEMGRP_CD ITEMGRP_NM ITEMGRP_DC
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA5
*  FROM ZTJ_PARTGROUP.
*
*SELECT MGM_CD MGM_NM REMARK_DC
*  INTO CORRESPONDING FIELDS OF TABLE GT_DATA6
*  FROM ZTJ_RESOURCE.
*
*
*
*
*EXEC SQL.
*  CONNECT TO 'MSSQL1'
*ENDEXEC.
*IF SY-SUBRC <> 0.
*  MESSAGE 'CONNECT FAIL' TYPE 'S' DISPLAY LIKE 'E'.
*  EXIT.
*ENDIF.
*
*TRY .
*
*EXEC SQL.
*  DELETE FROM sapout.BOM
*  DELETE FROM sapout.BUFFER
*  DELETE FROM sapout.INVENTORY_D
*ENDEXEC.
*
*LOOP AT GT_DATA.
*  EXEC SQL.
*    INSERT INTO sapout.BOM_T (PLANTCODE, MITEMCODE, ITEMCODE, COMPONENT, UOM, QUANTITY)
*           VALUES (:GT_DATA-PLANTCODE, :GT_DATA-MITEMCODE, :GT_DATA-ITEMCODE, :GT_DATA-COMPONENT, :GT_DATA-UOM, :GT_DATA-QUANTITY)
*  ENDEXEC.
*ENDLOOP.
*
*LOOP AT GT_DATA2.
*  EXEC SQL.
*
*    INSERT INTO sapout.BOMROUTING_T (MITEMCODE, STEP_NO, OP_NO, ASS_CODE, ITEMCODE, RES_ID, NEXTSTEP, DESCRIPTION, UOM, INPUT_QT, JSONCODE)
*           VALUES (:GT_DATA2-MITEMCODE, :GT_DATA2-STEP_NO, :GT_DATA2-OP_NO, :GT_DATA2-ASS_CODE, :GT_DATA2-ITEMCODE, :GT_DATA2-RES_ID, :GT_DATA2-NEXTSTEP, :GT_DATA2-DESCRIPTION, :GT_DATA2-UOM, :GT_DATA2-INPUT_QT, :GT_DATA2-JSONCODE)
*
*  ENDEXEC.
*ENDLOOP.
*
*LOOP AT GT_DATA3.
*  EXEC SQL.
*    INSERT INTO sapout.WORKPLAN_T (MITEMCODE, PLAN_DATE, COMPONENT, ICNAME, PLAN_QT, PLAN_CONFIRM)
*           VALUES (:GT_DATA3-MITEMCODE, :GT_DATA3-PLAN_DATE, :GT_DATA3-COMPONENT, :GT_DATA3-ICNAME, :GT_DATA3-PLAN_QT, :GT_DATA3-PLAN_CONFIRM)
*  ENDEXEC.
*ENDLOOP.
*
*CATCH CX_SY_NATIVE_SQL_ERROR INTO LX_EXEC.
*  LV_MSG = LX_EXEC->GET_TEXT(  ).
*  MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
*
*IF LV_MSG IS INITIAL.
*  EXEC SQL.
*    COMMIT
*  ENDEXEC.
*ELSE.
*  EXEC SQL.
*    ROLLBACK
*  ENDEXEC.
*ENDIF.
*
*EXEC SQL.
*  DISCONNECT 'MSSQL1'
*ENDEXEC.
*IF SY-SUBRC <> 0.
*  MESSAGE 'CONNECT FAIL' TYPE 'S' DISPLAY LIKE 'E'.
*  EXIT.
*ENDIF.
