--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-01-12 17:12:12

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
-- TOC entry 883 (class 1247 OID 16702)
-- Name: fonction; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.fonction AS ENUM (
    'VETERINAIRE',
    'RESPONSABLE_ZONE',
    'SOIGNEUR'
);


ALTER TYPE public.fonction OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16610)
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actions (
    id_action integer NOT NULL,
    id_personnel integer,
    id_enclos character varying(50),
    id_espece character varying(50),
    id_animal character varying(100),
    date_prevue timestamp without time zone,
    observations text
);


ALTER TABLE public.actions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16609)
-- Name: actions_id_action_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actions_id_action_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actions_id_action_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 223
-- Name: actions_id_action_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actions_id_action_seq OWNED BY public.actions.id_action;


--
-- TOC entry 215 (class 1259 OID 16407)
-- Name: administrateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrateurs (
    administrateur_id integer NOT NULL,
    nom character varying(30) NOT NULL,
    prenom character varying(30),
    date_de_naissance date
);


ALTER TABLE public.administrateurs OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16406)
-- Name: administrateurs_administrateur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrateurs_administrateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.administrateurs_administrateur_id_seq OWNER TO postgres;

--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 214
-- Name: administrateurs_administrateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrateurs_administrateur_id_seq OWNED BY public.administrateurs.administrateur_id;


--
-- TOC entry 216 (class 1259 OID 16439)
-- Name: animaux; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animaux (
    id_animal character varying(100) NOT NULL,
    nom character varying(100),
    espece character varying(100),
    naissance date,
    deces date,
    sexe character(1),
    observations text,
    localisation character varying(10)
);


ALTER TABLE public.animaux OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16571)
-- Name: enclos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enclos (
    id_enclos character varying(50) NOT NULL,
    nom character varying(50),
    zone_geo character varying(50),
    superficie smallint,
    coordonnees character varying(100),
    temperature_bassin_mini smallint,
    temperature_bassin_maxi smallint,
    temperature_air smallint,
    hygrometrie smallint
);


ALTER TABLE public.enclos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16470)
-- Name: especes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especes (
    id_espece character varying(50) NOT NULL,
    nom character varying(50),
    sociable boolean,
    observations text,
    dangereux boolean,
    enclos character varying(50)
);


ALTER TABLE public.especes OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16639)
-- Name: evenements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evenements (
    id_evenement integer NOT NULL,
    id_personnel integer,
    id_enclos character varying(50),
    id_espece character varying(50),
    id_animal character varying(100),
    id_type_evenement character varying(20),
    observations text,
    moment timestamp without time zone
);


ALTER TABLE public.evenements OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16638)
-- Name: evenements_id_evenement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evenements_id_evenement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evenements_id_evenement_seq OWNER TO postgres;

--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 225
-- Name: evenements_id_evenement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evenements_id_evenement_seq OWNED BY public.evenements.id_evenement;


--
-- TOC entry 219 (class 1259 OID 16463)
-- Name: evenements_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evenements_types (
    id_type_evenement character varying(20) NOT NULL,
    nom character varying(40)
);


ALTER TABLE public.evenements_types OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16454)
-- Name: personnels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personnels (
    id_personnel integer NOT NULL,
    nom character varying(30),
    prenom character varying(30),
    secu bigint,
    naissance date,
    profession public.fonction,
    username character varying(20)
);


ALTER TABLE public.personnels OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16453)
-- Name: personnels_personnel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personnels_personnel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personnels_personnel_id_seq OWNER TO postgres;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 217
-- Name: personnels_personnel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personnels_personnel_id_seq OWNED BY public.personnels.id_personnel;


--
-- TOC entry 228 (class 1259 OID 16763)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16762)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 229 (class 1259 OID 16769)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16775)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(50),
    password character varying(120),
    username character varying(20)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16774)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 230
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 221 (class 1259 OID 16559)
-- Name: zones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zones (
    id_zone character varying(50) NOT NULL,
    nom character varying(50)
);


ALTER TABLE public.zones OWNER TO postgres;

--
-- TOC entry 3227 (class 2604 OID 16613)
-- Name: actions id_action; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions ALTER COLUMN id_action SET DEFAULT nextval('public.actions_id_action_seq'::regclass);


--
-- TOC entry 3225 (class 2604 OID 16410)
-- Name: administrateurs administrateur_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs ALTER COLUMN administrateur_id SET DEFAULT nextval('public.administrateurs_administrateur_id_seq'::regclass);


