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
    int columnCount = 0;
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
<div class="container-fluid bg-primary my-5 py-5">
    <div class="container py-5">
        <div class="row gx-5">
            <div class="col-lg-4 mb-5 mb-lg-0">
                <div class="mb-4">
                    <h5 class="d-inline-block text-white text-uppercase border-bottom border-5">Realizar Cita</h5>
                    <h1 class="display-4">Haz tu Cita con Nosotros</h1>
                </div>
                <p class="text-white mb-5">Rapidamente desde la comodidad de tu Casa</p>
                <a class="btn btn-dark rounded-pill py-3 px-5 me-3" href="Medicos.jsp">Ver Doctores</a>
            </div>
            <div class="col-lg-8">
                <div class="bg-white text-center rounded p-5">
                    <h1 class="mb-4">Agendar Cita</h1>
                    <div id="resultado_operacion" class="col-12">
                    </div>
                    <form id="formulario_citas" enctype="">

                        <div class="row g-3">
                            <div class="col-12 col-sm-6">
                                <select class="form-select bg-light border-0" style="height: 55px;" required name="servicio" id="servicio">
                                    <option selected value="">Selecciona un Servicio</option>
                                    <%

                                        try {
                                            sta = cnx.prepareStatement("SELECT * from servicios where estado='Disponible'");
                                            rs = sta.executeQuery();
                                            rsmd = rs.getMetaData();
                                            columnCount = rsmd.getColumnCount();
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
                            <div class="container" id="datetimecontainer" style="display:none;">
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
                            <div class="col-12">
                                <button class="btn btn-primary w-100 py-3 ingreso" type="submit">Ingresar Cita</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<options id="opciones" modulo="servicios_medico"  identificadores="servicio;" receptores="medico;"/>
<variables id="variables" modulo="citas" id_usuario="<%=session.getAttribute("id_usuario")%>" usuario="<%=session.getAttribute("usuario")%>"></variables>
<jsp:include page="layouts/public_footer.jsp" >
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pie" value="<%=datos[8]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="direccion" value="<%=datos[3]%>" />
    <jsp:param name="js" value="realizar_cita.js;common.js" />
</jsp:include>