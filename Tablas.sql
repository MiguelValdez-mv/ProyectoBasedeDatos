CREATE TABLE IF NOT EXISTS Sedes (
	id SERIAL PRIMARY KEY,
	descripcion VARCHAR(25) NOT NULL,
	direccion VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Direcciones_x_Ciudad(
	direccion VARCHAR(50) PRIMARY KEY,
	ciudad VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS Unidades(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	id_jefe INT UNIQUE,
	id_sede INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Empleados(
	ficha SERIAL PRIMARY KEY,
	nombre VARCHAR(35) NOT NULL,
	cedula INT NOT NULL UNIQUE,
	id_unidad INT NOT NULL	
);

CREATE TABLE IF NOT EXISTS Tipos_de_Bien(
	tipo_de_bien VARCHAR(15) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Bienes(
	id SERIAL PRIMARY KEY,
	descripcion VARCHAR(25) NOT NULL,
	status VARCHAR(25) NOT NULL,
	fecha_a DATE NOT NULL,
	fecha_d DATE,
	origen VARCHAR(10) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	id_resp_uso INT NOT NULL,

	CONSTRAINT CHK_fecha_d CHECK(fecha_d >= fecha_a),
	CONSTRAINT CHK_origen CHECK(origen IN ('Compra','Donacion','Prestamo'))
);

CREATE TABLE IF NOT EXISTS Resp_Uso_x_Unidades(
	id_resp_uso INT PRIMARY KEY,
	id_unidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Transferibles(
	id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Intransferibles(
	id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Intangibles(
	id INT PRIMARY KEY,
	fecha_cad DATE NOT NULL,
	compartida BOOLEAN NOT NULL,
	status VARCHAR(30) NOT NULL,

	CONSTRAINT CHK_status CHECK(status IN('En proceso de registro','Vigente','Vencido','Desincorporado'))
);

CREATE TABLE IF NOT EXISTS Inmuebles(
	id INT PRIMARY KEY,
	ubicacion VARCHAR(15) NOT NULL,
	superficie FLOAT NOT NULL,
	status VARCHAR(30) NOT NULL,
	tipo VARCHAR(10) NOT NULL,

	CONSTRAINT CHK_status CHECK(status IN('En proceso de registro','En Construccion','Habitado','Desincorporado','Deshabitado')),
	CONSTRAINT CHK_tipo CHECK(tipo IN('Propia','Comodato'))
);

CREATE TABLE IF NOT EXISTS Componentes(
	id_bien INT,
	id_componente SERIAL,
	nombre VARCHAR(15) NOT NULL,

	PRIMARY KEY(id_bien, id_componente)
);

CREATE TABLE IF NOT EXISTS Tangibles(
	id INT PRIMARY KEY,
	status VARCHAR(30) NOT NULL,
	num_fact INT NOT NULL,
	precio FLOAT NOT NULL,
	garantia VARCHAR(15),

	CONSTRAINT CHK_status CHECK(status IN ('En proceso de registro','Activo','Dañado','Obsoleto','En reparacion','Desincorporado'))
);

CREATE TABLE IF NOT EXISTS Bienes_Transferidos(
	nro_mov INT NOT NULL,
	id_bien INT NOT NULL,

	PRIMARY KEY(nro_mov,id_bien)
);

CREATE TABLE IF NOT EXISTS Movilizaciones(
	nro_mov SERIAL PRIMARY KEY,
	fecha DATE NOT NULL,
	motivo VARCHAR(30),
	A_RP_REC BOOLEAN NOT NULL,
	A_RP_CED BOOLEAN NOT NULL,
	ficha_RU_REC INT NOT NULL,
	ficha_RU_CED INT NOT NULL,
	id_unidad_REC INT NOT NULL,
	id_unidad_CED INT NOT NULL,

	CONSTRAINT CHK_id_ced CHECK(id_unidad_CED <> id_unidad_REC )
);

CREATE TABLE IF NOT EXISTS Inventarios(
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),
	fecha_i DATE NOT NULL,
	fecha_f DATE,
	status VARCHAR(15) NOT NULL,
	id_emp_enc INT NOT NULL,

	PRIMARY KEY(año,semestre,tipo_bien),

	CONSTRAINT CHK_fechas CHECK (fecha_f >= fecha_i),
	CONSTRAINT CHK_status CHECK (status IN ('En ejercucion','En Conciliacion','Cerrado'))
);

CREATE TABLE IF NOT EXISTS Empleados_x_Inventario(
	id_emp INT,
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),

	PRIMARY KEY(id_emp,año,semestre,tipo_bien)
);

CREATE TABLE IF NOT EXISTS Registros(
	id_bien INT,
	id_emp INT,
	detalle VARCHAR(50) NOT NULL,
	existe BOOLEAN NOT NULL,

	PRIMARY KEY(id_bien,id_emp)
);

/*esta es la relacion Posee*/
CREATE TABLE IF NOT EXISTS Registros_x_Inventario(
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),
	id_bien INT,
	id_emp INT,

	PRIMARY KEY(año,semestre,tipo_bien,id_bien,id_emp)
);

CREATE TABLE IF NOT EXISTS Hist_Responsables(
	id_emp INT,
	id_bien INT,
	fecha DATE NOT NULL,

	PRIMARY KEY(id_emp,id_bien)
);

CREATE TABLE IF NOT EXISTS Hist_Jefes(
	id_unidad INT,
	id_emp INT,
	fecha DATE NOT NULL,

	PRIMARY KEY(id_emp,id_unidad)
);

CREATE TABLE IF NOT EXISTS Empleados_Enc(
	id_emp INT PRIMARY KEY,
	id_sede INT NOT NULL
);

/*esta es la relacion tiene entre comp y tang*/
CREATE TABLE IF NOT EXISTS Componentes_x_Bien(
	id_bien INT,
	id_componente INT,

	PRIMARY KEY(id_bien,id_componente)
);

/*relacion recursiva de componente*/
CREATE TABLE IF NOT EXISTS Componentes_x_Componente(
	id_bien_contenedor INT,
	id_comp_contenedor INT,
	id_bien_contenido INT,
	id_comp_contenido INT,

	PRIMARY KEY(id_bien_contenedor,id_comp_contenedor,id_bien_contenido,id_comp_contenido)

);

CREATE TABLE IF NOT EXISTS Facturas(
	num_fact INT PRIMARY KEY,
	num_orden INT NOT NULL,
	proveedor VARCHAR(20) NOT NULL

);

CREATE TABLE IF NOT EXISTS Naturales(
	id INT PRIMARY KEY,
	status VARCHAR(25) NOT NULL,
	nombre_c VARCHAR(15) NOT NULL UNIQUE,
	fecha_p DATE NOT NULL,
	origen VARCHAR(15) NOT NULL,
	ubicacion VARCHAR(20) NOT NULL,
	foto bytea 

	CONSTRAINT CHK_status CHECK (status IN ('en proceso de registro','plantado','enfermo','extinto'))
		
);

CREATE TABLE IF NOT EXISTS Info_Arboles(
	nombre_c VARCHAR(20) PRIMARY KEY,
	nombre_V VARCHAR(20) NOT NULL,
	frutal BOOLEAN NOT NULL,
	floracion VARCHAR(15) NOT NULL
);


/*-- Indices --*/
CREATE INDEX Idx_unidades_id_jefe ON Unidades(id_jefe);
CREATE INDEX Idx_empleados_Cedula ON Empleados(cedula);