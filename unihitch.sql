--
-- PostgreSQL database dump
--

\restrict nHr3g13o3MVm3xMGPjsghP7jntkHTqlaFEyOI8klg1J4eIYJXYIKbnQDP2uXKCJ

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-09 22:42:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 303 (class 1255 OID 40976)
-- Name: crear_wallet_usuario(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crear_wallet_usuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO wallet (id_usuario) VALUES (NEW.id);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.crear_wallet_usuario() OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 57477)
-- Name: limpiar_codigos_expirados(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.limpiar_codigos_expirados() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM codigos_verificacion_email 
    WHERE fecha_expiracion < NOW() - INTERVAL '1 day';
    
    DELETE FROM intentos_verificacion_email 
    WHERE fecha_intento < NOW() - INTERVAL '30 days';
END;
$$;


ALTER FUNCTION public.limpiar_codigos_expirados() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 290 (class 1259 OID 57479)
-- Name: alerta_emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerta_emergencia (
    id integer NOT NULL,
    id_usuario integer,
    latitud numeric(10,8) NOT NULL,
    longitud numeric(11,8) NOT NULL,
    fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'ENVIADA'::character varying
);


ALTER TABLE public.alerta_emergencia OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 57478)
-- Name: alerta_emergencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alerta_emergencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alerta_emergencia_id_seq OWNER TO postgres;

--
-- TOC entry 5688 (class 0 OID 0)
-- Dependencies: 289
-- Name: alerta_emergencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alerta_emergencia_id_seq OWNED BY public.alerta_emergencia.id;


--
-- TOC entry 219 (class 1259 OID 40977)
-- Name: badge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.badge (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    nombre_badge character varying(50) NOT NULL,
    fecha_obtencion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.badge OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 40984)
-- Name: badge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.badge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.badge_id_seq OWNER TO postgres;

--
-- TOC entry 5689 (class 0 OID 0)
-- Dependencies: 220
-- Name: badge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.badge_id_seq OWNED BY public.badge.id;


--
-- TOC entry 221 (class 1259 OID 40985)
-- Name: calificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calificacion (
    id integer NOT NULL,
    id_viaje integer,
    id_autor integer,
    id_destinatario integer,
    puntuacion integer,
    comentario text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT calificacion_puntuacion_check CHECK (((puntuacion >= 1) AND (puntuacion <= 5)))
);


ALTER TABLE public.calificacion OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 40993)
-- Name: calificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calificacion_id_seq OWNER TO postgres;

--
-- TOC entry 5690 (class 0 OID 0)
-- Dependencies: 222
-- Name: calificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calificacion_id_seq OWNED BY public.calificacion.id;


--
-- TOC entry 223 (class 1259 OID 40994)
-- Name: carrera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrera (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    id_universidad integer,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.carrera OWNER TO postgres;

--
-- TOC entry 5691 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE carrera; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.carrera IS 'Stores academic careers associated with each university.';


--
-- TOC entry 224 (class 1259 OID 41001)
-- Name: carrera_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrera_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrera_id_seq OWNER TO postgres;

--
-- TOC entry 5692 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrera_id_seq OWNED BY public.carrera.id;


--
-- TOC entry 225 (class 1259 OID 41002)
-- Name: chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat (
    id integer NOT NULL,
    id_usuario1 integer NOT NULL,
    id_usuario2 integer NOT NULL,
    ultimo_mensaje text,
    fecha_ultimo_mensaje timestamp without time zone,
    no_leidos_usuario1 integer DEFAULT 0,
    no_leidos_usuario2 integer DEFAULT 0
);


ALTER TABLE public.chat OWNER TO postgres;

--
-- TOC entry 5693 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE chat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.chat IS 'Chats entre usuarios';


--
-- TOC entry 226 (class 1259 OID 41012)
-- Name: chat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chat_id_seq OWNER TO postgres;

--
-- TOC entry 5694 (class 0 OID 0)
-- Dependencies: 226
-- Name: chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_id_seq OWNED BY public.chat.id;


--
-- TOC entry 286 (class 1259 OID 57437)
-- Name: codigos_verificacion_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codigos_verificacion_email (
    id integer NOT NULL,
    id_usuario integer,
    codigo character varying(6) NOT NULL,
    email character varying(255) NOT NULL,
    usado boolean DEFAULT false,
    intentos_fallidos integer DEFAULT 0,
    fecha_creacion timestamp without time zone DEFAULT now(),
    fecha_expiracion timestamp without time zone DEFAULT (now() + '00:15:00'::interval),
    fecha_uso timestamp without time zone,
    ip_solicitud character varying(45)
);


ALTER TABLE public.codigos_verificacion_email OWNER TO postgres;

--
-- TOC entry 5695 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE codigos_verificacion_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.codigos_verificacion_email IS 'Códigos de 6 dígitos enviados por email para verificación';


--
-- TOC entry 5696 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN codigos_verificacion_email.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codigos_verificacion_email.codigo IS 'Código de 6 dígitos numéricos';


--
-- TOC entry 5697 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN codigos_verificacion_email.intentos_fallidos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codigos_verificacion_email.intentos_fallidos IS 'Contador de intentos fallidos para prevenir ataques de fuerza bruta';


--
-- TOC entry 285 (class 1259 OID 57436)
-- Name: codigos_verificacion_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.codigos_verificacion_email_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.codigos_verificacion_email_id_seq OWNER TO postgres;

--
-- TOC entry 5698 (class 0 OID 0)
-- Dependencies: 285
-- Name: codigos_verificacion_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.codigos_verificacion_email_id_seq OWNED BY public.codigos_verificacion_email.id;


--
-- TOC entry 227 (class 1259 OID 41013)
-- Name: comprobante_recarga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comprobante_recarga (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo character varying(20) NOT NULL,
    numero_operacion character varying(50),
    imagen_comprobante text NOT NULL,
    estado character varying(20) DEFAULT 'COMPLETADA'::character varying,
    fecha_solicitud timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    observaciones text,
    tipo_recarga character varying(20) DEFAULT 'TRANSFERENCIA'::character varying,
    CONSTRAINT comprobante_recarga_tipo_recarga_check CHECK (((tipo_recarga)::text = ANY (ARRAY[('TRANSFERENCIA'::character varying)::text, ('TARJETA'::character varying)::text])))
);


ALTER TABLE public.comprobante_recarga OWNER TO postgres;

--
-- TOC entry 5699 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE comprobante_recarga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.comprobante_recarga IS 'Comprobantes de recarga con Yape/Plin';


--
-- TOC entry 228 (class 1259 OID 41027)
-- Name: comprobante_recarga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comprobante_recarga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comprobante_recarga_id_seq OWNER TO postgres;

--
-- TOC entry 5700 (class 0 OID 0)
-- Dependencies: 228
-- Name: comprobante_recarga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comprobante_recarga_id_seq OWNED BY public.comprobante_recarga.id;


--
-- TOC entry 229 (class 1259 OID 41028)
-- Name: conductor_favorito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conductor_favorito (
    id integer NOT NULL,
    id_usuario integer,
    id_conductor integer,
    fecha_agregado timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conductor_favorito OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 41033)
-- Name: conductor_favorito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conductor_favorito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conductor_favorito_id_seq OWNER TO postgres;

--
-- TOC entry 5701 (class 0 OID 0)
-- Dependencies: 230
-- Name: conductor_favorito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conductor_favorito_id_seq OWNED BY public.conductor_favorito.id;


--
-- TOC entry 231 (class 1259 OID 41034)
-- Name: configuracion_emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuracion_emergencia (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    auto_envio_ubicacion boolean DEFAULT false,
    notificar_universidad boolean DEFAULT true,
    grabar_audio boolean DEFAULT false,
    alertas_velocidad boolean DEFAULT false
);


ALTER TABLE public.configuracion_emergencia OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 41043)
-- Name: configuracion_emergencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configuracion_emergencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configuracion_emergencia_id_seq OWNER TO postgres;

--
-- TOC entry 5702 (class 0 OID 0)
-- Dependencies: 232
-- Name: configuracion_emergencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configuracion_emergencia_id_seq OWNED BY public.configuracion_emergencia.id;


--
-- TOC entry 233 (class 1259 OID 41044)
-- Name: confirmaciones_pago_efectivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.confirmaciones_pago_efectivo (
    id integer NOT NULL,
    id_reserva integer,
    id_conductor integer,
    id_pasajero integer,
    monto numeric(10,2) NOT NULL,
    fecha_confirmacion timestamp without time zone DEFAULT now(),
    ubicacion_lat numeric(10,8),
    ubicacion_lng numeric(11,8),
    comentarios text
);


ALTER TABLE public.confirmaciones_pago_efectivo OWNER TO postgres;

--
-- TOC entry 5703 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE confirmaciones_pago_efectivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.confirmaciones_pago_efectivo IS 'Registro de confirmaciones de pagos en efectivo para auditoría';


--
-- TOC entry 234 (class 1259 OID 41052)
-- Name: confirmaciones_pago_efectivo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.confirmaciones_pago_efectivo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.confirmaciones_pago_efectivo_id_seq OWNER TO postgres;

--
-- TOC entry 5704 (class 0 OID 0)
-- Dependencies: 234
-- Name: confirmaciones_pago_efectivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.confirmaciones_pago_efectivo_id_seq OWNED BY public.confirmaciones_pago_efectivo.id;


--
-- TOC entry 235 (class 1259 OID 41053)
-- Name: contacto_emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacto_emergencia (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    telefono character varying(20) NOT NULL,
    relacion character varying(50),
    activo boolean DEFAULT true
);


ALTER TABLE public.contacto_emergencia OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 41061)
-- Name: contacto_emergencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacto_emergencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacto_emergencia_id_seq OWNER TO postgres;

--
-- TOC entry 5705 (class 0 OID 0)
-- Dependencies: 236
-- Name: contacto_emergencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacto_emergencia_id_seq OWNED BY public.contacto_emergencia.id;


--
-- TOC entry 292 (class 1259 OID 57497)
-- Name: contactos_emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contactos_emergencia (
    id integer NOT NULL,
    id_usuario integer,
    nombre character varying(100) NOT NULL,
    telefono character varying(20) NOT NULL,
    relacion character varying(50),
    es_principal boolean DEFAULT false,
    fecha_creacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.contactos_emergencia OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 57496)
-- Name: contactos_emergencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contactos_emergencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contactos_emergencia_id_seq OWNER TO postgres;

--
-- TOC entry 5706 (class 0 OID 0)
-- Dependencies: 291
-- Name: contactos_emergencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contactos_emergencia_id_seq OWNED BY public.contactos_emergencia.id;


--
-- TOC entry 237 (class 1259 OID 41062)
-- Name: cuenta_recepcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_recepcion (
    id integer NOT NULL,
    tipo character varying(20) NOT NULL,
    numero_celular character varying(20) NOT NULL,
    nombre_titular character varying(100) NOT NULL,
    qr_code text,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cuenta_recepcion OWNER TO postgres;

--
-- TOC entry 5707 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE cuenta_recepcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cuenta_recepcion IS 'Cuentas de Yape/Plin para recibir pagos';


--
-- TOC entry 238 (class 1259 OID 41073)
-- Name: cuenta_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_recepcion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuenta_recepcion_id_seq OWNER TO postgres;

--
-- TOC entry 5708 (class 0 OID 0)
-- Dependencies: 238
-- Name: cuenta_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_recepcion_id_seq OWNED BY public.cuenta_recepcion.id;


--
-- TOC entry 239 (class 1259 OID 41074)
-- Name: cupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupon (
    id integer NOT NULL,
    codigo character varying(50) NOT NULL,
    tipo character varying(20) NOT NULL,
    valor numeric(10,2) NOT NULL,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion timestamp without time zone,
    usos_maximos integer,
    usos_actuales integer DEFAULT 0,
    activo boolean DEFAULT true,
    id_creador integer,
    CONSTRAINT cupon_tipo_check CHECK (((tipo)::text = ANY (ARRAY[('PORCENTAJE'::character varying)::text, ('MONTO_FIJO'::character varying)::text])))
);


ALTER TABLE public.cupon OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 41087)
-- Name: cupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cupon_id_seq OWNER TO postgres;

--
-- TOC entry 5709 (class 0 OID 0)
-- Dependencies: 240
-- Name: cupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cupon_id_seq OWNED BY public.cupon.id;


--
-- TOC entry 241 (class 1259 OID 41088)
-- Name: cupon_uso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupon_uso (
    id integer NOT NULL,
    id_cupon integer,
    id_usuario integer,
    id_viaje integer,
    monto_descuento numeric(10,2),
    fecha_uso timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cupon_uso OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 41093)
-- Name: cupon_uso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cupon_uso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cupon_uso_id_seq OWNER TO postgres;

--
-- TOC entry 5710 (class 0 OID 0)
-- Dependencies: 242
-- Name: cupon_uso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cupon_uso_id_seq OWNED BY public.cupon_uso.id;


--
-- TOC entry 243 (class 1259 OID 41094)
-- Name: documentos_conductor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documentos_conductor (
    id integer NOT NULL,
    id_conductor integer,
    tipo_documento character varying(50) NOT NULL,
    archivo_base64 text NOT NULL,
    nombre_archivo character varying(255) NOT NULL,
    mime_type character varying(100),
    tamanio_kb integer,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    fecha_vencimiento date,
    motivo_rechazo text,
    notas_adicionales text,
    fecha_subida timestamp without time zone DEFAULT now(),
    fecha_revision timestamp without time zone,
    id_revisor integer
);


ALTER TABLE public.documentos_conductor OWNER TO postgres;

--
-- TOC entry 5711 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE documentos_conductor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.documentos_conductor IS 'Almacena documentos de verificación de conductores (SOAT, tarjeta mantenimiento)';


--
-- TOC entry 5712 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN documentos_conductor.archivo_base64; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.documentos_conductor.archivo_base64 IS 'Documento codificado en base64, máximo 5MB recomendado';


--
-- TOC entry 244 (class 1259 OID 41105)
-- Name: documentos_conductor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documentos_conductor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documentos_conductor_id_seq OWNER TO postgres;

--
-- TOC entry 5713 (class 0 OID 0)
-- Dependencies: 244
-- Name: documentos_conductor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documentos_conductor_id_seq OWNED BY public.documentos_conductor.id;


