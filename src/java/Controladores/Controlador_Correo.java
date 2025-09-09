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
import java.security.NoSuchAlgorithmException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import seguridad.encriptacion;

/**
 *
 * pxakbwlkqcxyzuwo
 */
@WebServlet(name = "Controlador_Correo", urlPatterns = {"/Controlador_Correo"})
public class Controlador_Correo extends HttpServlet {

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
            out.println("<title>Servlet Controlador_Correo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controlador_Correo at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        ConsultasModelos c = new ConsultasModelos();
        OperacionesCRUD crud = new OperacionesCRUD();
        encriptacion encrypt = new encriptacion();
        String usuario = request.getParameter("usuario");
        String nueva_contra = "";
        String accion = request.getParameter("accion");
        String html = "";
        String destino = "";
        if (accion.equals("EnviarNuevaClave")) {
            nueva_contra = encrypt.obtener_contra();
            try {
                confirmacion = crud.Realizar_Operacion("actualizar", "set contrasenia='" + encrypt.getHashPass(nueva_contra) + "'", "", "usuarios", "where nombre_usuario='" + usuario + "' ");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(Controlador_Correo.class.getName()).log(Level.SEVERE, null, ex);
            }
            respuesta.put("correo", c.obtener_dato_campo("usuarios", usuario, "correo", "nombre_usuario"));
            html = "<h2> </h2><br><b>Envió de Contraseña</b><br/><br/>";
            html += "<br>Tu nueva Contraseña será: " + nueva_contra;
            destino = c.obtener_dato_campo("usuarios", usuario, "correo", "nombre_usuario");
        }
        if (accion != null) {
            String remitente = "santiagotronc9@gmail.com";

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.user", remitente);
            props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.clave", "pxakbwlkqcxyzuwo");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            javax.mail.Session s = javax.mail.Session.getDefaultInstance(props);

            s.setDebug(true);

            try {
                MimeMessage message = new MimeMessage(s);
                System.out.println("Correo Enviado");
                message.setFrom(new InternetAddress(remitente));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));

                message.setSubject(accion.equals("EnviarNuevaClave") ? "Te enviamos tu nueva Contraseña" : request.getParameter("asunto") != null ? request.getParameter("asunto") : "Correo Promocional");
                BodyPart parteTexto = new MimeBodyPart();
                parteTexto.setContent(html, "text/html");
                MimeMultipart todaslasPartes = new MimeMultipart();
                todaslasPartes.addBodyPart(parteTexto);
                message.setContent(todaslasPartes);
                Transport transport = s.getTransport("smtp");
                transport.connect("smtp.gmail.com", remitente, "pxakbwlkqcxyzuwo");
                transport.sendMessage(message, message.getAllRecipients());
                transport.close();
                confirmacion = 1;
                System.out.println("Correo Enviado");
            } catch (MessagingException ex) {
                System.out.print(ex.getMessage());
            }
        }

        respuesta.put(
                "resultado", confirmacion);
        response.setContentType(
                "application/json");
        response.getWriter()
                .write(respuesta.toString());
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
