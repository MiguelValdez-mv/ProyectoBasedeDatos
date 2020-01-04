/*ALTER TABLE Direcciones_x_Ciudad ADD CONSTRAINT FK_direccion FOREIGN KEY (direccion) REFERENCES Sedes(direccion) ON UPDATE CASCADE ON DELETE CASCADE;*/

ALTER TABLE Unidades ADD CONSTRAINT FK_id_jefe FOREIGN KEY (id_jefe) REFERENCES Empleados(ficha) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE  Unidades ADD CONSTRAINT FK_id_sede FOREIGN KEY (id_sede) REFERENCES Sedes(id) ON UPDATE CASCADE ON DELETE RESTRICT; /*cuidaito aqui xd*/

ALTER TABLE Empleados ADD CONSTRAINT FK_id_unidad FOREIGN KEY (id_unidad) REFERENCES Unidades(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  Bienes ADD CONSTRAINT FK_tipo FOREIGN KEY (tipo) REFERENCES Tipos_de_Bien(tipo_de_bien) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Bienes ADD CONSTRAINT FK_id_resp_uso FOREIGN KEY (id_resp_uso) REFERENCES Empleados(ficha) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE  Bienes ADD CONSTRAINT FK_id_unidad FOREIGN KEY (id_unidad) REFERENCES Unidades(id) ON UPDATE CASCADE ON DELETE RESTRICT; 

/*
ALTER TABLE Resp_Uso_x_Unidades ADD CONSTRAINT FK_id_resp_uso FOREIGN KEY (id_resp_uso) REFERENCES Empleados(ficha);
ALTER TABLE Resp_Uso_x_Unidades ADD CONSTRAINT FK_id_unidad FOREIGN KEY (id_unidad) REFERENCES Unidades(id);
*/

ALTER TABLE Transferibles ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Bienes(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Intransferibles ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Bienes(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Intangibles ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Transferibles(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Inmuebles ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Intransferibles(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Componentes ADD CONSTRAINT FK_id_bien FOREIGN KEY (id_bien) REFERENCES Tangibles(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Bienes_Transferidos ADD CONSTRAINT FK_nro_mov FOREIGN KEY (nro_mov) REFERENCES Movilizaciones(nro_mov) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Empleados_x_Inventario ADD CONSTRAINT FK__año_semestre_tipo_bien_id_sede FOREIGN KEY (año,semestre,tipo_bien,id_sede) REFERENCES Inventarios(año,semestre,tipo_bien,id_sede) ON UPDATE CASCADE ON DELETE CASCADE;

/*
ALTER TABLE Registros_x_Inventario ADD CONSTRAINT FK__año_semestre_tipo_bien FOREIGN KEY (año, semestre, tipo_bien) REFERENCES Inventarios(año, semestre, tipo_bien);
ALTER TABLE Registros_x_Inventario ADD CONSTRAINT FK__id_bien_id_emp  FOREIGN KEY (id_bien, id_emp) REFERENCES Registros(id_bien,id_emp);
*/

/*
ALTER TABLE Componentes_x_Bien ADD CONSTRAINT FK_id_bien_id_componente FOREIGN KEY (id_bien,id_componente) REFERENCES Componentes(id_bien,id_componente);
ALTER TABLE Componentes_x_Bien ADD CONSTRAINT FK_id_bien FOREIGN KEY(id_bien) REFERENCES Tangibles(id);
*/

ALTER TABLE Componentes_x_Componente ADD CONSTRAINT FK_contenedor FOREIGN KEY (id_bien_contenedor,id_comp_contenedor) REFERENCES Componentes(id_bien,id_componente) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Componentes_x_Componente ADD CONSTRAINT FK_contenido FOREIGN KEY (id_bien_contenido,id_comp_contenido) REFERENCES Componentes(id_bien,id_componente) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Registros ADD CONSTRAINT FK_id_sede_año_semestre_tipobien FOREIGN KEY (id_sede,año,semestre,tipo_bien) REFERENCES Inventarios(id_sede,año,semestre,tipo_bien) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Inventarios ADD CONSTRAINT FK_id_sede FOREIGN KEY (id_sede) REFERENCES Sedes(id) ON UPDATE CASCADE ON DELETE CASCADE;

/*
ALTER TABLE Empleados_Enc ADD CONSTRAINT FK_id_emp FOREIGN KEY (id_emp) REFERENCES Empleados(ficha);
ALTER TABLE Empleados_Enc ADD CONSTRAINT FK_id_sede FOREIGN KEY (id_sede) REFERENCES Sedes(id);
*/

ALTER TABLE Tangibles ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Transferibles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Tangibles ADD CONSTRAINT FK_num_fact FOREIGN KEY (num_fact) REFERENCES Facturas(num_fact) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Naturales ADD CONSTRAINT FK_id FOREIGN KEY (id) REFERENCES Intransferibles(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Info_Arboles ADD CONSTRAINT FK_id FOREIGN KEY (nombre_c) REFERENCES Naturales(nombre_c) ON UPDATE CASCADE ON DELETE CASCADE;
