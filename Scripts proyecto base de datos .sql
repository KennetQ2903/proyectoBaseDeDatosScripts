-- ***************************************************** DICCIONARIOS *******************************************************

-- CREACION DE LA SECUENCIA FORMAS DE PAGO
CREATE SEQUENCE seq_forma_pago
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA FORMAS DE PAGO
CREATE TABLE Forma_Pago (
    id_forma_pago NUMBER DEFAULT seq_forma_pago.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(100)
);

-- CREACION DE LA SECUENCIA DEPARTAMENTOS
CREATE SEQUENCE seq_departamento
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA DEPARTAMENTO  
CREATE TABLE Departamento (
    id_departamento NUMBER DEFAULT seq_departamento.NEXTVAL PRIMARY KEY,
    codigo VARCHAR(2) NOT NULL,
    nombre VARCHAR(40)
);

-- CREACION DE LA SECUENCIA MUNICIPIOS
CREATE SEQUENCE seq_municipio
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA MUNICIPIOS  
CREATE TABLE Municipio (
    id_municipio NUMBER DEFAULT seq_municipio.NEXTVAL PRIMARY KEY,
    departamento NUMBER NOT NULL,
    codigo VARCHAR(2) NOT NULL,
    nombre VARCHAR(40),
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento)
);


-- CREACION DE LA SECUENCIA ROLES
CREATE SEQUENCE seq_rol
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- Creación de la tabla roles
CREATE TABLE Rol (
    id_rol NUMBER DEFAULT seq_rol.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- CREACION DE LA SECUENCIA ACCESOS
CREATE SEQUENCE seq_acceso
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- Creación de la tabla accesos con relación a usuarios y roles
CREATE TABLE Accesos (
    id_acceso NUMBER DEFAULT seq_acceso.NEXTVAL PRIMARY KEY,
    acceso VARCHAR2(250) NOT NULL
);

-- CREACION DE LA SECUENCIA ROLES Y ACCESOS
CREATE SEQUENCE seq_rol_acceso
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo

CREATE TABLE RolAcceso (
    ID NUMBER DEFAULT seq_rol_acceso.NEXTVAL PRIMARY KEY,
    id_rol NUMBER,
    id_acceso NUMBER,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol),
    FOREIGN KEY (id_acceso) REFERENCES Accesos(id_acceso)
);

-- ***************************************************** TABLAS *******************************************************

-- CREACION DE LA SECUENCIA USUARIOS
CREATE SEQUENCE seq_usuario
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- Creación de la tabla usuarios
CREATE TABLE Usuario (
    id_usuario NUMBER DEFAULT seq_usuario.NEXTVAL PRIMARY KEY,
    nombre_usuario VARCHAR2(50),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100) NOT NULL,
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100) NOT NULL,
    otros_apellidos VARCHAR2(100),
    password VARCHAR2(50),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    nit VARCHAR2(12),
    dpi VARCHAR2(20),
    id_rol NUMBER,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- CREACION DE LA SECUENCIA CLIENTES
CREATE SEQUENCE seq_cliente
  START WITH 1  -- Valor inicial
  INCREMENT BY 1  -- Incremento en cada siguiente valor
  MINVALUE 1  -- Valor mínimo permitido
  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
  NOCACHE  -- No almacenar valores en caché
  NOCYCLE;  -- No reiniciar después de llegar al valor máximo

-- Creación de la tabla Clientes
CREATE TABLE Cliente (
    id_cliente NUMBER DEFAULT seq_cliente.NEXTVAL PRIMARY KEY,
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100) NOT NULL,
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100) NOT NULL,
    otros_apellidos VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    email VARCHAR(250),
    nit VARCHAR2(12) UNIQUE,
    dpi VARCHAR2(20) UNIQUE,
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);