--
-- TOC entry 3228 (class 2604 OID 16642)
-- Name: evenements id_evenement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements ALTER COLUMN id_evenement SET DEFAULT nextval('public.evenements_id_evenement_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 16457)
-- Name: personnels id_personnel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnels ALTER COLUMN id_personnel SET DEFAULT nextval('public.personnels_personnel_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 16766)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3230 (class 2604 OID 16778)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3429 (class 0 OID 16610)
-- Dependencies: 224
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actions (id_action, id_personnel, id_enclos, id_espece, id_animal, date_prevue, observations) FROM stdin;
85	19	plaine-afrique	gnou	tanza	2023-01-06 11:40:55.637253	Vérifier si tanza est rentré
87	19	foret-koalas	koala	eucalyptus	2023-01-06 12:10:00.02275	Vérifier si eucalyptus est rentré
10	19	montagne-chamois	marmotte	monax	2022-11-17 17:05:22.402003	Vérifier si monax est rentré
11	19	plaine-bisons	bison	tatanka	2022-11-17 17:27:49.403639	Vérifier si tatanka est sortie
12	19	plaine-bisons	bison	yotanka	2022-11-17 17:27:49.433762	Vérifier si yotanka est sortie
13	19	plaine-suricates	suricate	vincent	2022-12-19 17:22:32.386007	Vérifier si vincent est sortie
14	19	plaine-suricates	suricate	lea	2022-12-19 17:22:32.420772	Vérifier si lea est sortie
102	8	plaine-suricates	suricate	eleonore	2023-03-01 15:31:00	controler blessure oreille
118	8	plaine-suricates	\N	\N	2023-01-14 18:57:00	Re
9	19	montagne-chamois	marmotte	bobak	2022-11-17 17:05:22.329705	Vérifier si bobak est rentré
119	\N	\N	\N	\N	\N	\N
120	8	plaine-suricates	\N	\N	2023-01-14 04:36:00	Essai
126	8	\N	suricate	\N	2023-01-21 05:30:00	Bb
132	8	\N	\N	eleonore	2023-01-21 16:25:00	Jouer
133	8	\N	\N	eleonore	2023-01-29 05:56:00	Jouer
36	19	vivarium-afrique	vipere	salazar	2022-12-19 22:22:39.768878	Vérifier si salazar est rentré
37	19	plaine-suricates	suricate	eleonore	2022-12-19 22:27:25.536302	Vérifier si eleonore est rentré
38	19	plaine-suricates	suricate	raphael	2022-12-19 22:41:50.780796	Vérifier si raphael est sortie
39	19	plaine-bisons	bison	tatanka	2022-12-19 22:48:34.849691	Vérifier si tatanka est sortie
43	19	plaine-bisons	bison	iyotake	2022-12-19 22:52:11.285535	Vérifier si iyotake est sortie
45	19	montagne-chamois	chamois	messidor	2022-12-19 22:54:27.316422	Vérifier si messidor est sortie
46	19	vivarium-amerique-sud	boa	kaa	2022-12-19 22:59:25.26242	Vérifier si kaa est sortie
47	19	plaine-afrique	gnou	namie	2022-12-19 22:59:44.713697	Vérifier si namie est rentré
61	19	desert-kangourous	kangourou	drako	2022-12-19 23:25:45.267925	Vérifier si drako est sortie
62	19	desert-kangourous	kangourou	drako	2022-12-19 23:25:52.224494	Vérifier si drako est sortie
64	19	desert-kangourous	kangourou	ginger	2022-12-19 23:26:34.113549	Vérifier si ginger est sortie
66	19	desert-kangourous	kangourou	ginger	2022-12-19 23:26:48.307648	Vérifier si ginger est sortie
76	19	plaine-suricates	suricate	lea	2022-12-19 23:45:37.692176	Vérifier si lea est rentré
88	8	plaine-suricates	suricate	eleonore	2023-01-06 18:15:18.432062	Vérifier si eleonore est sortie
89	8	plaine-suricates	suricate	raphael	2023-01-06 18:15:18.45864	Vérifier si raphael est sortie
90	8	plaine-suricates	suricate	justine	2023-01-06 18:15:18.476247	Vérifier si justine est sortie
86	19	plaine-loutres	loutre	rappy	2023-01-06 12:00:19.84912	"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."\n\nSection 1.10.32 of "de Finibus Bonorum e
83	19	plaine-suricates	suricate	julien	2022-12-20 21:21:33.940162	Vérifier si julien est rentré
84	19	plaine-afrique	zebre	siofa	2022-12-21 17:59:55.015645	Vérifier si siofa est rentré
116	8	plaine-suricates	\N	\N	2023-01-20 15:53:00	Nettoyer entrée
117	8	plaine-suricates	\N	\N	2023-01-13 15:54:00	Remplir bac
103	\N	montagne-chamois	marmotte	bobak	2022-11-17 17:05:23	test
124	8	plaine-suricates	\N	\N	2023-01-13 17:25:00	Hh
128	8	\N	suricate	\N	2023-01-03 09:45:00	dsq
130	8	\N	suricate	\N	2023-01-11 09:54:00	dd
\.


--
-- TOC entry 3420 (class 0 OID 16407)
-- Dependencies: 215
-- Data for Name: administrateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrateurs (administrateur_id, nom, prenom, date_de_naissance) FROM stdin;
\.


--
-- TOC entry 3421 (class 0 OID 16439)
-- Dependencies: 216
-- Data for Name: animaux; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animaux (id_animal, nom, espece, naissance, deces, sexe, observations, localisation) FROM stdin;
salazar	Salazar	vipere	2020-07-29	\N	M	\N	dehors
popi	Popi	fennec	2018-09-21	\N	F	\N	dedans
finnick	Finnick	fennec	2019-04-03	\N	M	\N	dedans
drako	Drako	kangourou	2016-09-09	\N	M	\N	dehors
ginger	Ginger	kangourou	2019-06-10	\N	F	\N	dehors
harry	Harry	chouette	2019-05-16	\N	M	\N	dedans
kalia	Kalia	autruche	1995-06-18	\N	F	\N	dehors
tanza	Tanza	gnou	2019-01-23	\N	F	\N	dehors
marty	Marty	zebre	2007-11-13	\N	M	\N	dedans
namie	Namie	gnou	2013-04-14	\N	F	\N	dedans
mudge	Mudge	loutre	2021-11-21	\N	M	\N	dedans
peluche	Peluche	koala	2017-04-03	\N	F	\N	dedans
borealis	Borealis	lynx	2018-02-11	\N	F	\N	dehors
bolt	Bolt	autruche	1990-07-16	\N	M	\N	dedans
nala	Nala	lion	2010-04-19	\N	F	\N	dehors
blu	Blu	ara	1990-09-11	\N	M	\N	dedans
gala	Gala	iguane	2018-12-26	\N	F	\N	dehors
ryley	Ryley	loup	2018-06-08	\N	F	femelle bêta	dehors
kunta	Kunta	girafe	2017-04-24	\N	M	\N	dehors
siofa	Siofa	zebre	2017-03-17	\N	F	\N	dehors
monax	Monax	marmotte	2019-02-19	\N	F	\N	dedans
gorfa	Gorfa	manchot	2018-09-15	\N	F	\N	dehors
iyotake	Iyotake	bison	2020-01-04	\N	M	\N	dehors
tatanka	Tatanka	bison	2012-11-11	\N	F	\N	dehors
yotanka	Yotanka	bison	2015-12-13	\N	F	\N	dehors
messidor	Messidor	chamois	2020-06-28	\N	M	\N	dehors
yael	Yaël	chamois	2019-04-05	\N	M	\N	dehors
julie	Julie	chamois	2019-03-21	\N	F	\N	dehors
hathi	Hathi	elephant	1992-07-11	\N	M	\N	dedans
isabelle	Isabelle	chamois	2018-09-11	\N	F	\N	dehors
enola	Enola	lama	2021-10-20	\N	F	\N	dedans
machu	Machu	lama	2020-02-07	\N	M	\N	dedans
jad-bal-ja	Jad-bal-ja	lion	2012-04-30	\N	M	\N	dehors
kamel	Kamel	chameau	2016-06-21	\N	M	\N	dedans
alaska	Alaska	loup	2017-06-09	\N	M	mâle bêta	dedans
kaa	Kaa	boa	2018-03-04	\N	M	\N	dehors
ulf	Ulf	loup	2020-04-15	\N	M	mâle alpha	dehors
iowa	Iowa	aigle	1995-02-06	\N	M	\N	dehors
enak	Enak	girafe	2016-09-19	\N	M	\N	dedans
eucalyptus	Eucalyptus	koala	2016-11-28	\N	M	\N	dedans
jasper	Jasper	manchot	2018-03-11	\N	M	\N	dedans
ziggy	Ziggy	vautour	2021-11-17	\N	M	\N	dedans
onyx	Onyx	loup	2014-12-04	\N	M	\N	dedans
rappy	Rappy	loutre	2021-04-29	\N	F	\N	dedans
kourkova	Kourkova	manchot	2021-09-15	\N	F	\N	dedans
perla	Perla	ara	1987-04-21	\N	F	\N	dedans
tuxa	Tuxa	manchot	2019-12-17	\N	F	\N	dehors
willy	Willy	manchot	2019-03-22	\N	M	\N	dehors
bobak	Bobak	marmotte	2021-02-18	\N	M	\N	dedans
sibiraca	Sibiraca	marmotte	2020-10-19	\N	F	\N	dedans
kamtchaka	Kamtchaka	marmotte	2021-08-25	\N	M	\N	dedans
olympus	Olympus	marmotte	2019-10-22	\N	M	\N	dedans
pongo	Pongo	orang-outan	2020-11-26	\N	M	\N	dedans
sumtra	Sumatra	orang-outan	2022-01-02	\N	F	\N	dedans
uma	Uma	loup	2021-07-31	\N	F	femelle alpha	dehors
dizzie	Dizzie	vautour	2020-07-29	\N	F	\N	dehors
raphaela	Raphaela	tortue	1990-07-05	\N	F	\N	dehors
bambou	Bambou	panda	2018-05-31	\N	M	\N	dedans
hao	Hao	panda	2022-02-14	\N	F	\N	dedans
ouate	Ouate	phoque	2018-02-19	\N	F	\N	dedans
bibi	Bibi	phoque	2019-12-31	\N	M	\N	dedans
shere-khan	Shere Khan	tigre	2020-02-26	\N	M	\N	dedans
buzzie	Buzzie	vautour	2018-03-21	\N	F	\N	dedans
donatello	Donatello	tortue	1960-01-18	\N	M	\N	dedans
kodiak	Kodiak	ours-noir	2005-12-29	\N	M	\N	dedans
montana	Montana	ours-noir	2008-09-11	\N	F	\N	dedans
hosuni	Hosuni	tigre	2019-01-27	\N	F	\N	dedans
sakari	Sakari	ours-polaire	2015-03-05	\N	F	\N	dedans
eleonore	Eléonore	suricate	2017-10-17	\N	F	\N	dedans
raphael	Raphaël	suricate	2018-03-16	\N	M	\N	dedans
justine	Justine	suricate	2019-02-10	\N	F	\N	dedans
julien	Julien	suricate	2022-05-23	\N	M	\N	dehors
vincent	Vincent	suricate	2021-07-20	\N	M	\N	dehors
lea	Léa	suricate	2021-01-31	\N	F	\N	dehors
aleksei	Aleksei	rhinoceros	2011-02-11	\N	M	\N	dehors
\.


--
-- TOC entry 3427 (class 0 OID 16571)
-- Dependencies: 222
-- Data for Name: enclos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enclos (id_enclos, nom, zone_geo, superficie, coordonnees, temperature_bassin_mini, temperature_bassin_maxi, temperature_air, hygrometrie) FROM stdin;
foret-ours	Forêt des ours	foret-amerique-nord	2500	47.2424996080987,1.3487654815200327	\N	\N	\N	\N
foret-tigres	Forêt des tigres	asie	3000	47.24772909901873,1.3488513122055843	\N	\N	\N	\N
marais-rhinoceros	Marais des rhinocéros	asie	4000	47.24905459826632,1.348679650834481	\N	\N	\N	\N
montagne-chamois	Montagne des chamois	montagne-europe	2800	47.24335908634655,1.3432937753161096	\N	\N	\N	\N
montagne-lamas	Montagne des lamas	amerique-sud	3500	47.244553592279814,1.3474351058939809	\N	\N	\N	\N
montagne-lynx	Montagne des lynx	montagne-europe	3800	47.24335908634655,1.3432937753161096	\N	\N	\N	\N
plage-tortues	Plage des tortues	australie	500	47.24708818638679,1.3502246031744118	27	35	\N	\N
plaine-afrique	Plaine d'Afrique	savane-afrique	8000	47.24906916400784,1.351190198386869	\N	\N	\N	\N
plaine-bisons	Plaine des bisons	foret-amerique-nord	5000	47.24520910238226,1.344795812313265	\N	\N	\N	\N
plaine-lions	Plaine des lions	savane-afrique	4500	47.245718937965094,1.3450747620413082	\N	\N	\N	\N
plaine-loutres	Plaine des loutres	savane-afrique	800	47.24745234224264,1.3518768438712827	\N	\N	\N	\N
plaine-suricates	Plaine des suricates	savane-afrique	600	47.249768314891035,1.3495379576899982	\N	\N	\N	\N
vivarium-afrique	Vivarium d'Afrique	desert-afrique	150	47.2476271361642,\n1.352992642783455	\N	\N	32	40
vivarium-amerique-sud	Vivarium d'Amérique du Sud	amerique-sud	100	47.2476271361642,1.352992642783455	\N	\N	28	70
voliere-aigles	Volière des aigles	foret-amerique-nord	500	47.248005854348726,1.3506966719449465	\N	\N	\N	\N
voliere-amerique-sud	Volière d'Amérique du Sud	amerique-sud	500	47.248005854348726,1.3506966719449465	\N	\N	\N	\N
voliere-europe	Volière d'Europe	montagne-europe	500	47.248195212425586,1.3520699629137742	\N	\N	\N	\N
foret-pandas	Forêt des pandas	asie	1500	47.24401461123005,1.3439804208005235	\N	\N	\N	\N
banquise-manchots	Banquise des manchots	pole-nord	1000	47.24619963559166,1.3444095742282822	0	4	\N	\N
banquise-ours	Banquise des ours	pole-nord	1000	47.24619963559166,1.3444095742282822	0	4	\N	\N
banquise-phoques	Banquise des phoques	pole-nord	1000	47.24619963559166,1.3444095742282822	0	4	\N	\N
desert-chameaux	Désert des chameaux	desert-afrique	5000	47.24334451903477,1.3493233809761187	\N	\N	\N	\N
desert-kangourous	Désert des kangourous	australie	3000	47.24630160119406,1.3509970793443777	\N	\N	\N	\N
foret-koalas	Forêt des koalas	australie	500	47.24640356660021,1.3511687407154809	\N	\N	\N	\N
foret-loups	Forêt des loups	foret-amerique-nord	3000	47.24254331071894,1.3497096190611018	\N	\N	\N	\N
foret-orang-outans	Forêt des orang-outans	asie	1500	47.24625790167419,1.3462334762962564	\N	\N	\N	\N
\.


--
-- TOC entry 3425 (class 0 OID 16470)
-- Dependencies: 220
-- Data for Name: especes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especes (id_espece, nom, sociable, observations, dangereux, enclos) FROM stdin;
kangourou	Kangourou	f	\N	t	desert-kangourous
koala	Koala	f	\N	f	foret-koalas
autruche	Autruche	f	\N	t	desert-kangourous
tortue	Tortue	f	\N	f	plage-tortues
panda	Panda	f	\N	t	foret-pandas
tigre	Tigre	f	\N	t	foret-tigres
orang-outan	Orang-Outan	f	\N	t	foret-orang-outans
rhinoceros	Rhinocéros	f	\N	t	marais-rhinoceros
iguane	Iguane	f	\N	t	vivarium-amerique-sud
boa	Boa	f	\N	t	vivarium-amerique-sud
ara	Ara	f	\N	t	voliere-amerique-sud
chameau	Chameau	f	\N	t	desert-chameaux
vipere	Vipère	f	\N	t	vivarium-afrique
bison	Bison	f	\N	t	plaine-bisons
ours-noir	Ours noir	f	\N	t	foret-ours
loup	Loup	f	\N	t	foret-loups
aigle	Aigle	f	\N	t	voliere-aigles
ours-polaire	Ours polaire	f	\N	t	banquise-ours
phoque	Phoque	f	\N	t	banquise-phoques
elephant	Elephant	f	\N	t	plaine-afrique
lion	Lion	f	\N	t	plaine-lions
vautour	Vautour	f	\N	t	voliere-europe
chamois	Chamois	f	\N	t	montagne-chamois
lynx	Lynx	f	\N	t	montagne-lynx
chouette	Chouette	f	\N	t	voliere-europe
fennec	Fennec	f	\N	f	desert-chameaux
girafe	Girafe	f	\N	f	plaine-afrique
gnou	Gnou	f	\N	f	plaine-afrique
lama	Lama	f	\N	f	montagne-lamas
loutre	Loutre	f	\N	f	plaine-loutres
manchot	Manchot	f	\N	f	banquise-manchots
marmotte	Marmotte	f	\N	f	montagne-chamois
suricate	Suricate	f	\N	f	plaine-suricates
zebre	Zebre	f	\N	f	plaine-afrique
\.


--
-- TOC entry 3431 (class 0 OID 16639)
-- Dependencies: 226
-- Data for Name: evenements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evenements (id_evenement, id_personnel, id_enclos, id_espece, id_animal, id_type_evenement, observations, moment) FROM stdin;
209	19	\N	iguane	gala	sortie		2022-12-17 22:40:21.535845
210	19	\N	loutre	mudge	sortie		2022-12-17 22:40:26.623829
211	19	\N	loup	ryley	sortie		2022-12-17 22:44:32.043886
212	19	\N	lynx	borealis	sortie		2022-12-17 22:44:37.508209
213	19	\N	chamois	yael	sortie		2022-12-17 22:44:42.299693
214	9	\N	girafe	kunta	sortie	az	2022-12-17 22:49:29.665889
216	19	montagne-chamois	marmotte	monax	entree	rentrer	2022-12-17 23:46:18.158948
217	\N	plaine-afrique	girafe	kunta	soins	la queue	2022-12-18 00:03:15.736721
218	3	banquise-manchots	manchot	gorfa	sortie	sortie	2022-12-18 00:03:34.320893
9	4	\N	loup	\N	entree	Tous les animaux sont rentrés sauf ulf,uma.	\N
10	4	\N	chamois	\N	entree	julie, isabelle toujours dehors.	\N
11	5	\N	marmotte	\N	entree	bobak, monax toujours dehors.	\N
12	5	\N	marmotte	\N	sortie	bobak, monax toujours dedans.	\N
13	5	\N	marmotte	\N	sortie	bobak, monax toujours dedans.	\N
14	5	\N	ara	\N	sortie	 toujours dedans.	\N
221	3	vivarium-amerique-sud	iguane	gala	stimulation	jouer à la balle	2022-12-18 12:34:56.011115
232	19	desert-chameaux	chameau	\N	sortie	test	2022-12-19 10:32:50.602877
233	19	desert-chameaux	chameau	\N	soins	essai	2022-12-19 10:32:56.195789
234	19	desert-chameaux	chameau	\N	stimulation	eza	2022-12-19 10:32:58.446833
235	19	desert-chameaux	chameau	\N	nourrissage	laitue ?	2022-12-19 10:33:03.338595
236	19	desert-chameaux	chameau	\N	entree	dsq	2022-12-19 10:33:07.226064
21	6	\N	chamois	\N	stimulation	nouveau jeu	\N
22	6	\N	suricate	\N	stimulation	resté vers l'abris ext	\N
23	6	\N	suricate	\N	entree	resté vers l'abris ext	\N
24	6	\N	suricate	\N	entree	resté vers l'abris ext	\N
25	6	\N	suricate	\N	entree	resté vers l'abris ext	\N
26	6	\N	suricate	\N	entree	julien, lea toujours dehors. et resté vers l'abris ext	\N
27	6	\N	suricate	\N	sortie	dors encore	\N
28	6	\N	suricate	\N	sortie	vincent toujours dedans. // dors encore	\N
29	\N	banquise-manchots	manchot	\N	verification	nettoyage partiel du bassin	\N
30	19	\N	loup	\N	entree	ulf, uma toujours dehors. // Ils attendaient déjà tous devant la porte.	\N
31	19	\N	loup	\N	entree	ulf, uma toujours dehors. // Ils attendaient déjà tous devant la porte.	\N
238	19	vivarium-amerique-sud	boa	\N	sortie	g	2022-12-19 15:25:42.044659
242	19	plaine-suricates	suricate	julien	neRentrePas	N'est pas rentré avec les autres	2022-12-19 16:34:57.384396
243	19	plaine-suricates	suricate	raphael	neRentrePas	N'est pas rentré avec les autres	2022-12-19 16:34:57.430576
35	19	\N	loup	\N	entree	ulf, uma toujours dehors. // Ils attendaient déjà tous devant la porte.	\N
244	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentré saufjulien, raphael, qui sont toujours dehors.	2022-12-19 16:34:57.363319
253	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-19 18:04:25.618171
38	19	\N	manchot	\N	sortie	gorfa, jasper toujours dedans. // Se sont précipités dehors.	\N
254	19	plaine-suricates	suricate	vincent	neRentrePas	N'est pas rentré avec les autres	2022-12-19 18:04:25.660699
255	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentré sauf eleonore, vincent, qui sont toujours dehors.	2022-12-19 18:04:25.572166
41	19	\N	marmotte	\N	sortie	bobak, monax toujours dedans. // Se sont précipités dehors.	\N
44	19	\N	manchot	\N	entree	willy, tuxa toujours dehors. // Se sont précipités dehors.	\N
45	19	\N	manchot	\N	sortie	Se sont précipités dehors.	\N
262	19	plaine-suricates	suricate	julien	neRentrePas	N'est pas rentré avec les autres	2022-12-19 18:34:35.567522
263	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentré sauf Julien, qui sont toujours dehors.	2022-12-19 18:34:35.536422
267	19	plaine-suricates	suricate	julien	neSortPas	N'est pas sorti avec les autres	2022-12-19 20:22:56.291786
268	19	plaine-suricates	suricate	lea	neSortPas	N'est pas sorti avec les autres	2022-12-19 20:22:56.312876
269	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sortie sauf Julien, Léa, qui sont toujours dedans.	2022-12-19 20:22:56.278701
51	19	\N	marmotte	\N	sortie	bobak, monax toujours dedans. // Se sont précipités dehors.	\N
273	19	plaine-suricates	suricate	\N	sortie	\N	2022-12-19 20:58:06.139964
274	19	plaine-suricates	suricate	vincent	neSortPas	N'est pas sorti avec les autres	2022-12-19 20:58:36.181503
275	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sortie sauf Vincent, qui sont toujours dedans.	2022-12-19 20:58:36.170976
276	19	plaine-suricates	suricate	\N	sortie	\N	2022-12-19 20:58:52.430277
277	19	plaine-suricates	suricate	\N	sortie	\N	2022-12-19 20:59:04.748978
285	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:18:32.705583
286	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:20:17.491309
287	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés.	2022-12-19 21:20:34.641041
288	19	vivarium-afrique	vipere	\N	sortie	Tous les vipere sont sorties.	2022-12-19 21:22:28.833195
289	19	vivarium-afrique	vipere	salazar	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:22:39.764868
62	19	\N	marmotte	\N	entree	bobak, monax toujours dehors. // Se sont précipités dehors.	\N
290	19	vivarium-afrique	vipere	\N	entree	Tous les vipere sont rentrés sauf Salazar qui est (sont) toujours dehors.	2022-12-19 21:22:39.749822
291	19	plaine-suricates	suricate	\N	soins	tes	2022-12-19 21:23:00.282972
65	19	plaine-bisons	bison	\N	sortie	tatanka, yotanka toujours dedans. // Se sont précipités dedans.	\N
292	19	plaine-suricates	suricate	\N	stimulation	ici	2022-12-19 21:23:09.999803
293	19	plaine-suricates	suricate	\N	nourrissage	la	2022-12-19 21:23:17.501167
294	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:27:25.5323
1	2	montagne-lynx	\N	\N	verification	Portail cassé	2022-11-18 10:18:31.407442
66	2	montagne-lynx	\N	\N	verification	Portail cassé	2022-11-18 10:19:10.233102
67	2	montagne-lynx	\N	\N	soins	blessure à la patte gauche	2022-11-18 10:38:32.169919
295	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Eléonore qui est (sont) toujours dehors.	2022-12-19 21:27:25.523763
296	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:28:38.675132
297	19	marais-rhinoceros	rhinoceros	\N	sortie	Tous les rhinoceros sont sorties.	2022-12-19 21:37:09.711609
298	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:39:27.344877
299	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:39:33.659442
300	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:40:28.943878
423	\N	\N	\N	\N	\N	\N	\N
215	3	\N	zebre	siofa	sortie	à la traine	2022-12-17 23:10:03.460945
219	19	plaine-lions	lion	nala	soins	oreilles	2022-12-18 00:05:38.190839
222	3	voliere-amerique-sud	ara	blu	nourrissage	petite faim	2022-12-18 13:53:35.206543
223	19	vivarium-amerique-sud	iguane	gala	nourrissage	grosse faim	2022-12-18 13:56:39.86826
224	19	vivarium-amerique-sud	iguane	gala	nourrissage		2022-12-18 13:56:43.00112
225	19	vivarium-amerique-sud	boa	\N	sortie	\N	\N
226	19	vivarium-amerique-sud	boa	\N	entree	\N	\N
227	19	vivarium-amerique-sud	boa	\N	sortie	sortie	\N
228	19	vivarium-amerique-sud	boa	\N	entree	entrée	\N
229	19	montagne-chamois	chamois	\N	soins	test	2022-12-19 10:27:05.557238
230	19	montagne-chamois	chamois	\N	stimulation	balle	\N
231	19	montagne-chamois	chamois	\N	sortie	essai	\N
237	19	vivarium-amerique-sud	boa	\N	entree	dsq	2022-12-19 14:43:23.605868
239	19	plaine-suricates	suricate	vincent	neSortPas	N'est pas sorti avec les autres	2022-12-19 16:22:32.38098
240	19	plaine-suricates	suricate	lea	neSortPas	N'est pas sorti avec les autres	2022-12-19 16:22:32.41713
241	19	plaine-suricates	suricate	\N	sortie	vincent, lea toujours dedans.	2022-12-19 16:22:32.334345
247	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 17:57:54.525417
248	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 17:57:54.555086
249	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sortie sauf justine, eleonore, qui sont toujours dedans.	2022-12-19 17:57:54.511381
250	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 17:58:30.174116
251	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sortie sauf eleonore, qui sont toujours dedans.	2022-12-19 17:58:30.163583
256	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-19 18:15:07.690836
257	19	plaine-suricates	suricate	vincent	neRentrePas	N'est pas rentré avec les autres	2022-12-19 18:15:07.743359
258	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentré sauf eleonore, vincent, qui sont toujours dehors.	2022-12-19 18:15:07.639537
264	19	plaine-suricates	suricate	julien	neSortPas	N'est pas sorti avec les autres	2022-12-19 18:38:04.151214
265	19	plaine-suricates	suricate	lea	neSortPas	N'est pas sorti avec les autres	2022-12-19 18:38:04.199689
266	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sortie sauf Julien, Léa, qui sont toujours dedans.	2022-12-19 18:38:04.126575
270	19	plaine-suricates	suricate	julien	neRentrePas	N'est pas rentré avec les autres	2022-12-19 20:56:49.476976
271	19	plaine-suricates	suricate	lea	neRentrePas	N'est pas rentré avec les autres	2022-12-19 20:56:49.496164
272	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentré sauf Julien, Léa, qui sont toujours dehors.	2022-12-19 20:56:49.461895
278	19	plaine-suricates	suricate	vincent	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:16:43.307103
279	19	plaine-suricates	suricate	julien	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:16:43.359247
280	19	plaine-suricates	suricate	lea	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:16:43.374271
281	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Vincent, Julien, Léa qui est (sont) toujours dehors.	2022-12-19 21:16:43.28806
282	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 21:17:24.863959
283	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:17:53.02494
284	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Eléonore qui est (sont) toujours dehors.	2022-12-19 21:17:53.015419
301	19	plaine-suricates	suricate	\N	soins	dqs	2022-12-19 21:40:53.728244
302	19	plaine-suricates	suricate	raphael	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:41:50.777288
303	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Raphaël qui est (sont) toujours dedans. // ala main	2022-12-19 21:41:50.769246
304	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:44:04.460783
305	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:48:23.267398
306	19	plaine-bisons	bison	tatanka	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:48:34.845688
307	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties sauf Tatanka qui est (sont) toujours dedans.	2022-12-19 21:48:34.835657
308	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:48:47.293805
309	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:48:58.732419
310	19	plaine-bisons	bison	tatanka	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:49:07.603226
311	19	plaine-bisons	bison	iyotake	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:49:07.616262
312	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties sauf Tatanka, Iyotake qui est (sont) toujours dedans.	2022-12-19 21:49:07.593667
313	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:49:15.973733
314	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:49:24.937538
315	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:49:30.875751
316	19	plaine-bisons	bison	iyotake	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:49:35.481823
317	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties sauf Iyotake qui est (sont) toujours dedans.	2022-12-19 21:49:35.474798
318	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties.	2022-12-19 21:49:40.416923
319	19	plaine-bisons	bison	iyotake	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:52:11.282527
320	19	plaine-bisons	bison	tatanka	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:52:11.29474
410	19	plaine-afrique	gnou	\N	nourrissage	avec de l'avoine	2022-12-20 20:20:38.246995
190	\N	\N	\N	harry	soins	vole à nouveau	2022-12-15 18:50:52.720165
191	\N	\N	\N	harry	soins	vole à nouveau	2022-12-15 18:50:53.979221
192	\N	\N	\N	harry	soins	vole à nouveau	2022-12-15 18:51:02.123799
193	\N	\N	\N	siofa	soins	tt va mieux	2022-12-15 18:51:58.95603
194	\N	\N	\N	harry	soins	RAS	2022-12-16 08:44:04.471424
197	\N	\N	\N	gorfa	soins	ailes gauche	2022-12-16 09:05:11.405704
198	\N	\N	\N	nala	soins		2022-12-17 20:28:57.162514
202	\N	\N	\N	finnick	soins	bobo	2022-12-17 22:03:32.733069
203	\N	\N	\N	finnick	soins	2eme	2022-12-17 22:04:09.2959
205	\N	\N	\N	siofa	soins	bobo au coup	2022-12-17 22:26:45.735042
207	19	\N	ara	blu	entree	chante	2022-12-17 22:33:37.563998
208	\N	\N	manchot	gorfa	soins		2022-12-17 22:40:15.682487
321	19	plaine-bisons	bison	\N	sortie	Tous les bison sont sorties sauf Iyotake, Tatanka qui est (sont) toujours dedans.	2022-12-19 21:52:11.27649
322	19	montagne-chamois	chamois	\N	sortie	Tous les chamois sont sorties.	2022-12-19 21:54:20.163302
323	19	montagne-chamois	chamois	messidor	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:54:27.31342
324	19	montagne-chamois	chamois	\N	sortie	Tous les chamois sont sorties sauf Messidor qui est (sont) toujours dedans.	2022-12-19 21:54:27.307386
325	19	vivarium-amerique-sud	boa	\N	sortie	Tous les boa sont sorties.	2022-12-19 21:59:07.7816
326	19	vivarium-amerique-sud	boa	\N	sortie	Tous les boa sont sorties.	2022-12-19 21:59:15.442431
327	19	vivarium-amerique-sud	boa	kaa	neSortPas	N'est pas sorti avec les autres	2022-12-19 21:59:25.259395
328	19	vivarium-amerique-sud	boa	\N	sortie	Tous les boa sont sorties sauf Kaa qui est (sont) toujours dedans.	2022-12-19 21:59:25.254397
329	19	vivarium-amerique-sud	boa	\N	sortie	Tous les boa sont sorties.	2022-12-19 21:59:31.913684
330	19	plaine-afrique	gnou	namie	neRentrePas	N'est pas rentré avec les autres	2022-12-19 21:59:44.711172
331	19	plaine-afrique	gnou	\N	entree	Tous les gnou sont rentrés sauf Namie qui est (sont) toujours dehors.	2022-12-19 21:59:44.703558
332	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:04:31.934709
333	19	plaine-suricates	suricate	raphael	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:04:47.091555
334	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Raphaël qui est (sont) toujours dedans. // cxw	2022-12-19 22:04:47.085519
335	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés.	2022-12-19 22:04:55.34467
336	19	plaine-suricates	suricate	raphael	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:05:01.711127
337	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Raphaël qui est (sont) toujours dehors. // cxw	2022-12-19 22:05:01.704619
338	19	plaine-suricates	suricate	raphael	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:05:09.60932
339	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:05:09.619364
340	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:05:09.62941
341	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Raphaël, Eléonore, Justine qui est (sont) toujours dedans.	2022-12-19 22:05:09.6018
342	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:06:54.573057
343	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:17:55.173664
344	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:18:20.628165
345	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Eléonore qui est (sont) toujours dedans. // cxw	2022-12-19 22:18:20.613612
346	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:18:50.96823
347	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:18:50.982292
348	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Eléonore, Justine qui est (sont) toujours dedans. // cxw	2022-12-19 22:18:50.956683
349	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:19:06.462951
350	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés.	2022-12-19 22:19:22.035687
351	19	plaine-suricates	suricate	justine	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:19:26.504824
352	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Justine qui est (sont) toujours dehors. // cxw	2022-12-19 22:19:26.493216
353	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:23:04.37271
354	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans.	2022-12-19 22:23:04.363692
355	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:23:12.109795
356	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans.	2022-12-19 22:23:12.100751
357	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:23:17.762589
358	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans. //   "rr	2022-12-19 22:23:17.75192
359	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:23:21.715877
360	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans. //   "rr"	2022-12-19 22:23:21.705848
361	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:23:27.848668
362	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties. // rrr	2022-12-19 22:25:35.868848
363	19	desert-kangourous	kangourou	drako	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:25:45.262911
364	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties sauf Drako qui est (sont) toujours dedans. // rrr	2022-12-19 22:25:45.248858
365	19	desert-kangourous	kangourou	drako	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:25:52.220972
366	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties sauf Drako qui est (sont) toujours dedans.	2022-12-19 22:25:52.209433
367	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties. // rez	2022-12-19 22:26:31.000732
368	19	desert-kangourous	kangourou	drako	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:26:34.085418
369	19	desert-kangourous	kangourou	ginger	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:26:34.109495
370	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties sauf Drako, Ginger qui est (sont) toujours dedans. // rez	2022-12-19 22:26:34.069342
371	19	desert-kangourous	kangourou	drako	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:26:48.288516
372	19	desert-kangourous	kangourou	ginger	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:26:48.303642
373	19	desert-kangourous	kangourou	\N	sortie	Tous les kangourou sont sorties sauf Drako, Ginger qui est (sont) toujours dedans.	2022-12-19 22:26:48.279462
374	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties. // 	2022-12-19 22:31:56.94161
375	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés. // 	2022-12-19 22:31:58.751735
376	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties. // te	2022-12-19 22:32:02.480902
377	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés. // te	2022-12-19 22:32:04.901843
378	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:32:07.461833
379	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans. // te	2022-12-19 22:32:07.44579
380	19	plaine-suricates	suricate	justine	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:32:11.754716
381	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Justine qui est (sont) toujours dehors. // te	2022-12-19 22:32:11.741512
382	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:37:31.564444
383	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés.	2022-12-19 22:37:41.38363
384	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-19 22:37:55.911656
385	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:38:50.775406
386	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans.	2022-12-19 22:38:50.759338
387	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:40:05.444663
388	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans. //    vbc	2022-12-19 22:40:05.431588
389	19	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:41:05.11333
390	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Justine qui est (sont) toujours dedans. // dqs	2022-12-19 22:41:05.102746
391	19	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:45:29.339248
392	19	plaine-suricates	suricate	raphael	neSortPas	N'est pas sorti avec les autres	2022-12-19 22:45:29.353328
393	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Eléonore, Raphaël qui est (sont) toujours dedans. // last ?	2022-12-19 22:45:29.32921
394	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:45:37.66245
395	19	plaine-suricates	suricate	raphael	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:45:37.675497
396	19	plaine-suricates	suricate	lea	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:45:37.689143
397	19	plaine-suricates	suricate	justine	neRentrePas	N'est pas rentré avec les autres	2022-12-19 22:45:37.700693
398	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Eléonore, Raphaël, Léa, Justine qui est (sont) toujours dehors.	2022-12-19 22:45:37.653281
399	19	desert-chameaux	fennec	\N	entree	Tous les fennec sont rentrés.	2022-12-20 13:35:45.025372
400	19	desert-kangourous	autruche	\N	entree	Tous les autruche sont rentrés.	2022-12-20 14:18:20.334647
401	19	desert-kangourous	autruche	\N	sortie	Tous les autruche sont sorties. // dehors	2022-12-20 14:18:29.892166
402	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties.	2022-12-20 15:05:14.441711
403	19	plaine-suricates	suricate	julien	neSortPas	N'est pas sorti avec les autres	2022-12-20 15:06:53.620385
404	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Julien qui est (sont) toujours dedans.	2022-12-20 15:06:53.607022
405	19	plaine-suricates	suricate	julien	neSortPas	N'est pas sorti avec les autres	2022-12-20 15:07:17.355373
406	19	plaine-suricates	suricate	vincent	neSortPas	N'est pas sorti avec les autres	2022-12-20 15:07:17.368694
407	19	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Julien, Vincent qui est (sont) toujours dedans.	2022-12-20 15:07:17.346824
408	19	plaine-suricates	suricate	vincent	neRentrePas	N'est pas rentré avec les autres	2022-12-20 15:08:52.058065
409	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Vincent qui est (sont) toujours dehors. // e	2022-12-20 15:08:52.049144
411	19	plaine-afrique	gnou	\N	stimulation	avec un ballon	2022-12-20 20:20:58.078497
412	19	plaine-afrique	gnou	\N	soins		2022-12-20 20:21:00.38208
413	19	plaine-afrique	gnou	\N	sortie	Tous les gnou sont sorties.	2022-12-20 20:21:13.388883
414	19	plaine-suricates	suricate	eleonore	neRentrePas	N'est pas rentré avec les autres	2022-12-20 20:21:33.909528
415	19	plaine-suricates	suricate	julien	neRentrePas	N'est pas rentré avec les autres	2022-12-20 20:21:33.935621
416	19	plaine-suricates	suricate	\N	entree	Tous les suricate sont rentrés sauf Eléonore, Julien qui est (sont) toujours dehors.	2022-12-20 20:21:33.894457
417	19	plaine-suricates	suricate	\N	soins		2022-12-20 20:24:57.388
418	19	voliere-europe	vautour	buzzie	nourrissage	du pain	2022-12-20 20:33:37.423646
419	19	foret-tigres	\N	\N	verification	grillage	2022-12-21 15:07:57.970915
420	19	plaine-afrique	zebre	siofa	neRentrePas	N'est pas rentré avec les autres	2022-12-21 16:59:55.005105
421	19	plaine-afrique	zebre	\N	entree	Tous les zebre sont rentrés sauf Siofa qui est (sont) toujours dehors.	2022-12-21 16:59:54.988071
422	19	banquise-phoques	\N	\N	verification	portail cassé	2022-12-21 18:26:51.014202
424	\N	\N	\N	\N	\N	\N	\N
425	\N	\N	\N	\N	\N	\N	\N
426	\N	\N	\N	\N	\N	\N	\N
427	\N	\N	\N	\N	\N	\N	\N
428	\N	\N	\N	\N	\N	\N	\N
429	\N	\N	\N	\N	\N	\N	\N
430	\N	\N	\N	\N	\N	\N	\N
431	19	\N	\N	\N	\N	master	\N
432	19	\N	\N	\N	verification	dsq	2022-12-22 15:56:37.069598
433	19	\N	\N	\N	verification	dsq	2022-12-22 16:44:13.266243
435	19	\N	\N	\N	depart	depart	2022-12-22 23:08:07.428184
436	19	\N	\N	\N	naissance	\N	2022-12-23 07:34:43.460345
437	19	\N	\N	\N	accident	fds	2022-12-23 10:07:26.867011
438	19	desert-chameaux	\N	\N	verification		2022-12-24 12:18:16.789553
439	19	banquise-phoques	phoque	bibi	nourrissage	sans pain !	2023-01-02 08:52:03.427825
441	19	plage-tortues	\N	bibi	autre	test	2023-01-02 09:58:08.575227
442	19	banquise-ours	chameau	finnick	autre	test2	2023-01-02 10:00:17.316703
443	19	\N	\N	\N	autre	essai	2023-01-02 11:00:02.588949
444	19	banquise-ours	ours-polaire	\N	accident	essai2	2023-01-02 11:01:16.570625
445	19	\N	rhinoceros	\N	autre	essai3	2023-01-02 11:01:56.339959
446	19	banquise-phoques	phoque	bibi	arrivee	ed dsq dq	2023-01-02 12:04:35.761021
447	19	\N	\N	bambou	arrivee	test	2023-01-02 13:11:02.988298
448	19	\N	\N	bambou	entree	2	2023-01-02 13:11:39.241675
449	19	plaine-afrique	gnou	tanza	neRentrePas	N'est pas rentré avec les autres	2023-01-06 10:40:55.578918
450	19	plaine-afrique	gnou	\N	entree	Tous les gnou sont rentrés sauf Tanza qui est (sont) toujours dehors.	2023-01-06 10:40:55.556747
451	19	plaine-loutres	loutre	rappy	neRentrePas	N'est pas rentré avec les autres	2023-01-06 11:00:19.842098
452	19	plaine-loutres	loutre	\N	entree	Tous les loutre sont rentrés sauf Rappy qui est (sont) toujours dehors. // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."	2023-01-06 11:00:19.831032
453	19	foret-koalas	koala	eucalyptus	neRentrePas	N'est pas rentré avec les autres	2023-01-06 11:09:59.983569
454	19	foret-koalas	koala	\N	entree	Tous les koala sont rentrés sauf Eucalyptus qui est (sont) toujours dehors.	2023-01-06 11:09:59.959421
455	8	montagne-lamas	\N	\N	verification	grillage a repezindre	2023-01-06 17:14:43.239178
456	8	plaine-suricates	suricate	eleonore	neSortPas	N'est pas sorti avec les autres	2023-01-06 17:15:18.425988
457	8	plaine-suricates	suricate	raphael	neSortPas	N'est pas sorti avec les autres	2023-01-06 17:15:18.455636
458	8	plaine-suricates	suricate	justine	neSortPas	N'est pas sorti avec les autres	2023-01-06 17:15:18.472232
459	8	plaine-suricates	suricate	\N	sortie	Tous les suricate sont sorties sauf Eléonore, Raphaël, Justine qui est (sont) toujours dedans.	2023-01-06 17:15:18.408946
460	19	\N	\N	enak	deces	test	2023-01-11 18:24:00.399393
461	19	vivarium-amerique-sud	boa	\N	soins	mue	2023-01-12 14:03:42.187979
462	19	banquise-ours	\N	\N	verification	vérif températures de l'eau	2023-01-12 14:04:57.909744
463	19	marais-rhinoceros	\N	\N	verification	remplacement du toît de l'abris	2023-01-12 14:06:51.00232
464	19	montagne-lynx	lynx	borealis	stimulation	faire courir le gros chat au laser !	2023-01-12 14:41:09.199052
465	19	plaine-suricates	suricate	justine	nourrissage	chips	2023-01-12 14:54:32.901216
466	19	foret-pandas	panda	hao	nourrissage	bamboo	2023-01-12 14:54:41.236829
467	19	montagne-lynx	lynx	borealis	entree		2023-01-12 14:54:51.576874
468	19	montagne-lynx	lynx	borealis	sortie		2023-01-12 14:54:55.326899
469	19	desert-kangourous	autruche	bolt	entree		2023-01-12 14:55:01.36804
470	19	desert-kangourous	autruche	bolt	sortie		2023-01-12 14:55:10.12871
471	19	desert-kangourous	autruche	bolt	entree		2023-01-12 14:55:13.340765
472	19	banquise-phoques	\N	\N	verification	le tour	2023-01-12 14:55:55.604047
473	19	voliere-europe	\N	\N	verification	check up	2023-01-12 14:56:19.107016
474	19	plaine-afrique	elephant	hathi	stimulation	jeux d'eau	2023-01-12 16:35:30.69967
\.


--
-- TOC entry 3424 (class 0 OID 16463)
-- Dependencies: 219
-- Data for Name: evenements_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evenements_types (id_type_evenement, nom) FROM stdin;
entree	Entrée
sortie	Sortie
nourrissage	Nourrissage
soins	Soins
stimulation	Stimulation
naissance	Naissance
deces	Décès
depart	Départ
arrivee	Arrivée
bagarre	Bagarre
accident	Accident
verification	Vérification
autre	Autre type
neRentrePas	Ne rentre pas avec les autres
neSortPas	Ne sort pas avec les autres
\.


--
-- TOC entry 3423 (class 0 OID 16454)
-- Dependencies: 218
-- Data for Name: personnels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personnels (id_personnel, nom, prenom, secu, naissance, profession, username) FROM stdin;
1	Guerin	Dorothée	297015220117468	1987-09-10	SOIGNEUR	dorothee.guerin
2	Guillon	Pauline	257056737437777	1975-01-26	SOIGNEUR	soigneur
4	Maury	Augustin	198081908760980	1993-04-13	SOIGNEUR	augustin.maury
5	Picard	Adrien	196105655111445	1977-02-24	SOIGNEUR	adrien.picard
6	Blanchard	Colette	256118321943319	1985-05-12	SOIGNEUR	colette.blanchard
7	Fouquet	Colette	277097486062849	1979-02-19	RESPONSABLE_ZONE	resp
8	Dupuis	Christiane	267091023042629	2000-04-25	RESPONSABLE_ZONE	colette.fouquet
9	Marchand	Catherine	255102766126416	1990-07-10	RESPONSABLE_ZONE	catherine.marchand
10	Delmas	Marcelle	190037110572479	1989-09-06	VETERINAIRE	admin
3	Garcia	William	137120304077952	1995-04-22	SOIGNEUR	peon
19	Marie	René	257056737437779	1987-07-17	VETERINAIRE	master
\.


--
-- TOC entry 3433 (class 0 OID 16763)
-- Dependencies: 228
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	ROLE_SOIGNEUR
2	ROLE_RESPONSABLE
3	ROLE_VETO
\.


--
-- TOC entry 3434 (class 0 OID 16769)
-- Dependencies: 229
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
3	1
5	2
4	3
4	2
4	1
6	1
2	3
7	2
7	1
8	2
9	1
11	1
10	3
10	1
10	2
\.


--
-- TOC entry 3436 (class 0 OID 16775)
-- Dependencies: 231
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, username) FROM stdin;
4	master@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	master
7	colette.fouquet@info.fr	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	colette.fouquet
8	catherine.marchand@info.fr	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	catherine.marchand
9	augustin.maury@info.fr	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	augustin.maury
10	adrien.picard@info.fr	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	adrien.picard
11	colette.blanchard@info.fr	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	colette.blanchard
1	mod@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	dorothee.guerin
2	veto@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	admin
3	peon@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	peon
5	resp@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	resp
6	soin@info.com	$2a$10$sVyrrdXA53zsfKT9FjNSuO9DpsZP3m4aDWGai7229X23VgLJGX3mu	soigneur
\.


--
-- TOC entry 3426 (class 0 OID 16559)
-- Dependencies: 221
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zones (id_zone, nom) FROM stdin;
australie	Australie
asie	Asie
amerique-sud	Amérique du sud
desert-afrique	Désert d'Afrique
foret-amerique-nord	Forêt d'Amérique du nord
pole-nord	Pôle Nord
savane-afrique	Savane d'Afrique
montagne-europe	Montagne d'Europe
\.


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 223
-- Name: actions_id_action_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actions_id_action_seq', 133, true);


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 214
-- Name: administrateurs_administrateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administrateurs_administrateur_id_seq', 1, false);


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 225
-- Name: evenements_id_evenement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evenements_id_evenement_seq', 474, true);


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 217
-- Name: personnels_personnel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personnels_personnel_id_seq', 21, true);


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 230
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- TOC entry 3250 (class 2606 OID 16617)
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id_action);