--
-- TOC entry 245 (class 1259 OID 41106)
-- Name: emergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emergencia (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    ubicacion_lat numeric(10,8),
    ubicacion_lng numeric(11,8),
    mensaje text,
    contactos_notificados text[],
    estado character varying(20) DEFAULT 'ACTIVA'::character varying,
    fecha_activacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.emergencia OWNER TO postgres;

--
-- TOC entry 5714 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE emergencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.emergencia IS 'Alertas de emergencia activadas';


--
-- TOC entry 246 (class 1259 OID 41115)
-- Name: emergencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emergencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emergencia_id_seq OWNER TO postgres;

--
-- TOC entry 5715 (class 0 OID 0)
-- Dependencies: 246
-- Name: emergencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emergencia_id_seq OWNED BY public.emergencia.id;


--
-- TOC entry 296 (class 1259 OID 57533)
-- Name: grupos_viaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos_viaje (
    id integer NOT NULL,
    id_organizador integer,
    ruta_comun character varying(200) NOT NULL,
    origen character varying(200),
    destino character varying(200),
    horario_preferido time without time zone,
    dias_semana character varying(50),
    tipo_grupo character varying(50) DEFAULT 'CUALQUIERA'::character varying,
    costo_total numeric(10,2),
    num_pasajeros integer DEFAULT 4,
    costo_por_persona numeric(10,2),
    descripcion text,
    estado character varying(20) DEFAULT 'ABIERTO'::character varying,
    fecha_creacion timestamp without time zone DEFAULT now(),
    fecha_actualizacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.grupos_viaje OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 57532)
-- Name: grupos_viaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupos_viaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grupos_viaje_id_seq OWNER TO postgres;

--
-- TOC entry 5716 (class 0 OID 0)
-- Dependencies: 295
-- Name: grupos_viaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupos_viaje_id_seq OWNED BY public.grupos_viaje.id;


--
-- TOC entry 247 (class 1259 OID 41116)
-- Name: historial_verificacion_conductor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_verificacion_conductor (
    id integer NOT NULL,
    id_conductor integer,
    estado_anterior character varying(20),
    estado_nuevo character varying(20),
    comentario text,
    id_admin integer,
    fecha_cambio timestamp without time zone DEFAULT now()
);


ALTER TABLE public.historial_verificacion_conductor OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 41123)
-- Name: historial_verificacion_conductor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_verificacion_conductor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_verificacion_conductor_id_seq OWNER TO postgres;

--
-- TOC entry 5717 (class 0 OID 0)
-- Dependencies: 248
-- Name: historial_verificacion_conductor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_verificacion_conductor_id_seq OWNED BY public.historial_verificacion_conductor.id;


--
-- TOC entry 288 (class 1259 OID 57457)
-- Name: intentos_verificacion_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intentos_verificacion_email (
    id integer NOT NULL,
    id_usuario integer,
    email character varying(255) NOT NULL,
    codigo_ingresado character varying(6),
    exitoso boolean DEFAULT false,
    fecha_intento timestamp without time zone DEFAULT now(),
    ip_address character varying(45)
);


ALTER TABLE public.intentos_verificacion_email OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 57456)
-- Name: intentos_verificacion_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.intentos_verificacion_email_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.intentos_verificacion_email_id_seq OWNER TO postgres;

--
-- TOC entry 5718 (class 0 OID 0)
-- Dependencies: 287
-- Name: intentos_verificacion_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.intentos_verificacion_email_id_seq OWNED BY public.intentos_verificacion_email.id;


--
-- TOC entry 249 (class 1259 OID 41124)
-- Name: mensaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensaje (
    id integer NOT NULL,
    id_chat integer NOT NULL,
    id_remitente integer NOT NULL,
    mensaje text NOT NULL,
    leido boolean DEFAULT false,
    fecha_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.mensaje OWNER TO postgres;

--
-- TOC entry 5719 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE mensaje; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.mensaje IS 'Mensajes en los chats';


--
-- TOC entry 250 (class 1259 OID 41135)
-- Name: mensaje_comunidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensaje_comunidad (
    id integer NOT NULL,
    id_usuario integer,
    id_universidad integer,
    mensaje text NOT NULL,
    fecha_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.mensaje_comunidad OWNER TO postgres;

--
-- TOC entry 5720 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE mensaje_comunidad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.mensaje_comunidad IS 'Stores messages for the university-specific community forums.';


--
-- TOC entry 251 (class 1259 OID 41143)
-- Name: mensaje_comunidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mensaje_comunidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mensaje_comunidad_id_seq OWNER TO postgres;

--
-- TOC entry 5721 (class 0 OID 0)
-- Dependencies: 251
-- Name: mensaje_comunidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mensaje_comunidad_id_seq OWNED BY public.mensaje_comunidad.id;


--
-- TOC entry 252 (class 1259 OID 41144)
-- Name: mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mensaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mensaje_id_seq OWNER TO postgres;

--
-- TOC entry 5722 (class 0 OID 0)
-- Dependencies: 252
-- Name: mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mensaje_id_seq OWNED BY public.mensaje.id;


--
-- TOC entry 253 (class 1259 OID 41145)
-- Name: metodo_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metodo_pago (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo character varying(20) NOT NULL,
    nombre character varying(50) NOT NULL,
    ultimos_digitos character varying(4),
    es_predeterminado boolean DEFAULT false,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.metodo_pago OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 41155)
-- Name: metodo_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodo_pago_id_seq OWNER TO postgres;

--
-- TOC entry 5723 (class 0 OID 0)
-- Dependencies: 254
-- Name: metodo_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metodo_pago_id_seq OWNED BY public.metodo_pago.id;


--
-- TOC entry 298 (class 1259 OID 57554)
-- Name: miembros_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.miembros_grupo (
    id integer NOT NULL,
    id_grupo integer,
    id_usuario integer,
    fecha_union timestamp without time zone DEFAULT now(),
    estado character varying(20) DEFAULT 'ACTIVO'::character varying
);


ALTER TABLE public.miembros_grupo OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 57553)
-- Name: miembros_grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.miembros_grupo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.miembros_grupo_id_seq OWNER TO postgres;

--
-- TOC entry 5724 (class 0 OID 0)
-- Dependencies: 297
-- Name: miembros_grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.miembros_grupo_id_seq OWNED BY public.miembros_grupo.id;


--
-- TOC entry 255 (class 1259 OID 41156)
-- Name: notificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacion (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    titulo character varying(100) NOT NULL,
    mensaje text NOT NULL,
    tipo character varying(30) NOT NULL,
    leida boolean DEFAULT false,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notificacion OWNER TO postgres;

--
-- TOC entry 5725 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE notificacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.notificacion IS 'Notificaciones del sistema para usuarios';


--
-- TOC entry 256 (class 1259 OID 41168)
-- Name: notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacion_id_seq OWNER TO postgres;

--
-- TOC entry 5726 (class 0 OID 0)
-- Dependencies: 256
-- Name: notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacion_id_seq OWNED BY public.notificacion.id;


--
-- TOC entry 294 (class 1259 OID 57514)
-- Name: notificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificaciones (
    id integer NOT NULL,
    id_usuario integer,
    titulo character varying(200),
    mensaje text,
    fecha_creacion timestamp without time zone DEFAULT now(),
    tipo character varying(50) DEFAULT 'GENERAL'::character varying,
    prioridad character varying(20) DEFAULT 'NORMAL'::character varying,
    datos_adicionales jsonb,
    leida boolean DEFAULT false,
    fecha_lectura timestamp without time zone
);


ALTER TABLE public.notificaciones OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 57513)
-- Name: notificaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificaciones_id_seq OWNER TO postgres;

--
-- TOC entry 5727 (class 0 OID 0)
-- Dependencies: 293
-- Name: notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificaciones_id_seq OWNED BY public.notificaciones.id;


--
-- TOC entry 257 (class 1259 OID 41169)
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo character varying(20) NOT NULL,
    numero character varying(100) NOT NULL,
    nombre_titular character varying(100),
    es_principal boolean DEFAULT false,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion character varying(7),
    cvv_encrypted character varying(255),
    CONSTRAINT payment_method_tipo_check CHECK (((tipo)::text = ANY (ARRAY[('YAPE'::character varying)::text, ('PLIN'::character varying)::text, ('TARJETA'::character varying)::text])))
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 41180)
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_method_id_seq OWNER TO postgres;

--
-- TOC entry 5728 (class 0 OID 0)
-- Dependencies: 258
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_method_id_seq OWNED BY public.payment_method.id;


--
-- TOC entry 259 (class 1259 OID 41181)
-- Name: perfil_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.perfil_usuario AS
SELECT
    NULL::integer AS id,
    NULL::character varying(100) AS nombre,
    NULL::character varying(100) AS correo,
    NULL::character varying(255) AS password,
    NULL::character varying(20) AS telefono,
    NULL::integer AS id_universidad,
    NULL::character varying(100) AS carrera,
    NULL::character varying(20) AS rol,
    NULL::text AS foto_perfil,
    NULL::numeric(3,2) AS calificacion_promedio,
    NULL::integer AS total_viajes,
    NULL::numeric(10,2) AS total_ahorrado,
    NULL::boolean AS verificado,
    NULL::boolean AS activo,
    NULL::timestamp without time zone AS fecha_registro,
    NULL::character varying(100) AS nombre_universidad,
    NULL::numeric(10,2) AS saldo,
    NULL::bigint AS total_reservas,
    NULL::bigint AS viajes_completados;


ALTER VIEW public.perfil_usuario OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 41185)
-- Name: referido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referido (
    id integer NOT NULL,
    id_referidor integer,
    id_referido integer,
    codigo_referido character varying(20) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    recompensa_otorgada boolean DEFAULT false,
    monto_recompensa numeric(10,2) DEFAULT 10.00
);


ALTER TABLE public.referido OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 41193)
-- Name: referido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referido_id_seq OWNER TO postgres;

--
-- TOC entry 5729 (class 0 OID 0)
-- Dependencies: 261
-- Name: referido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referido_id_seq OWNED BY public.referido.id;


--
-- TOC entry 262 (class 1259 OID 41194)
-- Name: reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reserva (
    id integer NOT NULL,
    id_viaje integer NOT NULL,
    id_pasajero integer NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    fecha_reserva timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    calificacion_pasajero integer,
    calificacion_conductor integer,
    comentario_pasajero text,
    comentario_conductor text,
    precio_final numeric(10,2),
    metodo_pago character varying(20) DEFAULT 'WALLET'::character varying,
    pago_efectivo_confirmado boolean DEFAULT false,
    fecha_confirmacion_efectivo timestamp without time zone,
    monto_efectivo numeric(10,2),
    confirmado_por integer,
    CONSTRAINT check_metodo_pago CHECK (((metodo_pago)::text = ANY (ARRAY[('WALLET'::character varying)::text, ('EFECTIVO'::character varying)::text])))
);


ALTER TABLE public.reserva OWNER TO postgres;

--
-- TOC entry 5730 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE reserva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.reserva IS 'Connects users (passengers) to trips they have reserved.';


--
-- TOC entry 5731 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN reserva.metodo_pago; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reserva.metodo_pago IS 'WALLET: pago por billetera digital, EFECTIVO: pago en efectivo al conductor';


--
-- TOC entry 5732 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN reserva.pago_efectivo_confirmado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reserva.pago_efectivo_confirmado IS 'TRUE cuando el conductor confirma que recibió el pago en efectivo';


--
-- TOC entry 263 (class 1259 OID 41207)
-- Name: reserva_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reserva_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reserva_id_seq OWNER TO postgres;

--
-- TOC entry 5733 (class 0 OID 0)
-- Dependencies: 263
-- Name: reserva_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reserva_id_seq OWNED BY public.reserva.id;


--
-- TOC entry 264 (class 1259 OID 41208)
-- Name: ruta_favorita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruta_favorita (
    id integer NOT NULL,
    id_usuario integer,
    origen character varying(255) NOT NULL,
    destino character varying(255) NOT NULL,
    nombre character varying(100),
    fecha_agregado timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ruta_favorita OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 41217)
-- Name: ruta_favorita_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ruta_favorita_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ruta_favorita_id_seq OWNER TO postgres;

--
-- TOC entry 5734 (class 0 OID 0)
-- Dependencies: 265
-- Name: ruta_favorita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ruta_favorita_id_seq OWNED BY public.ruta_favorita.id;


--
-- TOC entry 302 (class 1259 OID 57611)
-- Name: rutas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rutas (
    id integer NOT NULL,
    id_viaje integer NOT NULL,
    coordenadas jsonb NOT NULL,
    distancia_km numeric(10,2),
    duracion_minutos integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.rutas OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 57610)
-- Name: rutas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rutas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rutas_id_seq OWNER TO postgres;

--
-- TOC entry 5735 (class 0 OID 0)
-- Dependencies: 301
-- Name: rutas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rutas_id_seq OWNED BY public.rutas.id;


--
-- TOC entry 266 (class 1259 OID 41218)
-- Name: solicitudes_recarga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_recarga (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo character varying(20) NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    comprobante_base64 text,
    numero_operacion character varying(100),
    referencia_pago character varying(100),
    fecha_solicitud timestamp without time zone DEFAULT now(),
    fecha_revision timestamp without time zone,
    id_revisor integer,
    motivo_rechazo text,
    datos_extra jsonb,
    CONSTRAINT monto_maximo CHECK ((monto <= 500.00)),
    CONSTRAINT monto_minimo CHECK ((monto >= 5.00)),
    CONSTRAINT monto_positivo CHECK ((monto > (0)::numeric)),
    CONSTRAINT solicitudes_recarga_estado_check CHECK (((estado)::text = ANY (ARRAY[('PENDIENTE'::character varying)::text, ('APROBADO'::character varying)::text, ('RECHAZADO'::character varying)::text]))),
    CONSTRAINT solicitudes_recarga_metodo_check CHECK (((metodo)::text = ANY (ARRAY[('YAPE'::character varying)::text, ('CULQI'::character varying)::text])))
);


ALTER TABLE public.solicitudes_recarga OWNER TO postgres;

--
-- TOC entry 5736 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE solicitudes_recarga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.solicitudes_recarga IS 'Solicitudes de recarga de billetera (Yape manual y Culqi)';


--
-- TOC entry 5737 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN solicitudes_recarga.metodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.solicitudes_recarga.metodo IS 'MÃ©todo de pago: YAPE (manual) o CULQI (automÃ¡tico)';


--
-- TOC entry 5738 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN solicitudes_recarga.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.solicitudes_recarga.estado IS 'Estado: PENDIENTE, APROBADO, RECHAZADO';


