
<%@page import="Modelo.ConsultasModelos"%>
<%@page import="java.util.Arrays"%>
<%
    ConsultasModelos p = new ConsultasModelos();
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    String identificador = "Bitácora";
    String titulo = "Vista de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 4);

        if (!permisos.equals("")) {

            lista_permisos = permisos.split(";");
        }
    }
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

    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;Tabla;Acción;Datos;Id Usuario;Usuario;Fecha;Ip Cliente" />
        <jsp:param name="mostrar_acciones" value="false" />
        <jsp:param name="puede_agregar" value="no" />
    </jsp:include>
</div>  
<variables id="variables" modulo="bitacora" />

<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>