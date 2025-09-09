package BD;

import java.sql.*;

public class Conexion {

    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://" + Config.get("db.server") + ":" + Config.get("db.port")
                        + "/" + Config.get("db.name")
                        + "?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";

            cn = DriverManager.getConnection(url, Config.get("db.user"), Config.get("db.password"));
            System.out.println("Conexión exitosa a la base de datos");

        } catch (Exception e) {
            System.out.println("Error de Conexion: " + e);
        }
        return cn;
    }

    public static void main(String[] args) {
        Conexion.getConexion();
    }

    public void desconectar() throws SQLException {
        Connection cn = Conexion.getConexion();
        if (cn != null && !cn.isClosed()) {
            cn.close();
            System.out.println("Desconectado correctamente");
        }
    }
}