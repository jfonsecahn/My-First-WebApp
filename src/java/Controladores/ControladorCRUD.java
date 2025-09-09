/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import BD.Conexion;
import BD.OperacionesCRUD;
import Funciones.Consultas;
import Modelo.ConsultasModelos;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.owasp.encoder.Encode;
import seguridad.encriptacion;

@WebServlet(name = "ControladorCRUD", urlPatterns = {"/ControladorCRUD"})
public class ControladorCRUD extends HttpServlet {

    Conexion con = new Conexion();
    OperacionesCRUD crud = new OperacionesCRUD();
    ConsultasModelos c = new ConsultasModelos();
    Connection cnx;
    encriptacion encrypt = new encriptacion();
    Consultas e = new Consultas();
    ResultSet rs;
    ResultSetMetaData rsmd;
    PreparedStatement sta;

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
            out.println("<title>Servlet ControladorCRUD</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControladorCRUD at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        JSONObject respuesta = new JSONObject();
        String modulo = request.getParameter("modulo");
        String tabla = e.Obtener_Tabla(modulo);;

        if (request.getParameter("accion") == null) {
            int contador = 0;

            String editar = "";
            String eliminar = "";
            String valores = "";
            String contenedores = "";

            JSONArray lista = new JSONArray();
            String[] campos_personalizados = {};
            String busqueda = request.getParameter("busqueda") != null ? request.getParameter("busqueda") : "";
            try {

                sta = cnx.prepareStatement(e.Obtener_Consulta(modulo, busqueda));
                System.out.println(e.Obtener_Consulta(modulo, busqueda) + "consulta");
                rs = sta.executeQuery();
                rsmd = rs.getMetaData();
                int columnCount = rsmd.getColumnCount();
                campos_personalizados = e.Obtener_Campos_Join(modulo);
                while (rs.next()) {
                    valores = "";
                    JSONArray registro = new JSONArray();
                    if (contador < 1 && session.getAttribute("usuario") != null) {
                        crud.Regitrar_Bitacora(session.getAttribute("usuario").toString() != null ? session.getAttribute("usuario").toString() : "usuario sin ingresar", modulo, "Vista", "Listado de todos los datos de " + tabla, session.getAttribute("id_usuario").toString(), request.getRemoteAddr());
                    }
                    for (int i = 1; i < (columnCount + 1); i++) {
                        String name = campos_personalizados != null ? campos_personalizados[(i - 1)] : rsmd.getColumnName(i);

                        registro.put((name.equals("imagen") || name.equals("imagen1")) ? "<img src='" + Encode.forHtml(rs.getString(name)) + "' width='70' height='70' title='' alt='' id='imagen" + ((modulo.equals("recetas_paciente") || modulo.equals("recetas_cita")) ? rs.getString("id_receta") : "") + "'/>" : name.equals("icono") ? "<i class='fa fa-2x " + Encode.forHtml(rs.getString(name)) + "' />" : Encode.forHtml(rs.getString(name)));
                        valores += rs.getString(name) + "&";
                        if (contador < 1) {
                            contenedores += name + ";";
                        }
                    }
                    editar = (request.getParameter("editar") != null && request.getParameter("editar").equals("si")) ? "<button class=\"btn btn-warning btn-sm mr-2\" onclick=\"editar('" + contenedores + "','" + Encode.forHtml(valores) + "') \"  data-toggle=\"modal\" data-target=\"#modal_editar\"><i class=\"fa fa-edit\"></i></button>" : "";
                    eliminar = (request.getParameter("eliminar") != null && request.getParameter("eliminar").equals("si")) ? " <button class=\"btn btn-danger btn-sm\" onclick=\"eliminar('" + valores.split("&")[0] + "')\"><i class=\"fa fa-trash\"></i></button>" : "";
                    if (modulo.equals("atencion_citas") && (request.getParameter("editar") != null && request.getParameter("editar").equals("si"))) {
                        if (rs.getString("estado").equals("Sin Atender")) {
                            editar = " <button class=\"btn btn-warning btn-sm mr-2\" onclick=\"cambiar_estado('" + rs.getString("id") + "','Atendiendo','estado','citas')\"  title=\"Atender Paciente\"><i class=\"fa fa-arrows-h\"></i></button>";
                            editar += " <button class=\"btn btn-danger btn-sm mr-2\" onclick=\"cambiar_estado('" + rs.getString("id") + "','Cancelada','estado','citas')\"  title=\"Cancelar Cita\"><i class=\"fa fa-minus-square\"></i></button>";

                        }
                        if (rs.getString("estado").equals("Atendiendo")) {
                            editar = " <button class=\"btn btn-success btn-sm mr-2\" onclick=\"redirigir('Atencion_Paciente.jsp?id_paciente=" + Encode.forHtml(rs.getString("cliente")) + "&id_cita=" + Encode.forHtml(rs.getString("id")) + "')\"  title=\"Ver Historial Médico\"><i class=\"fa fa-external-link-square\"></i></button>";
                            editar += " <button class=\"btn btn-danger btn-sm mr-2\" onclick=\"cambiar_estado('" + rs.getString("id") + "','Atendido','estado','citas')\"  title=\"Finalizar Atención del Paciente\"><i class=\"fa fa-times\"></i></button>";

                        }

                    }
                    if (request.getParameter("editar") != null && request.getParameter("editar").equals("si") && tabla.equals("historial_medico") && !rs.getString("medico").equals(session.getAttribute("id_usuario"))) {
                        editar = "Acciones solo Permitidas al Médico Creador";
                        eliminar = "";
                    }
                    if (request.getParameter("editar") != null && request.getParameter("editar").equals("si") && modulo.equals("recetas_paciente")) {
                        editar = (request.getParameter("editar") != null && request.getParameter("editar").equals("si")) ? "<button class=\"btn btn-warning btn-sm mr-2\" onclick=\"editar('" + contenedores + "','" + Encode.forHtml(valores) + "') \"  data-toggle=\"modal\" data-target=\"#modal_editar1\"><i class=\"fa fa-edit\"></i></button>" : "";

                    }
                    if (request.getParameter("editar") != null && request.getParameter("editar").equals("si") && modulo.equals("recetas_paciente") && !rs.getString("medico").equals(session.getAttribute("id_usuario"))) {
                        editar = "Acciones solo Permitidas al Médico Creador";
                        eliminar = "";
                    }
                    if (request.getParameter("editar") != null && request.getParameter("editar").equals("si") && modulo.equals("historial_pacientes")) {
                        editar = " <button class=\"btn btn-success btn-sm mr-2\" onclick=\"redirigir('Atencion_Paciente.jsp?id_paciente=" + Encode.forHtml(rs.getString("id")) + "')\"  title=\"Ver Historial Médico\"><i class=\"fa fa-external-link-square\"></i></button>";

                    }
                    if (request.getParameter("editar") != null && request.getParameter("editar").equals("si") && modulo.equals("facturas_guardadas")) {
                        editar = " <button class=\"btn btn-primary btn-sm mr-2 mb-1\" onclick=\"cargar_detalle('" + Encode.forHtml(rs.getString("id")) + "','detalle_factura','Detalle de la Factura')\"  title=\"Ver Detalle de la Factura\"><i class=\"fa fa-align-center\"></i></button>";
                    }
                    if (request.getParameter("eliminar") != null && request.getParameter("eliminar").equals("si") && modulo.equals("facturas_guardadas")) {
                        eliminar = " <button class=\"btn btn-danger btn-sm mr-2\" onclick=\"cambiar_estado('" + rs.getString("id") + "','Anulada','estado','factura')\"  title=\"Anular Factura\"><i class=\"fa fa-times\"></i></button>";

                    }
                    if (modulo.equals("citas_pendientes")) {
                        editar = (request.getParameter("editar") != null && request.getParameter("editar").equals("si")) ? "<button class=\"btn btn-warning btn-sm mr-2\" onclick=\"editar('" + contenedores + "','" + Encode.forHtml(valores) + "') \"  data-bs-toggle=\"modal\" data-bs-target=\"#modal_editar\"><i class=\"fa fa-edit\"></i></button>" : "";

                    }
                    if (modulo.equals("citas_finalizadas")) {
                        editar += " <button class=\"btn btn-primary btn-sm mr-2 mb-1\" onclick=\"cargar_detalle('" + Encode.forHtml(rs.getString("id")) + "','recetas_cita','Recetas Prescritas en la Cita')\"  title=\"Ver Recetas de la Cita\"><i class=\"fa fa-align-center\"></i></button>";
                    }
                    if (modulo.equals("admin_citas") && !rs.getString("estado").equals("Sin Atender")) {
                        editar = "Sin Acciones Disponibles";
                        eliminar = "";
                    }
                    registro.put(editar + " " + eliminar);
                    lista.put(registro);
                    contador++;
                }

            } catch (Exception e) {
                System.out.println(e.getMessage() + ",se presentó este error");
                //crud.Regitrar_Error(session.getAttribute("usuario").toString() != null ? session.getAttribute("usuario").toString() : "Usuario No Autenticado", e.getLocalizedMessage(), e.getMessage(), request.getRemoteAddr());
            }
            respuesta.put("data", lista);
        } else {
            String[] tablas_con_archivos = {"productos", "servicios"};
            boolean tiene_archivo = Arrays.asList(tablas_con_archivos).contains(tabla);
            if (tiene_archivo) {
                String ruta_interna = c.obtener_dato_campo(tabla, request.getParameter("id"), "imagen", null);
                File f = new File(getServletContext().getRealPath("/") + ruta_interna);
                f.delete();
            }
            String campo = tabla.equals("recetas") ? request.getParameter("campo") != null ? request.getParameter("campo") : "id_receta" : "id";
            String eliminacion_extra = tabla.equals("permisos_personas") ? "and seccion=" + request.getParameter("campo_extra") : "";
            int confirmacion = crud.Realizar_Operacion("eliminar", "", "", tabla, "where " + campo + "=" + request.getParameter("id") + " " + eliminacion_extra);
            String accion_detallada = (confirmacion < 1) ? "Intento de eliminación" : "eliminación";
            crud.Regitrar_Bitacora(session.getAttribute("usuario").toString(), tabla, accion_detallada, "Registro con id: " + request.getParameter("id").replace("'", "") + " ", session.getAttribute("id_usuario").toString(), request.getRemoteAddr());

            respuesta.put("resultado", confirmacion);
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

        JSONObject respuesta = new JSONObject();
        boolean tiene_archivo = false;
        String accion = "";
        String id = "";
        String tabla = "";
        String sentencia = "set ";
        String campos = "(";
        String valores = "(";
        int contador = 0;
        int confirmacion = 0;
        int total_parametros = 0;
        HttpSession session = request.getSession();
        String contentType = request.getContentType();

        String parametros_no_actualizables[] = {"tabla", "accion", "id", "imagen", "imagen1", "id_receta"};
        if (contentType.indexOf("multipart/form-data") >= 0) {
            try {
                String imagen = "";
                String imagen1 = "";
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                String path = getServletContext().getRealPath("/") + "archivos_subidos\\";
                List items = upload.parseRequest(request);
                for (Object item : items) {
                    FileItem uploaded = (FileItem) item;
                    if (!Arrays.asList(parametros_no_actualizables).contains(uploaded.getFieldName())) {
                        total_parametros += 1;
                    }
                    if (uploaded.getFieldName().equals("tabla")) {
                        tabla = e.Obtener_Tabla(uploaded.getString());
                    }
                    if (uploaded.isFormField() && uploaded.getFieldName().equals("accion")) {
                        accion = uploaded.getString();
                    } else if (uploaded.isFormField() && (uploaded.getFieldName().equals("id") || uploaded.getFieldName().equals("id_receta"))) {
                        id = uploaded.getString();
                    }

                }
                // Se recorren todos los items, que son de tipo FileItem
                for (Object item : items) {
                    FileItem uploaded = (FileItem) item;
                    // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
                    // subido donde nos interese
                    if (!uploaded.isFormField()) {
                        // No es campo de formulario, guardamos el fichero en algún sitio
                        if (uploaded.getSize() > 0) {
                            tiene_archivo = true;
                            File fichero = new File(path, uploaded.getName());
                            uploaded.write(fichero);
                            if (uploaded.getFieldName().equals("imagen")) {
                                imagen = "archivos_subidos/" + uploaded.getName();
                            } else {
                                imagen1 = "archivos_subidos/" + uploaded.getName();
                            }
                        }
                    } else {

                        String nombre_parametro = uploaded.getFieldName();

                        if (!Arrays.asList(parametros_no_actualizables).contains(nombre_parametro) && !uploaded.getString("UTF-8").equals("")) {
                            if (accion.equals("actualizar")) {
                                contador += 1;
                                String dato_extra = "";
                                if (nombre_parametro.equals("cantidad") && tabla.equals("productos") && total_parametros == 1) {
                                    dato_extra = "cantidad+";
                                }
                                String separador = (contador > 0 && contador < (total_parametros)) ? ", " : "";
                                sentencia += nombre_parametro + "=" + dato_extra + "'" + Encode.forHtml(nombre_parametro.equals("contrasenia") ? encrypt.getHashPass(uploaded.getString("UTF-8")) : uploaded.getString("UTF-8")) + "'" + separador;

                            } else {
                                String separador = (total_parametros > 1 && contador < (total_parametros - 1)) ? ", " : "";
                                valores += "'" + Encode.forHtml(nombre_parametro.equals("contrasenia") ? encrypt.getHashPass(uploaded.getString("UTF-8")) : uploaded.getString("UTF-8")) + "'" + separador;
                                campos += nombre_parametro + separador;
                                contador += 1;
                            }
                        }
                    }
                }
                if (accion.equals("ingresar")) {
                    if (!imagen.equals("")) {
                        campos += ",imagen";
                        valores += ",'" + imagen + "'";
                    }
                    if (!imagen1.equals("")) {
                        campos += ",imagen1";
                        valores += ",'" + imagen1 + "'";
                    }
                } else if (tiene_archivo) {
                    if (!imagen.equals("")) {
                        sentencia += ",imagen='" + imagen + "'";
                    }
                    if (!imagen1.equals("")) {
                        sentencia += ",imagen1='" + imagen1 + "'";
                    }
                }

            } catch (Exception e) {
                // crud.Regitrar_Error(session.getAttribute("usuario").toString() != null ? session.getAttribute("usuario").toString() : "Usuario No Autenticado", e.getLocalizedMessage(), e.getMessage(), request.getRemoteAddr());
            }

        } else {
            tabla = e.Obtener_Tabla(request.getParameter("tabla"));
            accion = request.getParameter("accion") != null ? request.getParameter("accion") : "Registro";
            Enumeration<String> parametros = request.getParameterNames();
            Enumeration<String> conteo_parametros = request.getParameterNames();
            while (conteo_parametros.hasMoreElements()) {
                String nombre_parametro = conteo_parametros.nextElement();
                if (!Arrays.asList(parametros_no_actualizables).contains(nombre_parametro) && !request.getParameter(nombre_parametro).equals("")) {
                    total_parametros += 1;
                }
            }

            while (parametros.hasMoreElements()) {
                String nombre_parametro = parametros.nextElement();
                if (!Arrays.asList(parametros_no_actualizables).contains(nombre_parametro) && !request.getParameter(nombre_parametro).equals("")) {
                    if (accion.equals("actualizar")) {

                        id = tabla.equals("recetas") ? request.getParameter("id_receta") : request.getParameter("id");
                        String separador = (total_parametros > 1 && contador < (total_parametros - 1)) ? ", " : "";
                        if (!request.getParameter(nombre_parametro).equals("")) {
                            String dato_extra = "";
                            try {
                                sentencia += nombre_parametro + "=" + dato_extra + "'" + Encode.forHtml(nombre_parametro.equals("contrasenia") ? encrypt.getHashPass(request.getParameter(nombre_parametro)) : request.getParameter(nombre_parametro)) + "'" + separador;
                            } catch (NoSuchAlgorithmException ex) {
                                Logger.getLogger(ControladorCRUD.class.getName()).log(Level.SEVERE, null, ex);
                            }

                        }
                    } else {
                        String separador = (total_parametros > 1 && contador < (total_parametros - 1)) ? ", " : "";
                        try {
                            valores += "'" + Encode.forHtml(nombre_parametro.equals("contrasenia") ? encrypt.getHashPass(request.getParameter(nombre_parametro)) : request.getParameter(nombre_parametro)) + "'" + separador;
                        } catch (NoSuchAlgorithmException ex) {
                            Logger.getLogger(ControladorCRUD.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        campos += nombre_parametro + separador;
                    }
                    contador += 1;
                }

            }
        }
        try {
            id = c.esNumero(id) == true ? id : "'" + id + "'";
            String usuario = session.getAttribute("usuario") != null ? session.getAttribute("usuario").toString() : "Sin usuario";
            String id_usuario = session.getAttribute("id_usuario") != null ? session.getAttribute("id_usuario").toString() : "Sin usuario";
            if (accion.equals("ingresar")) {
                valores += ")";
                campos += ")";
                confirmacion = !tabla.equals("factura") ? crud.Realizar_Operacion("insertar", campos, valores, tabla.replace("'", ""), "") : crud.insetar_retornando_id(campos, valores, tabla.replace("'", ""), session.getAttribute("id_usuario").toString());
            } else {
                String campo = tabla.equals("recetas") ? "id_receta" : "id";
                confirmacion = crud.Realizar_Operacion("actualizar", sentencia, "", tabla.replace("'", ""), "where " + campo + "=" + id + " ");
            }
            String accion_detallada = (confirmacion < 1) ? "Intento de " + accion : accion;
            crud.Regitrar_Bitacora(session.getAttribute("usuario").toString(), tabla, accion_detallada, accion.equals("actualizar") ? "Registro con id: " + request.getParameter("id").replace("'", "") : "Ingreso de Nuevo registro: " + valores + " ", session.getAttribute("id_usuario").toString(), request.getRemoteAddr());

        } catch (Exception e) {
            // crud.Regitrar_Error(session.getAttribute("usuario").toString() != null ? session.getAttribute("usuario").toString() : "Usuario No Autenticado", e.getLocalizedMessage(), e.getMessage(), request.getRemoteAddr());
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

    @Override
    public void init() {
        this.cnx = con.getConexion();
    }

    @Override
    public void destroy() {
        try {
            cnx.close();
        } catch (SQLException ex) {
            Logger.getLogger(ControladorCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
