<%@page import="BD.Conexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    String identificador = "Facturas";
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 19);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String impuesto = p.obtener_dato_campo("datos_fluctuantes", "1", "impuesto", "id");
    Connection cnx;
    Conexion con = new Conexion();
    cnx = con.getConexion();
    PreparedStatement sta;
    ResultSet rs;
    Date td = new Date();
    String b = new String("");
    SimpleDateFormat format = new SimpleDateFormat("YYYY/MM/dd hh:mm a");
    b = format.format(td);
    String puede_agregar = Arrays.asList(lista_permisos).contains("Facturar") ? "si" : "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String info_rangos = p.obtener_rango();
    String rango_fin = "";
    String rango_autorizado = "";
    if (!info_rangos.equals("")) {
        rango_fin = info_rangos.split(";")[1].split("-")[3];
        rango_autorizado = "Desde " + info_rangos.split(";")[0] + " hasta " + info_rangos.split(";")[1];
    }
    String rango_actual = p.obtener_rango_actual();
    String fecha_emision = p.obtener_dato_campo("datos_fluctuantes", "1", "DATE_FORMAT(fecha_limite, '%Y/%m/%d')as fecha", "id");

%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="<%=identificador%>" />
</jsp:include>

<div class="clearfix"></div>

<div class="row">
    <%if (puede_agregar.equals("si")) {%>
    <div class="modal fade bs-example-modal-xl"  id="modal_insertar" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Buscar Citas Finalizadas </h4>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="id" value="formulario_buscar" />
                        <jsp:param name="campos" value="nombre;" />
                        <jsp:param name="titulos" value="Código o Nombre del Paciente/Servicio" />
                        <jsp:param name="tipos_input" value="text;" />
                        <jsp:param name="clases_input" value="col-12;" />
                    </jsp:include>
                    <div class="row">
                        <div class="col-12">
                            <h5 class="card-title">Lista de Resultados</h5>
                            <table
                                id="lista_de_resultados"
                                class="table table-striped table-bordered dt-responsive nowrap"
                                style="width: 100%" >
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>  
                                        <th># Servicio</th>
                                        <th>Nombre Servicio</th>
                                        <th># Paciente</th>
                                        <th>Nombre Paciente</th>
                                        <th class="text-end">Cantidad </th>
                                        <th class="text-end">Fecha </th>
                                        <th class="all">Precio</th>
                                        <th class="all text-end">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_buscar')">Buscar</button>
                </div>

            </div>
        </div>
    </div>
    <%}%>
    <div class="col-md-12">
        <div class="x_panel">

            <div class="x_title">
                <h2>Facturación <small></small></h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                <section class="content invoice">
                    <!-- title row -->
                    <div class="row">
                        <div class="  invoice-header">
                            <h1>
                                <i class="fa fa-globe"></i> Factura
                            </h1>

                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- info row -->
                    <div class="row invoice-info">

                        <div class="col-sm-12 invoice-col">
                            <button class="btn btn-primary float-right" id="btn_nuevo" data-toggle="modal" data-target="#modal_insertar"><i class="fa fa-plus" ></i> Agregar detalle</button>
                            <button type="button"  class="btn btn-warning float-right ml-1" onclick="recargar();" id="btn_nueva_factura"><i class="fa fa-certificate" aria-hidden="true"></i>Nueva Factura</button>
                        </div>
                        <div class="col-sm-4 invoice-col">
                            Extendida por:
                            <address>
                                <strong><%=datos[1]%></strong>
                                <br>
                                <strong>RTN: <%=datos[11]%></strong> <br>
                                <%=datos[3]%>
                                <br>Teléfono:<%=datos[5]%>
                                <br>Correo: <%=datos[4]%>
                            </address>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-4 invoice-col">

                            <b>Fecha Límite de Emisión: <%=fecha_emision%></b> 
                            <br>
                            <label>Paciente</label>
                            <select class="form-control fill" id="cliente">
                                <option value="">Escoja una opción 
                                </option>
                                <%

                                    try {
                                        sta = cnx.prepareStatement("SELECT * from usuarios where id_rol=3");
                                        rs = sta.executeQuery();
                                        while (rs.next()) {
                                            String label = "";
                                            label = "(" + rs.getString("identidad") + ") " + rs.getString("nombres") + " " + rs.getString("apellidos");


                                %>
                                <option value="<%=rs.getString("id")%>"><%=label%></option>
                                <%
                                        }

                                    } catch (Exception e) {
                                        System.out.println(e.getMessage());
                                    }%>
                            </select>
                            <div class="invalid-feedback" >
                                Este dato es obligatorio (si ya lo lleno pudó haber ingresado un dato incorrecto)
                            </div>

                        </div>
                        <!-- /.col -->
                        <div class="col-sm-4 invoice-col">
                            <b>Factura #<div id="rango" style="display: none;"><%=rango_actual%></div></b>
                            <br>
                            <b>Fecha:</b>  <%= b%>
                            <br>
                            <b>Rango Autorizado:  <%= rango_autorizado%></b> 
                            <br>
                            <b>CAI:</b> <div id="cai"></div>

                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <!-- Table row -->
                    <div class="row">
                        <div class="alert alert-danger alert-dismissible col-12"  id="listamensaje" style="display:none;">
                            <div class="breadcrumb-header">
                                <h6 class="ml-1">Detalle Vacío</h6>
                                <span class="ml-1">Debe escoger al menos un producto o servicio</span>
                            </div>
                        </div>
                        <div class="  table">
                            <table class="table table-striped" style="width: 100%;" id="detalle_factura">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Id Servicio</th>
                                        <th>Servicio</th>
                                        <th>Cantidad #</th>
                                        <th>Precio</th>
                                        <th>Total Unitario</th>
                                        <th class="all text-end">Acciones</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <div class="row">
                        <!-- accepted payments column -->
                        <div class="col-md-6">
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="table-responsive">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th>Impuesto (%)</th>
                                            <td id="impuesto">Lps <div id="impuesto"></div></td>
                                        </tr>
                                        <tr>
                                            <th>Subtotal:</th>
                                            <td>Lps  <div id="subtotal"></div></td>
                                        </tr>
                                        <tr>
                                            <th>Total:</th>
                                            <td>Lps. <div id="total"></div></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <!-- this row will not appear when printing -->
                    <div class="row no-print">
                        <div class=" "  id="pdf">
                            <%if (puede_agregar.equals("si")) {%>
                            <button class="btn btn-default" onclick="table_detalle_factura.column(5).visible(false);window.print();"><i class="fa fa-print"></i> Imprimir</button>
                          
                                <button class="btn btn-success pull-right" onclick="realizar_pago();" id="boton_ingresar_factura"><i class="fa fa-credit-card"></i> Guardar</button>
                        
                            <%}%>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>
<options id="opciones" modulo="servicios_medico"  identificadores="servicio;" receptores="medico;"/></options>
<variables id="variables" modulo="admin_citas"  puede_editar="no"  puede_eliminar="no"

           usuario="<%=session.getAttribute("id_usuario")%>" 
           impuesto="<%=impuesto%>" fecha_emision="<%=fecha_emision%>"
           rango_actual="<%=rango_actual%>" rango_fin="<%=rango_fin%>"
           rango_autorizado="<%=rango_autorizado%>"
           ></variables>
    <jsp:include page="layouts/admin_footer.jsp" > 
        <jsp:param name="nombre" value="<%=datos[1]%>" />
        <jsp:param name="js" value="facturacion.js;" />
    </jsp:include>