--
-- TOC entry 5739 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN solicitudes_recarga.comprobante_base64; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.solicitudes_recarga.comprobante_base64 IS 'Screenshot del comprobante Yape en base64';


--
-- TOC entry 5740 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN solicitudes_recarga.referencia_pago; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.solicitudes_recarga.referencia_pago IS 'ID de transacciÃ³n de Culqi';


--
-- TOC entry 267 (class 1259 OID 41234)
-- Name: solicitudes_recarga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_recarga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solicitudes_recarga_id_seq OWNER TO postgres;

--
-- TOC entry 5741 (class 0 OID 0)
-- Dependencies: 267
-- Name: solicitudes_recarga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_recarga_id_seq OWNED BY public.solicitudes_recarga.id;


--
-- TOC entry 268 (class 1259 OID 41235)
-- Name: transaccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaccion (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo character varying(20) NOT NULL,
    monto numeric(10,2) NOT NULL,
    descripcion text,
    metodo_pago character varying(50),
    estado character varying(20) DEFAULT 'COMPLETADA'::character varying,
    fecha_transaccion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_solicitud_recarga integer
);


ALTER TABLE public.transaccion OWNER TO postgres;

--
-- TOC entry 5742 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE transaccion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.transaccion IS 'A log of all financial movements (payments, earnings, etc.).';


--
-- TOC entry 269 (class 1259 OID 41246)
-- Name: transaccion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaccion_id_seq OWNER TO postgres;

--
-- TOC entry 5743 (class 0 OID 0)
-- Dependencies: 269
-- Name: transaccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaccion_id_seq OWNED BY public.transaccion.id;


--
-- TOC entry 270 (class 1259 OID 41247)
-- Name: ubicacion_viaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubicacion_viaje (
    id integer NOT NULL,
    id_viaje integer,
    id_usuario integer,
    latitud numeric(10,8) NOT NULL,
    longitud numeric(11,8) NOT NULL,
    fecha_actualizacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ubicacion_viaje OWNER TO postgres;

--
-- TOC entry 5744 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE ubicacion_viaje; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.ubicacion_viaje IS 'Almacena ubicaciones en tiempo real de conductor y pasajeros durante un viaje activo';


--
-- TOC entry 271 (class 1259 OID 41254)
-- Name: ubicacion_viaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ubicacion_viaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ubicacion_viaje_id_seq OWNER TO postgres;

--
-- TOC entry 5745 (class 0 OID 0)
-- Dependencies: 271
-- Name: ubicacion_viaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ubicacion_viaje_id_seq OWNED BY public.ubicacion_viaje.id;


--
-- TOC entry 272 (class 1259 OID 41255)
-- Name: universidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universidad (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ciudad character varying(50),
    pais character varying(50) DEFAULT 'Perú'::character varying,
    activo boolean DEFAULT true,
    dominio text[]
);


ALTER TABLE public.universidad OWNER TO postgres;

--
-- TOC entry 5746 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE universidad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.universidad IS 'Stores university information, including name and email domains.';


--
-- TOC entry 273 (class 1259 OID 41264)
-- Name: universidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universidad_id_seq OWNER TO postgres;

--
-- TOC entry 5747 (class 0 OID 0)
-- Dependencies: 273
-- Name: universidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universidad_id_seq OWNED BY public.universidad.id;


--
-- TOC entry 274 (class 1259 OID 41265)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    telefono character varying(20),
    id_universidad integer,
    carrera character varying(100),
    rol character varying(20) DEFAULT 'estudiante'::character varying,
    foto_perfil text,
    calificacion_promedio numeric(3,2) DEFAULT 0.00,
    total_viajes integer DEFAULT 0,
    total_ahorrado numeric(10,2) DEFAULT 0.00,
    verificado boolean DEFAULT false,
    activo boolean DEFAULT true,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_carrera integer,
    codigo_universitario character varying(20),
    ubicacion_lat numeric(10,8),
    ubicacion_lng numeric(11,8),
    ubicacion_actualizada timestamp without time zone,
    numero_emergencia character varying(20),
    puede_conducir boolean DEFAULT false,
    estado_verificacion_conductor character varying(20) DEFAULT 'SIN_DOCUMENTOS'::character varying,
    fecha_verificacion_conductor timestamp without time zone,
    contactos_emergencia text,
    latitud numeric(10,8),
    longitud numeric(11,8),
    ultima_actualizacion_ubicacion timestamp without time zone,
    tipo_usuario character varying(20) DEFAULT 'UNIVERSITARIO'::character varying,
    es_agente_externo boolean DEFAULT false,
    codigo_referido character varying(20),
    email_verificado boolean DEFAULT false,
    fecha_verificacion_email timestamp without time zone,
    token_verificacion_email character varying(255),
    ultima_conexion timestamp without time zone DEFAULT now(),
    estado_cuenta character varying(50) DEFAULT 'ACTIVO'::character varying
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 5748 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE usuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.usuario IS 'Main table for user accounts and profile data.';


--
-- TOC entry 5749 (class 0 OID 0)
-- Dependencies: 274
-- Name: COLUMN usuario.numero_emergencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.numero_emergencia IS 'Número de emergencia personal del usuario';


--
-- TOC entry 5750 (class 0 OID 0)
-- Dependencies: 274
-- Name: COLUMN usuario.puede_conducir; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.puede_conducir IS 'TRUE si el conductor fue verificado y puede ofrecer viajes';


--
-- TOC entry 5751 (class 0 OID 0)
-- Dependencies: 274
-- Name: COLUMN usuario.email_verificado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.email_verificado IS 'TRUE si el usuario verificó su email con el código';


--
-- TOC entry 5752 (class 0 OID 0)
-- Dependencies: 274
-- Name: COLUMN usuario.ultima_conexion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.ultima_conexion IS 'Última vez que el usuario estuvo activo en la aplicación';


--
-- TOC entry 300 (class 1259 OID 57583)
-- Name: usuario_bloqueado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_bloqueado (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_usuario_bloqueado integer NOT NULL,
    fecha_bloqueo timestamp without time zone DEFAULT now(),
    CONSTRAINT usuario_bloqueado_check CHECK ((id_usuario <> id_usuario_bloqueado))
);


ALTER TABLE public.usuario_bloqueado OWNER TO postgres;

--
-- TOC entry 5753 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE usuario_bloqueado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.usuario_bloqueado IS 'Gestiona la lista de usuarios bloqueados por cada usuario';


--
-- TOC entry 299 (class 1259 OID 57582)
-- Name: usuario_bloqueado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_bloqueado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_bloqueado_id_seq OWNER TO postgres;

--
-- TOC entry 5754 (class 0 OID 0)
-- Dependencies: 299
-- Name: usuario_bloqueado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_bloqueado_id_seq OWNED BY public.usuario_bloqueado.id;


--
-- TOC entry 275 (class 1259 OID 41285)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5755 (class 0 OID 0)
-- Dependencies: 275
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 276 (class 1259 OID 41286)
-- Name: vehiculo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehiculo (
    id integer NOT NULL,
    id_conductor integer NOT NULL,
    marca character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL,
    "año" integer,
    placa character varying(20) NOT NULL,
    color character varying(30),
    capacidad integer NOT NULL,
    foto text,
    soat_vigente boolean DEFAULT false,
    soat_vencimiento date,
    revision_tecnica boolean DEFAULT false,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehiculo OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 41300)
-- Name: vehiculo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehiculo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehiculo_id_seq OWNER TO postgres;

--
-- TOC entry 5756 (class 0 OID 0)
-- Dependencies: 277
-- Name: vehiculo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehiculo_id_seq OWNED BY public.vehiculo.id;


--
-- TOC entry 278 (class 1259 OID 41301)
-- Name: viaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viaje (
    id integer NOT NULL,
    id_conductor integer NOT NULL,
    origen character varying(200) NOT NULL,
    destino character varying(200) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    precio numeric(10,2) NOT NULL,
    asientos_disponibles integer NOT NULL,
    asientos_totales integer NOT NULL,
    descripcion text,
    estado character varying(20) DEFAULT 'DISPONIBLE'::character varying,
    preferencias jsonb,
    id_vehiculo integer,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    latitud_origen numeric(10,8),
    longitud_origen numeric(11,8),
    origen_lat numeric(10,7),
    origen_long numeric(10,7),
    destino_lat numeric(10,7),
    destino_long numeric(10,7),
    conductor_lat numeric(10,7),
    conductor_long numeric(10,7),
    calificado boolean DEFAULT false
);


ALTER TABLE public.viaje OWNER TO postgres;

--
-- TOC entry 5757 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE viaje; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.viaje IS 'Stores all trips created by drivers.';


--
-- TOC entry 279 (class 1259 OID 41316)
-- Name: viaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.viaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.viaje_id_seq OWNER TO postgres;

--
-- TOC entry 5758 (class 0 OID 0)
-- Dependencies: 279
-- Name: viaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.viaje_id_seq OWNED BY public.viaje.id;


--
-- TOC entry 280 (class 1259 OID 41317)
-- Name: viajes_disponibles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.viajes_disponibles AS
 SELECT v.id,
    v.id_conductor,
    v.origen,
    v.destino,
    v.fecha_hora,
    v.precio,
    v.asientos_disponibles,
    v.asientos_totales,
    v.descripcion,
    v.estado,
    v.preferencias,
    v.id_vehiculo,
    v.fecha_creacion,
    u.nombre AS conductor_nombre,
    u.telefono AS conductor_telefono,
    u.calificacion_promedio,
    uni.nombre AS universidad
   FROM ((public.viaje v
     JOIN public.usuario u ON ((v.id_conductor = u.id)))
     LEFT JOIN public.universidad uni ON ((u.id_universidad = uni.id)))
  WHERE (((v.estado)::text = 'DISPONIBLE'::text) AND (v.fecha_hora > now()))
  ORDER BY v.fecha_hora;


ALTER VIEW public.viajes_disponibles OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 41322)
-- Name: wallet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    saldo numeric(10,2) DEFAULT 0.00,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wallet OWNER TO postgres;

--
-- TOC entry 5759 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE wallet; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.wallet IS 'Stores the financial balance for each user.';


--
-- TOC entry 282 (class 1259 OID 41329)
-- Name: wallet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallet_id_seq OWNER TO postgres;

--
-- TOC entry 5760 (class 0 OID 0)
-- Dependencies: 282
-- Name: wallet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_id_seq OWNED BY public.wallet.id;


--
-- TOC entry 283 (class 1259 OID 41330)
-- Name: withdrawal_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.withdrawal_request (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo character varying(20) NOT NULL,
    numero_destino character varying(20) NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    fecha_solicitud timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_procesado timestamp without time zone,
    observaciones text,
    procesado_por integer,
    CONSTRAINT withdrawal_request_estado_check CHECK (((estado)::text = ANY (ARRAY[('PENDIENTE'::character varying)::text, ('PROCESADO'::character varying)::text, ('RECHAZADO'::character varying)::text]))),
    CONSTRAINT withdrawal_request_metodo_check CHECK (((metodo)::text = ANY (ARRAY[('YAPE'::character varying)::text, ('PLIN'::character varying)::text]))),
    CONSTRAINT withdrawal_request_monto_check CHECK ((monto > (0)::numeric))
);


ALTER TABLE public.withdrawal_request OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 41345)
-- Name: withdrawal_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.withdrawal_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.withdrawal_request_id_seq OWNER TO postgres;

--
-- TOC entry 5761 (class 0 OID 0)
-- Dependencies: 284
-- Name: withdrawal_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.withdrawal_request_id_seq OWNED BY public.withdrawal_request.id;


--
-- TOC entry 5183 (class 2604 OID 57482)
-- Name: alerta_emergencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_emergencia ALTER COLUMN id SET DEFAULT nextval('public.alerta_emergencia_id_seq'::regclass);


--
-- TOC entry 5066 (class 2604 OID 41346)
-- Name: badge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badge ALTER COLUMN id SET DEFAULT nextval('public.badge_id_seq'::regclass);


--
-- TOC entry 5068 (class 2604 OID 41347)
-- Name: calificacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificacion ALTER COLUMN id SET DEFAULT nextval('public.calificacion_id_seq'::regclass);


--
-- TOC entry 5070 (class 2604 OID 41348)
-- Name: carrera id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera ALTER COLUMN id SET DEFAULT nextval('public.carrera_id_seq'::regclass);


--
-- TOC entry 5073 (class 2604 OID 41349)
-- Name: chat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat ALTER COLUMN id SET DEFAULT nextval('public.chat_id_seq'::regclass);


--
-- TOC entry 5175 (class 2604 OID 57440)
-- Name: codigos_verificacion_email id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigos_verificacion_email ALTER COLUMN id SET DEFAULT nextval('public.codigos_verificacion_email_id_seq'::regclass);


--
-- TOC entry 5076 (class 2604 OID 41350)
-- Name: comprobante_recarga id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprobante_recarga ALTER COLUMN id SET DEFAULT nextval('public.comprobante_recarga_id_seq'::regclass);


--
-- TOC entry 5080 (class 2604 OID 41351)
-- Name: conductor_favorito id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_favorito ALTER COLUMN id SET DEFAULT nextval('public.conductor_favorito_id_seq'::regclass);


--
-- TOC entry 5082 (class 2604 OID 41352)
-- Name: configuracion_emergencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion_emergencia ALTER COLUMN id SET DEFAULT nextval('public.configuracion_emergencia_id_seq'::regclass);


--
-- TOC entry 5087 (class 2604 OID 41353)
-- Name: confirmaciones_pago_efectivo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmaciones_pago_efectivo ALTER COLUMN id SET DEFAULT nextval('public.confirmaciones_pago_efectivo_id_seq'::regclass);


--
-- TOC entry 5089 (class 2604 OID 41354)
-- Name: contacto_emergencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacto_emergencia ALTER COLUMN id SET DEFAULT nextval('public.contacto_emergencia_id_seq'::regclass);


--
-- TOC entry 5186 (class 2604 OID 57500)
-- Name: contactos_emergencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contactos_emergencia ALTER COLUMN id SET DEFAULT nextval('public.contactos_emergencia_id_seq'::regclass);


--
-- TOC entry 5091 (class 2604 OID 41355)
-- Name: cuenta_recepcion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_recepcion ALTER COLUMN id SET DEFAULT nextval('public.cuenta_recepcion_id_seq'::regclass);


--
-- TOC entry 5094 (class 2604 OID 41356)
-- Name: cupon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon ALTER COLUMN id SET DEFAULT nextval('public.cupon_id_seq'::regclass);


