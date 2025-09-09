<%
    String[] campos = request.getParameter("campos").split(";");
    String[] tipos_input = request.getParameter("tipos_input").split(";");
    String[] titulos = request.getParameter("titulos").split(";");
    String[] clases_input = request.getParameter("clases_input").split(";");
    String[] values = request.getParameter("values") != null ? request.getParameter("values").split(";") : null;
    int contador_select = 0;
    int contador = 0;
    String id = request.getParameter("id");
%>

<form class="form-horizontal" id="<%=request.getParameter("id")%>"  enctype="<%=request.getParameter("enctype") != null ? request.getParameter("enctype") : ""%>"  method="post">

    <div class="form-group row">
        <%         try {

                for (int x = 0; x < campos.length; x++) {
        %>
        <div class='<%=clases_input.length > 0 ? clases_input[x] : "col-12"%>'>
            <label for="fname"><%=titulos[x]%></label>
            <%if (tipos_input[x].equals("text") || tipos_input[x].equals("email") || tipos_input[x].equals("number") || tipos_input[x].equals("number_decimal") || tipos_input[x].equals("file") || tipos_input[x].equals("password")) {%>
            <input type="<%=tipos_input[x].equals("number_decimal") ? "number" : tipos_input[x]%>" name="<%=campos[x]%>" class="form-control" id="<%=!request.getParameter("id").equals("formulario_ingreso") ? campos[x] : x%>" placeholder="<%=titulos[x]%>"  required="true"
                   step="<%=tipos_input[x].equals("number_decimal") ? "0.01" : "1"%>"
                   value="<%=request.getParameter("values") != null ? values[x] : ""%>"/>
            <% if (tipos_input[x].equals("password")) {%>

            <div class="mt-2">
                <label>
                    <input type="checkbox" class="js-switch" onclick="mostrar_contrasenia('<%=!request.getParameter("id").equals("formulario_ingreso") ? campos[x] : x%>')"/> Mostrar Contraseña
                </label>
            </div>
            <%}
            } else if (tipos_input[x].equals("date")) {%>
            <div class="form-group">
                <div class='input-group datetime' id="<%=!request.getParameter("id").equals("formulario_citas") ? campos[x] : x%>">
                    <input type='text' class="form-control" name="<%=campos[x]%>" id="<%=!request.getParameter("id").equals("formulario_citas") ? campos[x]+"input" : x+"_input"%>"/>
                    <span class="input-group-addon input-group-append bg-primary">
                        <span class="fa fa-calendar mt-2 ml-2 mr-2" style="color:white;"></span>
                    </span>
                </div>
            </div>

            <%} else if (tipos_input[x].equals("textarea")) {
            %>
            <textarea class="form-control"  name="<%=campos[x]%>" id="<%=!request.getParameter("id").equals("formulario_ingreso") ? campos[x] : x%>" placeholder="<%=titulos[x]%>"  required="true" ><%=request.getParameter("values") != null ? values[x] : ""%></textarea>
            <%} else if (tipos_input[x].equals("select")) {
                String[] opciones_select = request.getParameter("opciones").split("-");
                String[] opciones = opciones_select[contador_select].split(";");
            %>
            <select class="form-control" style="width: 100%; height: 36px" name="<%=campos[x]%>" id="<%=(!request.getParameter("id").equals("formulario_ingreso")&& !request.getParameter("id").equals("formulario_citas"))? campos[x] : x%>">
                <option value="" selected="" disabled="" id="opcionvacia">Escoja una Opción</option>
                <%
                    if (!opciones_select[contador_select].equals("null")) {

                        for (int y = 0; y < opciones.length; y++) {

                            String[] datos = opciones[y].split(":");
                            out.println("<option value='" + datos[0] + "'>" + datos[1] + "</option>");

                        }
                    }
                %>
            </select>
            <%contador_select++;
                }%>

            <div class="invalid-feedback" id="<%=campos[x] + "feedback"%><%=request.getParameter("id")%>">
                Este campo es obligatorio o ingresó un dato incorrecto
            </div>
            <div class="valid-feedback">
                Campo Correcto
            </div>
        </div>

        <%contador++;
                }
            } catch (Exception ex) {
                System.out.println("error en formulario");
            }%>
    </div> 
</form>

