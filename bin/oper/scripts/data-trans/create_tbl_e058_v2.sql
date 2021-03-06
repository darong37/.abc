set sqln off
set line 200
set pagesize 1000
set long 5000

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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
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
 TABLESPACE "APPS_TS_QUEUES"  ENABLE
  ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
 STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
 TABLESPACE "APPS_TS_QUEUES"
LOB ("USER_DATA"."TEXT_LOB") STORE AS (
 TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 32768 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
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
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "APPS_TS_QUEUES" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- "ODM"."DMS_QUEUE_TABLE"
  CREATE TABLE "ODM"."DMS_QUEUE_TABLE"
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
  TABLESPACE "ODM"  ENABLE
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "ODM"
 LOB ("USER_DATA"."TEXT_LOB") STORE AS (
  TABLESPACE "ODM" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));


-- 1a


-- "APPLSYS"."AQ$_WF_CONTROL_H"
  CREATE TABLE "APPLSYS"."AQ$_WF_CONTROL_H"
   (    "MSGID" RAW(16),
        "SUBSCRIBER#" NUMBER,
        "NAME" VARCHAR2(30),
        "ADDRESS#" NUMBER,
        "DEQUEUE_TIME" DATE,
        "TRANSACTION_ID" VARCHAR2(30),
        "DEQUEUE_USER" NUMBER,
        "PROPAGATED_MSGID" RAW(16),
        "RETRY_COUNT" NUMBER,
        "HINT" ROWID,
        "SPARE" RAW(16),
         PRIMARY KEY ("MSGID", "SUBSCRIBER#", "NAME", "ADDRESS#") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;


-- "APPLSYS"."AQ$_WF_CONTROL_I"
  CREATE TABLE "APPLSYS"."AQ$_WF_CONTROL_I"
   (    "SUBSCRIBER#" NUMBER,
        "NAME" VARCHAR2(30),
        "QUEUE#" NUMBER,
        "MSG_PRIORITY" NUMBER,
        "MSG_ENQ_TIME" DATE,
        "MSG_STEP_NO" NUMBER,
        "MSG_CHAIN_NO" NUMBER,
        "MSG_LOCAL_ORDER_NO" NUMBER,
        "MSGID" RAW(16),
        "HINT" ROWID,
        "SPARE" RAW(16),
         PRIMARY KEY ("SUBSCRIBER#", "NAME", "QUEUE#", "MSG_PRIORITY", "MSG_ENQ_TIME"
                    , "MSG_STEP_NO", "MSG_CHAIN_NO", "MSG_LOCAL_ORDER_NO", "MSGID") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;


-- "APPLSYS"."AQ$_WF_CONTROL_S"
  CREATE TABLE "APPLSYS"."AQ$_WF_CONTROL_S"
   (    "SUBSCRIBER_ID" NUMBER NOT NULL ENABLE,
        "QUEUE_NAME" VARCHAR2(30) NOT NULL ENABLE,
        "NAME" VARCHAR2(30),
        "ADDRESS" VARCHAR2(1024),
        "PROTOCOL" NUMBER,
        "SUBSCRIBER_TYPE" NUMBER,
        "RULE_NAME" VARCHAR2(30),
        "TRANS_NAME" VARCHAR2(61),
        "RULESET_NAME" VARCHAR2(61),
         PRIMARY KEY ("SUBSCRIBER_ID")
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES";

-- "APPLSYS"."AQ$_WF_CONTROL_T"
  CREATE TABLE "APPLSYS"."AQ$_WF_CONTROL_T"
   (    "NEXT_DATE" DATE,
        "TXN_ID" VARCHAR2(30),
        "MSGID" RAW(16),
        "ACTION" NUMBER,
         PRIMARY KEY ("NEXT_DATE", "TXN_ID", "MSGID") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;


-- "APPLSYS"."AQ$_WF_JAVA_DEFERRED_H"
  CREATE TABLE "APPLSYS"."AQ$_WF_JAVA_DEFERRED_H"
   (    "MSGID" RAW(16),
        "SUBSCRIBER#" NUMBER,
        "NAME" VARCHAR2(30),
        "ADDRESS#" NUMBER,
        "DEQUEUE_TIME" DATE,
        "TRANSACTION_ID" VARCHAR2(30),
        "DEQUEUE_USER" NUMBER,
        "PROPAGATED_MSGID" RAW(16),
        "RETRY_COUNT" NUMBER,
        "HINT" ROWID,
        "SPARE" RAW(16),
         PRIMARY KEY ("MSGID", "SUBSCRIBER#", "NAME", "ADDRESS#") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;


-- "APPLSYS"."AQ$_WF_JAVA_DEFERRED_I"
  CREATE TABLE "APPLSYS"."AQ$_WF_JAVA_DEFERRED_I"
   (    "SUBSCRIBER#" NUMBER,
        "NAME" VARCHAR2(30),
        "QUEUE#" NUMBER,
        "MSG_PRIORITY" NUMBER,
        "MSG_ENQ_TIME" DATE,
        "MSG_STEP_NO" NUMBER,
        "MSG_CHAIN_NO" NUMBER,
        "MSG_LOCAL_ORDER_NO" NUMBER,
        "MSGID" RAW(16),
        "HINT" ROWID,
        "SPARE" RAW(16),
         PRIMARY KEY ("SUBSCRIBER#", "NAME", "QUEUE#", "MSG_PRIORITY", "MSG_ENQ_TIME", "MSG_STEP_NO"
                    , "MSG_CHAIN_NO", "MSG_LOCAL_ORDER_NO", "MSGID") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;


-- "APPLSYS"."AQ$_WF_JAVA_DEFERRED_S"
  CREATE TABLE "APPLSYS"."AQ$_WF_JAVA_DEFERRED_S"
   (    "SUBSCRIBER_ID" NUMBER NOT NULL ENABLE,
        "QUEUE_NAME" VARCHAR2(30) NOT NULL ENABLE,
        "NAME" VARCHAR2(30),
        "ADDRESS" VARCHAR2(1024),
        "PROTOCOL" NUMBER,
        "SUBSCRIBER_TYPE" NUMBER,
        "RULE_NAME" VARCHAR2(30),
        "TRANS_NAME" VARCHAR2(61),
        "RULESET_NAME" VARCHAR2(61),
         PRIMARY KEY ("SUBSCRIBER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES";


-- "APPLSYS"."AQ$_WF_JAVA_DEFERRED_T"
  CREATE TABLE "APPLSYS"."AQ$_WF_JAVA_DEFERRED_T"
   (    "NEXT_DATE" DATE,
        "TXN_ID" VARCHAR2(30),
        "MSGID" RAW(16),
        "ACTION" NUMBER,
         PRIMARY KEY ("NEXT_DATE", "TXN_ID", "MSGID") ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 131072 NEXT 131072 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "APPS_TS_QUEUES"
 PCTTHRESHOLD 50;
 

