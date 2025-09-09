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
    String modelo = "Historial Médico";
    String modelo1 = "Receta";
    String identificador = "Historial Médico";
    String titulo = "Administracion de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    String permisos1 = "";
    String[] lista_permisos1 = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 14);
        permisos1 = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 15);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
        if (!permisos1.equals("")) {
            lista_permisos1 = permisos1.split(";");
        }
    }
    if (request.getParameter("id_paciente") == null) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String puede_agregar = Arrays.asList(lista_permisos).contains("Agregar") ? "si" : "no";
    String puede_agregar1 = Arrays.asList(lista_permisos1).contains("Agregar") ? "si" : "no";
    String mostrar_acciones = Arrays.asList(lista_permisos).contains("Editar") || Arrays.asList(lista_permisos).contains("Eliminar") ? "true" : "false";
    String puede_editar = Arrays.asList(lista_permisos).contains("Editar") ? "si" : "no";
    String puede_eliminar = Arrays.asList(lista_permisos).contains("Eliminar") ? "si" : "no";
    String mostrar_acciones1 = Arrays.asList(lista_permisos1).contains("Editar") || Arrays.asList(lista_permisos1).contains("Eliminar") ? "true" : "false";
    String puede_editar1 = Arrays.asList(lista_permisos1).contains("Editar") ? "si" : "no";
    String puede_eliminar1 = Arrays.asList(lista_permisos1).contains("Eliminar") ? "si" : "no";
    String[] perfil = p.obtener_informacion_paciente(request.getParameter("id_paciente") != null ? request.getParameter("id_paciente") : "");

%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="Atención del Paciente" />
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
                        <jsp:param name="campos" value="id;comentarios" />
                        <jsp:param name="titulos" value="Id;Comentarios" />
                        <jsp:param name="tipos_input" value="text;textarea;" />
                        <jsp:param name="clases_input" value="col-6;col-12;" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar');" >Actualizar </button>
                </div>
            </div>
        </div>
    </div>
    <%}
        if (Arrays.asList(lista_permisos).contains("Agregar")) {%>
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
                        <jsp:param name="id" value="formulario_ingreso" />
                        <jsp:param name="campos" value="comentarios;" />
                        <jsp:param name="titulos" value="Comentarios;" />
                        <jsp:param name="tipos_input" value="textarea;" />
                        <jsp:param name="clases_input" value="col-12;" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_ingreso')">Guardar</button>
                </div>

            </div>
        </div>
    </div><%}%>
    <%if (Arrays.asList(lista_permisos1).contains("Editar")) {%>
    <div class="modal fade bs-example-modal-lg"  id="modal_editar1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Actualización de <%=modelo1%></h5>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="id" value="formulario_actualizar_recetas" />
                        <jsp:param name="enctype" value="multipart/form-data" />
                        <jsp:param name="campos" value="id_receta;descripcion;imagen" />
                        <jsp:param name="titulos" value="Id;Descripción;Imagen" />
                        <jsp:param name="tipos_input" value="text;textarea;file;" />
                        <jsp:param name="clases_input" value="col-6;col-12;col-6" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar_recetas');" >Actualizar </button>
                </div>
            </div>
        </div>
    </div>
    <%}
        if (Arrays.asList(lista_permisos1).contains("Agregar")) {%>
    <div class="modal fade bs-example-modal-lg"  id="modal_insertar1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Ingresar <%=modelo1%></h4>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="id" value="formulario_ingreso_recetas" />
                        <jsp:param name="enctype" value="multipart/form-data" />
                        <jsp:param name="campos" value="descripcion;imagen" />
                        <jsp:param name="titulos" value="Descripción;Imagen" />
                        <jsp:param name="tipos_input" value="textarea;file;" />
                        <jsp:param name="clases_input" value="col-12;col-6" />
                    </jsp:include>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_ingreso_recetas')">Guardar</button>
                </div>

            </div>
        </div>
    </div><%}%>
    <div class="col-md-12 col-sm-12 ">
        <div class="x_panel">
            <div class="x_title">
                <h2>Datos Generales <small>del Paciente</small></h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <div class="col-md-3 col-sm-3  profile_left">
                    <div class="profile_img">
                        <div id="crop-avatar">
                            <!-- Current avatar -->
                            <img class="img-responsive avatar-view" src="<%=perfil[8]%>" alt="Sin Imagen" title="Change the avatar">
                        </div>
                    </div>
                    <h3><%=perfil[3]%> <%=perfil[4]%></h3>

                    <ul class="list-unstyled user_data">
                        <li><i class="fa fa-phone user-profile-icon"></i> <%=perfil[5]%>
                        </li>

                        <li>
                            <i class="fa fa-mail-forward user-profile-icon"></i> <%=perfil[6]%>
                        </li>

                    </ul>

                </div>
                <div class="col-md-9 col-sm-9 ">

                    <div class="profile_title">
                        <div class="col-md-6">
                            <h2>Información del Paciente</h2>
                        </div>
                    </div>
                    <button type="button" class="btn btn-round btn-danger float-right mt-3 mb-2"  onclick="cambiar_estado('<%=request.getParameter("id_cita")%>', 'Atendido', 'estado', 'citas', null, null, null, {url: 'Atencion_Citas.jsp'})">Finalizar Cita</button>

                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                            <li role="presentation" class="active" onclick="cambiar_actual('historial_paciente')"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true" class="active" aria-selected="true">Historial Médico</a>
                            </li>
                            <li role="presentation" class="" onclick="cambiar_actual('recetas_paciente')"><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false" class="" aria-selected="false">Recetas</a>
                            </li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="tab_content1" aria-labelledby="home-tab">
                                <div id="resultado_operacionhistorial_paciente" class="col-12">
                                </div>
                                <% if (Arrays.asList(lista_permisos).contains("Ver")) {%>
                                <jsp:include page="lista.jsp" >  
                                    <jsp:param name="identificador" value="Historial Médico" />
                                    <jsp:param name="id" value="historial_paciente" />
                                    <jsp:param name="titulos" value="Id;Id Médico;Nombre Médico;Comentarios;Fecha" />
                                    <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
                                    <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
                                </jsp:include>
                                <%}%>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">

                                <div id="resultado_operacionrecetas_paciente" class="col-12">
                                </div>
                                <% if (Arrays.asList(lista_permisos1).contains("Ver")) {%>
                                <jsp:include page="lista.jsp" >  
                                    <jsp:param name="identificador" value="Recetas"/>
                                    <jsp:param name="modal" value="modal_insertar1" />
                                    <jsp:param name="id" value="recetas_paciente" />
                                    <jsp:param name="titulos" value="Id;Imagen;Descripcion;Id Médico;Nombre Médico" />
                                    <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones1%>" />
                                    <jsp:param name="puede_agregar" value="<%=puede_agregar1%>" />
                                </jsp:include>
                                <%}%>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>  
<variables id="variables" modulo="historial_paciente;recetas_paciente" usuario="<%=session.getAttribute("id_usuario")%>" cita="<%=request.getParameter("id_cita")%>" busqueda="<%=request.getParameter("id_paciente")%>" paciente="<%=request.getParameter("id_paciente")%>" puede_editar="<%=puede_editar%>;<%=puede_editar1%>"  puede_eliminar="<%=puede_eliminar%>;<%=puede_eliminar1%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="js" value="mis_citas.js;" />
</jsp:include>