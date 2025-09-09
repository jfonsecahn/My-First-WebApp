<%
    String[] titulos = request.getParameter("titulos").split(";");
    String clase_encabezado = request.getParameter("clase_encabezado") != null ? request.getParameter("clase_encabezado") : "";
%> 
<div class="col-md-12 col-sm-12 ">
    <div class="x_panel">
        <div class="x_title">
            <h2>Listado de <%=request.getParameter("identificador")%> </h2>
            <ul class="nav navbar-right panel_toolbox">
                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                </li>
                <li>
                    <a onclick="actualizar_lista('<%=request.getParameter("id") != null ? request.getParameter("id") : "lista"%>')"><i class="fa fa-refresh"></i></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>

        <div class="x_content">
            <p>Aqui se muestran todos los registros guardados 
                <%if (request.getParameter("puede_agregar") != null && request.getParameter("puede_agregar").equals("si")) {%>
                <button type="button" class="btn btn-round btn-success float-right"  data-toggle="modal" data-target="#<%=request.getParameter("modal") != null ? request.getParameter("modal") : "modal_insertar"%>">Nuevo</button>
                <%
                    }%>
            </p>

            <div class="table-responsive">
                <table class="table table-striped jambo_table mb-5" id='<%=request.getParameter("id") != null ? request.getParameter("id") : "lista"%>' style="width:100%;">
                    <thead>
                        <tr class="headings  <%=clase_encabezado%>">
                            <%    for (int x = 0; x < titulos.length; x++) {%>
                            <th><%=titulos[x]%></th>
                                <%}%>
                                <%if (request.getParameter("mostrar_acciones").equals("true")) {
                                        out.print("<th class='all'>Acciones</th>");
                                    }%>
                        </tr>
                    </thead>

                    <tbody>

                    </tbody>
                </table>
            </div>


        </div>
    </div>
</div>