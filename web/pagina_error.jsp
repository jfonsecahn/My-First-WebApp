<%@page import="BD.OperacionesCRUD"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <%
            String codigo = request.getParameter("codigo_error") != null ? request.getParameter("codigo_error") : "0";
            OperacionesCRUD opdb = new OperacionesCRUD();
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="imagenes/logo.ico" type="image/ico" />
        <title>Error <%=codigo%></title>
        <link rel="icon" href="imagenes/clinica.jpg" type="image/ico" />
        <!-- Bootstrap -->
        <link href="plantillas/gentelella-alela/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="plantillas/gentelella-alela/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="plantillas/gentelella-alela/vendors/nprogress/nprogress.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="plantillas/gentelella-alela/build/css/custom.min.css" rel="stylesheet">
    </head>
    <%
        String titulo = "No identificado";

        String mensaje = "Algo inesperado sucedió, intentaremos resolverlo, intenta de nuevo más tarde";
        if (request.getParameter("codigo_error") != null) {

            if (codigo.equals("404")) {
                titulo = "Recurso no Encontrado";
                mensaje = "La página a la que intentas acceder no existe";

            } else if (codigo.equals("403")) {
                titulo = "Acceso Denegado";
                mensaje = "La página a la que intentas acceder, no esta disponible para tu perfil";
            } else if (codigo.equals("500")) {
                titulo = "Error interno del servidor";
                mensaje = "Ocurrió un error mientras procesamos tu solicitud, intenta de nuevo más tarde";
            }
            //opdb.Regitrar_Error(session.getAttribute("usuario").toString() != null ? session.getAttribute("usuario").toString() : "Usuario No Autenticado", codigo + " " + titulo, mensaje, request.getRemoteAddr());
        }
    %>
    <body class="nav-md">
        <div class="container body">
            <div class="main_container">
                <!-- page content -->
                <div class="col-md-12">
                    <div class="col-middle">
                        <div class="text-center text-center">
                            <h1 class="error-number"><%=codigo%></h1>
                            <h2>Error - <%=titulo%></h2>
                            <p><%=mensaje%> <a href="javascript:history.go(-1)">Regresar</a>
                            </p>
                            <div class="mid_center">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /page content -->
            </div>
        </div>

        <!-- jQuery -->
        <script src="plantillas/gentelella-alela/vendors/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap -->
        <script src="plantillas/gentelella-alela/vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <!-- FastClick -->
        <script src="plantillas/gentelella-alela/vendors/fastclick/lib/fastclick.js"></script>
        <!-- NProgress -->
        <script src="plantillas/gentelella-alela/vendors/nprogress/nprogress.js"></script>

        <!-- Custom Theme Scripts -->
        <script src=plantillas/gentelella-alela/build/js/custom.min.js"></script>
    </body>
</html>