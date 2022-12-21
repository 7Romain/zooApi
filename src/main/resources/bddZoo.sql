PGDMP     
                    z            zoo    15.0    15.0 a    o           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            p           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            r           1262    16398    zoo    DATABASE     v   CREATE DATABASE zoo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE zoo;
                postgres    false            s           0    0    DATABASE zoo    ACL     7   GRANT ALL ON DATABASE zoo TO "user" WITH GRANT OPTION;
                   postgres    false    3442            s           1247    16702    fonction    TYPE     c   CREATE TYPE public.fonction AS ENUM (
    'VETERINAIRE',
    'RESPONSABLE_ZONE',
    'SOIGNEUR'
);
    DROP TYPE public.fonction;
       public          postgres    false            �            1259    16610    actions    TABLE       CREATE TABLE public.actions (
    id_action integer NOT NULL,
    id_personnel integer,
    id_enclos character varying(50),
    id_espece character varying(50),
    id_animal character varying(100),
    date_prevue timestamp without time zone,
    observations text
);
    DROP TABLE public.actions;
       public         heap    postgres    false            t           0    0    TABLE actions    ACL     ?   GRANT ALL ON TABLE public.actions TO "user" WITH GRANT OPTION;
          public          postgres    false    224            �            1259    16609    actions_id_action_seq    SEQUENCE     �   CREATE SEQUENCE public.actions_id_action_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.actions_id_action_seq;
       public          postgres    false    224            u           0    0    actions_id_action_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.actions_id_action_seq OWNED BY public.actions.id_action;
          public          postgres    false    223            v           0    0    SEQUENCE actions_id_action_seq    ACL     P   GRANT ALL ON SEQUENCE public.actions_id_action_seq TO "user" WITH GRANT OPTION;
          public          postgres    false    223            �            1259    16407    administrateurs    TABLE     �   CREATE TABLE public.administrateurs (
    administrateur_id integer NOT NULL,
    nom character varying(30) NOT NULL,
    prenom character varying(30),
    date_de_naissance date
);
 #   DROP TABLE public.administrateurs;
       public         heap    postgres    false            w           0    0    TABLE administrateurs    ACL     G   GRANT ALL ON TABLE public.administrateurs TO "user" WITH GRANT OPTION;
          public          postgres    false    215            �            1259    16406 %   administrateurs_administrateur_id_seq    SEQUENCE     �   CREATE SEQUENCE public.administrateurs_administrateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.administrateurs_administrateur_id_seq;
       public          postgres    false    215            x           0    0 %   administrateurs_administrateur_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.administrateurs_administrateur_id_seq OWNED BY public.administrateurs.administrateur_id;
          public          postgres    false    214            y           0    0 .   SEQUENCE administrateurs_administrateur_id_seq    ACL     `   GRANT ALL ON SEQUENCE public.administrateurs_administrateur_id_seq TO "user" WITH GRANT OPTION;
          public          postgres    false    214            �            1259    16439    animaux    TABLE       CREATE TABLE public.animaux (
    id_animal character varying(100) NOT NULL,
    nom character varying(100),
    espece character varying(100),
    naissance date,
    deces date,
    sexe character(1),
    observations text,
    localisation character varying(10)
);
    DROP TABLE public.animaux;
       public         heap    postgres    false            z           0    0    TABLE animaux    ACL     ?   GRANT ALL ON TABLE public.animaux TO "user" WITH GRANT OPTION;
          public          postgres    false    216            �            1259    16571    enclos    TABLE     U  CREATE TABLE public.enclos (
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
    DROP TABLE public.enclos;
       public         heap    postgres    false            {           0    0    TABLE enclos    ACL     >   GRANT ALL ON TABLE public.enclos TO "user" WITH GRANT OPTION;
          public          postgres    false    222            �            1259    16470    especes    TABLE     �   CREATE TABLE public.especes (
    id_espece character varying(50) NOT NULL,
    nom character varying(50),
    sociable boolean,
    observations text,
    dangereux boolean,
    enclos character varying(50)
);
    DROP TABLE public.especes;
       public         heap    postgres    false            |           0    0    TABLE especes    ACL     ?   GRANT ALL ON TABLE public.especes TO "user" WITH GRANT OPTION;
          public          postgres    false    220            �            1259    16639 
   evenements    TABLE     <  CREATE TABLE public.evenements (
    id_evenement integer NOT NULL,
    id_personnel integer,
    id_enclos character varying(50),
    id_espece character varying(50),
    id_animal character varying(100),
    id_type_evenement character varying(20),
    observations text,
    moment timestamp without time zone
);
    DROP TABLE public.evenements;
       public         heap    postgres    false            }           0    0    TABLE evenements    ACL     B   GRANT ALL ON TABLE public.evenements TO "user" WITH GRANT OPTION;
          public          postgres    false    226            �            1259    16638    evenements_id_evenement_seq    SEQUENCE     �   CREATE SEQUENCE public.evenements_id_evenement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.evenements_id_evenement_seq;
       public          postgres    false    226            ~           0    0    evenements_id_evenement_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.evenements_id_evenement_seq OWNED BY public.evenements.id_evenement;
          public          postgres    false    225                       0    0 $   SEQUENCE evenements_id_evenement_seq    ACL     V   GRANT ALL ON SEQUENCE public.evenements_id_evenement_seq TO "user" WITH GRANT OPTION;
          public          postgres    false    225            �            1259    16463    evenements_types    TABLE     ~   CREATE TABLE public.evenements_types (
    id_type_evenement character varying(20) NOT NULL,
    nom character varying(20)
);
 $   DROP TABLE public.evenements_types;
       public         heap    postgres    false            �           0    0    TABLE evenements_types    ACL     H   GRANT ALL ON TABLE public.evenements_types TO "user" WITH GRANT OPTION;
          public          postgres    false    219            �            1259    16454 
   personnels    TABLE     �   CREATE TABLE public.personnels (
    id_personnel integer NOT NULL,
    nom character varying(30),
    prenom character varying(30),
    secu bigint,
    naissance date,
    profession public.fonction,
    username character varying(20)
);
    DROP TABLE public.personnels;
       public         heap    postgres    false    883            �           0    0    TABLE personnels    ACL     B   GRANT ALL ON TABLE public.personnels TO "user" WITH GRANT OPTION;
          public          postgres    false    218            �            1259    16453    personnels_personnel_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personnels_personnel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.personnels_personnel_id_seq;
       public          postgres    false    218            �           0    0    personnels_personnel_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.personnels_personnel_id_seq OWNED BY public.personnels.id_personnel;
          public          postgres    false    217            �           0    0 $   SEQUENCE personnels_personnel_id_seq    ACL     V   GRANT ALL ON SEQUENCE public.personnels_personnel_id_seq TO "user" WITH GRANT OPTION;
          public          postgres    false    217            �            1259    16763    roles    TABLE     W   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20)
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    16762    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    228            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    227            �            1259    16769 
   user_roles    TABLE     ^   CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id integer NOT NULL
);
    DROP TABLE public.user_roles;
       public         heap    postgres    false            �            1259    16775    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(50),
    password character varying(120),
    username character varying(20)
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16774    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    231            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    230            �            1259    16559    zones    TABLE     i   CREATE TABLE public.zones (
    id_zone character varying(50) NOT NULL,
    nom character varying(50)
);
    DROP TABLE public.zones;
       public         heap    postgres    false            �           0    0    TABLE zones    ACL     =   GRANT ALL ON TABLE public.zones TO "user" WITH GRANT OPTION;
          public          postgres    false    221            �           2604    16613    actions id_action    DEFAULT     v   ALTER TABLE ONLY public.actions ALTER COLUMN id_action SET DEFAULT nextval('public.actions_id_action_seq'::regclass);
 @   ALTER TABLE public.actions ALTER COLUMN id_action DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    16410 !   administrateurs administrateur_id    DEFAULT     �   ALTER TABLE ONLY public.administrateurs ALTER COLUMN administrateur_id SET DEFAULT nextval('public.administrateurs_administrateur_id_seq'::regclass);
 P   ALTER TABLE public.administrateurs ALTER COLUMN administrateur_id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    16642    evenements id_evenement    DEFAULT     �   ALTER TABLE ONLY public.evenements ALTER COLUMN id_evenement SET DEFAULT nextval('public.evenements_id_evenement_seq'::regclass);
 F   ALTER TABLE public.evenements ALTER COLUMN id_evenement DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    16457    personnels id_personnel    DEFAULT     �   ALTER TABLE ONLY public.personnels ALTER COLUMN id_personnel SET DEFAULT nextval('public.personnels_personnel_id_seq'::regclass);
 F   ALTER TABLE public.personnels ALTER COLUMN id_personnel DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    16766    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16778    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230    231            e          0    16610    actions 
   TABLE DATA           v   COPY public.actions (id_action, id_personnel, id_enclos, id_espece, id_animal, date_prevue, observations) FROM stdin;
    public          postgres    false    224   �p       \          0    16407    administrateurs 
   TABLE DATA           \   COPY public.administrateurs (administrateur_id, nom, prenom, date_de_naissance) FROM stdin;
    public          postgres    false    215   �v       ]          0    16439    animaux 
   TABLE DATA           m   COPY public.animaux (id_animal, nom, espece, naissance, deces, sexe, observations, localisation) FROM stdin;
    public          postgres    false    216   �v       c          0    16571    enclos 
   TABLE DATA           �   COPY public.enclos (id_enclos, nom, zone_geo, superficie, coordonnees, temperature_bassin_mini, temperature_bassin_maxi, temperature_air, hygrometrie) FROM stdin;
    public          postgres    false    222   �{       a          0    16470    especes 
   TABLE DATA           \   COPY public.especes (id_espece, nom, sociable, observations, dangereux, enclos) FROM stdin;
    public          postgres    false    220   �       g          0    16639 
   evenements 
   TABLE DATA           �   COPY public.evenements (id_evenement, id_personnel, id_enclos, id_espece, id_animal, id_type_evenement, observations, moment) FROM stdin;
    public          postgres    false    226   ��       `          0    16463    evenements_types 
   TABLE DATA           B   COPY public.evenements_types (id_type_evenement, nom) FROM stdin;
    public          postgres    false    219   ݒ       _          0    16454 
   personnels 
   TABLE DATA           f   COPY public.personnels (id_personnel, nom, prenom, secu, naissance, profession, username) FROM stdin;
    public          postgres    false    218   ��       i          0    16763    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    228   x�       j          0    16769 
   user_roles 
   TABLE DATA           6   COPY public.user_roles (user_id, role_id) FROM stdin;
    public          postgres    false    229   ��       l          0    16775    users 
   TABLE DATA           >   COPY public.users (id, email, password, username) FROM stdin;
    public          postgres    false    231   ��       b          0    16559    zones 
   TABLE DATA           -   COPY public.zones (id_zone, nom) FROM stdin;
    public          postgres    false    221   c�       �           0    0    actions_id_action_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.actions_id_action_seq', 83, true);
          public          postgres    false    223            �           0    0 %   administrateurs_administrateur_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.administrateurs_administrateur_id_seq', 1, false);
          public          postgres    false    214            �           0    0    evenements_id_evenement_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.evenements_id_evenement_seq', 418, true);
          public          postgres    false    225            �           0    0    personnels_personnel_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.personnels_personnel_id_seq', 21, true);
          public          postgres    false    217            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 6, true);
          public          postgres    false    227            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 6, true);
          public          postgres    false    230            �           2606    16617    actions actions_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id_action);
 >   ALTER TABLE ONLY public.actions DROP CONSTRAINT actions_pkey;
       public            postgres    false    224            �           2606    16412 $   administrateurs administrateurs_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_pkey PRIMARY KEY (administrateur_id);
 N   ALTER TABLE ONLY public.administrateurs DROP CONSTRAINT administrateurs_pkey;
       public            postgres    false    215            �           2606    16445    animaux animaux_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.animaux
    ADD CONSTRAINT animaux_pkey PRIMARY KEY (id_animal);
 >   ALTER TABLE ONLY public.animaux DROP CONSTRAINT animaux_pkey;
       public            postgres    false    216            �           2606    16608    enclos enclos_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.enclos
    ADD CONSTRAINT enclos_pkey PRIMARY KEY (id_enclos);
 <   ALTER TABLE ONLY public.enclos DROP CONSTRAINT enclos_pkey;
       public            postgres    false    222            �           2606    16476    especes especes_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.especes
    ADD CONSTRAINT especes_pkey PRIMARY KEY (id_espece);
 >   ALTER TABLE ONLY public.especes DROP CONSTRAINT especes_pkey;
       public            postgres    false    220            �           2606    16646    evenements evenements_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_pkey PRIMARY KEY (id_evenement);
 D   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_pkey;
       public            postgres    false    226            �           2606    16467 &   evenements_types evenements_types_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.evenements_types
    ADD CONSTRAINT evenements_types_pkey PRIMARY KEY (id_type_evenement);
 P   ALTER TABLE ONLY public.evenements_types DROP CONSTRAINT evenements_types_pkey;
       public            postgres    false    219            �           2606    16459    personnels personnels_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_pkey PRIMARY KEY (id_personnel);
 D   ALTER TABLE ONLY public.personnels DROP CONSTRAINT personnels_pkey;
       public            postgres    false    218            �           2606    16796 "   personnels personnels_username_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_username_key UNIQUE (username);
 L   ALTER TABLE ONLY public.personnels DROP CONSTRAINT personnels_username_key;
       public            postgres    false    218            �           2606    16768    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    228            �           2606    16712    personnels secunik 
   CONSTRAINT     M   ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT secunik UNIQUE (secu);
 <   ALTER TABLE ONLY public.personnels DROP CONSTRAINT secunik;
       public            postgres    false    218            �           2606    16784 !   users uk6dotkott2kjsp8vw4d0m25fb7 
   CONSTRAINT     ]   ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7;
       public            postgres    false    231            �           2606    16782 !   users ukr43af9ap4edm43mmtq01oddj6 
   CONSTRAINT     `   ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT ukr43af9ap4edm43mmtq01oddj6;
       public            postgres    false    231            �           2606    16773    user_roles user_roles_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public            postgres    false    229    229            �           2606    16780    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    231            �           2606    16570    zones zones_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id_zone);
 :   ALTER TABLE ONLY public.zones DROP CONSTRAINT zones_pkey;
       public            postgres    false    221            �           2606    16633    actions actions_id_animal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animaux(id_animal);
 H   ALTER TABLE ONLY public.actions DROP CONSTRAINT actions_id_animal_fkey;
       public          postgres    false    216    224    3234            �           2606    16623    actions actions_id_enclos_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_enclos_fkey FOREIGN KEY (id_enclos) REFERENCES public.enclos(id_enclos);
 H   ALTER TABLE ONLY public.actions DROP CONSTRAINT actions_id_enclos_fkey;
       public          postgres    false    224    222    3248            �           2606    16628    actions actions_id_espece_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_espece_fkey FOREIGN KEY (id_espece) REFERENCES public.especes(id_espece);
 H   ALTER TABLE ONLY public.actions DROP CONSTRAINT actions_id_espece_fkey;
       public          postgres    false    224    3244    220            �           2606    16618 !   actions actions_id_personnel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_id_personnel_fkey FOREIGN KEY (id_personnel) REFERENCES public.personnels(id_personnel);
 K   ALTER TABLE ONLY public.actions DROP CONSTRAINT actions_id_personnel_fkey;
       public          postgres    false    224    3236    218            �           2606    16749    especes enclos_lien    FK CONSTRAINT     �   ALTER TABLE ONLY public.especes
    ADD CONSTRAINT enclos_lien FOREIGN KEY (enclos) REFERENCES public.enclos(id_enclos) MATCH FULL NOT VALID;
 =   ALTER TABLE ONLY public.especes DROP CONSTRAINT enclos_lien;
       public          postgres    false    222    220    3248            �           2606    16574    enclos enclos_zone_geo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enclos
    ADD CONSTRAINT enclos_zone_geo_fkey FOREIGN KEY (zone_geo) REFERENCES public.zones(id_zone);
 E   ALTER TABLE ONLY public.enclos DROP CONSTRAINT enclos_zone_geo_fkey;
       public          postgres    false    221    3246    222            �           2606    16662 $   evenements evenements_id_animal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animaux(id_animal);
 N   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_id_animal_fkey;
       public          postgres    false    3234    216    226            �           2606    16652 $   evenements evenements_id_enclos_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_enclos_fkey FOREIGN KEY (id_enclos) REFERENCES public.enclos(id_enclos);
 N   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_id_enclos_fkey;
       public          postgres    false    226    3248    222            �           2606    16657 $   evenements evenements_id_espece_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_espece_fkey FOREIGN KEY (id_espece) REFERENCES public.especes(id_espece);
 N   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_id_espece_fkey;
       public          postgres    false    3244    226    220            �           2606    16647 '   evenements evenements_id_personnel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_personnel_fkey FOREIGN KEY (id_personnel) REFERENCES public.personnels(id_personnel);
 Q   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_id_personnel_fkey;
       public          postgres    false    3236    226    218            �           2606    16667 ,   evenements evenements_id_type_evenement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.evenements
    ADD CONSTRAINT evenements_id_type_evenement_fkey FOREIGN KEY (id_type_evenement) REFERENCES public.evenements_types(id_type_evenement);
 V   ALTER TABLE ONLY public.evenements DROP CONSTRAINT evenements_id_type_evenement_fkey;
       public          postgres    false    219    226    3242            �           2606    16785 &   user_roles fkh8ciramu9cc9q3qcqiv4ue8a6    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);
 P   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6;
       public          postgres    false    3254    229    228            �           2606    16790 &   user_roles fkhfh9dx7w3ubf1co1vdev94g3f    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES public.users(id);
 P   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f;
       public          postgres    false    3262    231    229            �           2606    16797    personnels username    FK CONSTRAINT     �   ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT username FOREIGN KEY (username) REFERENCES public.users(username) NOT VALID;
 =   ALTER TABLE ONLY public.personnels DROP CONSTRAINT username;
       public          postgres    false    3260    231    218            e   �  x��YKr�8]�S�&�L}9�,g�lc7�*� ���9�b�!PA�#�����^��,�p�|��}���K� x����{.3&3)RШ�L���)_ʢ�o��~�}�v�m�teq_H?���h�PV4s����X8`���\w]�<֏��h3fRi9moد��>޹��A<ŕ1v�ׯ�Ɠ^�������2:䒫9\���k��k���S^w���� '��[<Cӷ��L��J��#�gn9��0�*rz���o���*����l�v���H�frm�c��m�/w?�����'|���OyI�e[Wm�K��˫����	Kب�{W������� �KT0����
��4�S�m2��|��9PЗ�) C:{��^ʰ~F!�)NE����"��3h���r*��CG�I�
�{��\>�Y���������@��{���9��E�v���!�<%
��F�~vPf��8uU7+�*+��?�H�1C�"��p?�	�$����T	��n��W|�,&��n�b�C����S�-����!���h0���*�N"(�T�C@��_��`�BܻB?�\1��*"s?G���PH��� �n��]����1�S�=�mo�:.���<���Υ꫏Aaiiq��r���\���'��v���Tʍa�%T6�(8D�0E���A\p�&
 ֟�İ�>�kFF.!"�P�sTw0e`�67$9���Q~�My9?�/M���?�E������(�ǰ�&g�S����AV�
�$����8"J�"�jY��v�l�O���T'p҃H� ��NU���֕��B|�c��׾�g?�s����W=�*8U/a��}���SҖD��| �Z�M^��e�o����m��ڗ�$������N~���'�sѫ���3�}y�/B�NUt�~r��3�kюIᵪ/I���ũ�L�T�y�Wτ*�=�~�Yr���
2n�u�1)����ō��0d�
���vˮ�$�:h��8�ܢH.()�+qP{�qp�Q�T�u* V(��$�C�5p�d��.pX7�BA�V�d�y�:��v�7��ѫ������0"*_���r.S�E�b�QP{���2J�""_� J$ �?]Q�".ڢ���굾4��M���&�}
�	�Ƶ��_=#��R��^,	��r�+x�@�^��h����&>��(���!?@7�c1��12����pH���	������!Uco�����c��5�9VkK�a4}HւQ�KIꆡ����
�(8׈�80s2K-4��hCOGjw���Ӑ�[��*7q �(J
��u�t��H�k��P}�[�:2�ч�����Xt�!�騼g�`�\eL�y5�1��z�Tl Юb�\���&�l�4cРL�#�s66PWO9��)Ƌ0{�M$n6�3��r)��.(	�o<6�4��o�������      \      x������ � �      ]   !  x�mWKr�6]C���"1��2*ˎ��vEqRNyӜ��0A��G��8�99�.�n �-�5�� ��ׯ[=(x���y� [�	�s�g�:�[���%؋�t�EkZ�>���]�M�o3^����_�K��fo�=o�f�e�/���}�a�-֠f��H�+�@��� �At�3��ʊ<���QA��/w��0�̊U|��vcơw�`�v���o��K�vE:�@�ζ��'`�[<�ӭ��/�s54R�'����L]�'��F�cn��]�Ȯ��Kn���p�����Z�l<���f�����߲��C=5��wG%��7���za�}P�E#����8Ƿ��c���^�ީ5x����)"�2�S/�=�;�O��&�EV������b]c�<��`�0�}k���NuS,����P���R�6�T��=er�&.9;���Bǒ��/)�EB�F��ܛ��N�]���;�2���t��x�Oξ�Q!��[�{/��kx�$�0�P��@Dan�,���$*�w�"���L���P�z?y[*��:�"ί��~mQA��y��ص�]5�[��kN����Ϳ�>+Ae߀�?/���t�Eǲ,�,Bz��IAW�:���g�Ȁ���*qm+��m��OP�^I�8|/�rT��3����	�2<f�D{��;�5�,>3�N���h#��ڶ�b?P�;P�v{v}^���I#�cĨ[3���C	��T�I:,}5��O�p8��,>`���u�"���G��`J�efS;vж��C�%�K��Ə���8-�o�=�*�=	��'��il��&}Q���m��$B�]*udZ�yS��8�)1�W٥+sߏØ��D~�H��"ܔS��Z�4`��D�i}k��e�(ulZ��Go�]����[Z��R����%ü�Wz�e2��c3`����F��m<~:��ͩ���lQ������	���3I��0L"r�B���[�����'=����A�ʙ�~����[��

�9��S�|�qI#��b[��Gq�D�H
vEpv�,M��W8g5vvG�W7���4*��U�6~WcF�"i��q�08�V�@�l�O9^���j�q?�g�H�Ln�9O$g$��b�lO�]L?jl��L���:��f:��SXc�o�5J�ii�E�/v�n
Ь;�Wq�H�!��o4��Z=�p�`61*��nR�x~�V��yz;v�D~�u�$�J �������_�R� �lx�(�)��{!�q;�UR��茝j��4��ן...�a�g      c   �  x����n�F���Sx�Md�93g.�iw-
�ʛ�E�D$R��Hߨ�k����3�DVF�$�6��8�}���7��vůM��O�-����q:������rS7��`Q�0����*x����Ί�$��fW��>�o���ڵ傒��Ue��ɰsT���ɲ�ĬD��ˇ�ƪ۴OU�<�m��M�d>��_Gyb���	��՜�+�k�����.7O��T dab����rh�cY�?������ƊL(�A;'�,�`����W�$���m��d`�]�d&�3ZH�: GoP���� ���E�/�}ܕ��i�9�c|JI�J���{�e��)�	��d��E1�49c�|���r6_�����~5���,t�%^�����@���)!B���a����TuM�����k"3�H���v
�qA<�&�V���Պ���+f��8B~��)뢜q��!�<_e4CߖKJ������R�6G��N�دZ=S���b����ι�]M�#n:X�'�C+�^���V�a6�1U l���$'�,;�u�����'���Sr4cd\p.{�v��n���8[�H�
�-"�ؠ-Zħ����x|��MA����HȜx1�LN�'�ykc�Y��[x7#�ǻ�c�sA�%)�t�P&�"vA�08�r "����c��q�w�2�:�PE������iX���^:�)��CՕ�C����+~����c��ɡy.X��jL�<�B���<~\�5eZ�¤� �ǧ�y���I�>F�qK�q�R|x�:
���U��'��e�t�6Kw��YcaL`,O6�9�;Ħ��B>���jEVa�k7�\ Uu�2��eQe��Zò�b-�S�8�;��´���:&�qa<	ך����4�q'�e R�,\��`�aAq��^��.�U�X�}i��iGC@�0�Ѓb͂rwss�/�]��      a   �  x�}SKn�0]S���;$E�t��ȢȆ�mal��g��D�9r�R�L�L�!���I��hz�ܼ����=9��9ԸS��&�$�cK��!�0xځࢂ��l} ��]I6��S�)�f4{��dK�\-�B�V2$���[)�p�h`��6����);h�-Yv�-��?�&��]s)�4_�+��>��ajp"��5.�Վ.�/�paO"5YZj�A>1���.�:�Y~�=���g�֥�j��L�hd	�P�b��1�-l}Hh9@	����h\˭��(W"�ug1X��,�娩N�(�����j��rv��n-ɬS4�<��pU���:�QK��n 1��Q����W����RX�����a㱗\�W�O��h֊�H�=I�Η��j�sv��o@�-v�ٝ^���{#����7��qB�DS��y%���eK��92�ԄF��p[|Q���Qh'�M�V�.Z���-�ྂe��;��vr�ɞo��R�/�z��      g      x��\ˎ��]����&	�f���&� �k�Ye�V�۴�R�(ulM�F>�?�s��DI��"��ܰ��u߯�`~���_�M��M��'��<���պ�'��x���&BL�
�j���w����|�Y������9�pҤFH'<N�������<�|J�2%�38'��>/>M��<�兣6��	F(e}t�>{Y���,��?�D*�7^⤚����*{�'7���?ٗ�~*|j�v��B��ĉ�E�n��%[�,��>�>M���OV���@9Uf�]ʵ���%J^�Yp�Ӫ�q�V,��<K�	>�s	cS&�\�V+8����<d�7E��{����5Q~�</WO�������*��9��O�N�����?��2��e�-��l�))��$\���2)��S��?�o^���S�)�=��y��'E�=��y�����ͪL���UY��MGv�X>d�������l}�sg�E}V8����*kk�U!8$�V�e�b��.{Ƀ�+7��ƻ.^6�l], �Wɷ�$P���kʐp�M�8���e0�Ǽ�W렮9d6�h������O8��N5K�Z �Q@��yYfE �r�-��T1@���_�`.U�8	S�:l��
G#[o���%�>��iO3���=�?�����[��#�o�d�^�!�TzP�v�Y��V�Ư� �o_���3�e��%��u8*O�����S��)��9{*���=�Ivb�INn�<T�²J�q<�3D����o��H9���7�I����q޹�C�Y<� �|�^~��%��'��kY'Y3`�9B�3��<eH��n�h�D�㷯������������H� A@Xڝ�ò��,FO����`��AWU�­�ʽ�*ec���{VN��%.�(���Y�(�)��m*��ɇ�������SǨ$���U����P��Zb����`b��Bk^�#)��:	���6Rr�VGX����,�?�ݔ)hTj���UZB��@�jHy�}�!+_I�l����@:+^�5�6��B��k�2�uN<qP�(�d�������`�di$���)���u�R.W�|(����.�����z��h���Y�����O92	�� �\'�?��U�5-Ҩ@��x���ë�^��@IREṥ�и�Ȑ6�$9�[��,�����O9��o_�v>W@�խ����[ڕ�q��q�C*5 ry�RI����		�$�9��}w�݅��K~�M>5-�yRk��PJ	�U6bP� y8��*�C�;w��ͧ�Dj��2p��}\�#O�\Ro�ř��㵡�*5�3Ł�(s��/o�֫T�\���
�:J{PM:	C���K��**|ҧ�(gܝ-n�K�����,®c�4�u�!���y0>���w~}1�謁�P�yU�����i(�Y*��Vܙ��<������l�->^����n��dGU1+Z����ޑ?�q7~��8�Ʃ�ʹ�#�_><E'�6$�R�;>�Fjh����*��`V̓
�o_k`<t�X�L<U�*)�����C+`���x�N=��`M^7�^�BK����}~U�ɑ�S!�GJ�k;����� �k-����֐"�ʩ��.E�%�kp��LYQ�[�/�Y�Z��Ə-���^D%-Y��*S��ı�R�Th��q��6,R�F{�k��m�� ǥ^IG��I������~RPi�zE�28�R���Q����<�ª��4�[�-TsM��=s����K$ѫ���D-���������W}ʊ��N��jI��`F+(����T�^{�3Ԯl�m(!�
$�B]���)�/��ݵ�\��ګlخv�p(�諱T>�>�[Gf���6JO ����BBE���E@��Y�FB��	w�f�H�=g� 
bD`MӔ�	��*$nBJ$R�2q���"�-�-�.�W��~��?���w�J�7Q�NĽ�{^�N5�*�@�;[$b4��A�f��Pc�jN�7�z���=U�K�zHG�g8�0��
q�:kQ&��{E����Ցh�5�4"4�����\a�JJ��x^��4�kFH�%��DJ�!ME*�i�r�W@���;�&�M��8iu�� \�¥ڈ}�\SO
y�O�5U�,b��c�nd����'?����jG���?6bo�-��s!s����#���"�!�!�N�N9�`lVA��-2�)�wMর�,�+�s
�:txz5aQ�+�p����4�B�Q� U�i��f��5M9�Geܵ�����P���������� }���i��Z�s��y�rYG*V~O�}���'wJԠ�ж�g`��5E}��#,|p�͠()�,�,�:�Z����JO�5������1h�6A�v�%*���")&�vB�F@!nln*�
�jR��v��"�.g7��%�B@�9?���N�Ǟ��7����}򧊶ku#P��4�����h쭴f�G�����VK��Gx*�E����A!�N��N�������ʒS�#��ؙ*�`A�<�#�rS�)�4���,n�.j<�S^i���X�l��9���-�mq��*M}RDS�"�{VO���}�Z}�����<���]�=a�*7�hK�
���}aH�����O�@)���!�0�C�м]'o�-�|���<�����8��I��w?쏙��m�`�
�������
��ح�i��i8�-# n�1�8g�<�v��55
X�_O�bQ�>n�ˇ��3z9qI$!HЙ<wT�/��QE�+2{���K��ɌG���D3% �� �QI����g��1f)ÃT�=f[�9�Tx��p`�>;2ϳQ�zgw�33����B��-�U�G}�V�lj�` y�K^���r��3�0k䒆�Մi�*F����ZW�0+��#�����e����:N���ࡲ
�D"��>fb���@&�/;L�bW�����j��	Qғ��[�T��si�hy6|.2��A�`R�����$�����mM�+5Lj��Jޤ�"�U*���d�g
}�5`C��<��*㝞u'f���N�ӚjF9��L������d�i?�Q!�Sƃ2Sr+�Zv�����_�+Ҙ2����`�Ӕ��%u�u=l��ǆ$��[ņ���{l(-n�̯���}#�Z؁ޫB�^�,� ��;3a�l�����<�B�a�r+M�n�m�~�Ei�d�G��T#-_wo�_p�5i��f���{sB�ԛ����������F��;b{gc:��QC-�V=N���KC}���F��4B�HxUz����x�GG�hR���.�q��n����{!8V�)D+�Qbo��:-{�TZ|�؃��4�_��	2Ґ��$�p}.Rμ�**����?P�B'9��3��Q�2��;�ߟ� I~�Z������ �q0���eM;�Ҍ�ݏ�h��i��?�����6
`i~���l�Jn������CDt�թx5�qխd��*���/_M�K�8�aUF�v�JĿ'���D�r��}�o�-R!�I���|h'�yEC����9�g����`��^�ސ��%�]PT�T/�/a{.�y�~�♢xV��-��䏁�N���~0���r�v�n�~�hoJS2e�^m8��N2z�tQ�vK��s�zE��7՝�	������+n�j;<��X2���(E���}�f��9ƪp	Q*�<�e:<���Z��T�w
>1��94�!l6����-w�,�i��R�"7����Q�0޳ZY�#��^Q�q�S�^�n�B��"�6JѾbl��w�4���o�mv>��E�ٞ�$����U��Z1��PF�i/i�)�UC��u%,U� ӟ��L�f��I�vĉ��6�%�R�sՑǻ�;����~�V���Z��M�􂪻�W���ش���������^3g�g����t
/��_�0J�#����1u���6@����w;l�sʓ|g/7�eT� �HO�����iP�졝?vA׬>w�:��/�����s�\0zR.C��	���N�3'�2�ϵ`�~v	���MR*�,�)�x�m�O3ׯxׂЧ�W�@{�q}�BXtX T��r,�f�'   �52C��F0�C@6r��H뜤�,�E��a���O��*�,��?�?�f��
�:�Vw^�o�]��2E{��즏k��Șv̐�����뺔Uy;]
у��/�{5��!\v�ߋ�\4aV[�ڥ�:�����	�Ý��<�/�B���ˋ�f����k*�\4�� �mӏJ)Sϼt��>��)���B�gx����h�$�y�h��.>�MC�&�V[����䈁��X0DL6_��>d�E���,�U�Z�VB��J�����ʍ      `   �   x�EPK�@]�����[b$q��4сLo$��b��a���v�o8��g�yb�.ea���)�*��έK�Z�U�,��EY���1�7�`��V8�S��j���]:"����R:�.j�c8���43����<%����iWH���k�?�e�+{�)T\�E=��x���X���vk      _   �  x�e�ݎ�@��=�Ȟ�O�]R���v+U���0RH�$��#�s�����j"�|>>6�b�1�0�b7�^�=Hg���Hd�)�\i3t!���Ū����T�}~��B2&4M�¦��2E[��V�?�X�!e��)}���P����Ǳ��Ē�� ?�������~-��I+4l¾��b�	a�hMDJ�d�ǐ�ToSi~����CS��S�<v��4�!*IN�d����;e�����n�=��α�U�A#K�8�%7��V��z��=|�~|[�*������e=<�b�1딩a�,PI#HDL�H�r3��jD8�8���g�yu�$�8kI�Ȥ�hӪ�o*��
\6�͹�'�o���'o��S^.x�>W��j��V����&S������'�^�����o�Q�ড��|x�>q_���X�4���y����Z�=B�i��%      i   3   x�3���q���t�s�2���\�����|\��!Ba�!�\1z\\\ l$      j   3   x���  ��x�va�9�$�au��4�ï����Mu�2�E��G�      l   U  x����R�0�s�=��͖ڪTжS��%%�FM�8�>�Tg*7庇�wv��/��ʔ ��=�7�i:��c�G�`��LL�z{�!�>�	9N�:�X��SW�oz@���8RO^�C+����o�Y�ʐ��4M|�+��	DdynFi|@��A����8�^.�j;����ղZ`�>�j�Y"Q�ԳT{��
=[�V1��'���h8�zcM�P�LeX����m�
/@F�=�\2$���DҞ�:. 1��.ۙч~��M�m@��L��gD��挄�,r�Fdۮ��1���Ti�^��N���N�hI�Lu��o䉂�B���L�      b   �   x�M�=�0���٘�*���R\T)?�N�S��A.FZ������1Id�#�~� ������D�$�z��F�$]���Ь:乲6��g`L%_G|`�N�󻕶s5�)إt�K�R��=���n~��#>J����y�R96�= |�eU�     