--
-- TOC entry 5098 (class 2604 OID 41357)
-- Name: cupon_uso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso ALTER COLUMN id SET DEFAULT nextval('public.cupon_uso_id_seq'::regclass);


--
-- TOC entry 5100 (class 2604 OID 41358)
-- Name: documentos_conductor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_conductor ALTER COLUMN id SET DEFAULT nextval('public.documentos_conductor_id_seq'::regclass);


--
-- TOC entry 5103 (class 2604 OID 41359)
-- Name: emergencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergencia ALTER COLUMN id SET DEFAULT nextval('public.emergencia_id_seq'::regclass);


--
-- TOC entry 5194 (class 2604 OID 57536)
-- Name: grupos_viaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos_viaje ALTER COLUMN id SET DEFAULT nextval('public.grupos_viaje_id_seq'::regclass);


--
-- TOC entry 5106 (class 2604 OID 41360)
-- Name: historial_verificacion_conductor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_verificacion_conductor ALTER COLUMN id SET DEFAULT nextval('public.historial_verificacion_conductor_id_seq'::regclass);


--
-- TOC entry 5180 (class 2604 OID 57460)
-- Name: intentos_verificacion_email id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intentos_verificacion_email ALTER COLUMN id SET DEFAULT nextval('public.intentos_verificacion_email_id_seq'::regclass);


--
-- TOC entry 5108 (class 2604 OID 41361)
-- Name: mensaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje ALTER COLUMN id SET DEFAULT nextval('public.mensaje_id_seq'::regclass);


--
-- TOC entry 5111 (class 2604 OID 41362)
-- Name: mensaje_comunidad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_comunidad ALTER COLUMN id SET DEFAULT nextval('public.mensaje_comunidad_id_seq'::regclass);


--
-- TOC entry 5113 (class 2604 OID 41363)
-- Name: metodo_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodo_pago ALTER COLUMN id SET DEFAULT nextval('public.metodo_pago_id_seq'::regclass);


--
-- TOC entry 5200 (class 2604 OID 57557)
-- Name: miembros_grupo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembros_grupo ALTER COLUMN id SET DEFAULT nextval('public.miembros_grupo_id_seq'::regclass);


--
-- TOC entry 5117 (class 2604 OID 41364)
-- Name: notificacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion ALTER COLUMN id SET DEFAULT nextval('public.notificacion_id_seq'::regclass);


--
-- TOC entry 5189 (class 2604 OID 57517)
-- Name: notificaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones ALTER COLUMN id SET DEFAULT nextval('public.notificaciones_id_seq'::regclass);


--
-- TOC entry 5120 (class 2604 OID 41365)
-- Name: payment_method id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method ALTER COLUMN id SET DEFAULT nextval('public.payment_method_id_seq'::regclass);


--
-- TOC entry 5124 (class 2604 OID 41366)
-- Name: referido id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referido ALTER COLUMN id SET DEFAULT nextval('public.referido_id_seq'::regclass);


--
-- TOC entry 5128 (class 2604 OID 41367)
-- Name: reserva id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva ALTER COLUMN id SET DEFAULT nextval('public.reserva_id_seq'::regclass);


--
-- TOC entry 5133 (class 2604 OID 41368)
-- Name: ruta_favorita id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_favorita ALTER COLUMN id SET DEFAULT nextval('public.ruta_favorita_id_seq'::regclass);


--
-- TOC entry 5205 (class 2604 OID 57614)
-- Name: rutas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutas ALTER COLUMN id SET DEFAULT nextval('public.rutas_id_seq'::regclass);


--
-- TOC entry 5135 (class 2604 OID 41369)
-- Name: solicitudes_recarga id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_recarga ALTER COLUMN id SET DEFAULT nextval('public.solicitudes_recarga_id_seq'::regclass);


--
-- TOC entry 5138 (class 2604 OID 41370)
-- Name: transaccion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaccion ALTER COLUMN id SET DEFAULT nextval('public.transaccion_id_seq'::regclass);


--
-- TOC entry 5141 (class 2604 OID 41371)
-- Name: ubicacion_viaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion_viaje ALTER COLUMN id SET DEFAULT nextval('public.ubicacion_viaje_id_seq'::regclass);


--
-- TOC entry 5143 (class 2604 OID 41372)
-- Name: universidad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidad ALTER COLUMN id SET DEFAULT nextval('public.universidad_id_seq'::regclass);


--
-- TOC entry 5146 (class 2604 OID 41373)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 5203 (class 2604 OID 57586)
-- Name: usuario_bloqueado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_bloqueado ALTER COLUMN id SET DEFAULT nextval('public.usuario_bloqueado_id_seq'::regclass);


--
-- TOC entry 5161 (class 2604 OID 41374)
-- Name: vehiculo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo ALTER COLUMN id SET DEFAULT nextval('public.vehiculo_id_seq'::regclass);


--
-- TOC entry 5165 (class 2604 OID 41375)
-- Name: viaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje ALTER COLUMN id SET DEFAULT nextval('public.viaje_id_seq'::regclass);


--
-- TOC entry 5169 (class 2604 OID 41376)
-- Name: wallet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet ALTER COLUMN id SET DEFAULT nextval('public.wallet_id_seq'::regclass);


--
-- TOC entry 5172 (class 2604 OID 41377)
-- Name: withdrawal_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_request ALTER COLUMN id SET DEFAULT nextval('public.withdrawal_request_id_seq'::regclass);


--
-- TOC entry 5670 (class 0 OID 57479)
-- Dependencies: 290
-- Data for Name: alerta_emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alerta_emergencia (id, id_usuario, latitud, longitud, fecha_hora, estado) FROM stdin;
\.


--
-- TOC entry 5601 (class 0 OID 40977)
-- Dependencies: 219
-- Data for Name: badge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.badge (id, id_usuario, nombre_badge, fecha_obtencion) FROM stdin;
\.


--
-- TOC entry 5603 (class 0 OID 40985)
-- Dependencies: 221
-- Data for Name: calificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calificacion (id, id_viaje, id_autor, id_destinatario, puntuacion, comentario, fecha) FROM stdin;
\.


--
-- TOC entry 5605 (class 0 OID 40994)
-- Dependencies: 223
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrera (id, nombre, id_universidad, activo, fecha_creacion) FROM stdin;
1	Administración de Empresas	1	t	2025-12-09 21:41:01.902943
2	Administración y Servicios	1	t	2025-12-09 21:41:01.902943
3	Arquitectura	1	t	2025-12-09 21:41:01.902943
4	Contabilidad y Auditoría	1	t	2025-12-09 21:41:01.902943
5	Derecho	1	t	2025-12-09 21:41:01.902943
6	Economía	1	t	2025-12-09 21:41:01.902943
7	Educación Inicial	1	t	2025-12-09 21:41:01.902943
8	Educación Primaria	1	t	2025-12-09 21:41:01.902943
9	Educación Secundaria (Lengua Inglesa)	1	t	2025-12-09 21:41:01.902943
10	Educación Secundaria (Matemática y Física)	1	t	2025-12-09 21:41:01.902943
11	Educación Secundaria (Lengua y Literatura)	1	t	2025-12-09 21:41:01.902943
12	Educación Secundaria (Historia y Ciencias Sociales)	1	t	2025-12-09 21:41:01.902943
13	Historia y Gestión Cultural	1	t	2025-12-09 21:41:01.902943
14	Comunicación Audiovisual	1	t	2025-12-09 21:41:01.902943
15	Comunicaciones de Marketing	1	t	2025-12-09 21:41:01.902943
16	Periodismo	1	t	2025-12-09 21:41:01.902943
17	Ingeniería Civil	1	t	2025-12-09 21:41:01.902943
18	Ingeniería Industrial y de Sistemas	1	t	2025-12-09 21:41:01.902943
19	Ingeniería Mecánico-Eléctrica	1	t	2025-12-09 21:41:01.902943
20	Administración	2	t	2025-12-09 21:41:01.902943
21	Contabilidad y Finanzas	2	t	2025-12-09 21:41:01.902943
22	Economía	2	t	2025-12-09 21:41:01.902943
23	Estadística	2	t	2025-12-09 21:41:01.902943
24	Agronomía	2	t	2025-12-09 21:41:01.902943
25	Arquitectura y Urbanismo	2	t	2025-12-09 21:41:01.902943
26	Ingeniería Agrícola	2	t	2025-12-09 21:41:01.902943
27	Ingeniería Agroindustrial	2	t	2025-12-09 21:41:01.902943
28	Ingeniería Agrónoma	2	t	2025-12-09 21:41:01.902943
29	Ingeniería Ambiental	2	t	2025-12-09 21:41:01.902943
30	Ingeniería Civil	2	t	2025-12-09 21:41:01.902943
31	Ingeniería Electrónica y Telecomunicaciones	2	t	2025-12-09 21:41:01.902943
32	Ingeniería Geológica	2	t	2025-12-09 21:41:01.902943
33	Ingeniería Industrial	2	t	2025-12-09 21:41:01.902943
34	Ingeniería Informática	2	t	2025-12-09 21:41:01.902943
35	Ingeniería Mecatrónica	2	t	2025-12-09 21:41:01.902943
36	Ingeniería Pesquera	2	t	2025-12-09 21:41:01.902943
37	Ingeniería Química	2	t	2025-12-09 21:41:01.902943
38	Ingeniería Zootécnica	2	t	2025-12-09 21:41:01.902943
39	Ingeniería de Minas	2	t	2025-12-09 21:41:01.902943
40	Ingeniería de Petróleo	2	t	2025-12-09 21:41:01.902943
41	Ciencias Biológicas	2	t	2025-12-09 21:41:01.902943
42	Enfermería	2	t	2025-12-09 21:41:01.902943
43	Medicina Humana	2	t	2025-12-09 21:41:01.902943
44	Medicina Veterinaria	2	t	2025-12-09 21:41:01.902943
45	Psicología	2	t	2025-12-09 21:41:01.902943
46	Obstetricia	2	t	2025-12-09 21:41:01.902943
47	Estomatología	2	t	2025-12-09 21:41:01.902943
48	Historia y Geografía	2	t	2025-12-09 21:41:01.902943
49	Lengua y Literatura	2	t	2025-12-09 21:41:01.902943
50	Educación Inicial	2	t	2025-12-09 21:41:01.902943
51	Educación Primaria	2	t	2025-12-09 21:41:01.902943
52	Ciencias de la Comunicación	2	t	2025-12-09 21:41:01.902943
53	Derecho y Ciencias Políticas	2	t	2025-12-09 21:41:01.902943
54	Matemática	2	t	2025-12-09 21:41:01.902943
55	Física	2	t	2025-12-09 21:41:01.902943
56	Enfermería	3	t	2025-12-09 21:41:01.902943
57	Estomatología	3	t	2025-12-09 21:41:01.902943
58	Medicina	3	t	2025-12-09 21:41:01.902943
59	Nutrición	3	t	2025-12-09 21:41:01.902943
60	Psicología	3	t	2025-12-09 21:41:01.902943
61	Tecnología Médica	3	t	2025-12-09 21:41:01.902943
62	Administración de Empresas	3	t	2025-12-09 21:41:01.902943
63	Administración en Turismo y Hotelería	3	t	2025-12-09 21:41:01.902943
64	Administración y Gestión Pública	3	t	2025-12-09 21:41:01.902943
65	Administración y Marketing	3	t	2025-12-09 21:41:01.902943
66	Administración y Negocios Internacionales	3	t	2025-12-09 21:41:01.902943
67	Contabilidad	3	t	2025-12-09 21:41:01.902943
68	Economía	3	t	2025-12-09 21:41:01.902943
69	Derecho	3	t	2025-12-09 21:41:01.902943
70	Ciencias de la Comunicación	3	t	2025-12-09 21:41:01.902943
71	Arte & Diseño Gráfico Empresarial	3	t	2025-12-09 21:41:01.902943
72	Ciencias del Deporte	3	t	2025-12-09 21:41:01.902943
73	Educación Inicial	3	t	2025-12-09 21:41:01.902943
74	Educación Primaria	3	t	2025-12-09 21:41:01.902943
75	Traducción e Interpretación	3	t	2025-12-09 21:41:01.902943
76	Arquitectura	3	t	2025-12-09 21:41:01.902943
77	Ingeniería Empresarial	3	t	2025-12-09 21:41:01.902943
78	Ingeniería Agroindustrial	3	t	2025-12-09 21:41:01.902943
79	Ingeniería Ambiental	3	t	2025-12-09 21:41:01.902943
80	Ingeniería Civil	3	t	2025-12-09 21:41:01.902943
81	Ingeniería de Minas	3	t	2025-12-09 21:41:01.902943
82	Ingeniería de Sistemas	3	t	2025-12-09 21:41:01.902943
83	Ingeniería Industrial	3	t	2025-12-09 21:41:01.902943
84	Ingeniería Mecánica Eléctrica	3	t	2025-12-09 21:41:01.902943
85	Ingeniería en Ciencia de Datos	3	t	2025-12-09 21:41:01.902943
86	Ingeniería en Ciberseguridad	3	t	2025-12-09 21:41:01.902943
87	Administración	4	t	2025-12-09 21:41:01.902943
88	Administración Bancaria y Financiera	4	t	2025-12-09 21:41:01.902943
89	Administración y Gestión Empresarial	4	t	2025-12-09 21:41:01.902943
90	Administración y Marketing	4	t	2025-12-09 21:41:01.902943
91	Administración y Negocios Internacionales	4	t	2025-12-09 21:41:01.902943
92	Administración y Servicios Turísticos	4	t	2025-12-09 21:41:01.902943
93	Arquitectura y Diseño de Interiores	4	t	2025-12-09 21:41:01.902943
94	Arquitectura y Urbanismo	4	t	2025-12-09 21:41:01.902943
95	Comunicación	4	t	2025-12-09 21:41:01.902943
96	Comunicación Audiovisual	4	t	2025-12-09 21:41:01.902943
97	Comunicación y Diseño Gráfico	4	t	2025-12-09 21:41:01.902943
98	Comunicación y Marketing Digital	4	t	2025-12-09 21:41:01.902943
99	Comunicación y Periodismo	4	t	2025-12-09 21:41:01.902943
100	Comunicación y Publicidad	4	t	2025-12-09 21:41:01.902943
101	Contabilidad y Finanzas	4	t	2025-12-09 21:41:01.902943
102	Derecho	4	t	2025-12-09 21:41:01.902943
103	Diseño Industrial	4	t	2025-12-09 21:41:01.902943
104	Economía	4	t	2025-12-09 21:41:01.902943
105	Economía y Negocios Internacionales	4	t	2025-12-09 21:41:01.902943
106	Enfermería	4	t	2025-12-09 21:41:01.902943
107	Farmacia y Bioquímica	4	t	2025-12-09 21:41:01.902943
108	Gastronomía y Gestión de Restaurantes	4	t	2025-12-09 21:41:01.902943
109	Ingeniería Agroindustrial	4	t	2025-12-09 21:41:01.902943
110	Ingeniería Ambiental	4	t	2025-12-09 21:41:01.902943
111	Ingeniería Biomédica	4	t	2025-12-09 21:41:01.902943
112	Ingeniería Civil	4	t	2025-12-09 21:41:01.902943
113	Ingeniería de Minas	4	t	2025-12-09 21:41:01.902943
114	Ingeniería de Sistemas Computacionales	4	t	2025-12-09 21:41:01.902943
115	Ingeniería de Software	4	t	2025-12-09 21:41:01.902943
116	Ingeniería Electrónica	4	t	2025-12-09 21:41:01.902943
117	Ingeniería Empresarial	4	t	2025-12-09 21:41:01.902943
118	Ingeniería en Ciencia de Datos	4	t	2025-12-09 21:41:01.902943
119	Ingeniería Geológica	4	t	2025-12-09 21:41:01.902943
120	Ingeniería Industrial	4	t	2025-12-09 21:41:01.902943
121	Ingeniería Mecatrónica	4	t	2025-12-09 21:41:01.902943
122	Marketing Internacional	4	t	2025-12-09 21:41:01.902943
123	Medicina Humana	4	t	2025-12-09 21:41:01.902943
124	Negocios Internacionales	4	t	2025-12-09 21:41:01.902943
125	Nutrición y Dietética	4	t	2025-12-09 21:41:01.902943
126	Obstetricia	4	t	2025-12-09 21:41:01.902943
127	Psicología	4	t	2025-12-09 21:41:01.902943
128	Terapia Física y Rehabilitación	4	t	2025-12-09 21:41:01.902943
129	Administración	5	t	2025-12-09 21:41:01.902943
130	Administración de Negocios Internacionales	5	t	2025-12-09 21:41:01.902943
131	Gestión de Recursos Humanos	5	t	2025-12-09 21:41:01.902943
132	Marketing	5	t	2025-12-09 21:41:01.902943
133	Economía	5	t	2025-12-09 21:41:01.902943
134	Contabilidad y Finanzas	5	t	2025-12-09 21:41:01.902943
135	Arquitectura	5	t	2025-12-09 21:41:01.902943
136	Ingeniería Civil	5	t	2025-12-09 21:41:01.902943
137	Ingeniería Industrial	5	t	2025-12-09 21:41:01.902943
138	Ingeniería de Computación y Sistemas	5	t	2025-12-09 21:41:01.902943
139	Ciencias Aeronáuticas	5	t	2025-12-09 21:41:01.902943
140	Ingeniería en Ciencias de Datos	5	t	2025-12-09 21:41:01.902943
141	Ingeniería en Inteligencia Artificial	5	t	2025-12-09 21:41:01.902943
142	Ingeniería en Ciberseguridad	5	t	2025-12-09 21:41:01.902943
143	Ciencias de la Comunicación	5	t	2025-12-09 21:41:01.902943
144	Turismo y Hotelería	5	t	2025-12-09 21:41:01.902943
145	Psicología	5	t	2025-12-09 21:41:01.902943
146	Enfermería	5	t	2025-12-09 21:41:01.902943
147	Obstetricia	5	t	2025-12-09 21:41:01.902943
148	Medicina Humana	5	t	2025-12-09 21:41:01.902943
149	Odontología	5	t	2025-12-09 21:41:01.902943
150	Derecho	5	t	2025-12-09 21:41:01.902943
151	Educación	5	t	2025-12-09 21:41:01.902943
152	Administración de Empresas	6	t	2025-12-09 21:41:01.902943
153	Administración y Marketing	6	t	2025-12-09 21:41:01.902943
154	Administración de Negocios Internacionales	6	t	2025-12-09 21:41:01.902943
155	Contabilidad	6	t	2025-12-09 21:41:01.902943
156	Derecho	6	t	2025-12-09 21:41:01.902943
157	Psicología	6	t	2025-12-09 21:41:01.902943
158	Ingeniería de Sistemas e Informática	6	t	2025-12-09 21:41:01.902943
159	Ingeniería Civil	6	t	2025-12-09 21:41:01.902943
160	Ingeniería Industrial	6	t	2025-12-09 21:41:01.902943
161	Arquitectura	6	t	2025-12-09 21:41:01.902943
162	Enfermería	6	t	2025-12-09 21:41:01.902943
163	Nutrición	6	t	2025-12-09 21:41:01.902943
164	Ingenieria de Sistemas	6	t	2025-12-09 22:05:31.623813
\.


