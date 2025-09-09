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
    String identificador = "Citas Pendientes";
    String titulo = "Atención " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 13);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
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
        String mostrar_acciones = Arrays.asList(lista_permisos).contains("Atender") ? "true" : "false";
        String puede_editar = Arrays.asList(lista_permisos).contains("Atender") ? "si" : "no";
        String puede_eliminar = "no";

    %>
    <div id="resultado_operacion" class="col-12">
    </div>
    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;Id Servicio;Nombre Servicio;Id Cliente;Nombre Cliente;Fecha;Estado" />
        <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
        <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
    </jsp:include>
</div>  
<variables id="variables" modulo="atencion_citas" puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>" busqueda="<%=session.getAttribute("id_usuario")%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>
