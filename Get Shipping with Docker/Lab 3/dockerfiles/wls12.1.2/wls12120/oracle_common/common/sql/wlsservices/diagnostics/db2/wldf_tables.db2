
--SET SCHEMA=$1
--@

CREATE PROCEDURE executeWLDFStatement(in createStatement varchar(2056))
BEGIN
  EXECUTE IMMEDIATE createStatement; 
END
@

BEGIN ATOMIC
  DECLARE schemaName varchar(256); 
  DECLARE sqlvar varchar(4096);

  SET schemaName = CURRENT SCHEMA;

  VALUES 'Schema is ' || schemaName;

  IF (SELECT COUNT(*) FROM SYSCAT.TABLES WHERE 
        TABSCHEMA = schemaName AND TABNAME = 'WLS_HVST') = 0 
  THEN
    SET sqlvar = 'CREATE TABLE WLS_HVST ( 
      RECORDID DECIMAL(20,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      TIMESTAMP DECIMAL(20,0) DEFAULT NULL, 
      DOMAIN VARCHAR(250) DEFAULT NULL, 
      SERVER VARCHAR(250) DEFAULT NULL, 
      TYPE VARCHAR(250) DEFAULT NULL, 
      NAME VARCHAR(250) DEFAULT NULL, 
      ATTRNAME VARCHAR(250) DEFAULT NULL, 
      ATTRTYPE DECIMAL(10,0) DEFAULT NULL, 
      ATTRVALUE VARCHAR(4000) DEFAULT NULL, 
      WLDFMODULE VARCHAR(250) DEFAULT NULL
      )';
      call executeWLDFStatement(sqlvar);
      SET sqlvar = 'CREATE INDEX WLS_HVST_TS_INDEX ON WLS_HVST(TIMESTAMP)';
      call executeWLDFStatement(sqlvar);
     END IF;
        
END@

BEGIN ATOMIC
    DECLARE schemaName varchar(256); 
  DECLARE sqlvar varchar(4096);
  SET schemaName = CURRENT SCHEMA;

  VALUES 'Schema is ' || schemaName;

  IF (SELECT COUNT(*) FROM SYSCAT.COLUMNS 
      WHERE TABSCHEMA = schemaName AND TABNAME = 'WLS_HVST' 
      AND COLNAME ='WLDFMODULE') = 0 
  THEN
      SET sqlvar = 'ALTER TABLE WLS_HVST ADD WLDFMODULE VARCHAR(250) DEFAULT NULL';
      call executeWLDFStatement(sqlvar);
    END IF;  

END
@

BEGIN ATOMIC
  DECLARE schemaName varchar(256); 
  DECLARE sqlvar varchar(4096);
  
  SET schemaName = CURRENT SCHEMA;

  VALUES 'Schema is ' || schemaName;

  IF (SELECT COUNT(*) FROM SYSCAT.TABLES WHERE 
        TABSCHEMA = schemaName AND TABNAME = 'WLS_EVENTS') = 0 
  THEN
    SET sqlvar = 'CREATE TABLE WLS_EVENTS (
        RECORDID DECIMAL(20,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        TIMESTAMP DECIMAL(20,0) DEFAULT NULL, 
        CONTEXTID VARCHAR(250) DEFAULT NULL, 
        TXID VARCHAR(250) DEFAULT NULL, 
        USERID VARCHAR(250) DEFAULT NULL, 
        TYPE VARCHAR(250) DEFAULT NULL, 
        DOMAIN VARCHAR(250) DEFAULT NULL, 
        SERVER VARCHAR(250) DEFAULT NULL, 
        SCOPE VARCHAR(250) DEFAULT NULL, 
        MODULE VARCHAR(250) DEFAULT NULL, 
        MONITOR VARCHAR(250) DEFAULT NULL, 
        FILENAME VARCHAR(250) DEFAULT NULL, 
        LINENUM DECIMAL(10,0) DEFAULT NULL, 
        CLASSNAME VARCHAR(250) DEFAULT NULL, 
        METHODNAME VARCHAR(250) DEFAULT NULL, 
        METHODDSC VARCHAR(4000) DEFAULT NULL, 
        ARGUMENTS CLOB DEFAULT NULL, 
        RETVAL VARCHAR(4000) DEFAULT NULL, 
        PAYLOAD BLOB DEFAULT NULL, 
        CTXPAYLOAD VARCHAR(4000) DEFAULT NULL, 
        DYES DECIMAL(20,0) DEFAULT NULL, 
        THREADNAME VARCHAR(250) DEFAULT NULL
      )';
      call executeWLDFStatement(sqlvar);
      SET sqlvar = 'CREATE INDEX WLS_EVENTS_TS_INDEX ON WLS_EVENTS(TIMESTAMP)';
      call executeWLDFStatement(sqlvar);
    END IF;
        
END@

BEGIN ATOMIC
  DECLARE schemaName varchar(256); 
  DECLARE sqlvar varchar(4096);

  SET schemaName = CURRENT SCHEMA;

  VALUES 'Schema is ' || schemaName;

  if (SELECT COUNT(*) FROM SYSCAT.COLUMNS 
      WHERE TABSCHEMA = schemaName AND TABNAME = 'WLS_EVENTS'
      AND COLNAME ='THREADNAME') = 0 
  THEN
      SET sqlvar = 'ALTER TABLE WLS_EVENTS ADD THREADNAME VARCHAR(250) DEFAULT NULL';
      call executeWLDFStatement(sqlvar);
    END IF;  

END@

DROP PROCEDURE executeWLDFStatement
@