--
-- TOC entry 5607 (class 0 OID 41002)
-- Dependencies: 225
-- Data for Name: chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat (id, id_usuario1, id_usuario2, ultimo_mensaje, fecha_ultimo_mensaje, no_leidos_usuario1, no_leidos_usuario2) FROM stdin;
\.


--
-- TOC entry 5666 (class 0 OID 57437)
-- Dependencies: 286
-- Data for Name: codigos_verificacion_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codigos_verificacion_email (id, id_usuario, codigo, email, usado, intentos_fallidos, fecha_creacion, fecha_expiracion, fecha_uso, ip_solicitud) FROM stdin;
\.


--
-- TOC entry 5609 (class 0 OID 41013)
-- Dependencies: 227
-- Data for Name: comprobante_recarga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comprobante_recarga (id, id_usuario, monto, metodo, numero_operacion, imagen_comprobante, estado, fecha_solicitud, observaciones, tipo_recarga) FROM stdin;
\.


--
-- TOC entry 5611 (class 0 OID 41028)
-- Dependencies: 229
-- Data for Name: conductor_favorito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductor_favorito (id, id_usuario, id_conductor, fecha_agregado) FROM stdin;
\.


--
-- TOC entry 5613 (class 0 OID 41034)
-- Dependencies: 231
-- Data for Name: configuracion_emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracion_emergencia (id, id_usuario, auto_envio_ubicacion, notificar_universidad, grabar_audio, alertas_velocidad) FROM stdin;
\.


--
-- TOC entry 5615 (class 0 OID 41044)
-- Dependencies: 233
-- Data for Name: confirmaciones_pago_efectivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.confirmaciones_pago_efectivo (id, id_reserva, id_conductor, id_pasajero, monto, fecha_confirmacion, ubicacion_lat, ubicacion_lng, comentarios) FROM stdin;
\.


--
-- TOC entry 5617 (class 0 OID 41053)
-- Dependencies: 235
-- Data for Name: contacto_emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacto_emergencia (id, id_usuario, nombre, telefono, relacion, activo) FROM stdin;
\.


--
-- TOC entry 5672 (class 0 OID 57497)
-- Dependencies: 292
-- Data for Name: contactos_emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contactos_emergencia (id, id_usuario, nombre, telefono, relacion, es_principal, fecha_creacion) FROM stdin;
\.


--
-- TOC entry 5619 (class 0 OID 41062)
-- Dependencies: 237
-- Data for Name: cuenta_recepcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_recepcion (id, tipo, numero_celular, nombre_titular, qr_code, activo, fecha_creacion) FROM stdin;
1	YAPE	928318308	UniHitch	\N	t	2025-11-23 08:25:41.915258
2	YAPE	928318308	UniHitch	\N	t	2025-11-23 08:26:37.596566
\.


--
-- TOC entry 5621 (class 0 OID 41074)
-- Dependencies: 239
-- Data for Name: cupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cupon (id, codigo, tipo, valor, descripcion, fecha_creacion, fecha_expiracion, usos_maximos, usos_actuales, activo, id_creador) FROM stdin;
\.


--
-- TOC entry 5623 (class 0 OID 41088)
-- Dependencies: 241
-- Data for Name: cupon_uso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cupon_uso (id, id_cupon, id_usuario, id_viaje, monto_descuento, fecha_uso) FROM stdin;
\.


--
-- TOC entry 5625 (class 0 OID 41094)
-- Dependencies: 243
-- Data for Name: documentos_conductor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documentos_conductor (id, id_conductor, tipo_documento, archivo_base64, nombre_archivo, mime_type, tamanio_kb, estado, fecha_vencimiento, motivo_rechazo, notas_adicionales, fecha_subida, fecha_revision, id_revisor) FROM stdin;
\.


--
-- TOC entry 5627 (class 0 OID 41106)
-- Dependencies: 245
-- Data for Name: emergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emergencia (id, id_usuario, ubicacion_lat, ubicacion_lng, mensaje, contactos_notificados, estado, fecha_activacion) FROM stdin;
\.


