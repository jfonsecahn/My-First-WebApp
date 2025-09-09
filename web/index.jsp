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
    <jsp:param name="usar_header" value="si" />
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="imagen" value="<%=datos[9]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="eslogan" value="<%=datos[2]%>" />
    <jsp:param name="pagina" value="Página Principal" />
</jsp:include>
<!-- About Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row gx-5">
            <div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;">
                <div class="position-relative h-100">
                    <img class="position-absolute w-100 h-100 rounded" src="<%=datos[10]%>" style="object-fit: cover;">
                </div>
            </div>
            <div class="col-lg-7">
                <div class="mb-4">
                    <h5 class="d-inline-block text-primary text-uppercase border-bottom border-5">Sobre Nosotros</h5>
                    <h1 class="display-4"><%=datos[6]%></h1>
                </div>
                <p><%=datos[7]%></p>
                <div class="row g-3 pt-3">
                    <div class="col-sm-4 col-6">
                        <div class="bg-light text-center rounded-circle py-4">
                            <i class="fa fa-3x fa-user-md text-primary mb-3"></i>
                            <h6 class="mb-0">Excelentes<small class="d-block text-primary">Médicos</small></h6>
                        </div>
                    </div>
                    <div class="col-sm-4 col-6">
                        <div class="bg-light text-center rounded-circle py-4">
                            <i class="fa fa-3x fa-procedures text-primary mb-3"></i>
                            <h6 class="mb-0">Calidad<small class="d-block text-primary">En Servicios</small></h6>
                        </div>
                    </div>
                    <div class="col-sm-4 col-6">
                        <div class="bg-light text-center rounded-circle py-4">
                            <i class="fa fa-3x fa-microscope text-primary mb-3"></i>
                            <h6 class="mb-0">Laboratorio<small class="d-block text-primary">Especializado</small></h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- About End -->


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




<!-- Team Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 500px;">
            <h5 class="d-inline-block text-primary text-uppercase border-bottom border-5">Nuestros Médicos</h5>
            <h1 class="display-4">Profesionales Calificados</h1>
        </div>
        <div class="owl-carousel team-carousel position-relative">
            <%

                try {
                    sta = cnx.prepareStatement("SELECT * from usuarios where id_rol=4 and estado='Activo'");
                    rs = sta.executeQuery();
                    rsmd = rs.getMetaData();
                    columnCount = rsmd.getColumnCount();
                    while (rs.next()) {
            %>
            <div class="team-item">
                <div class="row g-0 bg-light rounded overflow-hidden">
                    <div class="col-12 col-sm-5 h-100">
                        <img class="img-fluid h-100" src="<%=rs.getString("imagen")%>" style="object-fit: cover;">
                    </div>
                    <div class="col-12 col-sm-7 h-100 d-flex flex-column">
                        <div class="mt-auto p-4">
                            <h3><%=rs.getString("nombres")%> <%=rs.getString("apellidos")%></h3>
                            <h6 class="fw-normal fst-italic text-primary mb-4"><%=rs.getString("especialidad_principal")%></h6>
                            <p class="m-0"><%=rs.getString("presentacion")%></p>
                        </div>
                        <div class="d-flex mt-auto border-top p-4">
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }%>
        </div>
    </div>
</div>
<!-- Team End -->
<%
cnx.close();
%>
<jsp:include page="layouts/public_footer.jsp" >
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pie" value="<%=datos[8]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="direccion" value="<%=datos[3]%>" />
</jsp:include>