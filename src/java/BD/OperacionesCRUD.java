/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Josué Fonseca
 */
public class OperacionesCRUD {

    public int Realizar_Operacion(String accion, String campos, String valores, String tabla, String where) {
        int confirmacion = 0;
        try {
            String conector = "";
            if (accion == "insertar") {
                conector = "values";
            }
            Connection cnx;
            Conexion con = new Conexion();
            cnx = con.getConexion();
            String operacion = this.get_Operacion(accion);
            System.out.println(operacion + " " + tabla + " "
                    + "" + campos + " " + conector
                    + " " + valores + " " + where);
            PreparedStatement sta = cnx.prepareStatement(operacion + " " + tabla + " "
                    + "" + campos + " " + conector
                    + " " + valores + " " + where);
            confirmacion = sta.executeUpdate();
            con.desconectar();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return confirmacion;

    }

    private String get_Operacion(String accion) {
        String operacion = "";
        switch (accion) {
            case "insertar":
                operacion = "insert into";
                break;
            case "actualizar":
                operacion = "update";
                break;
            case "eliminar":
                operacion = "delete from ";
                break;
        }
        return operacion;
    }

    public void Regitrar_Bitacora(String usuario, String tabla, String accion, String datos, String id_usuario, String ip) {
        String campos = "(usuario,tabla,accion,fecha,datos,id_usuario,ip)";
        String valores = "('" + usuario + "',"
                + "'" + tabla + "','" + accion + "',now(),'" + datos.replace("'", "") + "','" + id_usuario + "','" + ip + "')";
        this.Realizar_Operacion("insertar", campos, valores, "bitacora", "");
    }
       public void Regitrar_Error(String usuario, String error, String detalle, String ip) {
        String campos = "(usuario,ip,fecha,codigo,detalle)";
        String valores = "('" + usuario + "','" + ip + "',now(),'" + error.replace("'", "") + "','" + detalle + "')";
        this.Realizar_Operacion("insertar", campos, valores, "errores", "");
    }
     public int insetar_retornando_id(String campos, String valores, String tabla, String usuario) {
        int id = 0;
        Connection cnx;
        Conexion con = new Conexion();
        cnx = con.getConexion();
        try {
            int resultado = 0;
            PreparedStatement sta = cnx.prepareStatement("insert into " + tabla + " " + campos + " values " + valores + "");
            resultado = sta.executeUpdate();
            if (resultado > 0) {
                sta = cnx.prepareStatement("select max(id) from "+tabla+" where usuario=" + usuario+"");
                ResultSet rs = sta.executeQuery();
                if (rs.next()) {
                    id = rs.getInt(1);
                }
            }
            cnx.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return id;
    }
}
