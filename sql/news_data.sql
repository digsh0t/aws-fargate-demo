--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 15.2

-- Started on 2023-07-06 20:51:14 +07

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
-- TOC entry 4269 (class 0 OID 16406)
-- Dependencies: 210
-- Data for Name: news_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.news_table (id, headline, description, author) VALUES (1, 'Today''s news, Big Ben is gone', 'Where the hell could it goes? I don''t really know', 'Tre Li');
INSERT INTO public.news_table (id, headline, description, author) VALUES (2, 'HOT NEWS OF THE DAY', 'Did you know that Manatee is also called a Sea Pig?', 'No One');


--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 209
-- Name: news_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_table_id_seq', 2, true);


-- Completed on 2023-07-06 20:51:43 +07

--
-- PostgreSQL database dump complete
--