-- CREACION DE LA SECUENCIA VENDEDORES
--CREATE SEQUENCE seq_vendedor
--  START WITH 1  -- Valor inicial
--  INCREMENT BY 1  -- Incremento en cada siguiente valor
--  MINVALUE 1  -- Valor mínimo permitido
--  MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--  NOCACHE  -- No almacenar valores en caché
--  NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- Creación de la tabla vendedores
--CREATE TABLE Vendedor (
--    id_vendedor NUMBER DEFAULT seq_vendedor.NEXTVAL PRIMARY KEY,
--    primer_nombre VARCHAR2(100) NOT NULL,
--    segundo_nombre VARCHAR2(100) NOT NULL,
--    primer_apellido VARCHAR2(100) NOT NULL,
--    segundo_apellido VARCHAR2(100) NOT NULL,
--    otros_apellidos VARCHAR2(100),
--    --normalizacion de direccion
--    calle VARCHAR2(100),
--    colonia VARCHAR2(100),
--    zona VARCHAR2(50),
--    ciudad VARCHAR2(50),
--    municipio NUMBER,
--    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
--    departamento NUMBER,
--    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
--    codigo_postal VARCHAR2(10),
--    telefono VARCHAR2(20),
--    nit VARCHAR2(12) UNIQUE,
--    dpi VARCHAR2(20) UNIQUE,
--    email VARCHAR(250),
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
--);


-- CREACION DE LA SECUENCIA PROVEEDORES
CREATE SEQUENCE seq_proveedor
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- Creación de la tabla vendedores
CREATE TABLE Proveedor (
    id_proveedor NUMBER DEFAULT seq_proveedor.NEXTVAL PRIMARY KEY,
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100) NOT NULL,
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100) NOT NULL,
    otros_apellidos VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    nit VARCHAR2(12) UNIQUE,
    dpi VARCHAR2(20) UNIQUE,
    email VARCHAR(250),
    --auditoria
    usuario_creacion NUMBER NOT NULL,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER NOT NULL,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE NOT NULL,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);


-- CREACION DE LA SECUENCIA PRODUCTOS
CREATE SEQUENCE seq_producto
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
  -- Creación de la tabla Productos
CREATE TABLE Producto (
    id_producto NUMBER DEFAULT seq_producto.NEXTVAL PRIMARY KEY,
    id_proveedor NUMBER,
    codigo VARCHAR2(20) UNIQUE NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(200) NOT NULL,
    precio NUMBER NOT NULL,
    stock NUMBER NOT NULL,
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1)),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);


-- CREACION DE LA SECUENCIA EMPRESAS
CREATE SEQUENCE seq_empresa
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo

-- CREACION DE LA TABLA EMPRESA
CREATE TABLE Empresa (
    id_empresa NUMBER DEFAULT seq_empresa.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);


-- CREACION DE LA SECUENCIA SUCURSAL
CREATE SEQUENCE seq_sucursal
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo

-- CREACION DE LA TABLA SUCURSAL
CREATE TABLE Sucursal (
    id_sucursal NUMBER DEFAULT seq_sucursal.NEXTVAL PRIMARY KEY,
    id_empresa NUMBER,
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    nombre VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);


-- CREACION DE LA SECUENCIA PUNTO DE VENTA
CREATE SEQUENCE seq_punto_venta
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo

-- CREACION DE LA TABLA PUNTO DE VENTA
CREATE TABLE Punto_Venta (
    id_punto_venta NUMBER DEFAULT seq_punto_venta.NEXTVAL PRIMARY KEY,
    id_sucursal NUMBER,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    nombre VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);

-- CREACION DE LA SECUENCIA VENTAS
CREATE SEQUENCE seq_venta
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA VENTAS
CREATE TABLE Venta (
    id_venta NUMBER DEFAULT seq_venta.NEXTVAL PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    id_forma_pago NUMBER NOT NULL,
    id_punto_venta NUMBER,
    guid VARCHAR2(250) UNIQUE NOT NULL,
    fecha_venta DATE NOT NULL,
    total NUMBER(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_forma_pago) REFERENCES Forma_Pago(id_forma_pago),
    FOREIGN KEY (id_punto_venta) REFERENCES Punto_Venta(id_punto_venta)
);

