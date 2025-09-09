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
    String modelo = "Rol";
    String identificador = "Respaldo y Restauración";
    String titulo = "Control de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 2);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = Arrays.asList(lista_permisos).contains("Agregar") ? "si" : "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String opciones = "1:Realizar Backup;2:Restaurar desde Backup-";
%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="<%=identificador%>" />
</jsp:include>
<div class="row">
    <jsp:include page="titulo.jsp" >  
        <jsp:param name="titulo" value="<%=titulo%>" />
    </jsp:include>
    <div class="col-md-12 col-sm-12 ">
        <div class="x_panel">
            <div class="x_title">
                <h2>Respaldo y Restauración del Sistema <small>Integridad de la Información</small></h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <br>
                <div id="resultado_operacion" class="col-12">
                </div>
                <jsp:include page='formulario.jsp'>
                    <jsp:param name="id" value="formulario_actualizar" />
                    <jsp:param name="campos" value="opcion;" />
                    <jsp:param name="titulos" value="Opciones;" />
                    <jsp:param name="tipos_input" value="select;" />
                    <jsp:param name="clases_input" value="col-12" />
                    <jsp:param name="opciones" value="<%=opciones%>" />
                </jsp:include>  
            </div>
            <button type="button" class="btn btn-success ingreso" onclick="guardar('formulario_actualizar');" >Realizar Accion </button>
            <a class="btn btn-primary pull-right" id="descarga" style="margin-right: 5px;display:none;" download="<%=getServletContext().getRealPath("/") + "respaldo_bd\\respaldo.sql"%>" href="<%=getServletContext().getRealPath("/") + "respaldo_bd\\respaldo.sql"%>"><i class="fa fa-download"></i> Descargar Archivo de Respaldo</a>
        </div>
    </div>
    <%
        String puede_editar = Arrays.asList(lista_permisos).contains("Restaurar y Restablecer") ? "si" : "no";
        String puede_eliminar = "no";

    %>

</div>
<variables id="variables" modulo="respaldo_restauracion" puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>
