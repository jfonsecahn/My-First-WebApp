
<%@page import="java.util.Arrays"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
    DecimalFormat formatter = new DecimalFormat("###,###,###.00");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    if (session.getAttribute("usuario") == null || session.getAttribute("usuario").toString().equals("null")) {
        out.println("<script> window.location.href='index.jsp';</script>");
    }
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 20);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
%>
<jsp:include page="layouts/admin_header.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="Dashboard" />
</jsp:include>
<!-- top tiles -->
<div class="row"  >
    <br/>
    <br/>
    <br/>
</div>
<!-- /top tiles -->
<%if (Arrays.asList(lista_permisos).contains("Gráfico Ventas por Mes")) {%>
<div class="row">
    <div class="col-md-12 col-sm-12 ">
        <div class="x_panel">
            <div class="x_title">
                <h2>Cantidad de Ventas por Mes <small>(Año Actual)</small></h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content" style="heigh:75px;">
                <canvas id="mybarChart" height="75"></canvas>
            </div>
        </div>
    </div>

</div>
<br />
<%}%>
<div class="row">
    <%if (Arrays.asList(lista_permisos).contains("Gráfico Uso de Sistema")) {%>

    <div class="col-md-6 col-sm-6">
        <div class="x_panel tile fixed_height_320">
            <div class="x_title">
                <h2>Uso de Aplicación por Rol de Usuario</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <h4>Uso del Sistema por Rol de Usuario</h4>

                <%

                    try {
                        sta = cnx.prepareStatement("select r.id as id,r.nombre as nombre,count(b.id) as conteo_rol,(select count(*) from bitacora)as total from bitacora b inner join usuarios u on (b.id_usuario=u.id) inner join roles r on (r.id=u.id_rol) group by r.nombre,r.id");
                        rs = sta.executeQuery();
                        while (rs.next()) {
                            double porcentaje = (rs.getDouble("conteo_rol") / rs.getDouble("total")) * 100;
                            String zero = (porcentaje < 1) ? "0" : "";
                %>

                <div class="widget_summary">
                    <div class="w_left w_25">
                        <span><%=zero%><%=formatter.format(porcentaje)%></span>
                    </div>
                    <div class="w_center w_55">
                        <div class="progress">
                            <div class="progress-bar bg-green" role="progressbar" aria-valuenow="<%=formatter.format(porcentaje)%>" aria-valuemin="0" aria-valuemax="100" style="width: <%=formatter.format(porcentaje)%>%;">
                                <span class="sr-only"><%=formatter.format(porcentaje)%>% </span>
                            </div>
                        </div>
                    </div>
                    <div class="w_right w_20">
                        <span><%=rs.getString("nombre")%></span>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }%>

            </div>
        </div>
    </div>
    <%}%>

    <%if (Arrays.asList(lista_permisos).contains("Gráfico Top 5 Clientes")) {%>
    <div class="col-md-6 col-sm-6">
        <div class="x_panel tile fixed_height_320 overflow_hidden">
            <div class="x_title">
                <h2>Top 5 de Pacientes</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table class="" style="width:100%">
                    <tr>
                        <th style="width:37%;">
                            <p>Top 5</p>
                        </th>
                        <th>
                            <div class="col-lg-7 col-md-7 col-sm-7 ">
                                <p class="">Paciente</p>
                            </div>
                            <div class="col-lg-5 col-md-5 col-sm-5 ">
                                <p class="">Procentaje de Ventas</p>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <canvas class="canvasDoughnut" height="140" width="140" style="margin: 15px 10px 10px 0"></canvas>
                        </td>
                        <td>
                            <table class="tile_info">
                                <%

                                    try {
                                        sta = cnx.prepareStatement("select concat(p.id,' ',p.nombres,' ',p.apellidos) as cliente,sum(f.total) as total_vendido,(select sum(total) from factura where estado='Pagada')as total from factura f"
                                                + " inner join usuarios p on (f.paciente=p.id)"
                                                + " where f.estado='Pagada' and f.paciente<>0"
                                                + " group by concat(p.id,' ',p.nombres,' ',p.apellidos)"
                                                + "order by sum(f.total) desc limit 5");
                                        rs = sta.executeQuery();
                                        while (rs.next()) {
                                            double porcentaje = (rs.getDouble("total_vendido") / rs.getDouble("total")) * 100;
                                            String zero = (porcentaje < 1) ? "0" : "";
                                %>
                                <tr>
                                    <td>
                                        <p><i class="fa fa-square blue"></i><%=rs.getString("cliente")%> </p>
                                    </td>
                                    <td><%=zero%><%=formatter.format(porcentaje)%> %</td>
                                </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        System.out.println(e.getMessage());
                                    }%>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <%}%>
</div>
<%
    cnx.close();
%>
<variables id="variables" 
           grafico1="<%=Arrays.asList(lista_permisos).contains("Gráfico Ventas por Mes")%>" 
           grafico2="<%=Arrays.asList(lista_permisos).contains("Gráfico Top 5 Clientes")%>"
           />
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="js" value="dashboard.js;" />
</jsp:include>