--
-- TOC entry 3232 (class 2606 OID 16412)
-- Name: administrateurs administrateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_pkey PRIMARY KEY (administrateur_id);


--
-- TOC entry 3234 (class 2606 OID 16445)
-- Name: animaux animaux_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animaux
    ADD CONSTRAINT animaux_pkey PRIMARY KEY (id_animal);


--
-- TOC entry 3248 (class 2606 OID 16608)
-- Name: enclos enclos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enclos
    ADD CONSTRAINT enclos_pkey PRIMARY KEY (id_enclos);


--
-- TOC entry 3244 (class 2606 OID 16476)
-- Name: especes especes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especes
    ADD CONSTRAINT especes_pkey PRIMARY KEY (id_espece);


--
-- TOC entry 3252 (class 2606 OID 16646)
-- Name: evenements evenements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_pkey PRIMARY KEY (id_evenement);


--
-- TOC entry 3242 (class 2606 OID 16467)
-- Name: evenements_types evenements_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements_types
    ADD CONSTRAINT evenements_types_pkey PRIMARY KEY (id_type_evenement);


--
-- TOC entry 3236 (class 2606 OID 16459)
-- Name: personnels personnels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_pkey PRIMARY KEY (id_personnel);


--
-- TOC entry 3238 (class 2606 OID 16796)
-- Name: personnels personnels_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_username_key UNIQUE (username);


