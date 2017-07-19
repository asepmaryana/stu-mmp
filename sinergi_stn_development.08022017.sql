--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: pms; Type: SCHEMA; Schema: -; Owner: sinergi
--

CREATE SCHEMA pms;


ALTER SCHEMA pms OWNER TO sinergi;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = pms, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alarm_counter; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_counter (
    alarm_list_id integer NOT NULL,
    ddate timestamp without time zone NOT NULL,
    node_id integer NOT NULL,
    alarm_count smallint
);


ALTER TABLE alarm_counter OWNER TO sinergi;

--
-- Name: alarm_list; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_list (
    id integer NOT NULL,
    alarm_caused character varying(100),
    alarm_code character varying(10),
    alarm_impacted character varying(100),
    alarm_name character varying(200) NOT NULL,
    alarm_severity_id integer,
    device_id integer
);


ALTER TABLE alarm_list OWNER TO sinergi;

--
-- Name: alarm_list_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE alarm_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarm_list_id_seq OWNER TO sinergi;

--
-- Name: alarm_list_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE alarm_list_id_seq OWNED BY alarm_list.id;


--
-- Name: alarm_log; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_log (
    id bigint NOT NULL,
    alarm_counter smallint,
    alarm_index integer,
    alarm_name character varying(100),
    alarm_severity_id integer,
    dtime timestamp without time zone,
    dtime_end timestamp without time zone,
    enterprise character varying(100),
    notes character varying(50),
    trap_oid character varying(150),
    alarm_list_id integer,
    device_id integer,
    device_type_id integer,
    node_id integer
);


ALTER TABLE alarm_log OWNER TO sinergi;

--
-- Name: alarm_mapping; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_mapping (
    id integer NOT NULL,
    alarm_index smallint,
    alarm_list_id integer,
    device_id integer
);


ALTER TABLE alarm_mapping OWNER TO sinergi;

--
-- Name: alarm_mapping_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE alarm_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarm_mapping_id_seq OWNER TO sinergi;

--
-- Name: alarm_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE alarm_mapping_id_seq OWNED BY alarm_mapping.id;


--
-- Name: alarm_notified; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_notified (
    id integer NOT NULL,
    alarm_list_id integer
);


ALTER TABLE alarm_notified OWNER TO sinergi;

--
-- Name: alarm_notified_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE alarm_notified_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarm_notified_id_seq OWNER TO sinergi;

--
-- Name: alarm_notified_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE alarm_notified_id_seq OWNED BY alarm_notified.id;


--
-- Name: alarm_severity; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_severity (
    id integer NOT NULL,
    color character varying(7),
    name character varying(15),
    notified smallint
);


ALTER TABLE alarm_severity OWNER TO sinergi;

--
-- Name: alarm_severity_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE alarm_severity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarm_severity_id_seq OWNER TO sinergi;

--
-- Name: alarm_severity_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE alarm_severity_id_seq OWNED BY alarm_severity.id;


--
-- Name: alarm_temp; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE alarm_temp (
    id bigint NOT NULL,
    acknowledge character(1),
    alarm_counter smallint,
    alarm_index integer,
    alarm_name character varying(100),
    alarm_severity_id integer,
    dtime timestamp without time zone,
    enterprise character varying(100),
    notes character varying(50),
    notified character(1),
    trap_oid character varying(150),
    trap_updated timestamp without time zone,
    alarm_list_id integer,
    device_id integer,
    device_type_id integer,
    node_id integer
);


ALTER TABLE alarm_temp OWNER TO sinergi;

--
-- Name: alarm_temp_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE alarm_temp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarm_temp_id_seq OWNER TO sinergi;

--
-- Name: alarm_temp_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE alarm_temp_id_seq OWNED BY alarm_temp.id;


--
-- Name: analog_input; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE analog_input (
    id bigint NOT NULL,
    label character varying(100),
    pin smallint,
    alarm_list_id integer,
    alarm_severity_id integer,
    node_id integer
);


ALTER TABLE analog_input OWNER TO sinergi;

--
-- Name: analog_input_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE analog_input_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE analog_input_id_seq OWNER TO sinergi;

--
-- Name: analog_input_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE analog_input_id_seq OWNED BY analog_input.id;


