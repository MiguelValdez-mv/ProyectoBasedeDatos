/*para actualizar el jefe de una unidad, dado el nombre del empleado 
y el nombre de la unidad (podria hacerse con la cedula mejor)*/
UPDATE unidades 
SET id_jefe = emp.ficha
FROM (
    SELECT ficha
    FROM empleados 
	WHERE nombre = 'NombreEmpleado') AS emp
WHERE 
    unidades.nombre = 'NombreUnidad';

/**/