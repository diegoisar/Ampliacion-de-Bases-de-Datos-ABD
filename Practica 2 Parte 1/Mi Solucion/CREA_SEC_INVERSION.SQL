create or replace PROCEDURE CREA_SEC_INVERSION(NOMBRE_SECUENCIA INVIERTE.NOMBREE%TYPE) AS

    Tcoderror NUMBER;
    Ttexterror VARCHAR2(100);

    EXISTE_SECUENCIA NUMBER;
    PLSQLBLOCK VARCHAR2(500);

BEGIN

    SELECT COUNT(*) INTO EXISTE_SECUENCIA FROM USER_OBJECTS 
    WHERE OBJECT_TYPE = 'SEQUENCE' AND OBJECT_NAME = 'SEC_' || REPLACE(UPPER(NOMBRE_SECUENCIA),' ','');

    IF (EXISTE_SECUENCIA = 0) THEN 

        DBMS_OUTPUT.PUT_LINE('LA SECUENCIA NO EXISTE, SE PROCEDERA A SU CREACION.');

        PLSQLBLOCK := 'CREATE SEQUENCE SEC_' || REPLACE(NOMBRE_SECUENCIA,' ','') || ' START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE NOCYCLE NOCACHE';
        EXECUTE IMMEDIATE PLSQLBLOCK;

        DBMS_OUTPUT.PUT_LINE('LA SECUENCIA SE HA CREADO CORRECTAMENTE.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('LA SECUENCIA YA EXISTE, NO SE CREARA.');

    END IF;

EXCEPTION

  WHEN OTHERS THEN

  Tcoderror:= SQLCODE;
  Ttexterror:= SUBSTR(SQLERRM,1, 100);
  DBMS_output.put_line('Sale por una excepcion: ' || Tcoderror ||   '  -- ' || Ttexterror );

END CREA_SEC_INVERSION;