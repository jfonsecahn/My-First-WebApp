/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author Josué Fonseca
 */
@WebServlet(name = "ControladorBD", urlPatterns = {"/ControladorBD"})
public class ControladorBD extends HttpServlet {

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
            out.println("<title>Servlet ControladorBD</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControladorBD at " + request.getContextPath() + "</h1>");
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
        JSONObject respuesta = new JSONObject();
        int confirmacion = 0;
        int resp = Integer.parseInt(request.getParameter("opcion"));
        if (resp == 1) {
            try {
                Runtime runtime = Runtime.getRuntime();
                File backupFile = new File(String.valueOf(getServletContext().getRealPath("/") + "respaldo_bd\\respaldo.sql"));
                FileWriter fw = new FileWriter(backupFile);
                Process child = runtime.exec("C:\\Archivos de programa\\MySQL\\MySQL Server 8.0\\bin\\mysqldump --opt --password=1234 --user=root --databases clinica_medica");
                InputStreamReader irs = new InputStreamReader(child.getInputStream());
                BufferedReader br = new BufferedReader(irs);

                String line;
                while ((line = br.readLine()) != null) {
                    fw.write(line + "\n");
                }
                fw.close();
                irs.close();
                br.close();
                System.out.println("Finalizado");
            } catch (Exception e) {
                System.out.println("error: " + e.getMessage());
            }
            confirmacion = 1;
        }
        if (resp == 2) {
            String ubicacion = getServletContext().getRealPath("/") + "respaldo_bd\\respaldo.sql";
            String[] executeCmd = new String[]{"C:\\Archivos de programa\\MySQL\\MySQL Server 8.0\\bin\\mysql", "--user=root", "--password=1234", "-e", "source " + ubicacion};
            Process runtimeProcess;
            try {
                runtimeProcess = Runtime.getRuntime().exec(executeCmd);
                int processComplete = runtimeProcess.waitFor();
                if (processComplete == 0) {
                    confirmacion = 1;
                } else {
                    System.out.println("Could not restore the backup");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        respuesta.put("resultado", confirmacion);
        response.setContentType("application/json");
        response.getWriter().write(respuesta.toString());
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
