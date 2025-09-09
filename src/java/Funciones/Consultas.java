/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Funciones;

/**
 *
 */
public class Consultas {

    public String Obtener_Consulta(String modulo, String busqueda) {
        String consulta = "";
        if (modulo.equals("datos_clinica")) {
            consulta = "select * from datos_clinica";
        } else if (modulo.equals("roles")) {
            consulta = "select * from roles";
        } else if (modulo.equals("permisos_modulos") && busqueda != null) {
            consulta = "select p.id as value,p.nombre as label from permisos_modulos pd inner join permisos p on (p.id=pd.permiso) where modulo=" + busqueda;
        } else if (modulo.equals("permisos_rol")) {
            consulta = "select pr.id as id,r.id as rol,r.nombre as nombre_rol,d.id as modulo,d.nombre as nombre_modulo,p.id as permiso,p.nombre as nombre_permiso from permisos_rol pr inner join permisos p on(p.id=pr.permiso) inner join modulos d on (d.id=pr.modulo) inner join roles r on (r.id=pr.rol)";
        } else if (modulo.equals("bitacora")) {
            consulta = "select * from bitacora";
        } else if (modulo.equals("servicios")) {
            consulta = "select id,nombre,descripcion,icono,estado,concat('Lps. ',FORMAT(precio,2)) as precio from servicios";
        } else if (modulo.equals("especialidades")) {
            consulta = "select * from especialidades";
        } else if (modulo.equals("medicos")) {
            consulta = "select id,identidad,nombre_usuario,contrasenia,nombres,apellidos,telefono,correo,estado,especialidad_principal,presentacion,imagen from usuarios where id_rol=4";
        } else if (modulo.equals("enfermeras")) {
            consulta = "select id,identidad,nombre_usuario,contrasenia,nombres,apellidos,telefono,correo,estado,imagen from usuarios where id_rol=2";
        } else if (modulo.equals("pacientes")) {
            consulta = "select id,identidad,nombre_usuario,contrasenia,nombres,apellidos,telefono,correo,estado,imagen from usuarios where id_rol=3";
        } else if (modulo.equals("usuarios")) {
            consulta = "select u.id as id,u.identidad as identidad,u.nombre_usuario as nombre_usuario,u.contrasenia as contrasenia,u.nombres as nombres,u.apellidos as apellidos,u.telefono as \n"
                    + "telefono,u.correo as correo,u.estado as estado,u.imagen as imagen\n"
                    + " ,u.id_rol as id_rol,r.nombre as nombre_rol from usuarios u inner join roles r on (r.id=u.id_rol)";
        } else if (modulo.equals("especialidades_medicos")) {
            consulta = "select em.id as id ,m.id as medico,concat(m.id,' ',m.nombres,' ',m.apellidos) as nombre_medico,em.especialidad as especialidad,\n"
                    + "e.nombre as nombre_especialidad  from especialidades_medicos em inner join usuarios m on (m.id=em.medico) inner join especialidades e on (e.id=em.especialidad)";
        } else if (modulo.equals("especialidades_servicios")) {
            consulta = "select em.id as id ,m.id as servicio,m.nombre as nombre_servicio,em.especialidad as especialidad,\n"
                    + "e.nombre as nombre_especialidad  from especialidades_servicios em inner join servicios m on (m.id=em.servicio) inner join especialidades e on (e.id=em.especialidad)";
        } else if (modulo.equals("servicios_medico")) {
            consulta = "select m.id as value,concat(m.nombres,' ',m.apellidos)as label from usuarios m inner join especialidades_medicos em on (em.medico=m.id) inner join especialidades_servicios es on\n"
                    + "(es.especialidad=em.especialidad) where es.servicio=" + busqueda;
        } else if (modulo.equals("validar_disponibilidad")) {
            consulta = "select * from citas where medico=" + busqueda;
        } else if (modulo.equals("citas_pendientes")) {
            consulta = "select c.id as id,s.id as servicio,s.nombre as nombre_servicio,m.id as medico,concat(m.id,' ',m.nombres,' ',m.apellidos)as nombre_medico,\n"
                    + "DATE_FORMAT(c.fecha, '%Y/%m/%d %h:%i %p') as fecha,s.precio as precio from citas c inner join usuarios m on (m.id=c.medico) inner join servicios s on (s.id=c.servicio)\n"
                    + "where c.estado='Sin Atender' and c.usuario=" + busqueda;
        } else if (modulo.equals("atencion_citas")) {
            consulta = "select c.id as id,s.id as servicio,s.nombre as nombre_servicio,m.id as cliente,concat(m.nombres,' ',m.apellidos)as nombre_medico,\n"
                    + "DATE_FORMAT(c.fecha, '%m/%d/%Y %h:%i %p') as fecha,c.estado as estado from citas c inner join usuarios m on (m.id=c.usuario) inner join servicios s on (s.id=c.servicio)\n"
                    + "where (c.estado='Sin Atender' or c.estado='Atendiendo') and c.medico=" + busqueda;
        } else if (modulo.equals("historial_paciente")) {
            consulta = "select hm.id as id,m.id as medico,concat(m.nombres,' ',m.apellidos)as nombre_medico,"
                    + "hm.comentarios as comentarios,DATE_FORMAT(hm.fecha, '%m/%d/%Y %h:%i %p') as fecha "
                    + "from historial_medico hm inner join usuarios m on (m.id=hm.medico)where paciente=" + busqueda;
        } else if (modulo.equals("recetas_paciente")) {
            consulta = "select r.id_receta as id_receta,r.imagen as imagen,r.descripcion as descripcion,\n"
                    + "m.id as medico,concat(m.nombres,' ',m.apellidos) as nombre_medico from recetas r inner join "
                    + "usuarios m on (m.id=r.medico) where r.paciente=" + busqueda;
        } else if (modulo.equals("historial_pacientes")) {
            consulta = "select id,identidad,nombre_usuario,contrasenia,nombres,apellidos,telefono,correo,estado,imagen from usuarios where id_rol=3";
        } else if (modulo.equals("admin_citas")) {
            consulta = "select c.id as id,s.id as servicio,s.nombre as nombre_servicio,m.id as medico,concat(m.id,' ',m.nombres,' ',m.apellidos)as nombre_medico,\n"
                    + "DATE_FORMAT(c.fecha, '%m/%d/%Y %h:%i %p') as fecha,p.id as usuario,concat(p.identidad,' ',p.nombres,' ',p.apellidos)as nombre_paciente,c.estado as estado from citas c inner join usuarios m on (m.id=c.medico) inner join servicios s on (s.id=c.servicio) inner join usuarios p on (p.id=c.usuario)";
        } else if (modulo.equals("citas_finalizadas")) {
            consulta = "select c.id as id,s.id as servicio,s.nombre as nombre_servicio,m.id as medico,concat(m.id,' ',m.nombres,' ',m.apellidos)as nombre_medico,\n"
                    + "DATE_FORMAT(c.fecha, '%m/%d/%Y %h:%i %p') as fecha,s.precio as precio from citas c inner join usuarios m on (m.id=c.medico) inner join servicios s on (s.id=c.servicio)\n"
                    + "where c.estado='Atendido' and c.usuario=" + busqueda;
        } else if (modulo.equals("datos_fluctuantes")) {
            consulta = "select id,concat(impuesto,' ','%')as impuesto,rango_inicial,rango_final,DATE_FORMAT(fecha_limite, '%Y/%m/%d') as fecha_limite from datos_fluctuantes";
        } else if (modulo.equals("citas_facturar")) {
            consulta = "select c.id as id,s.id as servicio,s.nombre as nombre_servicio,\n"
                    + "DATE_FORMAT(c.fecha, '%m/%d/%Y %h:%i %p') as fecha,p.id as usuario,concat(p.identidad,' ',p.nombres,' ',p.apellidos)as"
                    + " nombre_paciente,count(c.id)as cantidad,concat('Lps. ',s.precio) as precio from citas c"
                    + " inner join servicios s on (s.id=c.servicio)"
                    + " inner join usuarios p on (p.id=c.usuario) where c.estado='Atendido' and c.estado_pago='Sin Pagar' and ( c.id LIKE '%" + busqueda + "%' or p.id LIKE '%" + busqueda + "%' or p.nombres LIKE '%" + busqueda + "%' or p.apellidos LIKE '%" + busqueda + "%' or s.nombre LIKE '%" + busqueda + "%' or s.id LIKE '%" + busqueda + "%')"
                    + "group by s.id,s.nombre,p.id,concat(p.identidad,' ',p.nombres,' ',p.apellidos)";

        } else if (modulo.equals("facturas_guardadas")) {
            consulta = "select f.id as id,f.no_rango as rango,DATE_FORMAT(f.fecha, '%m/%d/%Y %h:%i %p') as fecha,concat('Lps. ',f.impuesto) as imuesto,concat('Lps. ',f.total) as total,\n"
                    + "u.id as id_usuario,concat(u.nombres,' ',u.apellidos) as nombre_usuario,p.id as id_paciente,concat(p.nombres,' ',p.apellidos)as nombre_paciente,\n"
                    + "f.rango_autorizado as rango_autorizado,f.cai as cai,DATE_FORMAT(f.fecha_limite, '%m/%d/%Y') as fecha_limite,f.estado as estado\n"
                    + " from factura f inner join usuarios u on (u.id=f.usuario) inner join usuarios p on (p.id=f.paciente) ";
        } else if (modulo.equals("detalle_factura")) {
            consulta = "select df.id as id,s.id as id_servicio,s.nombre as nombre_servicio,concat('Lps. ',df.precio) as precio,cantidad as cantidad,"
                    + "concat('Lps. ',df.total_unitario) as total_unitario from detalle_factura df inner join servicios s on (s.id=df.servicio) where df.factura=" + busqueda;
        }
         else if (modulo.equals("recetas_cita")) {
            consulta = "select id_receta,descripcion,imagen from recetas where cita=" + busqueda;
        }
        return consulta;
    }

