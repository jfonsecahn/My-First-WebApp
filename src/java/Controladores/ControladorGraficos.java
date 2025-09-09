/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import BD.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Josué Fonseca
 */
@WebServlet(name = "ControladorGraficos", urlPatterns = {"/ControladorGraficos"})
public class ControladorGraficos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControladorGraficos</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControladorGraficos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject respuesta = new JSONObject();
        JSONArray lista = new JSONArray();
        String sql = "";
        if (request.getParameter("grafico").equals("1")) {
            sql = "SELECT CASE "
                    + "WHEN month(fecha) =1 THEN \"Enero\" "
                    + "WHEN month(fecha) =2 THEN \"Febrero\" "
                    + "WHEN month(fecha) =3 THEN \"Marzo\" "
                    + "WHEN month(fecha) =4 THEN \"Abril\" "
                    + "WHEN month(fecha) =5 THEN \"Mayo\" "
                    + "WHEN month(fecha) =6 THEN \"Junio\" "
                    + "WHEN month(fecha) = 7 then \"Julio\" "
                    + "WHEN month(fecha) = 8 then \"Agosto\" "
                    + "WHEN month(fecha) = 9 then \"Septiembre\" "
                    + "WHEN month(fecha) = 10 then \"Octubre\" "
                    + "WHEN month(fecha) = 11 then \"Noviembre\" "
                    + "WHEN month(fecha) = 12 then \"Diciembre\" "
                    + " ELSE \"Enero\" "
                    + "END as mes,count(id) from factura where estado='Pagada' and year(fecha)=year(now()) "
                    + "group by mes"
                    + " limit 12";
        } else if (request.getParameter("grafico").equals("2")) {
            sql = "select concat(p.id,' ',p.nombres,' ',p.apellidos) as cliente,sum(f.total) as total_vendido,(select sum(total) from factura where estado='Pagada')as total from factura f"
                    + " inner join usuarios p on (f.paciente=p.id)"
                    + " where f.estado='Pagada' and f.paciente<>0"
                    + " group by concat(p.id,' ',p.nombres,' ',p.apellidos)"
                    + " order by sum(f.total) desc limit 5";
        }
        try {
            Connection cnx;
            Conexion con = new Conexion();
            cnx = con.getConexion();
            PreparedStatement sta = cnx.prepareStatement(sql);
            System.out.println(sql);
            ResultSet rs = sta.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            while (rs.next()) {
                JSONArray registro = new JSONArray();
                for (int i = 1; i <= columnCount; i++) {
                    String name = rsmd.getColumnName(i);

                    registro.put(rs.getString(name));
                }
                lista.put(registro);
            }
            cnx.close();
        } catch (Exception e) {
        }
        respuesta.put("data", lista);
        response.setContentType("application/json");
        response.getWriter().write(respuesta.toString());
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
