/*para crear lista de doctores con especializacion*/
create view vdoctoresespecialidad as 
select  v.codigo,
        string('Dr.',v.nombre) as doctor,
        i.institucion as 'especialidad',
        v.empresa
from in_vendedor v
inner join in_institucion i on v.especialidad=i.codigo


/*para vista de in_item relacionarla con productos*/
create view vproductostipos as 
select ii.codigo as 'producto',
       ii.descripcion1 as 'descripcion',
       ig.grupo as 'tipo' 
from in_item ii
inner join in_grupo ig on ii.grupo = ig.codigo and ii.empresa = ig.empresa


/*Vista para mostrar nombres de pacientes, nombres de doctores, 
el tipo de cita que reservaron y el tiempo en el que tenian que estar
le quiete estos campos
icp.pro_cli,
icp.vendedor as 'codigo_doctor'
*/
create view vmostrarcitas as
select 
isnull(icp.documento,'sin datos')  as 'proforma',
isnull(ic.nombre,'')  as 'paciente',
isnull(icp.comentario,'sin datos') as 'comentario',
isnull(ic.cedula_ruc,'sin datos') as 'cedula_ruc',
isnull(vde.doctor,'sin datos') as 'doctor',
isnull(vde.codigo,'sin datos')  as 'codigo_doctor',
isnull(vde.especialidad,'sin datos') as 'especialidad',
isnull(icp.reserva_desde,'2022-01-01 00:00:00') as 'reserva_desde',
isnull(icp.reserva_hasta,'2022-01-01 00:00:00') as 'reserva_hasta',
isnull(vpt.descripcion,'sin datos') as 'descripcion',
isnull(vpt.tipo,'sin datos') as 'tipo'
from
in_cabecera_proforma icp
inner join in_cliente ic on icp.pro_cli = ic.codigo
inner join vdoctoresespecialidad vde on icp.vendedor = vde.codigo
inner join in_movimiento_proforma imp on icp.documento=imp.documento
inner join vproductostipos vpt on imp.producto = vpt.producto
where
icp.reserva_desde is Not null AND icp.reserva_hasta is not null
order by vpt.tipo ASC