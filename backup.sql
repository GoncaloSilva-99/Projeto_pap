--
-- PostgreSQL database dump
--

\restrict zx2l2gbE7OrcjRYNHfxcDYlhySBBmhS5KtSL3YN0Ff5CKF3Zp4dY96QFzJ7SGEN

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: admin_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.admin_profiles OWNER TO postgres;

--
-- Name: admin_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_profiles_id_seq OWNER TO postgres;

--
-- Name: admin_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_profiles_id_seq OWNED BY public.admin_profiles.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: board_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.board_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    bio text,
    birth_date date,
    club_profile_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    contact integer
);


ALTER TABLE public.board_profiles OWNER TO postgres;

--
-- Name: board_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.board_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.board_profiles_id_seq OWNER TO postgres;

--
-- Name: board_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.board_profiles_id_seq OWNED BY public.board_profiles.id;


--
-- Name: club_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    status boolean,
    approved_by integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    bio text,
    foundation_date date,
    contact integer
);


ALTER TABLE public.club_profiles OWNER TO postgres;

--
-- Name: club_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.club_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.club_profiles_id_seq OWNER TO postgres;

--
-- Name: club_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.club_profiles_id_seq OWNED BY public.club_profiles.id;


--
-- Name: club_sports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club_sports (
    id bigint NOT NULL,
    club_profile_id bigint NOT NULL,
    sport_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.club_sports OWNER TO postgres;

--
-- Name: club_sports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.club_sports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.club_sports_id_seq OWNER TO postgres;

--
-- Name: club_sports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.club_sports_id_seq OWNED BY public.club_sports.id;


--
-- Name: club_teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club_teams (
    id bigint NOT NULL,
    club_profile_id bigint NOT NULL,
    name character varying,
    sport_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.club_teams OWNER TO postgres;

--
-- Name: club_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.club_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.club_teams_id_seq OWNER TO postgres;

--
-- Name: club_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.club_teams_id_seq OWNED BY public.club_teams.id;


--
-- Name: club_training_centers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club_training_centers (
    id bigint NOT NULL,
    club_profile_id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sport_id bigint NOT NULL
);


ALTER TABLE public.club_training_centers OWNER TO postgres;

--
-- Name: club_training_centers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.club_training_centers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.club_training_centers_id_seq OWNER TO postgres;

--
-- Name: club_training_centers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.club_training_centers_id_seq OWNED BY public.club_training_centers.id;


--
-- Name: coach_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    birth_date date,
    club_profile_id bigint,
    coach_type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sport character varying,
    bio character varying,
    contact integer
);


ALTER TABLE public.coach_profiles OWNER TO postgres;

--
-- Name: coach_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coach_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coach_profiles_id_seq OWNER TO postgres;

--
-- Name: coach_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coach_profiles_id_seq OWNED BY public.coach_profiles.id;


--
-- Name: coach_teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach_teams (
    id bigint NOT NULL,
    coach_profile_id bigint NOT NULL,
    club_team_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.coach_teams OWNER TO postgres;

--
-- Name: coach_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coach_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coach_teams_id_seq OWNER TO postgres;

--
-- Name: coach_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coach_teams_id_seq OWNED BY public.coach_teams.id;


--
-- Name: player_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    birth_date date,
    "position" character varying,
    bio text,
    contact integer,
    parents_contact integer,
    club_profile_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sport character varying,
    secondary_position character varying,
    dominant_foot_or_hand character varying
);


ALTER TABLE public.player_profiles OWNER TO postgres;

--
-- Name: player_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.player_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_profiles_id_seq OWNER TO postgres;

--
-- Name: player_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.player_profiles_id_seq OWNED BY public.player_profiles.id;


--
-- Name: player_teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_teams (
    id bigint NOT NULL,
    player_profile_id bigint NOT NULL,
    club_team_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.player_teams OWNER TO postgres;

--
-- Name: player_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.player_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_teams_id_seq OWNER TO postgres;

--
-- Name: player_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.player_teams_id_seq OWNED BY public.player_teams.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: sports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sports (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sports OWNER TO postgres;

--
-- Name: sports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sports_id_seq OWNER TO postgres;

--
-- Name: sports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sports_id_seq OWNED BY public.sports.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying,
    bio text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_profiles_id_seq OWNER TO postgres;

--
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unconfirmed_email character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: admin_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_profiles ALTER COLUMN id SET DEFAULT nextval('public.admin_profiles_id_seq'::regclass);


--
-- Name: board_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_profiles ALTER COLUMN id SET DEFAULT nextval('public.board_profiles_id_seq'::regclass);


--
-- Name: club_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_profiles ALTER COLUMN id SET DEFAULT nextval('public.club_profiles_id_seq'::regclass);


--
-- Name: club_sports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_sports ALTER COLUMN id SET DEFAULT nextval('public.club_sports_id_seq'::regclass);


--
-- Name: club_teams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_teams ALTER COLUMN id SET DEFAULT nextval('public.club_teams_id_seq'::regclass);


--
-- Name: club_training_centers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_training_centers ALTER COLUMN id SET DEFAULT nextval('public.club_training_centers_id_seq'::regclass);


--
-- Name: coach_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_profiles ALTER COLUMN id SET DEFAULT nextval('public.coach_profiles_id_seq'::regclass);


--
-- Name: coach_teams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_teams ALTER COLUMN id SET DEFAULT nextval('public.coach_teams_id_seq'::regclass);


--
-- Name: player_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_profiles ALTER COLUMN id SET DEFAULT nextval('public.player_profiles_id_seq'::regclass);


--
-- Name: player_teams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_teams ALTER COLUMN id SET DEFAULT nextval('public.player_teams_id_seq'::regclass);


--
-- Name: sports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports ALTER COLUMN id SET DEFAULT nextval('public.sports_id_seq'::regclass);


--
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	profile_picture	ClubProfile	1	1	2025-12-03 14:34:06.958019
2	verification_document	ClubProfile	1	2	2025-12-03 14:34:06.978255
3	ct_picture	ClubTrainingCenter	2	3	2026-01-07 14:56:39.702166
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
2	5jukoxr6xvzvpbwzrpxtmt20fxbv	Módulo 4 - Pag 165-185.pdf	application/pdf	{"identified":true,"analyzed":true}	local	2346173	4IAm8aiNsaDaEzsJPiOMzg==	2025-12-03 14:34:06.973392
1	zb636d2thnh2i6pgnek3khq3flzy	ScoreImageHandler.png	image/png	{"identified":true,"analyzed":true}	local	49527	ClmX68F/N53wDpDX9FKcdg==	2025-12-03 14:34:06.949524
3	oen60mbdw3o8cypzv2nmgrpw9wfp	Captura de ecrã 2025-10-13 154944.png	image/png	{"identified":true,"analyzed":true}	local	60930	zHf+f0iwd3ML1W/yeUTQxg==	2026-01-07 14:56:39.695412
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: admin_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_profiles (id, user_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-10-15 14:15:32.729542	2025-10-15 14:15:32.729548
schema_sha1	81e01fdf6f11ef463ea14bf50ea02946af9c8143	2025-10-15 14:15:32.739877	2025-10-15 14:15:32.739881
\.


--
-- Data for Name: board_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.board_profiles (id, user_id, name, bio, birth_date, club_profile_id, created_at, updated_at, contact) FROM stdin;
\.


--
-- Data for Name: club_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.club_profiles (id, user_id, name, status, approved_by, created_at, updated_at, bio, foundation_date, contact) FROM stdin;
1	2	Ermesinde S.C 1936	\N	\N	2025-12-03 14:34:06.897031	2025-12-03 14:34:07.308087	aaaaaaaaaaaaaaaaaa	2025-08-08	964666237
\.


--
-- Data for Name: club_sports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.club_sports (id, club_profile_id, sport_id, created_at, updated_at) FROM stdin;
1	1	2	2025-12-15 14:16:19.136228	2025-12-15 14:16:19.136228
2	1	3	2025-12-15 14:16:31.80667	2025-12-15 14:16:31.80667
\.


--
-- Data for Name: club_teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.club_teams (id, club_profile_id, name, sport_id, created_at, updated_at) FROM stdin;
1	1	Sub 17 "A"	2	2025-12-15 14:33:12.992336	2025-12-15 14:33:12.992336
\.


--
-- Data for Name: club_training_centers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.club_training_centers (id, club_profile_id, name, created_at, updated_at, sport_id) FROM stdin;
2	1	sfafs	2026-01-07 14:56:39.656505	2026-01-07 14:56:39.833049	2
\.


--
-- Data for Name: coach_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coach_profiles (id, user_id, name, birth_date, club_profile_id, coach_type, created_at, updated_at, sport, bio, contact) FROM stdin;
\.


--
-- Data for Name: coach_teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coach_teams (id, coach_profile_id, club_team_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: player_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_profiles (id, user_id, name, birth_date, "position", bio, contact, parents_contact, club_profile_id, created_at, updated_at, sport, secondary_position, dominant_foot_or_hand) FROM stdin;
1	1	teste	2021-11-02	Guarda-Redes	bio	111111111	222222222	\N	2025-11-03 16:03:56.459438	2025-11-03 16:03:56.459438	Futebol	Guarda-Redes	Direito
2	3	Raphinha 	2008-09-15	Extremo Direito	Sou o Raphinha, Olá	964999623	\N	\N	2025-12-15 15:32:27.869347	2025-12-15 15:32:27.869347	Futebol	Médio Ofensivo	Esquerdo
\.


--
-- Data for Name: player_teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_teams (id, player_profile_id, club_team_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250827191241
20250827190438
20250827185509
20250827185232
20250827185144
20250827185046
20250827185007
20250827184544
20250826194923
20251026194338
20251029162309
20251101215053
20251110142107
20251110144831
20251112151156
20251121134628
20251121134808
20251121134928
20251121135042
20251129194302
20251218142955
20260102212407
20260102212750
\.


--
-- Data for Name: sports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sports (id, name, created_at, updated_at) FROM stdin;
1	teste	2025-12-15 14:13:57.830456	2025-12-15 14:13:57.830456
2	Football	2025-12-15 14:14:15.087638	2025-12-15 14:14:15.087638
3	Handball	2025-12-15 14:14:24.252009	2025-12-15 14:14:24.252009
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profiles (id, user_id, name, bio, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, created_at, updated_at, role) FROM stdin;
1	teste1@gmail.com	$2a$12$QeQOXl5saQZ02z6AaxudMOfnwR6HNy.GVmDmXXe3jrnvjXks3xt8C	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-03 16:03:56.444755	2025-11-03 16:03:56.444755	Player
2	teste2@gmail.com	$2a$12$abhHW5ebhsMJX164XTH2p.SONd1jfH0f/yoq4RJc23zXayZc5YTOy	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-03 14:34:06.88198	2025-12-03 14:34:06.88198	Club
3	testejogadorclube@gmail.com	$2a$12$iWpmiQHi37ASdhE4ao7SAOV18fRLLQKykRYY.mGGp3n3DMaQF.C1q	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-15 15:32:27.851187	2025-12-15 15:32:27.851187	Player
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 3, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 3, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: admin_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_profiles_id_seq', 1, false);


--
-- Name: board_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_profiles_id_seq', 1, false);


--
-- Name: club_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.club_profiles_id_seq', 1, true);


--
-- Name: club_sports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.club_sports_id_seq', 2, true);


--
-- Name: club_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.club_teams_id_seq', 1, true);


--
-- Name: club_training_centers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.club_training_centers_id_seq', 2, true);


--
-- Name: coach_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coach_profiles_id_seq', 1, false);


--
-- Name: coach_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coach_teams_id_seq', 1, false);


--
-- Name: player_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.player_profiles_id_seq', 2, true);


--
-- Name: player_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.player_teams_id_seq', 1, false);


--
-- Name: sports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sports_id_seq', 3, true);


--
-- Name: user_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_profiles_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: admin_profiles admin_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_profiles
    ADD CONSTRAINT admin_profiles_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: board_profiles board_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_profiles
    ADD CONSTRAINT board_profiles_pkey PRIMARY KEY (id);


--
-- Name: club_profiles club_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_profiles
    ADD CONSTRAINT club_profiles_pkey PRIMARY KEY (id);


--
-- Name: club_sports club_sports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_sports
    ADD CONSTRAINT club_sports_pkey PRIMARY KEY (id);


--
-- Name: club_teams club_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_teams
    ADD CONSTRAINT club_teams_pkey PRIMARY KEY (id);


--
-- Name: club_training_centers club_training_centers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_training_centers
    ADD CONSTRAINT club_training_centers_pkey PRIMARY KEY (id);


--
-- Name: coach_profiles coach_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_profiles
    ADD CONSTRAINT coach_profiles_pkey PRIMARY KEY (id);


--
-- Name: coach_teams coach_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_teams
    ADD CONSTRAINT coach_teams_pkey PRIMARY KEY (id);


--
-- Name: player_profiles player_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_profiles
    ADD CONSTRAINT player_profiles_pkey PRIMARY KEY (id);


--
-- Name: player_teams player_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_teams
    ADD CONSTRAINT player_teams_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sports sports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports
    ADD CONSTRAINT sports_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_admin_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_admin_profiles_on_user_id ON public.admin_profiles USING btree (user_id);


--
-- Name: index_board_profiles_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_board_profiles_on_club_profile_id ON public.board_profiles USING btree (club_profile_id);


--
-- Name: index_board_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_board_profiles_on_user_id ON public.board_profiles USING btree (user_id);


--
-- Name: index_club_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_profiles_on_user_id ON public.club_profiles USING btree (user_id);


--
-- Name: index_club_sports_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_sports_on_club_profile_id ON public.club_sports USING btree (club_profile_id);


--
-- Name: index_club_sports_on_sport_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_sports_on_sport_id ON public.club_sports USING btree (sport_id);


--
-- Name: index_club_teams_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_teams_on_club_profile_id ON public.club_teams USING btree (club_profile_id);


--
-- Name: index_club_teams_on_sport_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_teams_on_sport_id ON public.club_teams USING btree (sport_id);


--
-- Name: index_club_training_centers_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_training_centers_on_club_profile_id ON public.club_training_centers USING btree (club_profile_id);


--
-- Name: index_club_training_centers_on_sport_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_club_training_centers_on_sport_id ON public.club_training_centers USING btree (sport_id);


--
-- Name: index_coach_profiles_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_coach_profiles_on_club_profile_id ON public.coach_profiles USING btree (club_profile_id);


--
-- Name: index_coach_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_coach_profiles_on_user_id ON public.coach_profiles USING btree (user_id);


--
-- Name: index_coach_teams_on_club_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_coach_teams_on_club_team_id ON public.coach_teams USING btree (club_team_id);


--
-- Name: index_coach_teams_on_coach_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_coach_teams_on_coach_profile_id ON public.coach_teams USING btree (coach_profile_id);


--
-- Name: index_player_profiles_on_club_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_player_profiles_on_club_profile_id ON public.player_profiles USING btree (club_profile_id);


--
-- Name: index_player_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_player_profiles_on_user_id ON public.player_profiles USING btree (user_id);


--
-- Name: index_player_teams_on_club_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_player_teams_on_club_team_id ON public.player_teams USING btree (club_team_id);


--
-- Name: index_player_teams_on_player_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_player_teams_on_player_profile_id ON public.player_teams USING btree (player_profile_id);


--
-- Name: index_user_profiles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_profiles_on_user_id ON public.user_profiles USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: board_profiles fk_rails_0b00775ba0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_profiles
    ADD CONSTRAINT fk_rails_0b00775ba0 FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: club_training_centers fk_rails_142e0a63fd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_training_centers
    ADD CONSTRAINT fk_rails_142e0a63fd FOREIGN KEY (sport_id) REFERENCES public.sports(id);


--
-- Name: club_sports fk_rails_3425c497e0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_sports
    ADD CONSTRAINT fk_rails_3425c497e0 FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: coach_profiles fk_rails_53448cb5d3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_profiles
    ADD CONSTRAINT fk_rails_53448cb5d3 FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: player_teams fk_rails_56f7f450c9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_teams
    ADD CONSTRAINT fk_rails_56f7f450c9 FOREIGN KEY (player_profile_id) REFERENCES public.player_profiles(id);


--
-- Name: club_sports fk_rails_66bffef53b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_sports
    ADD CONSTRAINT fk_rails_66bffef53b FOREIGN KEY (sport_id) REFERENCES public.sports(id);


--
-- Name: user_profiles fk_rails_87a6352e58; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT fk_rails_87a6352e58 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: player_teams fk_rails_8b81f36d8d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_teams
    ADD CONSTRAINT fk_rails_8b81f36d8d FOREIGN KEY (club_team_id) REFERENCES public.club_teams(id);


--
-- Name: coach_profiles fk_rails_8dec7c825b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_profiles
    ADD CONSTRAINT fk_rails_8dec7c825b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: player_profiles fk_rails_a2e7f8c7ba; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_profiles
    ADD CONSTRAINT fk_rails_a2e7f8c7ba FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: club_profiles fk_rails_b03045753a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_profiles
    ADD CONSTRAINT fk_rails_b03045753a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: coach_teams fk_rails_bbbd8d16b1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_teams
    ADD CONSTRAINT fk_rails_bbbd8d16b1 FOREIGN KEY (coach_profile_id) REFERENCES public.coach_profiles(id);


--
-- Name: admin_profiles fk_rails_bdfe0f01ea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_profiles
    ADD CONSTRAINT fk_rails_bdfe0f01ea FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: board_profiles fk_rails_ca59989866; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_profiles
    ADD CONSTRAINT fk_rails_ca59989866 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: coach_teams fk_rails_d504835a36; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_teams
    ADD CONSTRAINT fk_rails_d504835a36 FOREIGN KEY (club_team_id) REFERENCES public.club_teams(id);


--
-- Name: club_training_centers fk_rails_d60386ca74; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_training_centers
    ADD CONSTRAINT fk_rails_d60386ca74 FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: player_profiles fk_rails_d839a7cd18; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_profiles
    ADD CONSTRAINT fk_rails_d839a7cd18 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: club_teams fk_rails_e24f747198; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_teams
    ADD CONSTRAINT fk_rails_e24f747198 FOREIGN KEY (club_profile_id) REFERENCES public.club_profiles(id);


--
-- Name: club_teams fk_rails_f4054b40e5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club_teams
    ADD CONSTRAINT fk_rails_f4054b40e5 FOREIGN KEY (sport_id) REFERENCES public.sports(id);


--
-- PostgreSQL database dump complete
--

\unrestrict zx2l2gbE7OrcjRYNHfxcDYlhySBBmhS5KtSL3YN0Ff5CKF3Zp4dY96QFzJ7SGEN

