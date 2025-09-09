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
    <jsp:param name="pagina" value="Médicos" />
</jsp:include>
<!-- Services Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 500px;">
            <h5 class="d-inline-block text-primary text-uppercase border-bottom border-5">Servicios</h5>
            <h1 class="display-4">Excelentes Servicios Médicos</h1>
        </div>
        <div class="row g-5">
            <%

                try {
                    sta = cnx.prepareStatement("SELECT * from servicios where estado='Disponible'");
                    rs = sta.executeQuery();
                    rsmd = rs.getMetaData();
                    columnCount = rsmd.getColumnCount();
                    int contador_servicios = 0;
                    while (rs.next()) {
                        contador_servicios++;
                        JSONArray servicio = new JSONArray();
                        for (int i = 1; i <= columnCount; i++) {
                            String name = rsmd.getColumnName(i);
                            servicio.put(Encode.forHtml(rs.getString(name)));
                        }
                        servicio.put("Servicio");
            %>
            <div class="col-lg-4 col-md-6">
                <div class="service-item bg-light rounded d-flex flex-column align-items-center justify-content-center text-center">
                    <div class="service-icon mb-4">
                        <i class="fa fa-2x <%=rs.getString("icono")%> text-white"></i>
                    </div>
                    <h4 class="mb-3"><%=rs.getString("nombre")%></h4>
                    <p class="m-0"><%=rs.getString("descripcion")%></p>
                    <p class="m-0"><%=rs.getString("precio")%></p>
                    <a class="btn btn-lg btn-primary rounded-pill" href="">
                        <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
            <%
                    }
                    if (contador_servicios == 0 && (request.getParameter("busqueda") != null && !request.getParameter("busqueda").equals(""))) {
                        out.println(" <h3 class='text-lg text-danger'>Sin resultados</h3>");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }%>
        </div>
    </div>
</div>
<!-- Services End -->
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