    public String Obtener_Tabla(String modulo) {
        String tabla = modulo;
        if (modulo != null) {
            if (modulo.equals("medicos") || modulo.equals("enfermeras") || modulo.equals("pacientes") || modulo.equals("informacion_personal")) {
                tabla = "usuarios";
            }
            if (modulo.equals("citas_finalizadas;citas_pendientes") || modulo.equals("admin_citas")) {
                tabla = "citas";
            }
            if (modulo.equals("historial_paciente")) {
                tabla = "historial_medico";

            }
            if (modulo.equals("recetas_paciente")) {
                tabla = "recetas";
            }
        }
        return tabla;
    }

    public String[] Obtener_Campos_Join(String modulo) {
        String[] campos = null;
        if (modulo.equals("permisos_modulos")) {
            campos = "value,label".split(",");
        } else if (modulo.equals("permisos_rol")) {
            campos = "id,rol,nombre_rol,modulo,nombre_modulo,permiso,nombre_permiso".split(",");
        } else if (modulo.equals("permisos_rol")) {
            campos = "id,nombre,descripcion,icono,estado,precio".split(",");

        } else if (modulo.equals("usuarios")) {
            campos = "id,identidad,nombre_usuario,contrasenia,nombres,apellidos,telefono,correo,estado,imagen,id_rol,nombre_rol".split(",");

        } else if (modulo.equals("especialidades_medicos")) {
            campos = "id,medico,nombre_medico,especialidad,nombre_especialidad".split(",");

        } else if (modulo.equals("especialidades_servicios")) {
            campos = "id,servicio,nombre_servicio,especialidad,nombre_especialidad".split(",");

        } else if (modulo.equals("servicios_medico")) {
            campos = "value,label".split(",");

        } else if (modulo.equals("citas_pendientes")) {
            campos = "id,servicio,nombre_servicio,medico,nombre_medico,fecha,precio".split(",");

        } else if (modulo.equals("citas_finalizadas")) {
            campos = "id,servicio,nombre_servicio,medico,nombre_medico,fecha,precio".split(",");

        } else if (modulo.equals("atencion_citas")) {
            campos = "id,servicio,nombre_servicio,cliente,nombre_medico,fecha,estado".split(",");

        } else if (modulo.equals("historial_paciente")) {
            campos = "id,medico,nombre_medico,comentarios,fecha".split(",");
        } else if (modulo.equals("recetas_paciente")) {
            campos = "id_receta,imagen,descripcion,medico,nombre_medico".split(",");

        } else if (modulo.equals("admin_citas")) {
            campos = "id,servicio,nombre_servicio,medico,nombre_medico,fecha,usuario,nombre_paciente,estado".split(",");

        } else if (modulo.equals("citas_facturar")) {
            campos = "id,servicio,nombre_servicio,fecha,usuario,nombre_paciente,cantidad,precio".split(",");

        } else if (modulo.equals("facturas_guardadas")) {
            campos = "id,rango,fecha,imuesto,total,id_usuario,nombre_usuario,id_paciente,nombre_paciente,rango_autorizado,cai,fecha_limite,estado".split(",");

        } else if (modulo.equals("detalle_factura")) {
            campos = "id,id_servicio,nombre_servicio,precio,cantidad,total_unitario".split(",");

        }

        return campos;
    }

}
