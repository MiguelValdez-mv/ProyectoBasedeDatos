/*Tabla Sedes*/
INSERT INTO Sedes (descripcion, direccion, ciudad)
VALUES  ('UCAB Caracas', 'Av Teheran', 'Caracas'),
        ('UCAB Guayana', 'Av Atlantico', 'Puerto Ordaz'),
        ('UCAB Coro', 'Av cacahuate', 'Coro');

/*Tabla Unidades*/
INSERT INTO Unidades (nombre, id_jefe, id_sede)
VALUES  ('Informatica', NULL, 1),
        ('Civil', NULL, 1),
        ('Industrial', NULL, 1),
        ('Derecho', NULL, 1);

    /*insertar con la sede de una vez dado el nombre de la sede*/
INSERT INTO unidades(nombre, id_jefe, id_sede)
	SELECT 'NombreUnidad', NULL, id
	FROM sedes WHERE descripcion = 'NombreSede';

    /*insertar con la sede y su jefe de una vez*/
INSERT INTO unidades(nombre, id_jefe, id_sede)
	SELECT 'Comunicacion', 
		   (SELECT ficha FROM empleados WHERE nombre = 'NombreJefe'), 
		   id
	FROM sedes WHERE descripcion = 'NombreSede'    

/*Tabla Empleados*/
INSERT INTO Empleados (nombre, cedula, id_unidad)
VALUES  ('NombreEmpleado', 66666, 2);

    /*insertar con la unidad de una dado su nombre*/
INSERT INTO Empleados(nombre, cedula, id_unidad)
	SELECT 'NombreEmpleado', 66666, id
	FROM Unidades WHERE nombre = 'NombreUnidad'; /*si falla el select, devuelve 0 y no se incrementa serial*/

/*Tabla Tipos de Bien*/
INSERT INTO tipos_de_bien
VALUES  ('Tangible'),
        ('Intangible'),
        ('Inmueble'),
        ('Natural');

/*Tabla Bienes*/
INSERT INTO Bienes (id, descripcion, status, fecha_a, fecha_d, origen, tipo, id_resp_uso, id_unidad)
VALUES  (1, 'Laptop', 'Activo', '19-01-2015', NULL, 'Compra', 'Tangible', 4, 1),
        (2, 'VideoBeam', 'Activo', '27-04-2018', NULL, 'Compra', 'Tangible', NULL, 2),
        (3, 'Licencia', 'Vigente', '15-12-2009', NULL, 'Donacion', 'Intangible', 4, 1),
        (4, 'Edificio', 'Habitado', '19-01-2018', NULL, 'Compra', 'Inmueble', NULL, 1),
        (5, 'Araguaney', 'plantado', '19-01-2010', NULL, 'Donacion', 'Natural', 6, 1);
/*Tabla Transferibles*/

/*Tabla Intransferibles*/

/*Tabla Tangibles*/

/*Tabla Intangibles*/

/*Tabla Inmuebles*/

/*Tabla Naturales*/