--
-- TOC entry 5676 (class 0 OID 57533)
-- Dependencies: 296
-- Data for Name: grupos_viaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupos_viaje (id, id_organizador, ruta_comun, origen, destino, horario_preferido, dias_semana, tipo_grupo, costo_total, num_pasajeros, costo_por_persona, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- TOC entry 5629 (class 0 OID 41116)
-- Dependencies: 247
-- Data for Name: historial_verificacion_conductor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_verificacion_conductor (id, id_conductor, estado_anterior, estado_nuevo, comentario, id_admin, fecha_cambio) FROM stdin;
\.


--
-- TOC entry 5668 (class 0 OID 57457)
-- Dependencies: 288
-- Data for Name: intentos_verificacion_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.intentos_verificacion_email (id, id_usuario, email, codigo_ingresado, exitoso, fecha_intento, ip_address) FROM stdin;
\.


--
-- TOC entry 5631 (class 0 OID 41124)
-- Dependencies: 249
-- Data for Name: mensaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensaje (id, id_chat, id_remitente, mensaje, leido, fecha_envio) FROM stdin;
\.


--
-- TOC entry 5632 (class 0 OID 41135)
-- Dependencies: 250
-- Data for Name: mensaje_comunidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensaje_comunidad (id, id_usuario, id_universidad, mensaje, fecha_envio) FROM stdin;
\.


--
-- TOC entry 5635 (class 0 OID 41145)
-- Dependencies: 253
-- Data for Name: metodo_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metodo_pago (id, id_usuario, tipo, nombre, ultimos_digitos, es_predeterminado, activo, fecha_creacion) FROM stdin;
\.


--
-- TOC entry 5678 (class 0 OID 57554)
-- Dependencies: 298
-- Data for Name: miembros_grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.miembros_grupo (id, id_grupo, id_usuario, fecha_union, estado) FROM stdin;
\.


--
-- TOC entry 5637 (class 0 OID 41156)
-- Dependencies: 255
-- Data for Name: notificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacion (id, id_usuario, titulo, mensaje, tipo, leida, fecha_creacion) FROM stdin;
\.


--
-- TOC entry 5674 (class 0 OID 57514)
-- Dependencies: 294
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificaciones (id, id_usuario, titulo, mensaje, fecha_creacion, tipo, prioridad, datos_adicionales, leida, fecha_lectura) FROM stdin;
\.


--
-- TOC entry 5639 (class 0 OID 41169)
-- Dependencies: 257
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_method (id, id_usuario, tipo, numero, nombre_titular, es_principal, activo, fecha_creacion, fecha_expiracion, cvv_encrypted) FROM stdin;
\.


--
-- TOC entry 5641 (class 0 OID 41185)
-- Dependencies: 260
-- Data for Name: referido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referido (id, id_referidor, id_referido, codigo_referido, fecha, recompensa_otorgada, monto_recompensa) FROM stdin;
\.


--
-- TOC entry 5643 (class 0 OID 41194)
-- Dependencies: 262
-- Data for Name: reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reserva (id, id_viaje, id_pasajero, estado, fecha_reserva, calificacion_pasajero, calificacion_conductor, comentario_pasajero, comentario_conductor, precio_final, metodo_pago, pago_efectivo_confirmado, fecha_confirmacion_efectivo, monto_efectivo, confirmado_por) FROM stdin;
\.


--
-- TOC entry 5645 (class 0 OID 41208)
-- Dependencies: 264
-- Data for Name: ruta_favorita; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ruta_favorita (id, id_usuario, origen, destino, nombre, fecha_agregado) FROM stdin;
\.


--
-- TOC entry 5682 (class 0 OID 57611)
-- Dependencies: 302
-- Data for Name: rutas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rutas (id, id_viaje, coordenadas, distancia_km, duracion_minutos, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5647 (class 0 OID 41218)
-- Dependencies: 266
-- Data for Name: solicitudes_recarga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_recarga (id, id_usuario, monto, metodo, estado, comprobante_base64, numero_operacion, referencia_pago, fecha_solicitud, fecha_revision, id_revisor, motivo_rechazo, datos_extra) FROM stdin;
\.


--
-- TOC entry 5649 (class 0 OID 41235)
-- Dependencies: 268
-- Data for Name: transaccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaccion (id, id_usuario, tipo, monto, descripcion, metodo_pago, estado, fecha_transaccion, id_solicitud_recarga) FROM stdin;
\.


--
-- TOC entry 5651 (class 0 OID 41247)
-- Dependencies: 270
-- Data for Name: ubicacion_viaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ubicacion_viaje (id, id_viaje, id_usuario, latitud, longitud, fecha_actualizacion) FROM stdin;
\.


--
-- TOC entry 5653 (class 0 OID 41255)
-- Dependencies: 272
-- Data for Name: universidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universidad (id, nombre, ciudad, pais, activo, dominio) FROM stdin;
1	Universidad de Piura (UDEP)	\N	Perú	t	{udep.edu.pe}
2	Universidad Nacional de Piura (UNP)	\N	Perú	t	{unp.edu.pe,alumnos.unp.edu.pe}
3	Universidad César Vallejo (UCV)	\N	Perú	t	{ucv.edu.pe,ucvvirtual.edu.pe}
4	Universidad Privada del Norte (UPN)	\N	Perú	t	{upn.edu.pe}
5	Universidad de San Martín de Porres (USMP)	\N	Perú	t	{usmp.pe}
6	Universidad Tecnológica del Perú (UTP)	\N	Perú	t	{utp.edu.pe}
\.


--
-- TOC entry 5655 (class 0 OID 41265)
-- Dependencies: 274
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nombre, correo, password, telefono, id_universidad, carrera, rol, foto_perfil, calificacion_promedio, total_viajes, total_ahorrado, verificado, activo, fecha_registro, id_carrera, codigo_universitario, ubicacion_lat, ubicacion_lng, ubicacion_actualizada, numero_emergencia, puede_conducir, estado_verificacion_conductor, fecha_verificacion_conductor, contactos_emergencia, latitud, longitud, ultima_actualizacion_ubicacion, tipo_usuario, es_agente_externo, codigo_referido, email_verificado, fecha_verificacion_email, token_verificacion_email, ultima_conexion, estado_cuenta) FROM stdin;
1	Valentino Marca Quedena	u22247388@utp.edu.pe	$2b$10$wA34bzpI4H6D2dpoSdd7ReH5VWlpTEX11BPHrMgiv2PssCRMLq2G6	950088093	6	\N	estudiante	\N	0.00	0	0.00	t	t	2025-12-09 22:05:31.623813	164	\N	\N	\N	\N	\N	f	SIN_DOCUMENTOS	\N	\N	\N	\N	\N	UNIVERSITARIO	f	\N	f	\N	\N	2025-12-09 22:05:31.623813	ACTIVO
\.


--
-- TOC entry 5680 (class 0 OID 57583)
-- Dependencies: 300
-- Data for Name: usuario_bloqueado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_bloqueado (id, id_usuario, id_usuario_bloqueado, fecha_bloqueo) FROM stdin;
\.


--
-- TOC entry 5657 (class 0 OID 41286)
-- Dependencies: 276
-- Data for Name: vehiculo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehiculo (id, id_conductor, marca, modelo, "año", placa, color, capacidad, foto, soat_vigente, soat_vencimiento, revision_tecnica, fecha_registro) FROM stdin;
\.


--
-- TOC entry 5659 (class 0 OID 41301)
-- Dependencies: 278
-- Data for Name: viaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.viaje (id, id_conductor, origen, destino, fecha_hora, precio, asientos_disponibles, asientos_totales, descripcion, estado, preferencias, id_vehiculo, fecha_creacion, latitud_origen, longitud_origen, origen_lat, origen_long, destino_lat, destino_long, conductor_lat, conductor_long, calificado) FROM stdin;
\.


--
-- TOC entry 5661 (class 0 OID 41322)
-- Dependencies: 281
-- Data for Name: wallet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet (id, id_usuario, saldo, fecha_actualizacion) FROM stdin;
1	1	0.00	2025-12-09 22:05:31.623813
\.


--
-- TOC entry 5663 (class 0 OID 41330)
-- Dependencies: 283
-- Data for Name: withdrawal_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawal_request (id, id_usuario, monto, metodo, numero_destino, estado, fecha_solicitud, fecha_procesado, observaciones, procesado_por) FROM stdin;
\.


--
-- TOC entry 5762 (class 0 OID 0)
-- Dependencies: 289
-- Name: alerta_emergencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alerta_emergencia_id_seq', 1, false);


--
-- TOC entry 5763 (class 0 OID 0)
-- Dependencies: 220
-- Name: badge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.badge_id_seq', 1, false);


--
-- TOC entry 5764 (class 0 OID 0)
-- Dependencies: 222
-- Name: calificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calificacion_id_seq', 1, false);


--
-- TOC entry 5765 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrera_id_seq', 164, true);


--
-- TOC entry 5766 (class 0 OID 0)
-- Dependencies: 226
-- Name: chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_id_seq', 1, false);


--
-- TOC entry 5767 (class 0 OID 0)
-- Dependencies: 285
-- Name: codigos_verificacion_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.codigos_verificacion_email_id_seq', 1, false);


--
-- TOC entry 5768 (class 0 OID 0)
-- Dependencies: 228
-- Name: comprobante_recarga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comprobante_recarga_id_seq', 1, false);


--
-- TOC entry 5769 (class 0 OID 0)
-- Dependencies: 230
-- Name: conductor_favorito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conductor_favorito_id_seq', 1, false);


--
-- TOC entry 5770 (class 0 OID 0)
-- Dependencies: 232
-- Name: configuracion_emergencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuracion_emergencia_id_seq', 1, false);


--
-- TOC entry 5771 (class 0 OID 0)
-- Dependencies: 234
-- Name: confirmaciones_pago_efectivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.confirmaciones_pago_efectivo_id_seq', 1, false);


--
-- TOC entry 5772 (class 0 OID 0)
-- Dependencies: 236
-- Name: contacto_emergencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacto_emergencia_id_seq', 1, false);


--
-- TOC entry 5773 (class 0 OID 0)
-- Dependencies: 291
-- Name: contactos_emergencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contactos_emergencia_id_seq', 1, false);


--
-- TOC entry 5774 (class 0 OID 0)
-- Dependencies: 238
-- Name: cuenta_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_recepcion_id_seq', 2, true);


--
-- TOC entry 5775 (class 0 OID 0)
-- Dependencies: 240
-- Name: cupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cupon_id_seq', 1, false);


--
-- TOC entry 5776 (class 0 OID 0)
-- Dependencies: 242
-- Name: cupon_uso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cupon_uso_id_seq', 1, false);


--
-- TOC entry 5777 (class 0 OID 0)
-- Dependencies: 244
-- Name: documentos_conductor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documentos_conductor_id_seq', 1, false);


--
-- TOC entry 5778 (class 0 OID 0)
-- Dependencies: 246
-- Name: emergencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emergencia_id_seq', 1, false);


--
-- TOC entry 5779 (class 0 OID 0)
-- Dependencies: 295
-- Name: grupos_viaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupos_viaje_id_seq', 1, false);


--
-- TOC entry 5780 (class 0 OID 0)
-- Dependencies: 248
-- Name: historial_verificacion_conductor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_verificacion_conductor_id_seq', 1, false);


--
-- TOC entry 5781 (class 0 OID 0)
-- Dependencies: 287
-- Name: intentos_verificacion_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.intentos_verificacion_email_id_seq', 1, false);


--
-- TOC entry 5782 (class 0 OID 0)
-- Dependencies: 251
-- Name: mensaje_comunidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mensaje_comunidad_id_seq', 1, false);


--
-- TOC entry 5783 (class 0 OID 0)
-- Dependencies: 252
-- Name: mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mensaje_id_seq', 1, false);


--
-- TOC entry 5784 (class 0 OID 0)
-- Dependencies: 254
-- Name: metodo_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metodo_pago_id_seq', 1, false);


--
-- TOC entry 5785 (class 0 OID 0)
-- Dependencies: 297
-- Name: miembros_grupo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.miembros_grupo_id_seq', 1, false);


--
-- TOC entry 5786 (class 0 OID 0)
-- Dependencies: 256
-- Name: notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacion_id_seq', 1, false);


--
-- TOC entry 5787 (class 0 OID 0)
-- Dependencies: 293
-- Name: notificaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificaciones_id_seq', 1, false);


--
-- TOC entry 5788 (class 0 OID 0)
-- Dependencies: 258
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_method_id_seq', 1, false);


--
-- TOC entry 5789 (class 0 OID 0)
-- Dependencies: 261
-- Name: referido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referido_id_seq', 1, false);


--
-- TOC entry 5790 (class 0 OID 0)
-- Dependencies: 263
-- Name: reserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reserva_id_seq', 1, false);


--
-- TOC entry 5791 (class 0 OID 0)
-- Dependencies: 265
-- Name: ruta_favorita_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ruta_favorita_id_seq', 1, false);


--
-- TOC entry 5792 (class 0 OID 0)
-- Dependencies: 301
-- Name: rutas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rutas_id_seq', 1, false);


--
-- TOC entry 5793 (class 0 OID 0)
-- Dependencies: 267
-- Name: solicitudes_recarga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_recarga_id_seq', 1, false);


--
-- TOC entry 5794 (class 0 OID 0)
-- Dependencies: 269
-- Name: transaccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaccion_id_seq', 1, false);


--
-- TOC entry 5795 (class 0 OID 0)
-- Dependencies: 271
-- Name: ubicacion_viaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ubicacion_viaje_id_seq', 1, false);


--
-- TOC entry 5796 (class 0 OID 0)
-- Dependencies: 273
-- Name: universidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universidad_id_seq', 1, false);


--
-- TOC entry 5797 (class 0 OID 0)
-- Dependencies: 299
-- Name: usuario_bloqueado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_bloqueado_id_seq', 1, false);


--
-- TOC entry 5798 (class 0 OID 0)
-- Dependencies: 275
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 1, true);


--
-- TOC entry 5799 (class 0 OID 0)
-- Dependencies: 277
-- Name: vehiculo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehiculo_id_seq', 1, false);


--
-- TOC entry 5800 (class 0 OID 0)
-- Dependencies: 279
-- Name: viaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.viaje_id_seq', 1, false);


--
-- TOC entry 5801 (class 0 OID 0)
-- Dependencies: 282
-- Name: wallet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_id_seq', 1, true);


--
-- TOC entry 5802 (class 0 OID 0)
-- Dependencies: 284
-- Name: withdrawal_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawal_request_id_seq', 1, false);


--
-- TOC entry 5361 (class 2606 OID 57489)
-- Name: alerta_emergencia alerta_emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_emergencia
    ADD CONSTRAINT alerta_emergencia_pkey PRIMARY KEY (id);


--
-- TOC entry 5223 (class 2606 OID 41381)
-- Name: badge badge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badge
    ADD CONSTRAINT badge_pkey PRIMARY KEY (id);


--
-- TOC entry 5225 (class 2606 OID 41383)
-- Name: calificacion calificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificacion
    ADD CONSTRAINT calificacion_pkey PRIMARY KEY (id);


--
-- TOC entry 5227 (class 2606 OID 41385)
-- Name: carrera carrera_nombre_id_universidad_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT carrera_nombre_id_universidad_key UNIQUE (nombre, id_universidad);


--
-- TOC entry 5229 (class 2606 OID 41387)
-- Name: carrera carrera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (id);


--
-- TOC entry 5232 (class 2606 OID 41389)
-- Name: chat chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (id);


--
-- TOC entry 5353 (class 2606 OID 57449)
-- Name: codigos_verificacion_email codigos_verificacion_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigos_verificacion_email
    ADD CONSTRAINT codigos_verificacion_email_pkey PRIMARY KEY (id);


--
-- TOC entry 5235 (class 2606 OID 41391)
-- Name: comprobante_recarga comprobante_recarga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprobante_recarga
    ADD CONSTRAINT comprobante_recarga_pkey PRIMARY KEY (id);


--
-- TOC entry 5239 (class 2606 OID 41393)
-- Name: conductor_favorito conductor_favorito_id_usuario_id_conductor_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_favorito
    ADD CONSTRAINT conductor_favorito_id_usuario_id_conductor_key UNIQUE (id_usuario, id_conductor);


--
-- TOC entry 5241 (class 2606 OID 41395)
-- Name: conductor_favorito conductor_favorito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_favorito
    ADD CONSTRAINT conductor_favorito_pkey PRIMARY KEY (id);


--
-- TOC entry 5244 (class 2606 OID 41397)
-- Name: configuracion_emergencia configuracion_emergencia_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion_emergencia
    ADD CONSTRAINT configuracion_emergencia_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 5246 (class 2606 OID 41399)
-- Name: configuracion_emergencia configuracion_emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion_emergencia
    ADD CONSTRAINT configuracion_emergencia_pkey PRIMARY KEY (id);


--
-- TOC entry 5249 (class 2606 OID 41401)
-- Name: confirmaciones_pago_efectivo confirmaciones_pago_efectivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmaciones_pago_efectivo
    ADD CONSTRAINT confirmaciones_pago_efectivo_pkey PRIMARY KEY (id);


--
-- TOC entry 5252 (class 2606 OID 41403)
-- Name: contacto_emergencia contacto_emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacto_emergencia
    ADD CONSTRAINT contacto_emergencia_pkey PRIMARY KEY (id);


--
-- TOC entry 5364 (class 2606 OID 57507)
-- Name: contactos_emergencia contactos_emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contactos_emergencia
    ADD CONSTRAINT contactos_emergencia_pkey PRIMARY KEY (id);


--
-- TOC entry 5254 (class 2606 OID 41405)
-- Name: cuenta_recepcion cuenta_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_recepcion
    ADD CONSTRAINT cuenta_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 5256 (class 2606 OID 41407)
-- Name: cupon cupon_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon
    ADD CONSTRAINT cupon_codigo_key UNIQUE (codigo);


--
-- TOC entry 5258 (class 2606 OID 41409)
-- Name: cupon cupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon
    ADD CONSTRAINT cupon_pkey PRIMARY KEY (id);


--
-- TOC entry 5261 (class 2606 OID 41411)
-- Name: cupon_uso cupon_uso_id_cupon_id_usuario_id_viaje_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso
    ADD CONSTRAINT cupon_uso_id_cupon_id_usuario_id_viaje_key UNIQUE (id_cupon, id_usuario, id_viaje);


--
-- TOC entry 5263 (class 2606 OID 41413)
-- Name: cupon_uso cupon_uso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso
    ADD CONSTRAINT cupon_uso_pkey PRIMARY KEY (id);


--
-- TOC entry 5266 (class 2606 OID 41415)
-- Name: documentos_conductor documentos_conductor_id_conductor_tipo_documento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_conductor
    ADD CONSTRAINT documentos_conductor_id_conductor_tipo_documento_key UNIQUE (id_conductor, tipo_documento);


--
-- TOC entry 5268 (class 2606 OID 41417)
-- Name: documentos_conductor documentos_conductor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_conductor
    ADD CONSTRAINT documentos_conductor_pkey PRIMARY KEY (id);


--
-- TOC entry 5273 (class 2606 OID 41419)
-- Name: emergencia emergencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergencia
    ADD CONSTRAINT emergencia_pkey PRIMARY KEY (id);


--
-- TOC entry 5371 (class 2606 OID 57547)
-- Name: grupos_viaje grupos_viaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos_viaje
    ADD CONSTRAINT grupos_viaje_pkey PRIMARY KEY (id);


--
-- TOC entry 5275 (class 2606 OID 41421)
-- Name: historial_verificacion_conductor historial_verificacion_conductor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_verificacion_conductor
    ADD CONSTRAINT historial_verificacion_conductor_pkey PRIMARY KEY (id);


--
-- TOC entry 5359 (class 2606 OID 57466)
-- Name: intentos_verificacion_email intentos_verificacion_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intentos_verificacion_email
    ADD CONSTRAINT intentos_verificacion_email_pkey PRIMARY KEY (id);


--
-- TOC entry 5280 (class 2606 OID 41423)
-- Name: mensaje_comunidad mensaje_comunidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_comunidad
    ADD CONSTRAINT mensaje_comunidad_pkey PRIMARY KEY (id);


