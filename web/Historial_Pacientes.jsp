<%@page import="Modelo.ConsultasModelos"%>
<%@page import="java.util.Arrays"%>
<%
    ConsultasModelos p = new ConsultasModelos();
    String[] datos = p.obtener_informacion_empresa();
    if (session.getAttribute("usuario") == null || session.getAttribute("usuario").toString().equals("null")) {
        out.println("<script> window.location.href='index.jsp';</script>");
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    String identificador = "Historial de Pacientes";
    String titulo = "Vista de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 16);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = Arrays.asList(lista_permisos).contains("Agregar") ? "si" : "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String opciones = "Activo:Activo;Inactivo:Inactivo-";
%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="<%=identificador%>" />
</jsp:include>
<div class="row">
    <jsp:include page="titulo.jsp" >  
        <jsp:param name="titulo" value="<%=titulo%>" />
    </jsp:include>
    <%
        String mostrar_acciones = "true";
        String puede_editar = "si";
        String puede_eliminar = "no";

    %>
    <div id="resultado_operacion" class="col-12">
    </div>
    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;Identidad;Nombre Usuario;Contraseña;Nombres;Apellidos;Teléfono;Correo;Estado;Imagen" />
        <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
        <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
    </jsp:include>
</div>  
<variables id="variables" modulo="historial_pacientes"  puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>