--
-- TOC entry 3254 (class 2606 OID 16768)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16712)
-- Name: personnels secunik; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT secunik UNIQUE (secu);


--
-- TOC entry 3258 (class 2606 OID 16784)
-- Name: users uk6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- TOC entry 3260 (class 2606 OID 16782)
-- Name: users ukr43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- TOC entry 3256 (class 2606 OID 16773)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3262 (class 2606 OID 16780)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16570)
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id_zone);


--
-- TOC entry 3266 (class 2606 OID 16633)
-- Name: actions actions_id_animal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animaux(id_animal);


--
-- TOC entry 3267 (class 2606 OID 16623)
-- Name: actions actions_id_enclos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_enclos_fkey FOREIGN KEY (id_enclos) REFERENCES public.enclos(id_enclos);


--
-- TOC entry 3268 (class 2606 OID 16628)
-- Name: actions actions_id_espece_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_espece_fkey FOREIGN KEY (id_espece) REFERENCES public.especes(id_espece);


--
-- TOC entry 3269 (class 2606 OID 16618)
-- Name: actions actions_id_personnel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_personnel_fkey FOREIGN KEY (id_personnel) REFERENCES public.personnels(id_personnel);


--
-- TOC entry 3264 (class 2606 OID 16749)
-- Name: especes enclos_lien; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especes
    ADD CONSTRAINT enclos_lien FOREIGN KEY (enclos) REFERENCES public.enclos(id_enclos) MATCH FULL NOT VALID;


