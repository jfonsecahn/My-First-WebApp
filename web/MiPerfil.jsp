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
    String identificador = "Información Personal";
    String titulo = "Administracion de " + identificador;
    String[] perfil = p.obtener_informacion_perfil(session.getAttribute("id_usuario")!=null?session.getAttribute("usuario").toString():"");
    String values = session.getAttribute("id_usuario")!=null?session.getAttribute("id_usuario").toString() + ";" + perfil[5] + ";" + perfil[6] + ";null;" + perfil[11] + ";"  + perfil[10]:"";
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
        String puede_editar = "si";
        String puede_eliminar = "no";

    %><div class="col-md-12 col-sm-12">
        <div class="x_panel">
            <div class="x_title">
                <h2><i class="fa fa-bars"></i> Mi Perfil <small></small></h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                <ul class="nav nav-tabs justify-content-end bar_tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home1" role="tab" aria-controls="home" aria-selected="true">Información General</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile1" role="tab" aria-controls="profile" aria-selected="false">Autenticación</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home1" role="tabpanel" aria-labelledby="home-tab">
                        <div id="resultado_operacion" class="col-12">
                        </div>
                        <jsp:include page='formulario.jsp'>
                            <jsp:param name="enctype" value="multipart/form-data" />
                            <jsp:param name="id" value="formulario_actualizar" /> 
                            <jsp:param name="values" value="<%=values%>" />
                            <jsp:param name="campos" value="id;telefono;correo;imagen;especialidad_principal;presentacion" />
                            <jsp:param name="titulos" value="Id;Teléfono;Correo;Imagen;Especialidad Principal;Presentación" />
                            <jsp:param name="tipos_input" value="text;text;email;file;text;textarea" />
                            <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-6;col-12" />
                        </jsp:include> 
                        <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar');" >Actualizar </button>

                    </div>
                    <div class="tab-pane fade" id="profile1" role="tabpanel" aria-labelledby="profile-tab">
                        <div id="resultado_operacion_contra" class="col-12">
                        </div>
                        <jsp:include page='formulario.jsp'>
                            <jsp:param name="id" value="formulario_cambio_contra" />        
                            <jsp:param name="campos" value="contra_actual;contra_nueva;contra_nueva_confirmacion" />
                            <jsp:param name="titulos" value="Contraseña Actual;Nueva Contraseña;Confirme Nueva Contraseña" />
                            <jsp:param name="tipos_input" value="password;password;password" />
                            <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-12" />
                        </jsp:include> 
                        <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_cambio_contra');" >Actualizar Credenciales </button>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>  
<variables id="variables" modulo="informacion_personal" usuario="<%=session.getAttribute("usuario")%>" puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>" id_usuario="<%=session.getAttribute("id_usuario")%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="js" value="mi_perfil.js" />
</jsp:include>
