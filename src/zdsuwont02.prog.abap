*----------------------------------------------------------------------*
***INCLUDE ZDSUWONT02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form FILL_ZDSUWONT02_LOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fill_zdsuwont02_log .

  DATA : LS_ZDSUWONT02 TYPE ZDSUWONT02.

  SELECT SINGLE *
    INTO CORRESPONDING FIELDS OF LS_ZDSUWONT02
    FROM ZDSUWONT02
    WHERE ZEMPNO = ZDSUWONT02-ZEMPNO.

    IF LS_ZDSUWONT02 IS NOT INITIAL.
      "변경
      ZDSUWONT02-AEDAT = SY-DATUM.
      ZDSUWONT02-AEZET = SY-UZEIT.
      ZDSUWONT02-AENAM = SY-UNAME.
    ELSE.
      "생성
      ZDSUWONT02-ERDAT = SY-DATUM.
      ZDSUWONT02-ERZET = SY-UZEIT.
      ZDSUWONT02-ERNAM = SY-UNAME.
    ENDIF.



ENDFORM.
