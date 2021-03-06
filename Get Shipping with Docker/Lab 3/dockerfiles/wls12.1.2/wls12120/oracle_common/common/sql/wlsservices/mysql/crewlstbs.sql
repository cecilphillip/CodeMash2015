-- Copyright (c) 2011, Oracle and/or its affiliates. All rights reserved. 
--
--
-- crewlstbs.sql - Create tables for Weblogic core services for MySQL
-- 
-- MODIFIED    (MM/DD/YY)
-- alai         01/13/12 - Creation. 
--

-- Note ';' has to be applied to the next line in define statement.

CREATE TABLE WEBLOGIC_TIMERS (
  TIMER_ID VARCHAR(100) NOT NULL,
  LISTENER LONGBLOB NOT NULL,
  START_TIME BIGINT NOT NULL,
  SCHEDULE_INTERVAL BIGINT NOT NULL,
  TIMER_MANAGER_NAME VARCHAR(100) NOT NULL,
  DOMAIN_NAME VARCHAR(100) NOT NULL,
  CLUSTER_NAME VARCHAR(100) NOT NULL,
  PRIMARY KEY (TIMER_ID, CLUSTER_NAME, DOMAIN_NAME)
)
/

CREATE TABLE ACTIVE (
  SERVER VARCHAR(150) NOT NULL,
  INSTANCE VARCHAR(100) NOT NULL,
  DOMAINNAME VARCHAR(50) NOT NULL,
  CLUSTERNAME VARCHAR(50) NOT NULL,
  TIMEOUT DATETIME,
  PRIMARY KEY (SERVER, DOMAINNAME, CLUSTERNAME)
)
/


