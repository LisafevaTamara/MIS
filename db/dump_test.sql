--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_sessions (
    session_id integer NOT NULL,
    user_id integer,
    active boolean
);


ALTER TABLE public.active_sessions OWNER TO postgres;

--
-- Name: active_sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_sessions_session_id_seq OWNER TO postgres;

--
-- Name: active_sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_sessions_session_id_seq OWNED BY public.active_sessions.session_id;


--
-- Name: checking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checking (
    fio text,
    date date,
    address text,
    doc_fio text,
    symptoms text,
    drug_title text,
    diagnosis text
);


ALTER TABLE public.checking OWNER TO postgres;

--
-- Name: drug_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drug_info (
    title text,
    active_substances text,
    effect text,
    method_of_taking text,
    side_effects text
);


ALTER TABLE public.drug_info OWNER TO postgres;

--
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    id integer NOT NULL,
    fio text,
    login text,
    password text,
    role text DEFAULT 'user'::text
);


ALTER TABLE public.log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: my_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.my_table (
    fio text,
    date date,
    address text,
    doc_fio text,
    symptoms text,
    drug_title text,
    diagnosis text
);


ALTER TABLE public.my_table OWNER TO postgres;

--
-- Name: patients_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients_info (
    fio text,
    gender text,
    date_birth date,
    address text
);


ALTER TABLE public.patients_info OWNER TO postgres;

--
-- Name: testing_db; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testing_db (
    session_id integer NOT NULL,
    user_id integer,
    active boolean
);


ALTER TABLE public.testing_db OWNER TO postgres;

--
-- Name: active_sessions session_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_sessions ALTER COLUMN session_id SET DEFAULT nextval('public.active_sessions_session_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Data for Name: active_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_sessions (session_id, user_id, active) FROM stdin;
\.


--
-- Data for Name: checking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checking (fio, date, address, doc_fio, symptoms, drug_title, diagnosis) FROM stdin;
\.


--
-- Data for Name: drug_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drug_info (title, active_substances, effect, method_of_taking, side_effects) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (id, fio, login, password, role) FROM stdin;
1	Lisafeva Tamara Andreevna	tamara	$2b$12$aqOYV8YdsHOFe2IktC7cJu30q/mxKWEe4RQi/61Khq2KwnVIabocC	admin
3	korolev maxim dmitrievich	maxim	$2b$12$HMwGBjWZqU2MhivG51t.0u4NEWJByYRVp75LtcOSBnmAwVnJa/IsO	user
12	test1 test2 test3	test	$2b$12$JtPsg/LJ3PEdNwPPMY99e.T8OP.uyMx3vQE3gUMiMCy3o/GOpD.AW	user
45	kiril kiril kiril	kiril	$2b$12$r4Txgo/PYDPKc2S2VxD3f.3qHHV.T1Q0x3mB8TiGtIItJEss7XVF6	user
46	pink flamingo hunter	pinflamhunt	$2b$12$FGoLol/zrXXz7FTjH1UtNeCrfFUwpkXuxvFhbFYwVDJKUnO7OI9bW	user
\.


--
-- Data for Name: my_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.my_table (fio, date, address, doc_fio, symptoms, drug_title, diagnosis) FROM stdin;
\.


--
-- Data for Name: patients_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients_info (fio, gender, date_birth, address) FROM stdin;
\.


--
-- Data for Name: testing_db; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testing_db (session_id, user_id, active) FROM stdin;
\.


--
-- Name: active_sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_sessions_session_id_seq', 2, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_id_seq', 46, true);


--
-- Name: active_sessions active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: log log_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_login_key UNIQUE (login);


--
-- Name: log log_password_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_password_key UNIQUE (password);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: active_sessions active_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_sessions
    ADD CONSTRAINT active_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.log(id);


--
-- PostgreSQL database dump complete
--