--
-- TOC entry 3265 (class 2606 OID 16574)
-- Name: enclos enclos_zone_geo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enclos
    ADD CONSTRAINT enclos_zone_geo_fkey FOREIGN KEY (zone_geo) REFERENCES public.zones(id_zone);


--
-- TOC entry 3270 (class 2606 OID 16662)
-- Name: evenements evenements_id_animal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animaux(id_animal);


--
-- TOC entry 3271 (class 2606 OID 16652)
-- Name: evenements evenements_id_enclos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_enclos_fkey FOREIGN KEY (id_enclos) REFERENCES public.enclos(id_enclos);


--
-- TOC entry 3272 (class 2606 OID 16657)
-- Name: evenements evenements_id_espece_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_espece_fkey FOREIGN KEY (id_espece) REFERENCES public.especes(id_espece);


--
-- TOC entry 3273 (class 2606 OID 16647)
-- Name: evenements evenements_id_personnel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_personnel_fkey FOREIGN KEY (id_personnel) REFERENCES public.personnels(id_personnel);


--
-- TOC entry 3274 (class 2606 OID 16667)
-- Name: evenements evenements_id_type_evenement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_type_evenement_fkey FOREIGN KEY (id_type_evenement) REFERENCES public.evenements_types(id_type_evenement);