--
-- Name: app_config; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_config (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE app_config OWNER TO sinergi;

--
-- Name: app_config_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE app_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_config_id_seq OWNER TO sinergi;

--
-- Name: app_config_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE app_config_id_seq OWNED BY app_config.id;


--
-- Name: app_menu; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_menu (
    id integer NOT NULL,
    menu_action character varying(255),
    label character varying(255) NOT NULL,
    menu_level integer NOT NULL,
    menu_options character varying(255),
    menu_order integer NOT NULL,
    parent_id integer,
    CONSTRAINT app_menu_menu_level_check CHECK ((menu_level >= 0)),
    CONSTRAINT app_menu_menu_order_check CHECK ((menu_order >= 0))
);


ALTER TABLE app_menu OWNER TO sinergi;

--
-- Name: app_menu_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE app_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_menu_id_seq OWNER TO sinergi;

--
-- Name: app_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE app_menu_id_seq OWNED BY app_menu.id;


--
-- Name: app_permission; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_permission (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE app_permission OWNER TO sinergi;

--
-- Name: app_permission_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE app_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_permission_id_seq OWNER TO sinergi;

--
-- Name: app_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE app_permission_id_seq OWNED BY app_permission.id;


--
-- Name: app_role; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_role (
    id integer NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE app_role OWNER TO sinergi;

--
-- Name: app_role_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE app_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_role_id_seq OWNER TO sinergi;

--
-- Name: app_role_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE app_role_id_seq OWNED BY app_role.id;


--
-- Name: app_role_menu; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_role_menu (
    app_role_id integer NOT NULL,
    app_menu_id integer NOT NULL
);


ALTER TABLE app_role_menu OWNER TO sinergi;

--
-- Name: app_role_permission; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_role_permission (
    app_role_id integer NOT NULL,
    app_permission_id integer NOT NULL
);


ALTER TABLE app_role_permission OWNER TO sinergi;

--
-- Name: app_user; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE app_user (
    id integer NOT NULL,
    active boolean NOT NULL,
    fullname character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    app_role_id integer NOT NULL
);


ALTER TABLE app_user OWNER TO sinergi;

--
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_user_id_seq OWNER TO sinergi;

--
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE app_user_id_seq OWNED BY app_user.id;


--
-- Name: ctvt; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE ctvt (
    node_id integer NOT NULL,
    vrect numeric DEFAULT 0,
    iload numeric DEFAULT 0,
    ibatt numeric DEFAULT 0
);


ALTER TABLE ctvt OWNER TO sinergi;

--
-- Name: customer; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE customer (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE customer OWNER TO sinergi;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customer_id_seq OWNER TO sinergi;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE customer_id_seq OWNED BY customer.id;


--
-- Name: device; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE device (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer,
    manufacturer_id integer
);


ALTER TABLE device OWNER TO sinergi;

--
-- Name: device_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_id_seq OWNER TO sinergi;

--
-- Name: device_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE device_id_seq OWNED BY device.id;


--
-- Name: device_object; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE device_object (
    id integer NOT NULL,
    divider smallint DEFAULT 1 NOT NULL,
    instance character varying(3),
    polled smallint,
    unit character varying(10),
    var_name character varying(50) NOT NULL,
    var_oid character varying(255),
    var_type character varying(15),
    device_id integer
);


ALTER TABLE device_object OWNER TO sinergi;

--
-- Name: device_object_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE device_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_object_id_seq OWNER TO sinergi;

--
-- Name: device_object_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE device_object_id_seq OWNED BY device_object.id;


--
-- Name: device_type; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE device_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE device_type OWNER TO sinergi;

--
-- Name: device_type_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE device_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_type_id_seq OWNER TO sinergi;

--
-- Name: device_type_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE device_type_id_seq OWNED BY device_type.id;


--
-- Name: digital_input; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE digital_input (
    id bigint NOT NULL,
    label character varying(100),
    pin smallint,
    alarm_list_id integer,
    alarm_severity_id integer,
    node_id integer
);


ALTER TABLE digital_input OWNER TO sinergi;

--
-- Name: digital_input_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE digital_input_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE digital_input_id_seq OWNER TO sinergi;

--
-- Name: digital_input_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE digital_input_id_seq OWNED BY digital_input.id;


--
-- Name: digital_output; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE digital_output (
    id bigint NOT NULL,
    enabled character(1),
    label character varying(100),
    pin smallint,
    alarm_list_id integer,
    alarm_severity_id integer,
    digital_input_id bigint,
    node_id integer
);


ALTER TABLE digital_output OWNER TO sinergi;

--
-- Name: digital_output_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE digital_output_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE digital_output_id_seq OWNER TO sinergi;

--
-- Name: digital_output_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE digital_output_id_seq OWNED BY digital_output.id;


--
-- Name: http; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE http (
    id integer NOT NULL,
    dtime timestamp without time zone,
    param character varying(255),
    uri character varying(255)
);


ALTER TABLE http OWNER TO sinergi;

--
-- Name: http_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE http_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE http_id_seq OWNER TO sinergi;

--
-- Name: http_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE http_id_seq OWNED BY http.id;


--
-- Name: humidity; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE humidity (
    id integer NOT NULL,
    label character varying(100),
    pin smallint,
    alarm_list_id integer,
    alarm_severity_id integer,
    node_id integer
);


ALTER TABLE humidity OWNER TO sinergi;

--
-- Name: humidity_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE humidity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humidity_id_seq OWNER TO sinergi;

--
-- Name: humidity_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE humidity_id_seq OWNED BY humidity.id;


--
-- Name: manufacturer; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE manufacturer (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE manufacturer OWNER TO sinergi;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE manufacturer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manufacturer_id_seq OWNER TO sinergi;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE manufacturer_id_seq OWNED BY manufacturer.id;


--
-- Name: message; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE message (
    id bigint NOT NULL,
    alarm_name character varying(100),
    alarm_severity character varying(10),
    alarm_status character varying(10),
    device_address character varying(16),
    device_name character varying(50),
    email_cc character varying(1000),
    email_date timestamp without time zone,
    email_from character varying(100),
    email_subject character varying(100),
    email_to character varying(1000),
    region_name character varying(50),
    sent smallint,
    site_name character varying(50)
);


ALTER TABLE message OWNER TO sinergi;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_id_seq OWNER TO sinergi;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE message_id_seq OWNED BY message.id;


--
-- Name: motion; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE motion (
    id bigint NOT NULL,
    dtime timestamp without time zone,
    file_ext character varying(10),
    file_name character varying(255),
    file_size integer,
    node_id integer,
    subnet_id integer
);


ALTER TABLE motion OWNER TO sinergi;

--
-- Name: motion_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE motion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE motion_id_seq OWNER TO sinergi;

--
-- Name: motion_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE motion_id_seq OWNED BY motion.id;


--
-- Name: node; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE node (
    id integer NOT NULL,
    address character varying(16),
    description character varying(100),
    last_update timestamp without time zone,
    mini smallint,
    name character varying(50) NOT NULL,
    poll_down integer,
    protocol character varying(5),
    sn character varying(16) NOT NULL,
    snmp_port smallint,
    snmp_read character varying(15),
    snmp_retries smallint,
    snmp_timeout smallint,
    snmp_version smallint,
    snmp_write character varying(15),
    device_id integer,
    opr_status_id integer,
    poller_agent character varying(16),
    subnet_id integer
);


ALTER TABLE node OWNER TO sinergi;

--
-- Name: node_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE node_id_seq OWNER TO sinergi;

--
-- Name: node_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE node_id_seq OWNED BY node.id;


--
-- Name: node_info; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE node_info (
    node_id integer NOT NULL,
    vr numeric DEFAULT 0,
    vs numeric DEFAULT 0,
    vt numeric DEFAULT 0,
    cr numeric DEFAULT 0,
    cs numeric DEFAULT 0,
    ct numeric DEFAULT 0,
    phr numeric DEFAULT 0,
    phs numeric DEFAULT 0,
    pht numeric DEFAULT 0,
    pr numeric DEFAULT 0,
    ps numeric DEFAULT 0,
    pt numeric DEFAULT 0,
    gvr numeric DEFAULT 0,
    gvs numeric DEFAULT 0,
    gvt numeric DEFAULT 0,
    gvr2 numeric DEFAULT 0,
    gvs2 numeric DEFAULT 0,
    gvt2 numeric DEFAULT 0,
    gen_fail_flag smallint DEFAULT 0,
    gcr numeric DEFAULT 0,
    gcs numeric DEFAULT 0,
    gct numeric DEFAULT 0,
    gcr2 numeric DEFAULT 0,
    gcs2 numeric DEFAULT 0,
    gct2 numeric DEFAULT 0,
    fuel numeric DEFAULT 0,
    fuel2 numeric DEFAULT 0
);


ALTER TABLE node_info OWNER TO sinergi;

--
-- Name: node_status; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE node_status (
    dtime timestamp without time zone NOT NULL,
    node_id integer NOT NULL,
    status character(1) NOT NULL,
    subnet_id integer NOT NULL
);


ALTER TABLE node_status OWNER TO sinergi;

--
-- Name: node_status_history; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE node_status_history (
    dtime timestamp without time zone NOT NULL,
    dtime_end timestamp without time zone NOT NULL,
    node_id integer NOT NULL,
    status character(1) NOT NULL,
    subnet_id integer NOT NULL
);


ALTER TABLE node_status_history OWNER TO sinergi;

--
-- Name: notification; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE notification (
    id integer NOT NULL,
    name character varying(15)
);


ALTER TABLE notification OWNER TO sinergi;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_id_seq OWNER TO sinergi;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE notification_id_seq OWNED BY notification.id;


--
-- Name: opr_status; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE opr_status (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE opr_status OWNER TO sinergi;

--
-- Name: opr_status_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE opr_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE opr_status_id_seq OWNER TO sinergi;

--
-- Name: opr_status_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE opr_status_id_seq OWNED BY opr_status.id;


--
-- Name: poll; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE poll (
    id bigint NOT NULL,
    node_id integer,
    device_object_id integer,
    dtime timestamp without time zone,
    value numeric,
    divider smallint DEFAULT 1 NOT NULL
);


ALTER TABLE poll OWNER TO sinergi;

--
-- Name: poll_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE poll_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poll_id_seq OWNER TO sinergi;

--
-- Name: poll_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE poll_id_seq OWNED BY poll.id;


--
-- Name: poller; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE poller (
    ip character varying(16) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE poller OWNER TO sinergi;

--
-- Name: role_menu; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE role_menu (
    id integer NOT NULL,
    menu_id integer,
    role_id integer
);


ALTER TABLE role_menu OWNER TO sinergi;

--
-- Name: role_menu_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE role_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_menu_id_seq OWNER TO sinergi;

--
-- Name: role_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE role_menu_id_seq OWNED BY role_menu.id;


--
-- Name: setting; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE setting (
    core_pool_size smallint NOT NULL,
    max_pool_size smallint NOT NULL,
    message_delete smallint NOT NULL,
    notif_active smallint NOT NULL,
    notif_mode smallint NOT NULL,
    smtp_auth boolean NOT NULL,
    smtp_cc character varying(1000) NOT NULL,
    smtp_debug boolean NOT NULL,
    smtp_host character varying(100) NOT NULL,
    smtp_password character varying(100) NOT NULL,
    smtp_port smallint NOT NULL,
    smtp_protocol character varying(10) NOT NULL,
    smtp_tls boolean NOT NULL,
    smtp_transport character varying(10) NOT NULL,
    smtp_user character varying(100) NOT NULL
);


ALTER TABLE setting OWNER TO sinergi;

--
-- Name: site_config; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE site_config (
    site_type_id smallint NOT NULL,
    subnet_id integer NOT NULL,
    phase smallint
);


ALTER TABLE site_config OWNER TO sinergi;

--
-- Name: site_status; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE site_status (
    dtime timestamp without time zone NOT NULL,
    parent_id integer NOT NULL,
    status character(1) NOT NULL,
    subnet_id integer NOT NULL
);


ALTER TABLE site_status OWNER TO sinergi;

--
-- Name: site_status_history; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE site_status_history (
    dtime timestamp without time zone NOT NULL,
    dtime_end timestamp without time zone NOT NULL,
    parent_id integer NOT NULL,
    status character(1) NOT NULL,
    subnet_id integer NOT NULL
);


ALTER TABLE site_status_history OWNER TO sinergi;

--
-- Name: site_type; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE site_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE site_type OWNER TO sinergi;

--
-- Name: site_type_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE site_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE site_type_id_seq OWNER TO sinergi;

--
-- Name: site_type_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE site_type_id_seq OWNED BY site_type.id;


--
-- Name: subnet; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE subnet (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(50),
    parent_id integer,
    protocol character varying(5) DEFAULT 'snmp'::character varying,
    xpos numeric,
    ypos numeric,
    alarm_temp_id bigint
);


ALTER TABLE subnet OWNER TO sinergi;

--
-- Name: subnet_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE subnet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subnet_id_seq OWNER TO sinergi;

--
-- Name: subnet_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE subnet_id_seq OWNED BY subnet.id;


--
-- Name: temperature; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE temperature (
    id integer NOT NULL,
    label character varying(100),
    pin smallint,
    alarm_list_id integer,
    alarm_severity_id integer,
    node_id integer
);


ALTER TABLE temperature OWNER TO sinergi;

--
-- Name: temperature_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE temperature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temperature_id_seq OWNER TO sinergi;

--
-- Name: temperature_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE temperature_id_seq OWNED BY temperature.id;


--
-- Name: trap; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE trap (
    id bigint NOT NULL,
    agent_addr character varying(15),
    community character varying(30),
    dtime timestamp without time zone,
    enterprise character varying(100),
    from_addr character varying(15),
    trap_oid character varying(150),
    trap_specific smallint,
    trap_type smallint,
    uptime bigint,
    var_name1 character varying(50),
    var_name10 character varying(50),
    var_name2 character varying(50),
    var_name3 character varying(50),
    var_name4 character varying(50),
    var_name5 character varying(150),
    var_name6 character varying(50),
    var_name7 character varying(50),
    var_name8 character varying(50),
    var_name9 character varying(50),
    var_val1 character varying(50),
    var_val10 character varying(50),
    var_val2 character varying(50),
    var_val3 character varying(50),
    var_val4 character varying(50),
    var_val5 character varying(150),
    var_val6 character varying(50),
    var_val7 character varying(50),
    var_val8 character varying(50),
    var_val9 character varying(50),
    node_id integer
);


ALTER TABLE trap OWNER TO sinergi;

--
-- Name: trap_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE trap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trap_id_seq OWNER TO sinergi;

--
-- Name: trap_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE trap_id_seq OWNED BY trap.id;


--
-- Name: users; Type: TABLE; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(50),
    enabled smallint NOT NULL,
    last_login timestamp without time zone,
    name character varying(40),
    password character varying(50),
    phone character varying(20),
    username character varying(30) NOT NULL,
    notification_id smallint,
    role_id integer,
    subnet_id integer
);


ALTER TABLE users OWNER TO sinergi;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: pms; Owner: sinergi
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO sinergi;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: sinergi
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_list ALTER COLUMN id SET DEFAULT nextval('alarm_list_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_mapping ALTER COLUMN id SET DEFAULT nextval('alarm_mapping_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_notified ALTER COLUMN id SET DEFAULT nextval('alarm_notified_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_severity ALTER COLUMN id SET DEFAULT nextval('alarm_severity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_temp ALTER COLUMN id SET DEFAULT nextval('alarm_temp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY analog_input ALTER COLUMN id SET DEFAULT nextval('analog_input_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_config ALTER COLUMN id SET DEFAULT nextval('app_config_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_menu ALTER COLUMN id SET DEFAULT nextval('app_menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_permission ALTER COLUMN id SET DEFAULT nextval('app_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_role ALTER COLUMN id SET DEFAULT nextval('app_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_user ALTER COLUMN id SET DEFAULT nextval('app_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY customer ALTER COLUMN id SET DEFAULT nextval('customer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device ALTER COLUMN id SET DEFAULT nextval('device_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device_object ALTER COLUMN id SET DEFAULT nextval('device_object_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device_type ALTER COLUMN id SET DEFAULT nextval('device_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_input ALTER COLUMN id SET DEFAULT nextval('digital_input_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_output ALTER COLUMN id SET DEFAULT nextval('digital_output_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY http ALTER COLUMN id SET DEFAULT nextval('http_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY humidity ALTER COLUMN id SET DEFAULT nextval('humidity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY manufacturer ALTER COLUMN id SET DEFAULT nextval('manufacturer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY message ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY motion ALTER COLUMN id SET DEFAULT nextval('motion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node ALTER COLUMN id SET DEFAULT nextval('node_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY notification ALTER COLUMN id SET DEFAULT nextval('notification_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY opr_status ALTER COLUMN id SET DEFAULT nextval('opr_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY poll ALTER COLUMN id SET DEFAULT nextval('poll_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY role_menu ALTER COLUMN id SET DEFAULT nextval('role_menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY site_type ALTER COLUMN id SET DEFAULT nextval('site_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY subnet ALTER COLUMN id SET DEFAULT nextval('subnet_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY temperature ALTER COLUMN id SET DEFAULT nextval('temperature_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY trap ALTER COLUMN id SET DEFAULT nextval('trap_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: alarm_counter; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: alarm_list; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: alarm_list_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('alarm_list_id_seq', 1, false);


--
-- Data for Name: alarm_log; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: alarm_mapping; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: alarm_mapping_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('alarm_mapping_id_seq', 1, false);


--
-- Data for Name: alarm_notified; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: alarm_notified_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('alarm_notified_id_seq', 1, false);


--
-- Data for Name: alarm_severity; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO alarm_severity VALUES (1, '#FF0000', 'CRITICAL', 1);
INSERT INTO alarm_severity VALUES (2, '#FF8040', 'MAJOR', 0);
INSERT INTO alarm_severity VALUES (3, '#F0F000', 'MINOR', 0);
INSERT INTO alarm_severity VALUES (4, '#FF8040', 'WARNING', 0);
INSERT INTO alarm_severity VALUES (5, '#808080', 'COMM', 0);


--
-- Name: alarm_severity_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('alarm_severity_id_seq', 5, true);


--
-- Data for Name: alarm_temp; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: alarm_temp_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('alarm_temp_id_seq', 1, false);


--
-- Data for Name: analog_input; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: analog_input_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('analog_input_id_seq', 1, false);


--
-- Data for Name: app_config; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: app_config_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('app_config_id_seq', 1, false);


--
-- Data for Name: app_menu; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: app_menu_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('app_menu_id_seq', 1, false);


--
-- Data for Name: app_permission; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: app_permission_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('app_permission_id_seq', 1, false);


--
-- Data for Name: app_role; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: app_role_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('app_role_id_seq', 1, false);


--
-- Data for Name: app_role_menu; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: app_role_permission; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: app_user; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('app_user_id_seq', 1, false);


--
-- Data for Name: ctvt; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO ctvt VALUES (1, 0, 0, 0);


--
-- Data for Name: customer; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('customer_id_seq', 1, false);


--
-- Data for Name: device; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO device VALUES (1, 'STN100', 1, 1);
INSERT INTO device VALUES (2, 'AEG ACM1000', 2, 3);
INSERT INTO device VALUES (3, 'Emerson M800D', 2, 2);
INSERT INTO device VALUES (4, 'Emerson M810G', 2, 2);
INSERT INTO device VALUES (5, 'PowerOne', 2, 4);
INSERT INTO device VALUES (6, 'AEG CTVT', 2, 3);
INSERT INTO device VALUES (7, 'SC200', 2, 5);
INSERT INTO device VALUES (8, 'SM45', 2, 6);
INSERT INTO device VALUES (9, 'Emerson CTVT', 2, 2);
INSERT INTO device VALUES (11, 'Energy Meter', 3, NULL);
INSERT INTO device VALUES (10, 'AEG STU', 2, 1);


--
-- Name: device_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('device_id_seq', 1, false);


--
-- Data for Name: device_object; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO device_object VALUES (1, 1, NULL, NULL, 'V', 'Battery Voltage', NULL, NULL, 1);
INSERT INTO device_object VALUES (2, 1, NULL, NULL, 'A', 'Analog input 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (3, 1, NULL, NULL, 'A', 'Analog input 3', NULL, NULL, 1);
INSERT INTO device_object VALUES (4, 1, NULL, NULL, 'V', 'Analog input 4', NULL, NULL, 1);
INSERT INTO device_object VALUES (5, 1, NULL, NULL, 'A', 'Analog input 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (6, 1, NULL, NULL, 'A', 'Analog input 6', NULL, NULL, 1);
INSERT INTO device_object VALUES (7, 1, NULL, NULL, 'V', 'Analog input 7', NULL, NULL, 1);
INSERT INTO device_object VALUES (8, 1, NULL, NULL, 'V', 'Analog input 8', NULL, NULL, 1);
INSERT INTO device_object VALUES (9, 1, NULL, NULL, 'V', 'Analog input 9', NULL, NULL, 1);
INSERT INTO device_object VALUES (10, 1, NULL, NULL, 'V', 'Analog input 10', NULL, NULL, 1);
INSERT INTO device_object VALUES (11, 1, NULL, NULL, 'V', 'Analog input 11', NULL, NULL, 1);
INSERT INTO device_object VALUES (12, 1, NULL, NULL, 'V', 'Analog input 12', NULL, NULL, 1);
INSERT INTO device_object VALUES (101, 1, NULL, NULL, 'V', 'Voltage Phase R 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (102, 1, NULL, NULL, 'A', 'Current Phase R 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (103, 1, NULL, NULL, 'KW', 'Power Phase R 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (104, 1, NULL, NULL, 'V', 'Voltage Phase S 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (105, 1, NULL, NULL, 'A', 'Current Phase S 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (106, 1, NULL, NULL, 'KW', 'Power Phase S 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (107, 1, NULL, NULL, 'V', 'Voltage Phase T 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (108, 1, NULL, NULL, 'A', 'Current Phase T 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (109, 1, NULL, NULL, 'KW', 'Power Phase T 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (121, 1, NULL, NULL, 'V', 'Voltage Phase R 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (122, 1, NULL, NULL, 'A', 'Current Phase R 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (123, 1, NULL, NULL, 'KW', 'Power Phase R 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (124, 1, NULL, NULL, 'V', 'Voltage Phase  S 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (125, 1, NULL, NULL, 'A', 'Current Phase S 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (126, 1, NULL, NULL, 'KW', 'Power Phase S 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (127, 1, NULL, NULL, 'V', 'Voltage Phase  T 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (128, 1, NULL, NULL, 'A', 'Current Phase  T 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (129, 1, NULL, NULL, 'KW', 'Power Phase T 2 ', NULL, NULL, 1);
INSERT INTO device_object VALUES (201, 1, NULL, NULL, '&deg;C', 'Temperature 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (202, 1, NULL, NULL, '%', 'Humidity 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (203, 1, NULL, NULL, '&deg;C', 'Temperature 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (204, 1, NULL, NULL, '%', 'Humidity 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (301, 1, NULL, NULL, '', 'tank ', NULL, NULL, 1);
INSERT INTO device_object VALUES (302, 1, NULL, NULL, '', 'tank ', NULL, NULL, 1);
INSERT INTO device_object VALUES (401, 1, NULL, NULL, '', 'Phase R', NULL, NULL, 1);
INSERT INTO device_object VALUES (402, 1, NULL, NULL, '', 'Phase S', NULL, NULL, 1);
INSERT INTO device_object VALUES (403, 1, NULL, NULL, '', 'Phase T', NULL, NULL, 1);
INSERT INTO device_object VALUES (404, 1, NULL, NULL, '', 'Door Open', NULL, NULL, 1);
INSERT INTO device_object VALUES (405, 1, NULL, NULL, '', 'DI 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (406, 1, NULL, NULL, '', 'DI 6', NULL, NULL, 1);
INSERT INTO device_object VALUES (407, 1, NULL, NULL, '', 'DI 7', NULL, NULL, 1);
INSERT INTO device_object VALUES (408, 1, NULL, NULL, '', 'DI 8', NULL, NULL, 1);
INSERT INTO device_object VALUES (409, 1, NULL, NULL, '', 'DI 9', NULL, NULL, 1);
INSERT INTO device_object VALUES (410, 1, NULL, NULL, '', 'DI 10', NULL, NULL, 1);
INSERT INTO device_object VALUES (411, 1, NULL, NULL, '', 'DI 11', NULL, NULL, 1);
INSERT INTO device_object VALUES (412, 1, NULL, NULL, '', 'DI 12', NULL, NULL, 1);
INSERT INTO device_object VALUES (413, 1, NULL, NULL, '', 'DI 13', NULL, NULL, 1);
INSERT INTO device_object VALUES (414, 1, NULL, NULL, '', 'DI 14', NULL, NULL, 1);
INSERT INTO device_object VALUES (415, 1, NULL, NULL, '', 'DI 15', NULL, NULL, 1);
INSERT INTO device_object VALUES (416, 1, NULL, NULL, '', 'DI 16', NULL, NULL, 1);
INSERT INTO device_object VALUES (417, 1, NULL, NULL, '', 'DI 17', NULL, NULL, 1);
INSERT INTO device_object VALUES (418, 1, NULL, NULL, '', 'DI 18', NULL, NULL, 1);
INSERT INTO device_object VALUES (419, 1, NULL, NULL, '', 'DI 19', NULL, NULL, 1);
INSERT INTO device_object VALUES (420, 1, NULL, NULL, '', 'DI 20', NULL, NULL, 1);
INSERT INTO device_object VALUES (421, 1, NULL, NULL, '', 'DI 21', NULL, NULL, 1);
INSERT INTO device_object VALUES (422, 1, NULL, NULL, '', 'DI 22', NULL, NULL, 1);
INSERT INTO device_object VALUES (423, 1, NULL, NULL, '', 'DI 23', NULL, NULL, 1);
INSERT INTO device_object VALUES (424, 1, NULL, NULL, '', 'DI 24', NULL, NULL, 1);
INSERT INTO device_object VALUES (425, 1, NULL, NULL, '', 'DI 25', NULL, NULL, 1);
INSERT INTO device_object VALUES (426, 1, NULL, NULL, '', 'DI 26', NULL, NULL, 1);
INSERT INTO device_object VALUES (427, 1, NULL, NULL, '', 'DI 27', NULL, NULL, 1);
INSERT INTO device_object VALUES (428, 1, NULL, NULL, '', 'DI 28', NULL, NULL, 1);
INSERT INTO device_object VALUES (429, 1, NULL, NULL, '', 'DI 29', NULL, NULL, 1);
INSERT INTO device_object VALUES (430, 1, NULL, NULL, '', 'DI 30', NULL, NULL, 1);
INSERT INTO device_object VALUES (431, 1, NULL, NULL, '', 'DI 31', NULL, NULL, 1);
INSERT INTO device_object VALUES (432, 1, NULL, NULL, '', 'DI 32', NULL, NULL, 1);
INSERT INTO device_object VALUES (501, 1, NULL, NULL, '', 'DO 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (502, 1, NULL, NULL, '', 'DO 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (503, 1, NULL, NULL, '', 'DO 3', NULL, NULL, 1);
INSERT INTO device_object VALUES (504, 1, NULL, NULL, '', 'DO 4', NULL, NULL, 1);
INSERT INTO device_object VALUES (505, 1, NULL, NULL, '', 'DO 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (506, 1, NULL, NULL, '', 'DO 6', NULL, NULL, 1);
INSERT INTO device_object VALUES (507, 1, NULL, NULL, '', 'DO 7', NULL, NULL, 1);
INSERT INTO device_object VALUES (508, 1, NULL, NULL, '', 'DO 8', NULL, NULL, 1);
INSERT INTO device_object VALUES (601, 1, NULL, NULL, 'V', 'Voltage 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (602, 1, NULL, NULL, 'A', 'Current 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (603, 1, NULL, NULL, 'W', 'Power  1', NULL, NULL, 1);
INSERT INTO device_object VALUES (604, 1, NULL, NULL, 'WH', 'Watts/Hour 1', NULL, NULL, 1);
INSERT INTO device_object VALUES (605, 1, NULL, NULL, 'V', 'Voltage 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (606, 1, NULL, NULL, 'A', 'Current 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (607, 1, NULL, NULL, 'W', 'Power  2', NULL, NULL, 1);
INSERT INTO device_object VALUES (608, 1, NULL, NULL, 'WH', 'Watts/Hour 2', NULL, NULL, 1);
INSERT INTO device_object VALUES (609, 1, NULL, NULL, 'V', 'Voltage 3', NULL, NULL, 1);
INSERT INTO device_object VALUES (610, 1, NULL, NULL, 'A', 'Current 3', NULL, NULL, 1);
INSERT INTO device_object VALUES (611, 1, NULL, NULL, 'W', 'Power  3', NULL, NULL, 1);
INSERT INTO device_object VALUES (612, 1, NULL, NULL, 'WH', 'Watts/Hour 3', NULL, NULL, 1);
INSERT INTO device_object VALUES (613, 1, NULL, NULL, 'V', 'Voltage 4', NULL, NULL, 1);
INSERT INTO device_object VALUES (614, 1, NULL, NULL, 'A', 'Current 4', NULL, NULL, 1);
INSERT INTO device_object VALUES (615, 1, NULL, NULL, 'W', 'Power  4', NULL, NULL, 1);
INSERT INTO device_object VALUES (616, 1, NULL, NULL, 'WH', 'Watts/Hour 4', NULL, NULL, 1);
INSERT INTO device_object VALUES (617, 1, NULL, NULL, 'V', 'Voltage 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (618, 1, NULL, NULL, 'A', 'Current 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (619, 1, NULL, NULL, 'W', 'Power  5', NULL, NULL, 1);
INSERT INTO device_object VALUES (620, 1, NULL, NULL, 'WH', 'Watts/Hour 5', NULL, NULL, 1);
INSERT INTO device_object VALUES (701, 1, NULL, NULL, '', 'Communication Status', NULL, NULL, 1);
INSERT INTO device_object VALUES (702, 1, NULL, NULL, 'V', 'Battery', NULL, NULL, 1);
INSERT INTO device_object VALUES (703, 1, NULL, NULL, 'Hour', 'Running Hour', NULL, NULL, 1);
INSERT INTO device_object VALUES (704, 1, NULL, NULL, 'Hz', 'Frequency', NULL, NULL, 1);
INSERT INTO device_object VALUES (705, 1, NULL, NULL, 'V', 'Voltage L1-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (706, 1, NULL, NULL, 'V', 'Voltage L2-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (707, 1, NULL, NULL, 'V', 'Voltage L3-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (708, 1, NULL, NULL, 'A', 'Current L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (709, 1, NULL, NULL, 'A', 'Current L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (710, 1, NULL, NULL, 'A', 'Current L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (711, 1, NULL, NULL, 'Watts', 'Power L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (712, 1, NULL, NULL, 'Watts', 'Power L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (713, 1, NULL, NULL, 'Watts', 'Power L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (714, 1, NULL, NULL, 'Watts', 'Power Total', NULL, NULL, 1);
INSERT INTO device_object VALUES (715, 1, NULL, NULL, '', 'Power Factor L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (716, 1, NULL, NULL, '', 'Power Factor L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (717, 1, NULL, NULL, '', 'Power Factor L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (718, 1, NULL, NULL, '', 'Power Factor Total', NULL, NULL, 1);
INSERT INTO device_object VALUES (801, 1, NULL, NULL, '', 'Communication Status', NULL, NULL, 1);
INSERT INTO device_object VALUES (802, 1, NULL, NULL, 'V', 'Battery', NULL, NULL, 1);
INSERT INTO device_object VALUES (803, 1, NULL, NULL, 'Hour', 'Running Hour', NULL, NULL, 1);
INSERT INTO device_object VALUES (804, 1, NULL, NULL, 'Hz', 'Frequency', NULL, NULL, 1);
INSERT INTO device_object VALUES (805, 1, NULL, NULL, 'V', 'Voltage L1-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (806, 1, NULL, NULL, 'V', 'Voltage L2-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (807, 1, NULL, NULL, 'V', 'Voltage L3-N', NULL, NULL, 1);
INSERT INTO device_object VALUES (808, 1, NULL, NULL, 'A', 'Current L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (809, 1, NULL, NULL, 'A', 'Current L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (810, 1, NULL, NULL, 'A', 'Current L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (811, 1, NULL, NULL, 'Watts', 'Power L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (812, 1, NULL, NULL, 'Watts', 'Power L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (813, 1, NULL, NULL, 'Watts', 'Power L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (814, 1, NULL, NULL, 'Watts', 'Power Total', NULL, NULL, 1);
INSERT INTO device_object VALUES (815, 1, NULL, NULL, '', 'Power Factor L1', NULL, NULL, 1);
INSERT INTO device_object VALUES (816, 1, NULL, NULL, '', 'Power Factor L2', NULL, NULL, 1);
INSERT INTO device_object VALUES (817, 1, NULL, NULL, '', 'Power Factor L3', NULL, NULL, 1);
INSERT INTO device_object VALUES (818, 1, NULL, NULL, '', 'Power Factor Total', NULL, NULL, 1);
INSERT INTO device_object VALUES (901, 1, NULL, NULL, 'A', 'Battery Current', NULL, NULL, 1);
INSERT INTO device_object VALUES (902, 1, NULL, NULL, 'A', 'Load Current', NULL, NULL, 1);
INSERT INTO device_object VALUES (903, 1, NULL, NULL, 'V', 'Battery Voltage', NULL, NULL, 1);
INSERT INTO device_object VALUES (904, 1, NULL, NULL, 'V', 'Voltage Float', NULL, NULL, 1);
INSERT INTO device_object VALUES (905, 1, NULL, NULL, 'V', 'Charge Voltage', NULL, NULL, 1);
INSERT INTO device_object VALUES (906, 1, NULL, NULL, 'V', 'Under Voltage', NULL, NULL, 1);
INSERT INTO device_object VALUES (907, 1, NULL, NULL, 'V', 'Low Voltage', NULL, NULL, 1);
INSERT INTO device_object VALUES (908, 1, NULL, NULL, 'A', 'Current Limit', NULL, NULL, 1);


--
-- Name: device_object_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('device_object_id_seq', 1, false);


--
-- Data for Name: device_type; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO device_type VALUES (1, 'MCT');
INSERT INTO device_type VALUES (2, 'Rectifier');
INSERT INTO device_type VALUES (3, 'DC Meter');


--
-- Name: device_type_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('device_type_id_seq', 3, true);


--
-- Data for Name: digital_input; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: digital_input_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('digital_input_id_seq', 1, false);


--
-- Data for Name: digital_output; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: digital_output_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('digital_output_id_seq', 1, false);


--
-- Data for Name: http; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: http_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('http_id_seq', 1, false);


--
-- Data for Name: humidity; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: humidity_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('humidity_id_seq', 1, false);


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO manufacturer VALUES (1, 'STU');
INSERT INTO manufacturer VALUES (2, 'Emerson');
INSERT INTO manufacturer VALUES (3, 'Harmer Simmons');
INSERT INTO manufacturer VALUES (4, 'PowerOne');
INSERT INTO manufacturer VALUES (5, 'Eaton');
INSERT INTO manufacturer VALUES (6, 'ICON+');


--
-- Name: manufacturer_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('manufacturer_id_seq', 6, true);


--
-- Data for Name: message; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('message_id_seq', 1, false);


--
-- Data for Name: motion; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: motion_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('motion_id_seq', 1, false);


--
-- Data for Name: node; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO node VALUES (1, '192.168.1.100', NULL, NULL, 0, 'MCT_01_TRIAL', 0, 'http', 'STN1010', 161, 'public', 2, 10, 1, 'private', 1, 2, NULL, 3);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('node_id_seq', 1, true);


--
-- Data for Name: node_info; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO node_info VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


--
-- Data for Name: node_status; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: node_status_history; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: notification; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('notification_id_seq', 1, false);


--
-- Data for Name: opr_status; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO opr_status VALUES (1, 'UP');
INSERT INTO opr_status VALUES (2, 'COMM LOST');


--
-- Name: opr_status_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('opr_status_id_seq', 2, true);


--
-- Data for Name: poll; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: poll_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('poll_id_seq', 1, false);


--
-- Data for Name: poller; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: role_menu; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: role_menu_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('role_menu_id_seq', 1, false);


--
-- Data for Name: setting; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: site_config; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: site_status; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: site_status_history; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Data for Name: site_type; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: site_type_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('site_type_id_seq', 1, false);


--
-- Data for Name: subnet; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO subnet VALUES (2, 'JAKARTA SELATAN', NULL, 1, 'snmp', NULL, NULL, NULL);
INSERT INTO subnet VALUES (3, 'TRIAL', NULL, 2, 'snmp', -6.209007, 106.709361, NULL);
INSERT INTO subnet VALUES (5, 'BANDUNG', NULL, 4, 'http', NULL, NULL, NULL);
INSERT INTO subnet VALUES (6, 'BUBAT', NULL, 5, 'http', -6.249007, 106.719361, NULL);
INSERT INTO subnet VALUES (7, 'ICON', 'GANDUL', 2, 'http', -6.219007, 106.709361, NULL);
INSERT INTO subnet VALUES (1, 'DKI JAKARTA', 'Jakarta Depok Bogor Tangerang Bekasi', NULL, 'snmp', NULL, NULL, NULL);
INSERT INTO subnet VALUES (4, 'JAWA BARAT', 'Jabar', NULL, 'http', NULL, NULL, NULL);
INSERT INTO subnet VALUES (8, 'JAWA TENGAH', 'Jateng', NULL, 'snmp', NULL, NULL, NULL);
INSERT INTO subnet VALUES (9, 'JAWA TIMUR', 'Jatim', NULL, 'snmp', NULL, NULL, NULL);
INSERT INTO subnet VALUES (10, 'WILAYAH ACEH', 'PLN Wilayah Aceh', NULL, 'snmp', NULL, NULL, NULL);


--
-- Name: subnet_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('subnet_id_seq', 10, true);


--
-- Data for Name: temperature; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: temperature_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('temperature_id_seq', 1, false);


--
-- Data for Name: trap; Type: TABLE DATA; Schema: pms; Owner: sinergi
--

INSERT INTO trap VALUES (1, '192.168.1.100', 'public', '2016-11-20 07:23:56', 'hmct-Traps', '127.0.0.1', 'digital-Input-Active', NULL, 6, 1479598888347, 'di-Index', NULL, 'di-Value', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '0.0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (2, '192.168.1.100', 'public', '2016-11-20 07:23:56', 'hmct-Traps', '127.0.0.1', 'digital-Input-Active', NULL, 6, 1479598888347, 'di-Index', NULL, 'di-Value', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', NULL, '0.0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (3, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153445, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (4, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (5, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (6, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (7, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (8, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (9, '192.168.1.100', 'public', '2016-09-22 12:07:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (10, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (11, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (12, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (13, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (14, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (15, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (16, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (17, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (18, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (19, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (20, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (21, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (22, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (23, '192.168.1.100', 'public', '2016-09-22 12:08:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (24, '192.168.1.100', 'public', '2016-09-22 12:18:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (25, '192.168.1.100', 'public', '2016-09-22 12:18:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (26, '192.168.1.100', 'public', '2016-09-22 12:18:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (27, '192.168.1.100', 'public', '2016-09-22 12:18:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (28, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (29, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (30, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (31, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (32, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (33, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (34, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (35, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (36, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (37, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (38, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (39, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600153448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (40, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (41, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (42, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (43, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (44, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (45, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (46, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (47, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (48, '192.168.1.100', 'public', '2016-09-22 12:19:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (49, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (50, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (51, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (52, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (53, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (54, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (55, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (56, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (57, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (58, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (59, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (60, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (61, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (62, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (63, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (64, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (65, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', 'high-temperature-Inactive', NULL, 6, 1479600213338, 'temperature-Index', NULL, 'temperature-Value', 'temperature-Value-Threshold', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '253.0', '25.3', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (66, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', 'fuel-Low-Active', NULL, 6, 1479600213338, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '649.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (67, '192.168.1.100', 'public', '2016-09-22 12:30:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (68, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (69, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (70, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (71, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (72, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (73, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (74, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (75, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (76, '192.168.1.100', 'public', '2016-09-22 12:31:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600213339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (77, '192.168.1.100', 'public', '2016-09-22 12:41:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (78, '192.168.1.100', 'public', '2016-09-22 12:41:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (79, '192.168.1.100', 'public', '2016-09-22 12:41:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (80, '192.168.1.100', 'public', '2016-09-22 12:41:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (81, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (82, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (83, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (84, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (85, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (86, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (87, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (88, '192.168.1.100', 'public', '2016-09-22 12:42:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (89, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (90, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (91, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (92, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (93, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (94, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (95, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (96, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (97, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (98, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (99, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (100, '192.168.1.100', 'public', '2016-09-22 12:43:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (101, '192.168.1.100', 'public', '2016-09-22 12:44:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (102, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', 'fuel-Low-Inactive', NULL, 6, 1479600273274, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '429.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (103, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', 'fuel-Low-Inactive', NULL, 6, 1479600273274, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '577.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (104, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', 'high-Temperature-Active', NULL, 6, 1479600273274, 'temperature-Index', NULL, 'temperature-Value', 'temperature-Value-Threshold', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '535.0', '30.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (105, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (106, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (107, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (108, '192.168.1.100', 'public', '2016-09-22 12:54:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (109, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (110, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (111, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (112, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (113, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600273274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (114, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (115, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (116, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (117, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (118, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (119, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (120, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (121, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (122, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (123, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (124, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (125, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (126, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (127, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (128, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (129, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (130, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (131, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (132, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (133, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (134, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (135, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (136, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (137, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (138, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (139, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (140, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (141, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (142, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (143, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (144, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (145, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (146, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (147, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (148, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (149, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '127.0.0.1', NULL, NULL, 6, 1479600333264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (150, '192.168.1.100', 'public', '2016-09-22 12:38:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266002, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (151, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', 'high-Temperature-Active', NULL, 6, 1479651266003, 'temperature-Index', NULL, 'temperature-Value', 'temperature-Value-Threshold', NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '337.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (152, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651266003, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '518.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (153, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (154, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (155, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (156, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (157, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (158, '192.168.1.100', 'public', '2016-09-22 12:41:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (159, '192.168.1.100', 'public', '2016-09-22 12:42:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (160, '192.168.1.100', 'public', '2016-09-22 12:42:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (161, '192.168.1.100', 'public', '2016-09-22 12:42:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (162, '192.168.1.100', 'public', '2016-09-22 12:42:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (163, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (164, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (165, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (166, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (167, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (168, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (169, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (170, '192.168.1.100', 'public', '2016-09-22 12:43:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (171, '192.168.1.100', 'public', '2016-09-22 12:54:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (172, '192.168.1.100', 'public', '2016-09-22 12:54:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (173, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (174, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (175, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (176, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651266009, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '584.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (177, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266010, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (178, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266010, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (179, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266010, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (180, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266010, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (181, '192.168.1.100', 'public', '2016-09-22 12:55:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266011, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (182, '192.168.1.100', 'public', '2016-09-22 12:56:13', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651266011, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (183, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (184, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (185, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (186, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (187, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (188, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (189, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (190, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (191, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (192, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (193, '192.168.1.100', 'public', '2016-09-22 12:19:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295511, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (194, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295511, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (195, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295511, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (196, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (197, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (198, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (199, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (200, '192.168.1.100', 'public', '2016-09-22 12:20:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (201, '192.168.1.100', 'public', '2016-09-22 12:30:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (202, '192.168.1.100', 'public', '2016-09-22 12:30:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (203, '192.168.1.100', 'public', '2016-09-22 12:30:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (204, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (205, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Inactive', NULL, 6, 1479651295515, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '602.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (206, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651295515, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '432.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (207, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (208, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (209, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (210, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (211, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (212, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (213, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (214, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (215, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (216, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (217, '192.168.1.100', 'public', '2016-09-22 12:31:14', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651295516, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (218, '192.168.1.100', 'public', '2016-09-22 12:55:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385343, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (219, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (220, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (221, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (222, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (223, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (224, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (225, '192.168.1.100', 'public', '2016-09-22 12:56:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (226, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (227, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (228, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (229, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (230, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (231, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (232, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (233, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (234, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (235, '192.168.1.100', 'public', '2016-09-22 12:57:15', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (236, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (237, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385347, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (238, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385348, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (239, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385348, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (240, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (241, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (242, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (243, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (244, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (245, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (246, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (247, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (248, '192.168.1.100', 'public', '2016-09-22 12:08:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (249, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (250, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (251, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (252, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (253, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651385351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (254, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (255, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (256, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (257, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (258, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (259, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (260, '192.168.1.100', 'public', '2016-09-22 12:09:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (261, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (262, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (263, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (264, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (265, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (266, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', 'high-temperature-Inactive', NULL, 6, 1479651400310, 'temperature-Index', NULL, 'temperature-Value', 'temperature-Value-Threshold', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '263.0', '26.3', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (267, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651400310, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '726.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (268, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (269, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (270, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (271, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (272, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (273, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (274, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (275, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (276, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (277, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (278, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (279, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (280, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400314, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (281, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (282, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (283, '192.168.1.100', 'public', '2016-09-22 12:20:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (284, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (285, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (286, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (287, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (288, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (289, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651400315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (290, '192.168.1.100', 'public', '2016-09-22 12:21:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (291, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (292, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (293, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (294, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (295, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (296, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651415200, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '791.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (297, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (298, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (299, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (300, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (301, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (302, '192.168.1.100', 'public', '2016-09-22 12:31:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (303, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (304, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (305, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (306, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (307, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (308, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (309, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (310, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (311, '192.168.1.100', 'public', '2016-09-22 12:32:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (312, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (313, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (314, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (315, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', 'high-Temperature-Active', NULL, 6, 1479651415205, 'temperature-Index', NULL, 'temperature-Value', 'temperature-Value-Threshold', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '538.0', '30.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (316, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Inactive', NULL, 6, 1479651415205, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '370.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (317, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (318, '192.168.1.100', 'public', '2016-09-22 12:42:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (319, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (320, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (321, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (322, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (323, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (324, '192.168.1.100', 'public', '2016-09-22 12:43:16', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651415205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (325, '192.168.1.100', 'public', '2016-09-22 12:07:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445040, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (326, '192.168.1.100', 'public', '2016-09-22 12:07:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445040, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (327, '192.168.1.100', 'public', '2016-09-22 12:07:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445041, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (328, '192.168.1.100', 'public', '2016-09-22 12:07:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445041, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (329, '192.168.1.100', 'public', '2016-09-22 12:07:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (330, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (331, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (332, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (333, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (334, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (335, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (336, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (337, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (338, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (339, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (340, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (341, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (342, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445044, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (343, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (344, '192.168.1.100', 'public', '2016-09-22 12:08:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (345, '192.168.1.100', 'public', '2016-09-22 12:09:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (346, '192.168.1.100', 'public', '2016-09-22 12:09:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (347, '192.168.1.100', 'public', '2016-09-22 12:09:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (348, '192.168.1.100', 'public', '2016-09-22 12:19:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (349, '192.168.1.100', 'public', '2016-09-22 12:19:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (350, '192.168.1.100', 'public', '2016-09-22 12:19:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (351, '192.168.1.100', 'public', '2016-09-22 12:19:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (352, '192.168.1.100', 'public', '2016-09-22 12:19:17', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651445045, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '272.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (353, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Inactive', NULL, 6, 1479651445045, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '145.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (354, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (355, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (356, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (357, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (358, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (359, '192.168.1.100', 'public', '2016-09-22 12:20:17', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651445045, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (360, '192.168.1.100', 'public', '2016-09-22 12:12:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (361, '192.168.1.100', 'public', '2016-09-22 12:12:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (362, '192.168.1.100', 'public', '2016-09-22 12:12:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (363, '192.168.1.100', 'public', '2016-09-22 12:12:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (364, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (365, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (366, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (367, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (368, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (369, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (370, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (371, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (372, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (373, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (374, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (375, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (376, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (377, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (378, '192.168.1.100', 'public', '2016-09-22 12:13:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (379, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (380, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (381, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (382, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651553109, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '768.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (383, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (384, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (385, '192.168.1.100', 'public', '2016-09-22 12:24:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (386, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (387, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (388, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (389, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (390, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (391, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (392, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (393, '192.168.1.100', 'public', '2016-09-22 12:25:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (394, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (395, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (396, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (397, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (398, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651553110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (399, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (400, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (401, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (402, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (403, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (404, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (405, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565058, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (406, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (407, '192.168.1.100', 'public', '2016-09-22 12:26:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (408, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (409, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (410, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (411, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (412, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (413, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (414, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (415, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (416, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (417, '192.168.1.100', 'public', '2016-09-22 12:37:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (418, '192.168.1.100', 'public', '2016-09-22 12:38:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (419, '192.168.1.100', 'public', '2016-09-22 12:38:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (420, '192.168.1.100', 'public', '2016-09-22 12:38:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (421, '192.168.1.100', 'public', '2016-09-22 12:38:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (422, '192.168.1.100', 'public', '2016-09-22 12:38:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (423, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (424, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (425, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (426, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565065, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (427, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565065, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (428, '192.168.1.100', 'public', '2016-09-22 12:39:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565065, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (429, '192.168.1.100', 'public', '2016-09-22 12:40:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (430, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (431, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (432, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (433, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (434, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (435, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (436, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (437, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651565066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (438, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (439, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Inactive', NULL, 6, 1479651579643, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '262.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (440, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651579643, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '436.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (441, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (442, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (443, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (444, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (445, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (446, '192.168.1.100', 'public', '2016-09-22 12:50:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (447, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (448, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (449, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (450, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (451, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (452, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (453, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (454, '192.168.1.100', 'public', '2016-09-22 12:51:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (455, '192.168.1.100', 'public', '2016-09-22 12:52:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (456, '192.168.1.100', 'public', '2016-09-22 12:52:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (457, '192.168.1.100', 'public', '2016-09-22 12:52:19', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (458, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (459, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (460, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (461, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (462, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (463, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (464, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (465, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (466, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (467, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (468, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (469, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (470, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (471, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (472, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (473, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (474, '192.168.1.100', 'public', '2016-09-22 12:03:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (475, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651579644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (476, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (477, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (478, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (479, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (480, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (481, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (482, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (483, '192.168.1.100', 'public', '2016-09-22 12:04:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (484, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (485, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (486, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (487, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (488, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (489, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (490, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651594984, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '300.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (491, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (492, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (493, '192.168.1.100', 'public', '2016-09-22 12:14:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (494, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (495, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (496, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (497, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (498, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (499, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (500, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (501, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (502, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (503, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (504, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (505, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (506, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (507, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (508, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (509, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (510, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (511, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (512, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (513, '192.168.1.100', 'public', '2016-09-22 12:15:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651594986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (514, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651594986, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '441.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (515, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Inactive', NULL, 6, 1479651594986, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '133.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (516, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (517, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (518, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (519, '192.168.1.100', 'public', '2016-09-22 12:26:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (520, '192.168.1.100', 'public', '2016-09-22 12:27:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (521, '192.168.1.100', 'public', '2016-09-22 12:27:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (522, '192.168.1.100', 'public', '2016-09-22 12:27:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (523, '192.168.1.100', 'public', '2016-09-22 12:28:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (524, '192.168.1.100', 'public', '2016-09-22 12:28:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (525, '192.168.1.100', 'public', '2016-09-22 12:28:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (526, '192.168.1.100', 'public', '2016-09-22 12:28:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (527, '192.168.1.100', 'public', '2016-09-22 12:29:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (528, '192.168.1.100', 'public', '2016-09-22 12:29:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (529, '192.168.1.100', 'public', '2016-09-22 12:30:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (530, '192.168.1.100', 'public', '2016-09-22 12:30:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (531, '192.168.1.100', 'public', '2016-09-22 12:31:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (532, '192.168.1.100', 'public', '2016-09-22 12:31:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (533, '192.168.1.100', 'public', '2016-09-22 12:32:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (534, '192.168.1.100', 'public', '2016-09-22 12:32:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (535, '192.168.1.100', 'public', '2016-09-22 12:32:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (536, '192.168.1.100', 'public', '2016-09-22 12:42:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (537, '192.168.1.100', 'public', '2016-09-22 12:42:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (538, '192.168.1.100', 'public', '2016-09-22 12:42:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (539, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (540, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (541, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (542, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (543, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (544, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (545, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (546, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (547, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (548, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (549, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651610670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (550, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (551, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (552, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (553, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (554, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (555, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (556, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (557, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (558, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (559, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (560, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (561, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651625213, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '1', NULL, '429.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (562, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (563, '192.168.1.100', 'public', '2016-09-22 12:43:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (564, '192.168.1.100', 'public', '2016-09-22 12:44:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (565, '192.168.1.100', 'public', '2016-09-22 12:54:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (566, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', 'fuel-Low-Active', NULL, 6, 1479651625213, 'fuel-Index', NULL, 'fuel-Volume-Liter', 'fuel-Volume-Liter-Treshold', 'fuel-Volume-Percent', 'fuel-Volume-Percent-Treshold', NULL, NULL, NULL, NULL, '2', NULL, '619.0', '0.0', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (567, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (568, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (569, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (570, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (571, '192.168.1.100', 'public', '2016-09-22 12:55:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (572, '192.168.1.100', 'public', '2016-09-22 12:56:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (573, '192.168.1.100', 'public', '2016-09-22 12:56:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (574, '192.168.1.100', 'public', '2016-09-22 12:56:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (575, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (576, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (577, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (578, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (579, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (580, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (581, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (582, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (583, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (584, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (585, '192.168.1.100', 'public', '2016-09-22 12:57:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (586, '192.168.1.100', 'public', '2016-09-22 12:58:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (587, '192.168.1.100', 'public', '2016-09-22 12:58:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (588, '192.168.1.100', 'public', '2016-09-22 12:58:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO trap VALUES (589, '192.168.1.100', 'public', '2016-09-22 12:58:20', 'hmct-Traps', '125.163.93.5', NULL, NULL, 6, 1479651625214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);


--
-- Name: trap_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('trap_id_seq', 589, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: pms; Owner: sinergi
--



--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: sinergi
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: alarm_counter_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_counter
    ADD CONSTRAINT alarm_counter_pkey PRIMARY KEY (alarm_list_id, ddate, node_id);


--
-- Name: alarm_list_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_list
    ADD CONSTRAINT alarm_list_pkey PRIMARY KEY (id);


--
-- Name: alarm_log_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_log
    ADD CONSTRAINT alarm_log_pkey PRIMARY KEY (id);


--
-- Name: alarm_mapping_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_mapping
    ADD CONSTRAINT alarm_mapping_pkey PRIMARY KEY (id);


--
-- Name: alarm_notified_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_notified
    ADD CONSTRAINT alarm_notified_pkey PRIMARY KEY (id);


--
-- Name: alarm_severity_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_severity
    ADD CONSTRAINT alarm_severity_pkey PRIMARY KEY (id);


--
-- Name: alarm_temp_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_temp
    ADD CONSTRAINT alarm_temp_pkey PRIMARY KEY (id);


--
-- Name: analog_input_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY analog_input
    ADD CONSTRAINT analog_input_pkey PRIMARY KEY (id);


--
-- Name: app_config_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_config
    ADD CONSTRAINT app_config_pkey PRIMARY KEY (id);


--
-- Name: app_menu_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_menu
    ADD CONSTRAINT app_menu_pkey PRIMARY KEY (id);


--
-- Name: app_permission_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_permission
    ADD CONSTRAINT app_permission_pkey PRIMARY KEY (id);


--
-- Name: app_role_menu_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_role_menu
    ADD CONSTRAINT app_role_menu_pkey PRIMARY KEY (app_role_id, app_menu_id);


--
-- Name: app_role_permission_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_role_permission
    ADD CONSTRAINT app_role_permission_pkey PRIMARY KEY (app_role_id, app_permission_id);


--
-- Name: app_role_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_role
    ADD CONSTRAINT app_role_pkey PRIMARY KEY (id);


--
-- Name: app_user_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: ctvt_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY ctvt
    ADD CONSTRAINT ctvt_pkey PRIMARY KEY (node_id);


--
-- Name: customer_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: device_object_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY device_object
    ADD CONSTRAINT device_object_pkey PRIMARY KEY (id);


--
-- Name: device_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);


--
-- Name: device_type_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY device_type
    ADD CONSTRAINT device_type_pkey PRIMARY KEY (id);


--
-- Name: digital_input_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY digital_input
    ADD CONSTRAINT digital_input_pkey PRIMARY KEY (id);


--
-- Name: digital_output_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY digital_output
    ADD CONSTRAINT digital_output_pkey PRIMARY KEY (id);


--
-- Name: http_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY http
    ADD CONSTRAINT http_pkey PRIMARY KEY (id);


--
-- Name: humidity_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY humidity
    ADD CONSTRAINT humidity_pkey PRIMARY KEY (id);


--
-- Name: manufacturer_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: motion_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY motion
    ADD CONSTRAINT motion_pkey PRIMARY KEY (id);


--
-- Name: node_info_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY node_info
    ADD CONSTRAINT node_info_pkey PRIMARY KEY (node_id);


--
-- Name: node_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_status_history_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY node_status_history
    ADD CONSTRAINT node_status_history_pkey PRIMARY KEY (dtime, dtime_end, node_id, status, subnet_id);


--
-- Name: node_status_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY node_status
    ADD CONSTRAINT node_status_pkey PRIMARY KEY (dtime, node_id, status, subnet_id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: opr_status_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY opr_status
    ADD CONSTRAINT opr_status_pkey PRIMARY KEY (id);


--
-- Name: poll_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY poll
    ADD CONSTRAINT poll_pkey PRIMARY KEY (id);


--
-- Name: poller_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY poller
    ADD CONSTRAINT poller_pkey PRIMARY KEY (ip);


--
-- Name: role_menu_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY role_menu
    ADD CONSTRAINT role_menu_pkey PRIMARY KEY (id);


--
-- Name: setting_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (core_pool_size, max_pool_size, message_delete, notif_active, notif_mode, smtp_auth, smtp_cc, smtp_debug, smtp_host, smtp_password, smtp_port, smtp_protocol, smtp_tls, smtp_transport, smtp_user);


--
-- Name: site_config_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY site_config
    ADD CONSTRAINT site_config_pkey PRIMARY KEY (site_type_id, subnet_id);


--
-- Name: site_status_history_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY site_status_history
    ADD CONSTRAINT site_status_history_pkey PRIMARY KEY (dtime, dtime_end, parent_id, status, subnet_id);


--
-- Name: site_status_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY site_status
    ADD CONSTRAINT site_status_pkey PRIMARY KEY (dtime, parent_id, status, subnet_id);


--
-- Name: site_type_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY site_type
    ADD CONSTRAINT site_type_pkey PRIMARY KEY (id);


--
-- Name: subnet_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY subnet
    ADD CONSTRAINT subnet_pkey PRIMARY KEY (id);


--
-- Name: temperature_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY temperature
    ADD CONSTRAINT temperature_pkey PRIMARY KEY (id);


--
-- Name: trap_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY trap
    ADD CONSTRAINT trap_pkey PRIMARY KEY (id);


--
-- Name: uk_3k4cplvh82srueuttfkwnylq0; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_user
    ADD CONSTRAINT uk_3k4cplvh82srueuttfkwnylq0 UNIQUE (username);


--
-- Name: uk_4djc4hgujx3qe293w47942aeb; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY role_menu
    ADD CONSTRAINT uk_4djc4hgujx3qe293w47942aeb UNIQUE (role_id, menu_id);


--
-- Name: uk_8wjnfm2u65ytesm027lnoo2iq; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY poller
    ADD CONSTRAINT uk_8wjnfm2u65ytesm027lnoo2iq UNIQUE (name);


--
-- Name: uk_b4ivdh3hhwojf2b0jcmsm2m73; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY device_type
    ADD CONSTRAINT uk_b4ivdh3hhwojf2b0jcmsm2m73 UNIQUE (name);


--
-- Name: uk_cffa9qrdaswsvbnu07n9b6wit; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_permission
    ADD CONSTRAINT uk_cffa9qrdaswsvbnu07n9b6wit UNIQUE (value);


--
-- Name: uk_crkjmjk1oj8gb6j6t5kt7gcxm; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT uk_crkjmjk1oj8gb6j6t5kt7gcxm UNIQUE (name);


--
-- Name: uk_dyf5hu50ddvjoy0pfpleevwfl; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_role
    ADD CONSTRAINT uk_dyf5hu50ddvjoy0pfpleevwfl UNIQUE (name);


--
-- Name: uk_fvhf6l0xkf8hnay7lvwimnwu1; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT uk_fvhf6l0xkf8hnay7lvwimnwu1 UNIQUE (name);


--
-- Name: uk_gt8rtbpsq6rpo6nnv25p665f2; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT uk_gt8rtbpsq6rpo6nnv25p665f2 UNIQUE (name);


--
-- Name: uk_mvopeswxpu6exl6f2e9wv6ckh; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY alarm_severity
    ADD CONSTRAINT uk_mvopeswxpu6exl6f2e9wv6ckh UNIQUE (name);


--
-- Name: uk_oesoxj95nuiic4anb0i5fh9b1; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY device
    ADD CONSTRAINT uk_oesoxj95nuiic4anb0i5fh9b1 UNIQUE (name);


--
-- Name: uk_ofjlurjc70f4lav6ydu62i7bu; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY opr_status
    ADD CONSTRAINT uk_ofjlurjc70f4lav6ydu62i7bu UNIQUE (name);


--
-- Name: uk_r43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT uk_r43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- Name: uk_s3382ob0hdy8n4kbe2xvjyn23; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT uk_s3382ob0hdy8n4kbe2xvjyn23 UNIQUE (sn);


--
-- Name: uk_tembswd64882tsr9n54ajtjcj; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY app_config
    ADD CONSTRAINT uk_tembswd64882tsr9n54ajtjcj UNIQUE (label);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: pms; Owner: sinergi; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: node_sn_idx; Type: INDEX; Schema: pms; Owner: sinergi; Tablespace: 
--

CREATE INDEX node_sn_idx ON node USING btree (sn);


--
-- Name: ctvt_node_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY ctvt
    ADD CONSTRAINT ctvt_node_id_fkey FOREIGN KEY (node_id) REFERENCES node(id) ON DELETE CASCADE;


--
-- Name: fk_1xkaejk5akqp8fs6sq18gk99c; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY humidity
    ADD CONSTRAINT fk_1xkaejk5akqp8fs6sq18gk99c FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_2v0sh7a14nlaa0gvts77b5461; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node
    ADD CONSTRAINT fk_2v0sh7a14nlaa0gvts77b5461 FOREIGN KEY (poller_agent) REFERENCES poller(ip);


--
-- Name: fk_38qc52dcw39vu9drdjrd8v3yu; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_temp
    ADD CONSTRAINT fk_38qc52dcw39vu9drdjrd8v3yu FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_4qf7cecyvy0q51c1ecifyfd65; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_log
    ADD CONSTRAINT fk_4qf7cecyvy0q51c1ecifyfd65 FOREIGN KEY (device_type_id) REFERENCES device_type(id);


--
-- Name: fk_50vsp12grw653pkuq0o1oaqjt; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_log
    ADD CONSTRAINT fk_50vsp12grw653pkuq0o1oaqjt FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_6xl4jvqdalelcfj2w297pvbe4; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device
    ADD CONSTRAINT fk_6xl4jvqdalelcfj2w297pvbe4 FOREIGN KEY (device_type_id) REFERENCES device_type(id);


--
-- Name: fk_7g750gnqaa7yn2iu28nq4f8f7; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_output
    ADD CONSTRAINT fk_7g750gnqaa7yn2iu28nq4f8f7 FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_7rxvs31cvfu9c37qxnag4ris8; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY role_menu
    ADD CONSTRAINT fk_7rxvs31cvfu9c37qxnag4ris8 FOREIGN KEY (menu_id) REFERENCES app_menu(id);


--
-- Name: fk_8wu5owh0qyheyn57m5o7id7vg; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY humidity
    ADD CONSTRAINT fk_8wu5owh0qyheyn57m5o7id7vg FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_9v5235g6a1tnyockx7p7i22p9; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_log
    ADD CONSTRAINT fk_9v5235g6a1tnyockx7p7i22p9 FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_a0vlp1909mhr2wiwmsdf7a7b1; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_temp
    ADD CONSTRAINT fk_a0vlp1909mhr2wiwmsdf7a7b1 FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_a3dh8d99epf1cp14rkqkyrhq; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_mapping
    ADD CONSTRAINT fk_a3dh8d99epf1cp14rkqkyrhq FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_a5jxkc0rbcuk921wvms7r55sq; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_output
    ADD CONSTRAINT fk_a5jxkc0rbcuk921wvms7r55sq FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_aabvldlfaafvnmj9c1qnqvcyb; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node_status_history
    ADD CONSTRAINT fk_aabvldlfaafvnmj9c1qnqvcyb FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_asfigmv5d73eod9t27nkhcsnt; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_counter
    ADD CONSTRAINT fk_asfigmv5d73eod9t27nkhcsnt FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_bb7w2jmos5du4qciexmwp8ogb; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_user
    ADD CONSTRAINT fk_bb7w2jmos5du4qciexmwp8ogb FOREIGN KEY (app_role_id) REFERENCES app_role(id);


--
-- Name: fk_bia09uh3vtsxm4k300twuwcim; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY analog_input
    ADD CONSTRAINT fk_bia09uh3vtsxm4k300twuwcim FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_bn15pjnpfncl3ah089wu3c60b; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY analog_input
    ADD CONSTRAINT fk_bn15pjnpfncl3ah089wu3c60b FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_cni3h9rjh18s28v3dtukq9087; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_output
    ADD CONSTRAINT fk_cni3h9rjh18s28v3dtukq9087 FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_d2k0s8lnaf7bhiw6rrs3xnlp8; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_list
    ADD CONSTRAINT fk_d2k0s8lnaf7bhiw6rrs3xnlp8 FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_d6h2mrrt934wd5e0gwrivomc; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_d6h2mrrt934wd5e0gwrivomc FOREIGN KEY (notification_id) REFERENCES notification(id);


--
-- Name: fk_dbp5neg8uuhskrgjf76yh3l3q; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_role_permission
    ADD CONSTRAINT fk_dbp5neg8uuhskrgjf76yh3l3q FOREIGN KEY (app_role_id) REFERENCES app_role(id);


--
-- Name: fk_e2r502f48vjugqs79j28uexqm; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY motion
    ADD CONSTRAINT fk_e2r502f48vjugqs79j28uexqm FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_e8cxnvwofrd69q10v36v9agva; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY site_config
    ADD CONSTRAINT fk_e8cxnvwofrd69q10v36v9agva FOREIGN KEY (site_type_id) REFERENCES site_type(id);


--
-- Name: fk_eey93iujafd7cjox21lliqo35; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_notified
    ADD CONSTRAINT fk_eey93iujafd7cjox21lliqo35 FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_erj5xjh4ekm7qj1ot0fpf3k73; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node_status
    ADD CONSTRAINT fk_erj5xjh4ekm7qj1ot0fpf3k73 FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_g7i5sbmt01or8qvulf56ak03c; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_role_menu
    ADD CONSTRAINT fk_g7i5sbmt01or8qvulf56ak03c FOREIGN KEY (app_menu_id) REFERENCES app_menu(id);


--
-- Name: fk_hlv7udn0nv6a52c7uq786infq; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_temp
    ADD CONSTRAINT fk_hlv7udn0nv6a52c7uq786infq FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_ip28302jrlbuqqfmm4o3i24o2; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_role_menu
    ADD CONSTRAINT fk_ip28302jrlbuqqfmm4o3i24o2 FOREIGN KEY (app_role_id) REFERENCES app_role(id);


--
-- Name: fk_jd7id7gv42krocdg720kjan82; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY analog_input
    ADD CONSTRAINT fk_jd7id7gv42krocdg720kjan82 FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_jx61fywbumqwqgn2i7okrisev; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_role_permission
    ADD CONSTRAINT fk_jx61fywbumqwqgn2i7okrisev FOREIGN KEY (app_permission_id) REFERENCES app_permission(id);


--
-- Name: fk_k0ksejy8u3pwnyycmdtslmwii; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node
    ADD CONSTRAINT fk_k0ksejy8u3pwnyycmdtslmwii FOREIGN KEY (opr_status_id) REFERENCES opr_status(id);


--
-- Name: fk_krvotbtiqhudlkamvlpaqus0t; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_krvotbtiqhudlkamvlpaqus0t FOREIGN KEY (role_id) REFERENCES app_role(id);


--
-- Name: fk_lce101u1gvcrfc90xk1bskuun; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device
    ADD CONSTRAINT fk_lce101u1gvcrfc90xk1bskuun FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(id);


--
-- Name: fk_lfo3vyqmx1mfk2j6s17mwkd4v; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY temperature
    ADD CONSTRAINT fk_lfo3vyqmx1mfk2j6s17mwkd4v FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_lh9ffv1bvo3qhcnp96uuu0gyg; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY humidity
    ADD CONSTRAINT fk_lh9ffv1bvo3qhcnp96uuu0gyg FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_mc66e0al0bdsgodyw9iolyxm2; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_input
    ADD CONSTRAINT fk_mc66e0al0bdsgodyw9iolyxm2 FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_mg802dhparv7y3v0jyp3qstib; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY temperature
    ADD CONSTRAINT fk_mg802dhparv7y3v0jyp3qstib FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_myirkf1qfnnqasvn595xia2gn; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_log
    ADD CONSTRAINT fk_myirkf1qfnnqasvn595xia2gn FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_nm7yxhd003fl8iv0qwkihayv1; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_counter
    ADD CONSTRAINT fk_nm7yxhd003fl8iv0qwkihayv1 FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_node_subnet; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node
    ADD CONSTRAINT fk_node_subnet FOREIGN KEY (subnet_id) REFERENCES subnet(id) ON DELETE CASCADE;


--
-- Name: fk_oaun7bmukwv03apse9hnif8cj; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY app_menu
    ADD CONSTRAINT fk_oaun7bmukwv03apse9hnif8cj FOREIGN KEY (parent_id) REFERENCES app_menu(id);


--
-- Name: fk_puu1ui37vc6lddr2hqp223c39; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_mapping
    ADD CONSTRAINT fk_puu1ui37vc6lddr2hqp223c39 FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_qlp5yveggm91g6jpybm9wtfdp; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY trap
    ADD CONSTRAINT fk_qlp5yveggm91g6jpybm9wtfdp FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: fk_qoy8o7h2iastrf75njyigdeqt; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY device_object
    ADD CONSTRAINT fk_qoy8o7h2iastrf75njyigdeqt FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_r6o1lqlask5jahtkqv3w8sbeh; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY role_menu
    ADD CONSTRAINT fk_r6o1lqlask5jahtkqv3w8sbeh FOREIGN KEY (role_id) REFERENCES app_role(id);


--
-- Name: fk_rlfvasg7lsoku9f0soowti53u; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_output
    ADD CONSTRAINT fk_rlfvasg7lsoku9f0soowti53u FOREIGN KEY (digital_input_id) REFERENCES digital_input(id);


--
-- Name: fk_rs8tv5rxkj7x1ene0k2dcfu6k; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_input
    ADD CONSTRAINT fk_rs8tv5rxkj7x1ene0k2dcfu6k FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: fk_s4a5e9b7qju6crrrq1e6iiy; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_temp
    ADD CONSTRAINT fk_s4a5e9b7qju6crrrq1e6iiy FOREIGN KEY (device_type_id) REFERENCES device_type(id);


--
-- Name: fk_s98byquj1oo9ff3av6l5e8ynn; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node
    ADD CONSTRAINT fk_s98byquj1oo9ff3av6l5e8ynn FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: fk_sdghotn6as6hrboimbd5xxdon; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY digital_input
    ADD CONSTRAINT fk_sdghotn6as6hrboimbd5xxdon FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_subnet_alarm_temp_id; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY subnet
    ADD CONSTRAINT fk_subnet_alarm_temp_id FOREIGN KEY (alarm_temp_id) REFERENCES alarm_temp(id) ON DELETE SET NULL;


--
-- Name: fk_t2wrs1gypwjayp94n1fim4f16; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY alarm_list
    ADD CONSTRAINT fk_t2wrs1gypwjayp94n1fim4f16 FOREIGN KEY (alarm_severity_id) REFERENCES alarm_severity(id);


--
-- Name: fk_wgak0efb2m8yswmnnjvtpl1y; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY temperature
    ADD CONSTRAINT fk_wgak0efb2m8yswmnnjvtpl1y FOREIGN KEY (alarm_list_id) REFERENCES alarm_list(id);


--
-- Name: node_info_node_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: sinergi
--

ALTER TABLE ONLY node_info
    ADD CONSTRAINT node_info_node_id_fkey FOREIGN KEY (node_id) REFERENCES node(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