-- CREACION DE LA SECUENCIA DETALLE DE VENTA
CREATE SEQUENCE seq_detalle_venta
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA DETALLE DE VENTAS
CREATE TABLE Detalle_Venta (
    id_detalle_venta NUMBER DEFAULT seq_detalle_venta.NEXTVAL PRIMARY KEY,
    id_venta NUMBER,
    id_producto NUMBER,
    cantidad NUMBER(10, 2),
    descuento NUMBER,
    impuestos NUMBER,
    subtotal NUMBER,
    total NUMBER(10, 2),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);

-- CREACION DE LA SECUENCIA COMPRAS
CREATE SEQUENCE seq_compra
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA COMPRAS
CREATE TABLE Compra (
    id_compra NUMBER DEFAULT seq_compra.NEXTVAL PRIMARY KEY,
    id_proveedor NUMBER NOT NULL,
    fecha_compra DATE NOT NULL,
    total NUMBER(10, 2),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);

-- CREACION DE LA SECUENCIA DETALLE DE COMPRA
CREATE SEQUENCE seq_detalle_compra
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA DETALLE DE COMPRAS
CREATE TABLE Detalle_Compra (
    id_detalle_compra NUMBER DEFAULT seq_detalle_compra.NEXTVAL PRIMARY KEY,
    id_compra NUMBER,
    id_producto NUMBER,
    cantidad NUMBER(10, 2),
    descuento NUMBER,
    impuestos NUMBER,
    subtotal NUMBER,
    total NUMBER(10, 2),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra)
);

-- CREACION DE LA SECUENCIA ORDE DE COMPRA
--CREATE SEQUENCE seq_orden_compra
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA ORDENES DE COMPRA
--CREATE TABLE Orden_Compra (
--    id_orden_compra NUMBER DEFAULT seq_orden_compra.NEXTVAL PRIMARY KEY,
--    id_proveedor NUMBER,
--    fecha_orden DATE,
--    total NUMBER,
--    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
--);

-- CREACION DE LA SECUENCIA COTIZACIONES
--CREATE SEQUENCE seq_cotizacion
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo

-- CREACION DE LA TABLA COTIZACIONES
--CREATE TABLE Cotizacion (
--    id_cotizacion NUMBER DEFAULT seq_cotizacion.NEXTVAL PRIMARY KEY,
--    id_cliente NUMBER,
--    fecha_cotizacion DATE NOT NULL,
--    detalle VARCHAR2(500),
--    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
--);

-- CREACION DE LA SECUENCIA COLABORADORES
CREATE SEQUENCE seq_colaborador
    START WITH 1  -- Valor inicial
    INCREMENT BY 1  -- Incremento en cada siguiente valor
    MINVALUE 1  -- Valor mínimo permitido
    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
    NOCACHE  -- No almacenar valores en caché
    NOCYCLE;  -- No reiniciar después de llegar al valor máximo

CREATE TABLE Colaborador (
    id_colaborador NUMBER DEFAULT seq_colaborador.NEXTVAL PRIMARY KEY,
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100) NOT NULL,
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100) NOT NULL,
    otros_apellidos VARCHAR2(100),
    --normalizacion de direccion
    calle VARCHAR2(100),
    colonia VARCHAR2(100),
    zona VARCHAR2(50),
    ciudad VARCHAR2(50),
    municipio NUMBER,
    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
    departamento NUMBER,
    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(20),
    nit VARCHAR2(12) UNIQUE,
    dpi VARCHAR2(20) UNIQUE,
    email VARCHAR(250),
    --auditoria
    usuario_creacion NUMBER,
    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
    usuario_mod NUMBER,
    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
    fecha_creacion DATE DEFAULT SYSDATE,
    fecha_mod DATE,
    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
);


