/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Optional;
import seguridad.encriptacion;

/**
 *
 * @author Josué Fonseca
 */
public class ConsultasModelos {

    Conexion con = new Conexion();
    Connection cnx;
    PreparedStatement sta;
    ResultSet rs;
    ResultSetMetaData rsmd;

    public ConsultasModelos() {
        cnx = con.getConexion();
    }

    public int login(String usuario, String contrasenia) {
        try {
            encriptacion md = new encriptacion();

            sta = cnx.prepareStatement("select * from usuarios where nombre_usuario='" + usuario + "' and contrasenia='" + md.getHashPass(contrasenia) + "' and estado='Activo'");
            rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            cnx.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean esNumero(String strNum) {
        if (strNum == null) {
            return false;
        }
        try {
            int d = Integer.parseInt(strNum);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

    public String obtener_dato_campo(String tabla, String id, String campo, String campo_filtro) {
        Optional<String> filtro = Optional.ofNullable(campo_filtro);
        String campo_filtrado_opcional = filtro.isPresent() ? filtro.get() : "id";
        String informacion = "";
        String valor = esNumero(id) == true ? id : "'" + id + "'";
        try {
            cnx = con.getConexion();
            sta = cnx.prepareStatement("select " + campo + " from " + tabla + " where " + campo_filtrado_opcional + "=" + valor + "");
            rs = sta.executeQuery();
            if (rs.next()) {
                informacion = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return informacion;
    }

    public String obtener_dato_variable(String campo) {
        String informacion = "";
        try {
            cnx = con.getConexion();
            sta = cnx.prepareStatement("select " + campo + " from variables");
            rs = sta.executeQuery();
            if (rs.next()) {
                informacion = rs.getString(campo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return informacion;
    }

    public String obtener_opciones_select(String tabla, String campos) {
        String informacion = "";
        try {
            cnx = con.getConexion();
            sta = cnx.prepareStatement("select " + campos + " from " + tabla);
            rs = sta.executeQuery();
            while (rs.next()) {
                informacion += rs.getString("value") + ":" + rs.getString("label") + ";";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        if (!informacion.equals("")) {
            return informacion;
        } else {
            return "null";
        }
    }

    public String obtener_permisos_usuario_modulo(int tipo, int modulo) {
        String resultado = "";
        int contador = 0;
        String[] informacion = {"sin_permiso", "sin_permiso", "sin_permiso", "sin_permiso"};
        try {
            Connection cnx;
            Conexion con = new Conexion();
            cnx = con.getConexion();
            PreparedStatement sta = cnx.prepareStatement("select p.nombre as nombre FROM permisos_rol pr inner join permisos p"
                    + " on pr.permiso=p.id "
                    + "where pr.rol=" + tipo + " and pr.modulo=" + modulo + " order by p.id");
            ResultSet rs = sta.executeQuery();
            System.out.println("select p.nombre as nombre FROM permisos_rol pr inner join permisos p"
                    + " on pr.permiso=p.id "
                    + "where pr.rol=" + tipo + " and pr.modulo=" + modulo + " order by p.id");
            while (rs.next()) {
                informacion[contador] = rs.getString("nombre");
                contador++;
            }
            for (int i = 0; i <= informacion.length; i++) {

                resultado += informacion[i] + ";";
            }
            cnx.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public int obtener_conteo(String sentencia) {
        int conteo = 0;
        try {
            cnx = con.getConexion();
            sta = cnx.prepareStatement(sentencia);
            rs = sta.executeQuery();
            while (rs.next()) {
                conteo = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conteo;
    }

    protected void finalize() throws SQLException {
        con.desconectar();
        cnx.close();
    }

    public String[] obtener_informacion_empresa() {
        String[] informacion = new String[12];
        try {
            sta = cnx.prepareStatement("select * from datos_clinica");
            rs = sta.executeQuery();
            rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            if (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String name = rsmd.getColumnName(i);
                    informacion[(i - 1)] = rs.getString(name);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return informacion;
    }

    public String[] obtener_informacion_perfil(String usuario) {
        String[] informacion = new String[13];
        try {
            sta = cnx.prepareStatement("select * from usuarios where nombre_usuario='" + usuario + "'");
            rs = sta.executeQuery();
            rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            if (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String name = rsmd.getColumnName(i);
                    informacion[(i - 1)] = rs.getString(name);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return informacion;
    }

    public String[] obtener_informacion_paciente(String usuario) {
        String[] informacion = new String[13];
        try {
            sta = cnx.prepareStatement("select * from usuarios where id=" + usuario + "");
            rs = sta.executeQuery();
            rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            if (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String name = rsmd.getColumnName(i);
                    informacion[(i - 1)] = rs.getString(name);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return informacion;
    }

    public String obtener_rango() {
        String resultado = "";
        try {
            sta = cnx.prepareStatement("select rango_inicial,rango_final from datos_fluctuantes");
            rs = sta.executeQuery();
            rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String name = rsmd.getColumnName(i);
                    resultado += rs.getString(name) + ";";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public String obtener_rango_actual() {
        String resultado = "";
        try {
            sta = cnx.prepareStatement("select id,(CONVERT(ifnull(no_rango,(select substring_index(rango_inicial,'-',-1) from datos_fluctuantes limit 1)),UNSIGNED INTEGER)+1)as rango from factura order by id desc limit 1");
            rs = sta.executeQuery();
            while (rs.next()) {
                resultado += rs.getString("rango");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }
}
