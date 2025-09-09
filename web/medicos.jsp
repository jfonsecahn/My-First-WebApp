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