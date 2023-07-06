--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 15.2

-- Started on 2023-07-06 20:49:47 +07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16406)
-- Name: news_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_table (
    id integer NOT NULL,
    headline text NOT NULL,
    description text NOT NULL,
    author text NOT NULL
);


ALTER TABLE public.news_table OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16405)
-- Name: news_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_table_id_seq OWNER TO postgres;

--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 209
-- Name: news_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_table_id_seq OWNED BY public.news_table.id;


--
-- TOC entry 4127 (class 2604 OID 16409)
-- Name: news_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_table ALTER COLUMN id SET DEFAULT nextval('public.news_table_id_seq'::regclass);


--
-- TOC entry 4129 (class 2606 OID 16413)
-- Name: news_table news_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_table
    ADD CONSTRAINT news_table_pkey PRIMARY KEY (id);


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-07-06 20:50:14 +07

--
-- PostgreSQL database dump complete
--