--
-- TOC entry 3275 (class 2606 OID 16785)
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 3276 (class 2606 OID 16790)
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3263 (class 2606 OID 16797)
-- Name: personnels username; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT username FOREIGN KEY (username) REFERENCES public.users(username) NOT VALID;


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE actions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.actions TO "user" WITH GRANT OPTION;


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE actions_id_action_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.actions_id_action_seq TO "user" WITH GRANT OPTION;


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE administrateurs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.administrateurs TO "user" WITH GRANT OPTION;


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 214
-- Name: SEQUENCE administrateurs_administrateur_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.administrateurs_administrateur_id_seq TO "user" WITH GRANT OPTION;


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE animaux; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.animaux TO "user" WITH GRANT OPTION;


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE enclos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.enclos TO "user" WITH GRANT OPTION;


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE especes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.especes TO "user" WITH GRANT OPTION;


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE evenements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.evenements TO "user" WITH GRANT OPTION;


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 225
-- Name: SEQUENCE evenements_id_evenement_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.evenements_id_evenement_seq TO "user" WITH GRANT OPTION;


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE evenements_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.evenements_types TO "user" WITH GRANT OPTION;


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE personnels; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.personnels TO "user" WITH GRANT OPTION;


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE personnels_personnel_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.personnels_personnel_id_seq TO "user" WITH GRANT OPTION;


--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE zones; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zones TO "user" WITH GRANT OPTION;


-- Completed on 2023-01-12 17:12:12

--
-- PostgreSQL database dump complete
--