-- CREACION DE LA SECUENCIA CUADRES
--CREATE SEQUENCE seq_cuadre
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
--  
--CREATE TABLE Cuadre (
--    id_cuadre NUMBER DEFAULT seq_cuadre.NEXTVAL PRIMARY KEY,
--    id_punto_venta NUMBER,
--    fecha_cuadre DATE NOT NULL,
--    total_articulos NUMBER,
--    total_ventas NUMBER,
--    FOREIGN KEY (id_punto_venta) REFERENCES Punto_Venta(id_punto_venta),
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
--);
  
-- CREACION DE LA SECUENCIA BITACORA
--CREATE SEQUENCE seq_bitacora
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA BITACORA
--CREATE TABLE Bitacora(
--    id_bitacora NUMBER DEFAULT seq_bitacora.NEXTVAL PRIMARY KEY,
----    id_usuario NUMBER,
--    fecha_evento DATE,
--    evento VARCHAR2(200),
----    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
--);

-- CREACION DE LA SECUENCIA BODEGAS
--CREATE SEQUENCE seq_bodega
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
  
-- CREACION DE LA TABLA BODEGAS
--CREATE TABLE Bodega(
--    id_bodega NUMBER DEFAULT seq_bodega.NEXTVAL PRIMARY KEY,
--    nombre VARCHAR2(100),
--    --normalizacion de direccion
--    calle VARCHAR2(100),
--    colonia VARCHAR2(100),
--    zona VARCHAR2(50),
--    ciudad VARCHAR2(50),
--    municipio NUMBER,
--    FOREIGN KEY (municipio) REFERENCES Municipio(id_municipio),
--    departamento NUMBER,
--    FOREIGN KEY (departamento) REFERENCES Departamento(id_departamento),
--    codigo_postal VARCHAR2(10),
--    telefono VARCHAR2(20),
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1))
--);

-- CREACION DE LA SECUENCIA TRASLADOS
--CREATE SEQUENCE seq_traslado
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
--  
---- CREACION DE LA TABLA TRASLADOS
--CREATE TABLE Traslado(
--    id_traslado NUMBER DEFAULT seq_traslado.NEXTVAL PRIMARY KEY,
--    origen_bodega_id NUMBER,
--    destino_bodega_id NUMBER,
--    fecha_traslado DATE,
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1)),
--    FOREIGN KEY (origen_bodega_id) REFERENCES Bodega(id_bodega),
--    FOREIGN KEY (destino_bodega_id) REFERENCES Bodega(id_bodega)
--);
--  
-- CREACION DE LA SECUENCIA ENVIOS
--CREATE SEQUENCE seq_envio
--    START WITH 1  -- Valor inicial
--    INCREMENT BY 1  -- Incremento en cada siguiente valor
--    MINVALUE 1  -- Valor mínimo permitido
--    MAXVALUE 999999999  -- Valor máximo (puedes ajustarlo según tus necesidades)
--    NOCACHE  -- No almacenar valores en caché
--    NOCYCLE;  -- No reiniciar después de llegar al valor máximo
--  
---- CREACION DE LA TABLA ENVIOS
--CREATE TABLE Envio(
--    id_envio NUMBER DEFAULT seq_envio.NEXTVAL PRIMARY KEY,
--    id_venta NUMBER,
--    --auditoria
--    usuario_creacion NUMBER,
--    FOREIGN KEY (usuario_creacion) REFERENCES Usuario(id_usuario),
--    usuario_mod NUMBER,
--    FOREIGN KEY (usuario_mod) REFERENCES Usuario(id_usuario),
--    fecha_creacion DATE DEFAULT SYSDATE,
--    fecha_mod DATE,
--    estado NUMBER(1) DEFAULT 1 CHECK (estado IN (0, 1)),
--    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
--);