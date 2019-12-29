CREATE TABLE IF NOT EXISTS Sedes (
	id_sede VARCHAR(5) PRIMARY KEY,
	descripcion VARCHAR(25) NOT NULL,
	direccion VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Direcciones_x_Ciudades(
	direccion VARCHAR(50) PRIMARY KEY,
	ciudad VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS Unidades(
	id_unidad VARCHAR(5) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	id_jefe VARCHAR(5) UNIQUE,
	id_sede VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS Empleados(
	ficha VARCHAR(5) PRIMARY KEY,
	nombre VARCHAR(35) NOT NULL,
	cedula INT NOT NULL,
	id_unidad VARCHAR(5) NOT NULL	
);

CREATE TABLE IF NOT EXISTS Tipos_de_Bien(
	tipo_de_bien VARCHAR(15) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Bienes(
	id_bien VARCHAR(5) PRIMARY KEY,
	descripcion VARCHAR(25) NOT NULL,
	status VARCHAR(25) NOT NULL,
	fecha_a DATE NOT NULL,
	fecha_d DATE,
	origen VARCHAR(10) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	id_resp_uso VARCHAR(5) NOT NULL,

	CONSTRAINT CHK_fecha_d CHECK(fecha_d >= fecha_a),
	CONSTRAINT CHK_origen CHECK(origen IN ('Compra','Donacion','Prestamo'))
);

CREATE TABLE IF NOT EXISTS Resp_Uso_x_Unidades(
	id_resp_uso VARCHAR(5) PRIMARY KEY,
	id_unidad VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS Transferibles(
	id_transferible VARCHAR(5) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Intransferibles(
	id_intransferible VARCHAR(5) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Intangibles(
	id_trans_intg VARCHAR(5) PRIMARY KEY,
	fecha_cad DATE NOT NULL,
	compartida BIT NOT NULL,
	status VARCHAR(30) NOT NULL,

	CONSTRAINT CHK_status CHECK(status IN('En proceso de registro','Vigente','Vencido','Desincorporado'))
);

CREATE TABLE IF NOT EXISTS Inmuebles(
	id_inst_in VARCHAR(5) PRIMARY KEY,
	ubicacion VARCHAR(15) NOT NULL,
	superficie FLOAT NOT NULL,
	status VARCHAR(30) NOT NULL,
	tipo VARCHAR(10) NOT NULL,

	CONSTRAINT CHK_status CHECK(status IN('En proceso de registro','En Construccion','Habitado','Desincorporado','Deshabitado')),
	CONSTRAINT CHK_tipo CHECK(tipo IN('Propia','Comodato'))
);

CREATE TABLE IF NOT EXISTS Componentes(
	id_tangible VARCHAR(5),
	id_componente VARCHAR(5),
	nombre VARCHAR(15) NOT NULL,

	PRIMARY KEY(id_Tangible,id_componente)
);

CREATE TABLE IF NOT EXISTS Tangibles(
	id_trans_tan VARCHAR(5) PRIMARY KEY,
	status VARCHAR(30) NOT NULL,
	num_fact INT NOT NULL,
	precio FLOAT NOT NULL,
	garantia VARCHAR(15),

	CONSTRAINT CHECK_status CHECK(status IN ('En proceso de registro','Activo','Dañado','Obsoleto','En reparacion','Desincorporado'))
);

CREATE TABLE IF NOT EXISTS Se_transfieren(
	nro_mov INT NOT NULL,
	id_bien_trans VARCHAR(5) NOT NULL,

	PRIMARY KEY(nro_mov,id_bien_trans)
);

CREATE TABLE IF NOT EXISTS Movilizaciones(
	nro_mov INT PRIMARY KEY,
	fecha DATE NOT NULL,
	motivo VARCHAR(30),
	A_RP_REC BIT NOT NULL,
	A_RP_CED BIT NOT NULL,
	ficha_RU_REC VARCHAR(5) NOT NULL,
	ficha_RU_CED VARCHAR(5) NOT NULL,
	id_unidad_REC VARCHAR(5) NOT NULL,
	id_unidad_CED VARCHAR(5) NOT NULL,

	CONSTRAINT CHK_id_ced CHECK(id_unidad_CED <> id_unidad_REC )
);

CREATE TABLE IF NOT EXISTS Inventarios(
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),
	fecha_i DATE NOT NULL,
	fecha_f DATE,
	status VARCHAR(15) NOT NULL,
	id_emp_enc VARCHAR(5) NOT NULL,

	PRIMARY KEY(año,semestre,tipo_bien),

	CONSTRAINT CHK_fechas CHECK (fecha_f >= fecha_i),
	CONSTRAINT CHK_status CHECK (status IN ('En ejercucion','En Conciliacion','Cerrado'))
);

CREATE TABLE IF NOT EXISTS Participan_Emp_Inv(
	id_emp VARCHAR(5),
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),

	PRIMARY KEY(id_emp,año,semestre,tipo_bien)
);


CREATE TABLE IF NOT EXISTS Registros(
	id_bien VARCHAR(5),
	id_emp VARCHAR(5),
	detalle VARCHAR(50) NOT NULL,
	existe BIT NOT NULL,

	PRIMARY KEY(id_bien,id_emp)
);

CREATE TABLE IF NOT EXISTS Posee_Cuerpo(
	año INT,
	semestre VARCHAR(20),
	tipo_bien VARCHAR(10),
	id_bien VARCHAR(5),
	id_emp VARCHAR(5),

	PRIMARY KEY(año,semestre,tipo_bien,id_bien,id_emp)
);

CREATE TABLE IF NOT EXISTS Hist_Responsables(
	id_emp VARCHAR(5),
	id_bien varchar(5),
	fecha DATE NOT NULL,

	PRIMARY KEY(id_emp,id_bien)
);

CREATE TABLE IF NOT EXISTS Hist_Jefes(
	id_unidad VARCHAR(5),
	id_emp varchar(5),
	fecha DATE NOT NULL,

	PRIMARY KEY(id_emp,id_unidad)
);


CREATE TABLE IF NOT EXISTS Empleados_Enc(
	id_emp_enc VARCHAR(5) PRIMARY KEY,
	id_sede VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS Comp_x_Tangibles(
	id_tangible VARCHAR(5),
	id_componente VARCHAR (5),

	PRIMARY KEY(id_tangible,id_componente)
);

CREATE TABLE IF NOT EXISTS Es_parte_de(
	id_bien_contenedor VARCHAR(5),
	id_comp_contenedor VARCHAR(5),
	id_bien_contenido VARCHAR(5),
	id_comp_contenido VARCHAR(5),

	PRIMARY KEY(id_bien_contenedor,id_comp_contenedor,id_bien_contenido,id_comp_contenido)

);

CREATE TABLE IF NOT EXISTS Facturas(
	id_trans_tan VARCHAR(5) PRIMARY KEY,
	num_orden INT NOT NULL,
	proveedor VARCHAR(20) NOT NULL

);

CREATE TABLE IF NO EXISTS Naturales(
	id_inst_nat VARCHAR(5) PRIMARY KEY,
	status VARCHAR(25) NOT NULL,
	nombre_c VARCHAR(15) NOT NULL,
	fecha_p DATE NOT NULL,
	origen VARCHAR(15) NOT NULL,
	ubicacion VARCHAR(20) NOT NULL,
	--la foto te la debo xd

	CONSTRAINT CHK_status CHECK (status IN ('En proceso de registro','plantado','enfermo','extinto'))
		
);

CREATE TABLE IF NO EXISTS Nombres_Cientificos(
	nombre_c VARCHAR(20) PRIMARY KEY,
	nombre_V VARCHAR(20) NOT NULL,
	frutal BIT NOT NULL,
	floracion VARCHAR(15) NOT NULL
);

CREATE INDEX Idx_unidades_id_jefe ON Unidades(id_jefe);
CREATE INDEX Idx_empleados_Cedula ON Empleados(cedula);