--
-- TOC entry 5278 (class 2606 OID 41425)
-- Name: mensaje mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_pkey PRIMARY KEY (id);


--
-- TOC entry 5282 (class 2606 OID 41427)
-- Name: metodo_pago metodo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodo_pago
    ADD CONSTRAINT metodo_pago_pkey PRIMARY KEY (id);


--
-- TOC entry 5376 (class 2606 OID 57564)
-- Name: miembros_grupo miembros_grupo_id_grupo_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembros_grupo
    ADD CONSTRAINT miembros_grupo_id_grupo_id_usuario_key UNIQUE (id_grupo, id_usuario);


--
-- TOC entry 5378 (class 2606 OID 57562)
-- Name: miembros_grupo miembros_grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembros_grupo
    ADD CONSTRAINT miembros_grupo_pkey PRIMARY KEY (id);


--
-- TOC entry 5285 (class 2606 OID 41429)
-- Name: notificacion notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id);


--
-- TOC entry 5369 (class 2606 OID 57523)
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 5289 (class 2606 OID 41431)
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- TOC entry 5293 (class 2606 OID 41433)
-- Name: referido referido_id_referidor_id_referido_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referido
    ADD CONSTRAINT referido_id_referidor_id_referido_key UNIQUE (id_referidor, id_referido);


--
-- TOC entry 5295 (class 2606 OID 41435)
-- Name: referido referido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referido
    ADD CONSTRAINT referido_pkey PRIMARY KEY (id);


--
-- TOC entry 5301 (class 2606 OID 41437)
-- Name: reserva reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_pkey PRIMARY KEY (id);


--
-- TOC entry 5304 (class 2606 OID 41439)
-- Name: ruta_favorita ruta_favorita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_favorita
    ADD CONSTRAINT ruta_favorita_pkey PRIMARY KEY (id);


--
-- TOC entry 5387 (class 2606 OID 57625)
-- Name: rutas rutas_id_viaje_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutas
    ADD CONSTRAINT rutas_id_viaje_key UNIQUE (id_viaje);


--
-- TOC entry 5389 (class 2606 OID 57623)
-- Name: rutas rutas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutas
    ADD CONSTRAINT rutas_pkey PRIMARY KEY (id);


--
-- TOC entry 5310 (class 2606 OID 41441)
-- Name: solicitudes_recarga solicitudes_recarga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_recarga
    ADD CONSTRAINT solicitudes_recarga_pkey PRIMARY KEY (id);


--
-- TOC entry 5312 (class 2606 OID 41443)
-- Name: transaccion transaccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_pkey PRIMARY KEY (id);


--
-- TOC entry 5316 (class 2606 OID 41445)
-- Name: ubicacion_viaje ubicacion_viaje_id_viaje_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion_viaje
    ADD CONSTRAINT ubicacion_viaje_id_viaje_id_usuario_key UNIQUE (id_viaje, id_usuario);


--
-- TOC entry 5318 (class 2606 OID 41447)
-- Name: ubicacion_viaje ubicacion_viaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion_viaje
    ADD CONSTRAINT ubicacion_viaje_pkey PRIMARY KEY (id);


--
-- TOC entry 5320 (class 2606 OID 41449)
-- Name: universidad universidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidad
    ADD CONSTRAINT universidad_pkey PRIMARY KEY (id);


--
-- TOC entry 5382 (class 2606 OID 57595)
-- Name: usuario_bloqueado usuario_bloqueado_id_usuario_id_usuario_bloqueado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_bloqueado
    ADD CONSTRAINT usuario_bloqueado_id_usuario_id_usuario_bloqueado_key UNIQUE (id_usuario, id_usuario_bloqueado);


--
-- TOC entry 5384 (class 2606 OID 57593)
-- Name: usuario_bloqueado usuario_bloqueado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_bloqueado
    ADD CONSTRAINT usuario_bloqueado_pkey PRIMARY KEY (id);


--
-- TOC entry 5329 (class 2606 OID 41451)
-- Name: usuario usuario_codigo_referido_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_codigo_referido_key UNIQUE (codigo_referido);


--
-- TOC entry 5331 (class 2606 OID 41453)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 5333 (class 2606 OID 41455)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 5335 (class 2606 OID 41457)
-- Name: vehiculo vehiculo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_pkey PRIMARY KEY (id);


--
-- TOC entry 5337 (class 2606 OID 41459)
-- Name: vehiculo vehiculo_placa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_placa_key UNIQUE (placa);


--
-- TOC entry 5343 (class 2606 OID 41461)
-- Name: viaje viaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_pkey PRIMARY KEY (id);


--
-- TOC entry 5345 (class 2606 OID 41463)
-- Name: wallet wallet_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 5347 (class 2606 OID 41465)
-- Name: wallet wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id);


--
-- TOC entry 5351 (class 2606 OID 41467)
-- Name: withdrawal_request withdrawal_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_request
    ADD CONSTRAINT withdrawal_request_pkey PRIMARY KEY (id);


--
-- TOC entry 5362 (class 1259 OID 57495)
-- Name: idx_alerta_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_alerta_usuario ON public.alerta_emergencia USING btree (id_usuario);


--
-- TOC entry 5230 (class 1259 OID 41468)
-- Name: idx_carrera_universidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_carrera_universidad ON public.carrera USING btree (id_universidad);


--
-- TOC entry 5233 (class 1259 OID 41469)
-- Name: idx_chat_usuarios; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_usuarios ON public.chat USING btree (id_usuario1, id_usuario2);


--
-- TOC entry 5354 (class 1259 OID 57473)
-- Name: idx_codigo_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_codigo_email ON public.codigos_verificacion_email USING btree (email);


--
-- TOC entry 5355 (class 1259 OID 57472)
-- Name: idx_codigo_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_codigo_usuario ON public.codigos_verificacion_email USING btree (id_usuario);


--
-- TOC entry 5356 (class 1259 OID 57474)
-- Name: idx_codigo_valido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_codigo_valido ON public.codigos_verificacion_email USING btree (usado, fecha_expiracion) WHERE (usado = false);


--
-- TOC entry 5236 (class 1259 OID 41470)
-- Name: idx_comprobante_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comprobante_fecha ON public.comprobante_recarga USING btree (fecha_solicitud);


--
-- TOC entry 5237 (class 1259 OID 41471)
-- Name: idx_comprobante_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comprobante_usuario ON public.comprobante_recarga USING btree (id_usuario);


--
-- TOC entry 5242 (class 1259 OID 41472)
-- Name: idx_conductor_favorito_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conductor_favorito_usuario ON public.conductor_favorito USING btree (id_usuario);


--
-- TOC entry 5247 (class 1259 OID 57576)
-- Name: idx_config_emergencia_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_config_emergencia_usuario ON public.configuracion_emergencia USING btree (id_usuario);


--
-- TOC entry 5250 (class 1259 OID 41473)
-- Name: idx_confirmaciones_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_confirmaciones_pago ON public.confirmaciones_pago_efectivo USING btree (id_reserva);


--
-- TOC entry 5365 (class 1259 OID 57575)
-- Name: idx_contactos_emergencia_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contactos_emergencia_usuario ON public.contactos_emergencia USING btree (id_usuario);


--
-- TOC entry 5259 (class 1259 OID 41474)
-- Name: idx_cupon_codigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cupon_codigo ON public.cupon USING btree (codigo);


--
-- TOC entry 5264 (class 1259 OID 41475)
-- Name: idx_cupon_uso_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cupon_uso_usuario ON public.cupon_uso USING btree (id_usuario);


--
-- TOC entry 5269 (class 1259 OID 41476)
-- Name: idx_documentos_conductor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_documentos_conductor ON public.documentos_conductor USING btree (id_conductor);


--
-- TOC entry 5270 (class 1259 OID 41477)
-- Name: idx_documentos_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_documentos_estado ON public.documentos_conductor USING btree (estado);


--
-- TOC entry 5271 (class 1259 OID 41478)
-- Name: idx_documentos_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_documentos_tipo ON public.documentos_conductor USING btree (tipo_documento);


--
-- TOC entry 5372 (class 1259 OID 57579)
-- Name: idx_grupos_viaje_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_grupos_viaje_estado ON public.grupos_viaje USING btree (estado);


--
-- TOC entry 5373 (class 1259 OID 57580)
-- Name: idx_grupos_viaje_organizador; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_grupos_viaje_organizador ON public.grupos_viaje USING btree (id_organizador);


--
-- TOC entry 5276 (class 1259 OID 41479)
-- Name: idx_historial_conductor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_historial_conductor ON public.historial_verificacion_conductor USING btree (id_conductor);


--
-- TOC entry 5357 (class 1259 OID 57476)
-- Name: idx_intentos_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_intentos_usuario ON public.intentos_verificacion_email USING btree (id_usuario);


--
-- TOC entry 5374 (class 1259 OID 57581)
-- Name: idx_miembros_grupo_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_miembros_grupo_usuario ON public.miembros_grupo USING btree (id_usuario);


--
-- TOC entry 5283 (class 1259 OID 41480)
-- Name: idx_notificacion_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificacion_usuario ON public.notificacion USING btree (id_usuario);


--
-- TOC entry 5366 (class 1259 OID 57578)
-- Name: idx_notificaciones_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificaciones_tipo ON public.notificaciones USING btree (tipo);


--
-- TOC entry 5367 (class 1259 OID 57577)
-- Name: idx_notificaciones_usuario_leida; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificaciones_usuario_leida ON public.notificaciones USING btree (id_usuario, leida);


--
-- TOC entry 5286 (class 1259 OID 41481)
-- Name: idx_payment_method_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_method_activo ON public.payment_method USING btree (activo);


--
-- TOC entry 5287 (class 1259 OID 41482)
-- Name: idx_payment_method_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_method_usuario ON public.payment_method USING btree (id_usuario);


--
-- TOC entry 5290 (class 1259 OID 41483)
-- Name: idx_referido_codigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_referido_codigo ON public.referido USING btree (codigo_referido);


--
-- TOC entry 5291 (class 1259 OID 41484)
-- Name: idx_referido_referidor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_referido_referidor ON public.referido USING btree (id_referidor);


--
-- TOC entry 5296 (class 1259 OID 41485)
-- Name: idx_reserva_efectivo_pendiente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reserva_efectivo_pendiente ON public.reserva USING btree (metodo_pago, pago_efectivo_confirmado) WHERE (((metodo_pago)::text = 'EFECTIVO'::text) AND (pago_efectivo_confirmado = false));


--
-- TOC entry 5297 (class 1259 OID 41486)
-- Name: idx_reserva_metodo_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reserva_metodo_pago ON public.reserva USING btree (metodo_pago);


--
-- TOC entry 5298 (class 1259 OID 41487)
-- Name: idx_reserva_pasajero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reserva_pasajero ON public.reserva USING btree (id_pasajero);


--
-- TOC entry 5299 (class 1259 OID 41488)
-- Name: idx_reserva_viaje; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reserva_viaje ON public.reserva USING btree (id_viaje);


--
-- TOC entry 5302 (class 1259 OID 41489)
-- Name: idx_ruta_favorita_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ruta_favorita_usuario ON public.ruta_favorita USING btree (id_usuario);


--
-- TOC entry 5385 (class 1259 OID 57631)
-- Name: idx_rutas_viaje; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rutas_viaje ON public.rutas USING btree (id_viaje);


--
-- TOC entry 5305 (class 1259 OID 41490)
-- Name: idx_solicitudes_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_solicitudes_estado ON public.solicitudes_recarga USING btree (estado);


--
-- TOC entry 5306 (class 1259 OID 41491)
-- Name: idx_solicitudes_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_solicitudes_fecha ON public.solicitudes_recarga USING btree (fecha_solicitud DESC);


--
-- TOC entry 5307 (class 1259 OID 41492)
-- Name: idx_solicitudes_metodo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_solicitudes_metodo ON public.solicitudes_recarga USING btree (metodo);


--
-- TOC entry 5308 (class 1259 OID 41493)
-- Name: idx_solicitudes_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_solicitudes_usuario ON public.solicitudes_recarga USING btree (id_usuario);


--
-- TOC entry 5313 (class 1259 OID 41494)
-- Name: idx_ubicacion_viaje_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ubicacion_viaje_usuario ON public.ubicacion_viaje USING btree (id_usuario);


--
-- TOC entry 5314 (class 1259 OID 41495)
-- Name: idx_ubicacion_viaje_viaje; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ubicacion_viaje_viaje ON public.ubicacion_viaje USING btree (id_viaje);


--
-- TOC entry 5379 (class 1259 OID 57608)
-- Name: idx_usuario_bloqueado_bloqueado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_bloqueado_bloqueado ON public.usuario_bloqueado USING btree (id_usuario_bloqueado);


--
-- TOC entry 5380 (class 1259 OID 57607)
-- Name: idx_usuario_bloqueado_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_bloqueado_usuario ON public.usuario_bloqueado USING btree (id_usuario);


--
-- TOC entry 5321 (class 1259 OID 65788)
-- Name: idx_usuario_correo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_correo ON public.usuario USING btree (correo);


--
-- TOC entry 5322 (class 1259 OID 57475)
-- Name: idx_usuario_email_verificado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_email_verificado ON public.usuario USING btree (email_verificado);


--
-- TOC entry 5323 (class 1259 OID 65790)
-- Name: idx_usuario_rating; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_rating ON public.usuario USING btree (calificacion_promedio DESC);


--
-- TOC entry 5324 (class 1259 OID 41496)
-- Name: idx_usuario_ubicacion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_ubicacion ON public.usuario USING btree (ubicacion_lat, ubicacion_lng);


--
-- TOC entry 5325 (class 1259 OID 57609)
-- Name: idx_usuario_ultima_conexion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_ultima_conexion ON public.usuario USING btree (ultima_conexion);


--
-- TOC entry 5326 (class 1259 OID 41497)
-- Name: idx_usuario_universidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_universidad ON public.usuario USING btree (id_universidad);


--
-- TOC entry 5327 (class 1259 OID 41498)
-- Name: idx_usuario_verificacion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuario_verificacion ON public.usuario USING btree (estado_verificacion_conductor);


--
-- TOC entry 5338 (class 1259 OID 41499)
-- Name: idx_viaje_conductor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_viaje_conductor ON public.viaje USING btree (id_conductor);


--
-- TOC entry 5339 (class 1259 OID 41500)
-- Name: idx_viaje_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_viaje_estado ON public.viaje USING btree (estado);


