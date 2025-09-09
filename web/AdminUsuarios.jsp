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
    String modelo = "Usuario";
    String identificador = "Usuarios";
    String titulo = "Administracion de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 10);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = Arrays.asList(lista_permisos).contains("Agregar") ? "si" : "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String opciones = "Activo:Activo;Inactivo:Inactivo-" + p.obtener_opciones_select("roles", "id as value,nombre as label");
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
                        <jsp:param name="enctype" value="multipart/form-data" />
                        <jsp:param name="id" value="formulario_actualizar" />
                        <jsp:param name="campos" value="id;identidad;nombres;apellidos;correo;telefono;imagen;estado;nombre_usuario;contrasenia;id_rol" />
                        <jsp:param name="titulos" value="Id;Identidad;Nombres;Apellidos;Correo;Teléfono;Imagen;Estado;Nombre Usuario;Contraseña;Rol" />
                        <jsp:param name="tipos_input" value="text;text;text;text;email;text;file;select;text;password;select" />
                        <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6" />
                        <jsp:param name="opciones" value="<%=opciones%>" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar');" >Actualizar </button>
                </div>
            </div>
        </div>
    </div>
    <%}%>
    <%if (Arrays.asList(lista_permisos).contains("Agregar")) {%>
    <div class="modal fade bs-example-modal-lg"  id="modal_insertar" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Ingresar <%=modelo%></h4>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="enctype" value="multipart/form-data" />
                        <jsp:param name="id" value="formulario_ingreso" />
                        <jsp:param name="campos" value="identidad;nombres;apellidos;correo;telefono;imagen;estado;nombre_usuario;contrasenia;id_rol" />
                        <jsp:param name="titulos" value="Identidad;Nombres;Apellidos;Correo;Teléfono;Imagen;Estado;Nombre Usuario;Contraseña;Rol" />
                        <jsp:param name="tipos_input" value="text;text;text;email;text;file;select;text;password;select" />
                        <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6;col-6" />
                        <jsp:param name="opciones" value="<%=opciones%>" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_ingreso')">Guardar</button>
                </div>

            </div>
        </div>
    </div>
    <%}
        String mostrar_acciones = Arrays.asList(lista_permisos).contains("Editar") || Arrays.asList(lista_permisos).contains("Eliminar") ? "true" : "false";
        String puede_editar = Arrays.asList(lista_permisos).contains("Editar") ? "si" : "no";
        String puede_eliminar = Arrays.asList(lista_permisos).contains("Eliminar") ? "si" : "no";

    %>
    <div id="resultado_operacion" class="col-12">
    </div>
    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;Identidad;Nombre Usuario;Contraseña;Nombres;Apellidos;Teléfono;Correo;Estado;Imagen;Id Rol;Nombre Rol" />
        <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
        <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
    </jsp:include>
</div>  
<variables id="variables" modulo="usuarios"  puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>
