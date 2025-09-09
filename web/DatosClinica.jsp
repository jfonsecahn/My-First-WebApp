<%@page import="java.util.Arrays"%>
<%@page import="Modelo.ConsultasModelos"%>
<%
    ConsultasModelos p = new ConsultasModelos();
    if (session.getAttribute("usuario") == null || session.getAttribute("usuario").toString().equals("null")) {
        out.println("<script> window.location.href='index.jsp';</script>");
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    String modelo = "Datos de la Clínica";
    String identificador = "Datos de la Clinica";
    String titulo = "Administracion de " + identificador;
    ConsultasModelos cp = new ConsultasModelos();
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = cp.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 1);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String[] datos = p.obtener_informacion_empresa();
%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="<%=identificador%>" />
</jsp:include>
<div class="row">

    <jsp:include page="titulo.jsp" >  
        <jsp:param name="titulo" value="<%=titulo%>" />
    </jsp:include>
    <%if (Arrays.asList(lista_permisos).contains("Editar")) {%>
    <div class="modal fade bs-example-modal-lg"  id="modal_editar" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Actualización de <%=modelo%></h5>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="id" value="formulario_actualizar" />
                        <jsp:param name="enctype" value="multipart/form-data" />
                        <jsp:param name="campos" value="id;nombre;eslogan;correo;telefono;titulo_mision;mision;mensaje_pie;direccion;imagen;imagen1;rtn" />
                        <jsp:param name="titulos" value="Id;Nombre;Eslogan;Correo;Teléfono;Título Misión;Misión;Mensaje Pie;Dirección;Imagen;Imagen Nosotros;RTN" />
                        <jsp:param name="tipos_input" value="text;text;text;email;text;text;textarea;textarea;textarea;file;file;text" />
                        <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-6;col-12;col-12;col-12;col-12;col-6;col-6;col-6" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar');" >Actualizar </button>
                </div>
            </div>
        </div>
    </div>
    <%}
        String mostrar_acciones = Arrays.asList(lista_permisos).contains("Editar") || Arrays.asList(lista_permisos).contains("Eliminar") ? "true" : "false";
        String puede_editar = Arrays.asList(lista_permisos).contains("Editar") ? "si" : "no";
        String puede_eliminar = "no";

    %>
    <div id="resultado_operacion" class="col-12">
    </div>
    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;Nombre;Eslogan;Dirección;Correo;Teléfono;Titulo Misión;Misión;Mensaje Pie;Imagen;Imagen Nosotros;RTN" />
        <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
        <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
    </jsp:include>
</div>  
<variables id="variables" modulo="datos_clinica"  puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>"/>
<%String archivos_js = "common.js;admin_productos.js";%>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>