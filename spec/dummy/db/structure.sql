--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: do_dummy(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION do_dummy() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
              begin
                return null;
              end;
             $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dummy; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE dummy (
    id integer NOT NULL
);


--
-- Name: dummy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dummy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dummy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dummy_id_seq OWNED BY dummy.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dummy ALTER COLUMN id SET DEFAULT nextval('dummy_id_seq'::regclass);


--
-- Name: dummy_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY dummy
    ADD CONSTRAINT dummy_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140724185749');

INSERT INTO schema_migrations (version) VALUES ('20140724192457');