--
-- TOC entry 5340 (class 1259 OID 41501)
-- Name: idx_viaje_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_viaje_fecha ON public.viaje USING btree (fecha_hora);


--
-- TOC entry 5341 (class 1259 OID 65789)
-- Name: idx_viaje_search; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_viaje_search ON public.viaje USING btree (estado, fecha_hora, origen);


--
-- TOC entry 5348 (class 1259 OID 41502)
-- Name: idx_withdrawal_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_withdrawal_estado ON public.withdrawal_request USING btree (estado);


--
-- TOC entry 5349 (class 1259 OID 41503)
-- Name: idx_withdrawal_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_withdrawal_usuario ON public.withdrawal_request USING btree (id_usuario);


--
-- TOC entry 5599 (class 2618 OID 41184)
-- Name: perfil_usuario _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.perfil_usuario AS
 SELECT u.id,
    u.nombre,
    u.correo,
    u.password,
    u.telefono,
    u.id_universidad,
    u.carrera,
    u.rol,
    u.foto_perfil,
    u.calificacion_promedio,
    u.total_viajes,
    u.total_ahorrado,
    u.verificado,
    u.activo,
    u.fecha_registro,
    uni.nombre AS nombre_universidad,
    w.saldo,
    count(DISTINCT r.id) AS total_reservas,
    count(DISTINCT
        CASE
            WHEN ((v.estado)::text = 'COMPLETADO'::text) THEN v.id
            ELSE NULL::integer
        END) AS viajes_completados
   FROM ((((public.usuario u
     LEFT JOIN public.universidad uni ON ((u.id_universidad = uni.id)))
     LEFT JOIN public.wallet w ON ((u.id = w.id_usuario)))
     LEFT JOIN public.reserva r ON ((u.id = r.id_pasajero)))
     LEFT JOIN public.viaje v ON ((u.id = v.id_conductor)))
  GROUP BY u.id, uni.nombre, w.saldo;


--
-- TOC entry 5451 (class 2620 OID 41505)
-- Name: usuario trigger_crear_wallet; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_crear_wallet AFTER INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.crear_wallet_usuario();


--
-- TOC entry 5442 (class 2606 OID 57490)
-- Name: alerta_emergencia alerta_emergencia_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_emergencia
    ADD CONSTRAINT alerta_emergencia_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5390 (class 2606 OID 41506)
-- Name: badge badge_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badge
    ADD CONSTRAINT badge_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5391 (class 2606 OID 41511)
-- Name: calificacion calificacion_id_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificacion
    ADD CONSTRAINT calificacion_id_autor_fkey FOREIGN KEY (id_autor) REFERENCES public.usuario(id);


--
-- TOC entry 5392 (class 2606 OID 41516)
-- Name: calificacion calificacion_id_destinatario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificacion
    ADD CONSTRAINT calificacion_id_destinatario_fkey FOREIGN KEY (id_destinatario) REFERENCES public.usuario(id);


--
-- TOC entry 5393 (class 2606 OID 41521)
-- Name: calificacion calificacion_id_viaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificacion
    ADD CONSTRAINT calificacion_id_viaje_fkey FOREIGN KEY (id_viaje) REFERENCES public.viaje(id);


--
-- TOC entry 5394 (class 2606 OID 41526)
-- Name: carrera carrera_id_universidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT carrera_id_universidad_fkey FOREIGN KEY (id_universidad) REFERENCES public.universidad(id);


--
-- TOC entry 5395 (class 2606 OID 41531)
-- Name: chat chat_id_usuario1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_id_usuario1_fkey FOREIGN KEY (id_usuario1) REFERENCES public.usuario(id);


--
-- TOC entry 5396 (class 2606 OID 41536)
-- Name: chat chat_id_usuario2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_id_usuario2_fkey FOREIGN KEY (id_usuario2) REFERENCES public.usuario(id);


--
-- TOC entry 5440 (class 2606 OID 57450)
-- Name: codigos_verificacion_email codigos_verificacion_email_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigos_verificacion_email
    ADD CONSTRAINT codigos_verificacion_email_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5397 (class 2606 OID 41541)
-- Name: comprobante_recarga comprobante_recarga_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprobante_recarga
    ADD CONSTRAINT comprobante_recarga_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5398 (class 2606 OID 41546)
-- Name: conductor_favorito conductor_favorito_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_favorito
    ADD CONSTRAINT conductor_favorito_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5399 (class 2606 OID 41551)
-- Name: conductor_favorito conductor_favorito_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_favorito
    ADD CONSTRAINT conductor_favorito_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5400 (class 2606 OID 41556)
-- Name: configuracion_emergencia configuracion_emergencia_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion_emergencia
    ADD CONSTRAINT configuracion_emergencia_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5401 (class 2606 OID 41561)
-- Name: confirmaciones_pago_efectivo confirmaciones_pago_efectivo_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmaciones_pago_efectivo
    ADD CONSTRAINT confirmaciones_pago_efectivo_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id);


--
-- TOC entry 5402 (class 2606 OID 41566)
-- Name: confirmaciones_pago_efectivo confirmaciones_pago_efectivo_id_pasajero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmaciones_pago_efectivo
    ADD CONSTRAINT confirmaciones_pago_efectivo_id_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES public.usuario(id);


--
-- TOC entry 5403 (class 2606 OID 41571)
-- Name: confirmaciones_pago_efectivo confirmaciones_pago_efectivo_id_reserva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmaciones_pago_efectivo
    ADD CONSTRAINT confirmaciones_pago_efectivo_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id) ON DELETE CASCADE;


--
-- TOC entry 5404 (class 2606 OID 41576)
-- Name: contacto_emergencia contacto_emergencia_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacto_emergencia
    ADD CONSTRAINT contacto_emergencia_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5443 (class 2606 OID 57508)
-- Name: contactos_emergencia contactos_emergencia_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contactos_emergencia
    ADD CONSTRAINT contactos_emergencia_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5405 (class 2606 OID 41581)
-- Name: cupon cupon_id_creador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon
    ADD CONSTRAINT cupon_id_creador_fkey FOREIGN KEY (id_creador) REFERENCES public.usuario(id);


--
-- TOC entry 5406 (class 2606 OID 41586)
-- Name: cupon_uso cupon_uso_id_cupon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso
    ADD CONSTRAINT cupon_uso_id_cupon_fkey FOREIGN KEY (id_cupon) REFERENCES public.cupon(id) ON DELETE CASCADE;


--
-- TOC entry 5407 (class 2606 OID 41591)
-- Name: cupon_uso cupon_uso_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso
    ADD CONSTRAINT cupon_uso_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5408 (class 2606 OID 41596)
-- Name: cupon_uso cupon_uso_id_viaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_uso
    ADD CONSTRAINT cupon_uso_id_viaje_fkey FOREIGN KEY (id_viaje) REFERENCES public.viaje(id);


--
-- TOC entry 5409 (class 2606 OID 41601)
-- Name: documentos_conductor documentos_conductor_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_conductor
    ADD CONSTRAINT documentos_conductor_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5410 (class 2606 OID 41606)
-- Name: documentos_conductor documentos_conductor_id_revisor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_conductor
    ADD CONSTRAINT documentos_conductor_id_revisor_fkey FOREIGN KEY (id_revisor) REFERENCES public.usuario(id);


--
-- TOC entry 5411 (class 2606 OID 41611)
-- Name: emergencia emergencia_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergencia
    ADD CONSTRAINT emergencia_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5445 (class 2606 OID 57548)
-- Name: grupos_viaje grupos_viaje_id_organizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos_viaje
    ADD CONSTRAINT grupos_viaje_id_organizador_fkey FOREIGN KEY (id_organizador) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5412 (class 2606 OID 41616)
-- Name: historial_verificacion_conductor historial_verificacion_conductor_id_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_verificacion_conductor
    ADD CONSTRAINT historial_verificacion_conductor_id_admin_fkey FOREIGN KEY (id_admin) REFERENCES public.usuario(id);


--
-- TOC entry 5413 (class 2606 OID 41621)
-- Name: historial_verificacion_conductor historial_verificacion_conductor_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_verificacion_conductor
    ADD CONSTRAINT historial_verificacion_conductor_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5441 (class 2606 OID 57467)
-- Name: intentos_verificacion_email intentos_verificacion_email_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intentos_verificacion_email
    ADD CONSTRAINT intentos_verificacion_email_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5416 (class 2606 OID 41626)
-- Name: mensaje_comunidad mensaje_comunidad_id_universidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_comunidad
    ADD CONSTRAINT mensaje_comunidad_id_universidad_fkey FOREIGN KEY (id_universidad) REFERENCES public.universidad(id);


--
-- TOC entry 5417 (class 2606 OID 41631)
-- Name: mensaje_comunidad mensaje_comunidad_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_comunidad
    ADD CONSTRAINT mensaje_comunidad_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5414 (class 2606 OID 41636)
-- Name: mensaje mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_id_chat_fkey FOREIGN KEY (id_chat) REFERENCES public.chat(id);


--
-- TOC entry 5415 (class 2606 OID 41641)
-- Name: mensaje mensaje_id_remitente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_id_remitente_fkey FOREIGN KEY (id_remitente) REFERENCES public.usuario(id);


--
-- TOC entry 5418 (class 2606 OID 41646)
-- Name: metodo_pago metodo_pago_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodo_pago
    ADD CONSTRAINT metodo_pago_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5446 (class 2606 OID 57565)
-- Name: miembros_grupo miembros_grupo_id_grupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembros_grupo
    ADD CONSTRAINT miembros_grupo_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES public.grupos_viaje(id) ON DELETE CASCADE;


--
-- TOC entry 5447 (class 2606 OID 57570)
-- Name: miembros_grupo miembros_grupo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembros_grupo
    ADD CONSTRAINT miembros_grupo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5419 (class 2606 OID 41651)
-- Name: notificacion notificacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5444 (class 2606 OID 57524)
-- Name: notificaciones notificaciones_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5420 (class 2606 OID 41656)
-- Name: payment_method payment_method_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5421 (class 2606 OID 41661)
-- Name: referido referido_id_referido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referido
    ADD CONSTRAINT referido_id_referido_fkey FOREIGN KEY (id_referido) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5422 (class 2606 OID 41666)
-- Name: referido referido_id_referidor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referido
    ADD CONSTRAINT referido_id_referidor_fkey FOREIGN KEY (id_referidor) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5423 (class 2606 OID 41671)
-- Name: reserva reserva_confirmado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_confirmado_por_fkey FOREIGN KEY (confirmado_por) REFERENCES public.usuario(id);


--
-- TOC entry 5424 (class 2606 OID 41676)
-- Name: reserva reserva_id_pasajero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES public.usuario(id);


--
-- TOC entry 5425 (class 2606 OID 41681)
-- Name: reserva reserva_id_viaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_viaje_fkey FOREIGN KEY (id_viaje) REFERENCES public.viaje(id);


--
-- TOC entry 5426 (class 2606 OID 41686)
-- Name: ruta_favorita ruta_favorita_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_favorita
    ADD CONSTRAINT ruta_favorita_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5450 (class 2606 OID 57626)
-- Name: rutas rutas_id_viaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutas
    ADD CONSTRAINT rutas_id_viaje_fkey FOREIGN KEY (id_viaje) REFERENCES public.viaje(id) ON DELETE CASCADE;


--
-- TOC entry 5427 (class 2606 OID 41691)
-- Name: solicitudes_recarga solicitudes_recarga_id_revisor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_recarga
    ADD CONSTRAINT solicitudes_recarga_id_revisor_fkey FOREIGN KEY (id_revisor) REFERENCES public.usuario(id);


--
-- TOC entry 5428 (class 2606 OID 41696)
-- Name: solicitudes_recarga solicitudes_recarga_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_recarga
    ADD CONSTRAINT solicitudes_recarga_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5429 (class 2606 OID 41701)
-- Name: transaccion transaccion_id_solicitud_recarga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_id_solicitud_recarga_fkey FOREIGN KEY (id_solicitud_recarga) REFERENCES public.solicitudes_recarga(id);


--
-- TOC entry 5430 (class 2606 OID 41706)
-- Name: transaccion transaccion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5431 (class 2606 OID 41711)
-- Name: ubicacion_viaje ubicacion_viaje_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion_viaje
    ADD CONSTRAINT ubicacion_viaje_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5432 (class 2606 OID 41716)
-- Name: ubicacion_viaje ubicacion_viaje_id_viaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion_viaje
    ADD CONSTRAINT ubicacion_viaje_id_viaje_fkey FOREIGN KEY (id_viaje) REFERENCES public.viaje(id) ON DELETE CASCADE;


--
-- TOC entry 5448 (class 2606 OID 57601)
-- Name: usuario_bloqueado usuario_bloqueado_id_usuario_bloqueado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_bloqueado
    ADD CONSTRAINT usuario_bloqueado_id_usuario_bloqueado_fkey FOREIGN KEY (id_usuario_bloqueado) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5449 (class 2606 OID 57596)
-- Name: usuario_bloqueado usuario_bloqueado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_bloqueado
    ADD CONSTRAINT usuario_bloqueado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 5433 (class 2606 OID 41721)
-- Name: usuario usuario_id_carrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_carrera_fkey FOREIGN KEY (id_carrera) REFERENCES public.carrera(id);


--
-- TOC entry 5434 (class 2606 OID 41726)
-- Name: usuario usuario_id_universidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_universidad_fkey FOREIGN KEY (id_universidad) REFERENCES public.universidad(id);


--
-- TOC entry 5435 (class 2606 OID 41731)
-- Name: vehiculo vehiculo_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id);


--
-- TOC entry 5436 (class 2606 OID 41736)
-- Name: viaje viaje_id_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_id_conductor_fkey FOREIGN KEY (id_conductor) REFERENCES public.usuario(id);


--
-- TOC entry 5437 (class 2606 OID 41741)
-- Name: wallet wallet_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5438 (class 2606 OID 41746)
-- Name: withdrawal_request withdrawal_request_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_request
    ADD CONSTRAINT withdrawal_request_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 5439 (class 2606 OID 41751)
-- Name: withdrawal_request withdrawal_request_procesado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_request
    ADD CONSTRAINT withdrawal_request_procesado_por_fkey FOREIGN KEY (procesado_por) REFERENCES public.usuario(id);


-- Completed on 2025-12-09 22:42:19

--
-- PostgreSQL database dump complete
--

\unrestrict nHr3g13o3MVm3xMGPjsghP7jntkHTqlaFEyOI8klg1J4eIYJXYIKbnQDP2uXKCJ

