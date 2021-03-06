set sqln off
set line 200
set pagesize 1000
set long 5000
set echo on


---- "APPLSYS"."AQ$_WF_REPLAY_IN_NR"
--  CREATE TABLE "APPLSYS"."AQ$_WF_REPLAY_IN_NR"
--   (	"MSGID" RAW(16),
--	"SUBSCRIBER#" NUMBER,
--	"NAME" VARCHAR2(30),
--	"ADDRESS#" NUMBER,
--	"SIGN" "SYS"."AQ$_SIG_PROP" ,
--	"DBS_SIGN" "SYS"."AQ$_SIG_PROP" ,
--	 PRIMARY KEY ("MSGID", "SUBSCRIBER#", "NAME", "ADDRESS#") ENABLE
--   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS 
-- PCTTHRESHOLD 50 INCLUDING "SIGN" OVERFLOW
-- PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
--  STORAGE(INITIAL 40960 NEXT 40960 MINEXTENTS 1 MAXEXTENTS 505
--  PCTINCREASE 50 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
--  TABLESPACE "APPLSYSD";
--
--
---- "APPLSYS"."AQ$_WF_REPLAY_OUT_NR"
--  CREATE TABLE "APPLSYS"."AQ$_WF_REPLAY_OUT_NR"
--   (	"MSGID" RAW(16),
--	"SUBSCRIBER#" NUMBER,
--	"NAME" VARCHAR2(30),
--	"ADDRESS#" NUMBER,
--	"SIGN" "SYS"."AQ$_SIG_PROP" ,
--	"DBS_SIGN" "SYS"."AQ$_SIG_PROP" ,
--	 PRIMARY KEY ("MSGID", "SUBSCRIBER#", "NAME", "ADDRESS#") ENABLE
--   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS 
-- PCTTHRESHOLD 50 INCLUDING "SIGN" OVERFLOW
-- PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
--  STORAGE(INITIAL 40960 NEXT 40960 MINEXTENTS 1 MAXEXTENTS 505
--  PCTINCREASE 50 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
--  TABLESPACE "APPLSYSD";
--

-- "APPLSYS"."WF_CONTROL"
  CREATE TABLE "APPLSYS"."WF_CONTROL"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255  NOLOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_JAVA_DEFERRED"
CREATE TABLE "APPLSYS"."WF_JAVA_DEFERRED"
  (    "Q_NAME" VARCHAR2(30),
       "MSGID" RAW(16),
       "CORRID" VARCHAR2(128),
       "PRIORITY" NUMBER,
       "STATE" NUMBER,
       "DELAY" DATE,
       "EXPIRATION" NUMBER,
       "TIME_MANAGER_INFO" DATE,
       "LOCAL_ORDER_NO" NUMBER,
       "CHAIN_NO" NUMBER,
       "CSCN" NUMBER,
       "DSCN" NUMBER,
       "ENQ_TIME" DATE,
       "ENQ_UID" NUMBER,
       "ENQ_TID" VARCHAR2(30),
       "DEQ_TIME" DATE,
       "DEQ_UID" NUMBER,
       "DEQ_TID" VARCHAR2(30),
       "RETRY_COUNT" NUMBER,
       "EXCEPTION_QSCHEMA" VARCHAR2(30),
       "EXCEPTION_QUEUE" VARCHAR2(30),
       "STEP_NO" NUMBER,
       "RECIPIENT_KEY" NUMBER,
       "DEQUEUE_MSGID" RAW(16),
       "SENDER_NAME" VARCHAR2(30),
       "SENDER_ADDRESS" VARCHAR2(1024),
       "SENDER_PROTOCOL" NUMBER,
       "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
        PRIMARY KEY ("MSGID")
 USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
 STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
 TABLESPACE "APPLSYSD"  ENABLE
  ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
 STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
 TABLESPACE "APPLSYSD"
LOB ("USER_DATA"."TEXT_LOB") STORE AS (
 TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
 NOCACHE
 STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_JAVA_ERROR"
  CREATE TABLE "APPLSYS"."WF_JAVA_ERROR"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_JMS_IN"
  CREATE TABLE "APPLSYS"."WF_JMS_IN"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE"
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));

-- "APPLSYS"."WF_JMS_JMS_OUT"
  CREATE TABLE "APPLSYS"."WF_JMS_JMS_OUT"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_JMS_OUT"
  CREATE TABLE "APPLSYS"."WF_JMS_OUT"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE"
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_NOTIFICATION_IN"
  CREATE TABLE "APPLSYS"."WF_NOTIFICATION_IN"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE"
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_NOTIFICATION_OUT"
  CREATE TABLE "APPLSYS"."WF_NOTIFICATION_OUT"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE"
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_WS_JMS_IN"
  CREATE TABLE "APPLSYS"."WF_WS_JMS_IN"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_WS_JMS_OUT"
  CREATE TABLE "APPLSYS"."WF_WS_JMS_OUT"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "APPLSYS"."WF_WS_SAMPLE"
  CREATE TABLE "APPLSYS"."WF_WS_SAMPLE"
   (    "Q_NAME" VARCHAR2(30),
        "MSGID" RAW(16),
        "CORRID" VARCHAR2(128),
        "PRIORITY" NUMBER,
        "STATE" NUMBER,
        "DELAY" DATE,
        "EXPIRATION" NUMBER,
        "TIME_MANAGER_INFO" DATE,
        "LOCAL_ORDER_NO" NUMBER,
        "CHAIN_NO" NUMBER,
        "CSCN" NUMBER,
        "DSCN" NUMBER,
        "ENQ_TIME" DATE,
        "ENQ_UID" NUMBER,
        "ENQ_TID" VARCHAR2(30),
        "DEQ_TIME" DATE,
        "DEQ_UID" NUMBER,
        "DEQ_TID" VARCHAR2(30),
        "RETRY_COUNT" NUMBER,
        "EXCEPTION_QSCHEMA" VARCHAR2(30),
        "EXCEPTION_QUEUE" VARCHAR2(30),
        "STEP_NO" NUMBER,
        "RECIPIENT_KEY" NUMBER,
        "DEQUEUE_MSGID" RAW(16),
        "SENDER_NAME" VARCHAR2(30),
        "SENDER_ADDRESS" VARCHAR2(1024),
        "SENDER_PROTOCOL" NUMBER,
        "USER_DATA" "SYS"."AQ$_JMS_TEXT_MESSAGE" ,
         PRIMARY KEY ("MSGID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPLSYSD"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPLSYSD" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));



---- "AR"."AQ$_AR_REV_REC_QT_NR"
--  CREATE TABLE "AR"."AQ$_AR_REV_REC_QT_NR"
--   (	"MSGID" RAW(16),
--	"SUBSCRIBER#" NUMBER,
--	"NAME" VARCHAR2(30),
--	"ADDRESS#" NUMBER,
--	"SIGN" "SYS"."AQ$_SIG_PROP" ,
--	"DBS_SIGN" "SYS"."AQ$_SIG_PROP" ,
--	 PRIMARY KEY ("MSGID", "SUBSCRIBER#", "NAME", "ADDRESS#") ENABLE
--   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS 
-- PCTTHRESHOLD 50 INCLUDING "SIGN" OVERFLOW
-- PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
--  STORAGE(INITIAL 40960 NEXT 40960 MINEXTENTS 1 MAXEXTENTS 505
--  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
--  TABLESPACE "ARD";
--
--
--
---- "HR"."DR$HR_LOCATIONS_N1$I"
--  CREATE TABLE "HR"."DR$HR_LOCATIONS_N1$I"
--   (	"DR$TOKEN" VARCHAR2(64) NOT NULL ENABLE,
--	"DR$TOKEN_TYPE" NUMBER(3,0) NOT NULL ENABLE,
--	"DR$ROWID" ROWID NOT NULL ENABLE,
--	"DR$TOKEN_INFO" RAW(2000) NOT NULL ENABLE
--   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
--  STORAGE(INITIAL 40960 NEXT 40960 MINEXTENTS 1 MAXEXTENTS 505
--  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
--  TABLESPACE "HRD"
--
--
--
---- "HR"."DR$IRC_SEARCH_CRITERIA_CTX$I"
--  CREATE TABLE "HR"."DR$IRC_SEARCH_CRITERIA_CTX$I"
--   (	"DR$TOKEN" VARCHAR2(64) NOT NULL ENABLE,
--	"DR$TOKEN_TYPE" NUMBER(3,0) NOT NULL ENABLE,
--	"DR$ROWID" ROWID NOT NULL ENABLE,
--	"DR$TOKEN_INFO" RAW(2000) NOT NULL ENABLE
--   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
--  STORAGE(INITIAL 40960 NEXT 40960 MINEXTENTS 1 MAXEXTENTS 505
--  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
--  TABLESPACE "HRD";
--
--
---- "HR"."IRC_SEARCH_CRITERIA"
--  CREATE TABLE "HR"."IRC_SEARCH_CRITERIA"
--   (	"SEARCH_CRITERIA_ID" NUMBER(15,0) NOT NULL ENABLE,
--	"OBJECT_ID" NUMBER(15,0) NOT NULL ENABLE,
--	"OBJECT_TYPE" VARCHAR2(30) NOT NULL ENABLE,
--	"SEARCH_NAME" VARCHAR2(240),
--	"SEARCH_TYPE" VARCHAR2(30),
--	"LOCATION" VARCHAR2(240),
--	"DISTANCE_TO_LOCATION" VARCHAR2(30),
--	"EMPLOYEE" VARCHAR2(30),
--	"CONTRACTOR" VARCHAR2(30),
--	"EMPLOYMENT_CATEGORY" VARCHAR2(30),
--	"KEYWORDS" VARCHAR2(240),
--	"TRAVEL_PERCENTAGE" NUMBER,
--	"MIN_SALARY" NUMBER,
--	"MAX_SALARY" NUMBER,
--	"SALARY_CURRENCY" VARCHAR2(30),
--	"SALARY_PERIOD" VARCHAR2(30),
--	"MATCH_COMPETENCE" VARCHAR2(30),
--	"MATCH_QUALIFICATION" VARCHAR2(30),
--	"JOB_TITLE" VARCHAR2(240),
--	"DEPARTMENT" VARCHAR2(240),
--	"PROFESSIONAL_AREA" VARCHAR2(30),
--	"WORK_AT_HOME" VARCHAR2(30),
--	"MIN_QUAL_LEVEL" NUMBER(9,0),
--	"MAX_QUAL_LEVEL" NUMBER(9,0),
--	"USE_FOR_MATCHING" VARCHAR2(30),
--	"DESCRIPTION" CLOB,
--	"ATTRIBUTE_CATEGORY" VARCHAR2(30),
--	"ATTRIBUTE1" VARCHAR2(150),
--	"ATTRIBUTE2" VARCHAR2(150),
--	"ATTRIBUTE3" VARCHAR2(150),
--	"ATTRIBUTE4" VARCHAR2(150),
--	"ATTRIBUTE5" VARCHAR2(150),
--	"ATTRIBUTE6" VARCHAR2(150),
--	"ATTRIBUTE7" VARCHAR2(150),
--	"ATTRIBUTE8" VARCHAR2(150),
--	"ATTRIBUTE9" VARCHAR2(150),
--	"ATTRIBUTE10" VARCHAR2(150),
--	"ATTRIBUTE11" VARCHAR2(150),
--	"ATTRIBUTE12" VARCHAR2(150),
--	"ATTRIBUTE13" VARCHAR2(150),
--	"ATTRIBUTE14" VARCHAR2(150),
--	"ATTRIBUTE15" VARCHAR2(150),
--	"ATTRIBUTE16" VARCHAR2(150),
--	"ATTRIBUTE17" VARCHAR2(150),
--	"ATTRIBUTE18" VARCHAR2(150),
--	"ATTRIBUTE19" VARCHAR2(150),
--	"ATTRIBUTE20" VARCHAR2(150),
--	"ATTRIBUTE21" VARCHAR2(240),
--	"ATTRIBUTE22" VARCHAR2(240),
--	"ATTRIBUTE23" VARCHAR2(240),
--	"ATTRIBUTE24" VARCHAR2(240),
--	"ATTRIBUTE25" VARCHAR2(240),
--	"ATTRIBUTE26" VARCHAR2(240),
--	"ATTRIBUTE27" VARCHAR2(240),
--	"ATTRIBUTE28" VARCHAR2(240),
--	"ATTRIBUTE29" VARCHAR2(240),
--	"ATTRIBUTE30" VARCHAR2(240),
--	"ISC_INFORMATION_CATEGORY" VARCHAR2(30),
--	"ISC_INFORMATION1" VARCHAR2(150),
--	"ISC_INFORMATION2" VARCHAR2(150),
--	"ISC_INFORMATION3" VARCHAR2(150),
--	"ISC_INFORMATION4" VARCHAR2(150),
--	"ISC_INFORMATION5" VARCHAR2(150),
--	"ISC_INFORMATION6" VARCHAR2(150),
--	"ISC_INFORMATION7" VARCHAR2(150),
--	"ISC_INFORMATION8" VARCHAR2(150),
--	"ISC_INFORMATION9" VARCHAR2(150),
--	"ISC_INFORMATION10" VARCHAR2(150),
--	"ISC_INFORMATION11" VARCHAR2(150),
--	"ISC_INFORMATION12" VARCHAR2(150),
--	"ISC_INFORMATION13" VARCHAR2(150),
--	"ISC_INFORMATION14" VARCHAR2(150),
--	"ISC_INFORMATION15" VARCHAR2(150),
--	"ISC_INFORMATION16" VARCHAR2(150),
--	"ISC_INFORMATION17" VARCHAR2(150),
--	"ISC_INFORMATION18" VARCHAR2(150),
--	"ISC_INFORMATION19" VARCHAR2(150),
--	"ISC_INFORMATION20" VARCHAR2(150),
--	"ISC_INFORMATION21" VARCHAR2(150),
--	"ISC_INFORMATION22" VARCHAR2(150),
--	"ISC_INFORMATION23" VARCHAR2(150),
--	"ISC_INFORMATION24" VARCHAR2(150),
--	"ISC_INFORMATION25" VARCHAR2(150),
--	"ISC_INFORMATION26" VARCHAR2(150),
--	"ISC_INFORMATION27" VARCHAR2(150),
--	"ISC_INFORMATION28" VARCHAR2(150),
--	"ISC_INFORMATION29" VARCHAR2(150),
--	"ISC_INFORMATION30" VARCHAR2(150),
--	"LAST_UPDATE_DATE" DATE NOT NULL ENABLE,
--	"LAST_UPDATED_BY" NUMBER(15,0) NOT NULL ENABLE,
--	"LAST_UPDATE_LOGIN" NUMBER(15,0),
--	"CREATED_BY" NUMBER(15,0) NOT NULL ENABLE,
--	"CREATION_DATE" DATE NOT NULL ENABLE,
--	"OBJECT_VERSION_NUMBER" NUMBER(9,0) NOT NULL ENABLE,
--	"DATE_POSTED" VARCHAR2(30),
--	"GEOCODE_LOCATION" VARCHAR2(240),
--	"GEOCODE_COUNTRY" VARCHAR2(30),
--	"DERIVED_LOCATION" VARCHAR2(240),
--	"LOCATION_ID" NUMBER(15,0),
--	"GEOMETRY" "MDSYS"."SDO_GEOMETRY"
--   ) PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 NOCOMPRESS LOGGING
--  STORAGE(INITIAL 16384 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
--  PCTINCREASE 0 FREELISTS 4 FREELIST GROUPS 4 BUFFER_POOL DEFAULT)
--  TABLESPACE "HRD"
-- LOB ("DESCRIPTION") STORE AS (
--  TABLESPACE "HRD" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
--  NOCACHE
--  STORAGE(INITIAL 16384 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
--  PCTINCREASE 0 FREELISTS 4 FREELIST GROUPS 4 BUFFER_POOL DEFAULT));
--

/
