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
    String[] perfil = p.obtener_informacion_perfil(session.getAttribute("id_usuario") != null ? session.getAttribute("usuario").toString() : "");
    String values = session.getAttribute("id_usuario") != null ? session.getAttribute("id_usuario").toString() + ";" + perfil[5] + ";" + perfil[6] + ";null;" + perfil[11] + ";" + perfil[10] : "";
    if (session.getAttribute("usuario") == null || session.getAttribute("usuario").toString().equals("null")) {
        out.println("<script> window.location.href='index.jsp';</script>");
    }
%>
<jsp:include page="layouts/public_header.jsp"> 
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="imagen" value="<%=datos[9]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="eslogan" value="<%=datos[2]%>" />
    <jsp:param name="pagina" value="Página Principal" />
</jsp:include>
<div class="container-fluid my-5 py-5">
    <div class="container py-5">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Información General</button>
                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Autenticación</button>
            </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                <div class="tab-pane fade show active" id="home1" role="tabpanel" aria-labelledby="home-tab">

                    <div  class="bg-white text-center rounded p-5">
                        <div id="resultado_operacion" class="col-12">
                        </div>
                        <div class="position-relative">
                            <img class="img-fluid rounded-top" src="<%=perfil[8]%>" alt="Sin Imagen">
                        </div>
                        <jsp:include page='formulario.jsp'>
                            <jsp:param name="enctype" value="multipart/form-data" />
                            <jsp:param name="id" value="formulario_actualizar" /> 
                            <jsp:param name="values" value="<%=values%>" />
                            <jsp:param name="campos" value="id;telefono;correo;imagen" />
                            <jsp:param name="titulos" value="Id;Teléfono;Correo;Imagen" />
                            <jsp:param name="tipos_input" value="text;text;email;file" />
                            <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6" />
                        </jsp:include> 
                        <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_actualizar');" >Actualizar </button>
                    </div>


                </div>
            </div>
            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab"> <div  class="bg-white text-center rounded p-5">
                    <div id="resultado_operacion_contra" class="col-12">
                    </div>
                    <jsp:include page='formulario.jsp'>
                        <jsp:param name="id" value="formulario_cambio_contra" />        
                        <jsp:param name="campos" value="contra_actual;contra_nueva;contra_nueva_confirmacion" />
                        <jsp:param name="titulos" value="Contraseña Actual;Nueva Contraseña;Confirme Nueva Contraseña" />
                        <jsp:param name="tipos_input" value="password;password;password" />
                        <jsp:param name="clases_input" value="col-6;col-6;col-6;col-6;col-12" />
                    </jsp:include> 
                    <button type="button" class="btn btn-primary ingreso" onclick="guardar('formulario_cambio_contra');" >Actualizar Credenciales </button>
                </div></div>
        </div>

    </div>
</div>
<%
    cnx.close();
    String puede_editar = "si";
    String puede_eliminar = "no";
%>
<variables id="variables" modulo="informacion_personal" usuario="<%=session.getAttribute("usuario")%>" puede_editar="<%=puede_editar%>"  puede_eliminar="<%=puede_eliminar%>" id_usuario="<%=session.getAttribute("id_usuario")%>"/>
<jsp:include page="layouts/public_footer.jsp" >
    <jsp:param name="js" value="mi_perfil.js;common.js" />
    <jsp:param name="nombre" value="<%=datos[1]%>" />
    <jsp:param name="pie" value="<%=datos[8]%>" />
    <jsp:param name="correo" value="<%=datos[4]%>" />
    <jsp:param name="telefono" value="<%=datos[5]%>" />
    <jsp:param name="direccion" value="<%=datos[3]%>" />
</jsp:include>