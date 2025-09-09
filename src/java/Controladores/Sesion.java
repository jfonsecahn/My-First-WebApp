/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import BD.OperacionesCRUD;
import Modelo.ConsultasModelos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author Josué Fonseca
 */
@WebServlet(name = "Sesion", urlPatterns = {"/Sesion"})
public class Sesion extends HttpServlet {

    ConsultasModelos cp = new ConsultasModelos();
    OperacionesCRUD opdb = new OperacionesCRUD();

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
            out.println("<title>Servlet Sesion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sesion at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(true);
        JSONObject respuesta = new JSONObject();
        if (request.getParameter("consultar") == null) {
            opdb.Regitrar_Bitacora(session.getAttribute("usuario").toString(), "usuarios", "Salida el sistema", "Salida del sistema del usuario: " + session.getAttribute("usuario").toString() + " ", session.getAttribute("id_usuario").toString(), request.getRemoteAddr());

            session.setAttribute("usuario", null);

            session.invalidate();

            response.sendRedirect("index.jsp");

        } else {
            if (session.getAttribute("id_usuario") != null) {
                respuesta.put("autorizacion", 1);
            } else {
                respuesta.put("autorizacion", 0);
            }
        }
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

        HttpSession session = request.getSession(true);
        // session.invalidate();
        JSONObject respuesta = new JSONObject();
        String usuario = request.getParameter("usuario");
        String esta_bloqueado = "";
        esta_bloqueado = cp.obtener_dato_campo("usuarios", usuario, "estado", "nombre_usuario");
        try {
            if (esta_bloqueado.equals("Inactivo")) {
                respuesta.put("bloqueo", 1);
                respuesta.put("autorizacion", 0);
            } else {

                int resultado = cp.login(usuario, request.getParameter("contrasenia"));
                if (resultado > 0) {
                    String rol = cp.obtener_dato_campo("usuarios", usuario, "id_rol", "nombre_usuario");
                    session.setAttribute("usuario", usuario);
                    session.setAttribute("id_usuario", cp.obtener_dato_campo("usuarios", usuario, "id", "nombre_usuario"));
                    session.setAttribute("rol", rol);
                    session.setAttribute("nombre_rol", cp.obtener_dato_campo("roles", rol, "nombre", "id"));
                    session.setAttribute(usuario, null);
                    respuesta.put("autorizacion", 1);
                    respuesta.put("url", rol.equals("3") ? "index.jsp" : "pagina_principal.jsp");
                    opdb.Regitrar_Bitacora(request.getParameter("usuario"), "usuarios", "Inicio de sesión", "Inicio de sesión con nombre de usuario: " + request.getParameter("usuario") + " ", String.valueOf(resultado), request.getRemoteAddr());
                } else {
                    respuesta.put("autorizacion", 0);
                    opdb.Regitrar_Bitacora(request.getParameter("usuario"), "usuarios", "Inicio de sesión fállido", "Inicio de sesión fállido con nombre de usuario: " + request.getParameter("usuario") + " ", String.valueOf(resultado), request.getRemoteAddr());
                }
            }
            response.setContentType("application/json");
            response.getWriter().write(respuesta.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
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
