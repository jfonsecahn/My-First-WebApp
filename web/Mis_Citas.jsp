<%@page import="org.owasp.encoder.Encode"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="BD.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="Modelo.ConsultasModelos"%>
<%

    ConsultasModelos p = new ConsultasModelos();
    String[] datos = p.obtener_informacion_empresa();
    Connection cnx;
    Conexion con = new Conexion();
    PreparedStatement sta;
    ResultSet rs;
    cnx = con.getConexion();
    ResultSetMetaData rsmd;
    if (session.getAttribute("usuario") == null || session.getAttribute("usuario").toString().equals("null")) {
        out.println("<script> window.location.href='index.jsp';</script>");
    }
    String titulos[] = "Id;Descripción;Imagen".split(";");
%>
<jsp:include page="layouts/public_header.jsp"> 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="imagen" value="<%=datos[9]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="eslogan" value="<%=datos[2]%>" />
    <jsp:param name="pagina" value="Página Principal" />
</jsp:include>
<!-- Appointment Start -->
<div class="container-fluid my-5 py-5">
    <div class="container py-5">
        <div class="modal fade bs-example-modal-lg"  id="modal_detalle" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title" id="titulo_modal_detalle" style="color:black"></h4>
                        <button type="button" class="close" data-bs-dismiss="modal"><span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body" style="color:black;">
                        <table class="table table-striped jambo_table mb-5" id='detalle_reservacion' style="width:100%">
                            <thead>
                                <tr>
                                    <%    for (int x = 0; x < titulos.length; x++) {%>
                                    <th><%=titulos[x]%></th>
                                        <%}%>
                                </tr>
                            </thead>

                            <tbody>

                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade bs-example-modal-lg"  id="modal_editar" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Actualización de Cita</h5>
                        <button type="button" class="close"  data-bs-dismiss="modal"><span aria-hidden="true">×</span>
                        </button>
                    </div>            
                    <form id="formulario_citas_actualizar" enctype="">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-12 col-sm-12">
                                    <input type="text" class="form-control bg-light border-0" style="height: 55px;" required name="id" id="id"/>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <select class="form-select bg-light border-0" style="height: 55px;" required name="servicio" id="servicio">
                                        <option selected value="">Selecciona un Servicio</option>
                                        <%

                                            try {
                                                sta = cnx.prepareStatement("SELECT * from servicios where estado='Disponible'");
                                                rs = sta.executeQuery();
                                                rsmd = rs.getMetaData();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("id")%>"><%=rs.getString("nombre")%> Lps. <%=rs.getString("precio")%></option>
                                        <%
                                                }

                                            } catch (Exception e) {
                                                System.out.println(e.getMessage());
                                            }%>
                                    </select>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <select class="form-select bg-light border-0" style="height: 55px;" required name="medico" id="medico">
                                        <option selected value="">Selecciona el Médico</option>
                                    </select>
                                </div>
                                <div class="container" id="datetimecontainer">
                                    <div class="row">
                                        <div class='col-sm-12'>
                                            <div class="form-group">
                                                <div class='input-group datetime'>
                                                    <input type='text'  name="fecha" id="fecha" class="form-control bg-light border-0" />
                                                    <span class="input-group-addon bg-info" style="width: 50px;">
                                                        <span class="fa fa-calendar mr-2 mt-2 ml-2" style="color:white;"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary w-100 py-3 ingreso" type="submit">Modificar Cita</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="accordion" id="accordionExample">
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Citas Pendientes
                    </button>
                </h2>
                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div id="resultado_operacion" class="col-12">
                        </div>
                        <jsp:include page="lista.jsp" > 
                            <jsp:param name="id" value="citas_pendientes" />
                            <jsp:param name="identificador" value="Mis Citas Pendientes" />
                            <jsp:param name="titulos" value="Id;Id Servicio;Nombre Servicio;Id Médico;Nombre Nombre Médico;Fecha;Precio" />
                            <jsp:param name="mostrar_acciones" value="true" />
                            <jsp:param name="puede_agregar" value="no" />
                        </jsp:include>   
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Citas Finalizadas
                    </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <jsp:include page="lista.jsp" > 
                            <jsp:param name="id" value="citas_finalizadas" />
                            <jsp:param name="identificador" value="Mis Citas Finalizadas" />
                            <jsp:param name="titulos" value="Id;Id Servicio;Nombre Servicio;Id Médico;Nombre Médico;Fecha;Precio" />
                            <jsp:param name="mostrar_acciones" value="true" />
                            <jsp:param name="puede_agregar" value="no" />
                        </jsp:include>    
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    cnx.close();
%>
<options id="opciones" modulo="servicios_medico"  identificadores="servicio;" receptores="medico;"/>
<variables id="variables" id_usuario="<%=session.getAttribute("id_usuario")%>" busqueda="<%=session.getAttribute("id_usuario")%>" modulo="citas_finalizadas;citas_pendientes" puede_editar="no;si" puede_eliminar="no;si"></variables>
<jsp:include page="layouts/public_footer.jsp" >
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pie" value="<%=datos[8]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="direccion" value="<%=datos[3]%>" />
    <jsp:param name="js" value="common.js;realizar_cita.js;mis_citas.js" />
</jsp:include>