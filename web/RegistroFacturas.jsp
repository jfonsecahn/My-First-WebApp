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
    String titulo = "Registro de " + identificador;
    String permisos = "";
    String[] lista_permisos = {};
    if (session.getAttribute("rol") != null) {
        permisos = p.obtener_permisos_usuario_modulo(Integer.parseInt(session.getAttribute("rol").toString()), 19);
        if (!permisos.equals("")) {
            lista_permisos = permisos.split(";");
        }
    }
    String puede_agregar = "no";
    if (!Arrays.asList(lista_permisos).contains("Ver")) {
        out.println("<script> window.location.href='pagina_error.jsp?codigo_error=403';</script>");
    }
    String titulos[] = "Id;Id Servicio;Servicio;Cantidad;Precio;Total Unitario".split(";");
%>
<jsp:include page="layouts/admin_header.jsp" >  
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pagina_actual" value="<%=identificador%>" />
</jsp:include>
<div class="row">
    <jsp:include page="titulo.jsp" >  
        <jsp:param name="titulo" value="<%=titulo%>" />
    </jsp:include>
    <div class="modal fade bs-example-modal-lg"  id="modal_detalle" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="titulo_modal_detalle" style="color:black"></h4>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
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
    <%
        String mostrar_acciones = Arrays.asList(lista_permisos).contains("Anular") ? "true" : "false";
        String puede_eliminar = Arrays.asList(lista_permisos).contains("Anular") ? "si" : "no";
        String puede_editar = Arrays.asList(lista_permisos).contains("Ver") ? "si" : "no";
    %>
    <div id="resultado_operacion" class="col-12">
    </div>
    <jsp:include page="lista.jsp" >  
        <jsp:param name="identificador" value="<%=identificador%>" />
        <jsp:param name="titulos" value="Id;No. Factura;Fecha;Impuesto;Total;Id Usuario;Nombre Usuario;Id Paciente;Nombre Paciente;Rango_Autorizado;CAI;Fecha Límite de Emisión;Estado" />
        <jsp:param name="mostrar_acciones" value="<%=mostrar_acciones%>" />
        <jsp:param name="puede_agregar" value="<%=puede_agregar%>" />
    </jsp:include>
</div>  
<variables id="variables" modulo="facturas_guardadas" campos="*" puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>"  titulo="<%=identificador%>"/>
<jsp:include page="layouts/admin_footer.jsp" > 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
</jsp:include>
