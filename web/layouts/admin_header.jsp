<%@page import="Modelo.ConsultasModelos"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="imagenes/clinica.jpg" type="image/ico" />

        <title><%=request.getParameter("nombre")%> | <%=request.getParameter("pagina_actual")%></title>

        <!-- Bootstrap -->
        <link href="plantillas/gentelella-alela/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="plantillas/gentelella-alela/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="plantillas/gentelella-alela/vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="plantillas/gentelella-alela/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

        <!-- bootstrap-progressbar -->
        <link href="plantillas/gentelella-alela/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
        <!-- JQVMap -->
        <link href="plantillas/gentelella-alela/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
        <!-- bootstrap-daterangepicker -->
        <link href="plantillas/gentelella-alela/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="plantillas/gentelella-alela/build/css/custom.min.css" rel="stylesheet">
        <link href="plantillas/gentelella-alela/vendors/switchery/dist/switchery.min.css" rel="stylesheet">


        <link href="plantillas/gentelella-alela/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
        <link href="plantillas/gentelella-alela/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">

        <link href="plantillas/gentelella-alela/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
        <link href="plantillas/gentelella-alela/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
        <link href="plantillas/gentelella-alela/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
        <link href="plantillas/gentelella-alela/vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.1/viewer.min.css" integrity="sha512-XHhuZDcgyu28Fsd75blrhZKbqqWCXaUCOuy2McB4doeSDu34BgydakOK71TH/QEhr0nhiieBNhF8yWS8thOGUg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link  href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    </head>
    <%
        ConsultasModelos p = new ConsultasModelos();
        String imagen = session.getAttribute("usuario") != null ? p.obtener_dato_campo("usuarios", session.getAttribute("usuario").toString(), "imagen", "nombre_usuario") : "";
        String nombres= p.obtener_dato_campo("usuarios", session.getAttribute("usuario") != null ? session.getAttribute("usuario").toString() : "", "concat(nombres,' ',apellidos)", "nombre_usuario");
    %>
    <body class="nav-md">
        <div class="container body">
            <div class="main_container">
                <div class="col-md-3 left_col">
                    <div class="left_col scroll-view">
                        <div class="navbar nav_title" style="border: 0;">
                            <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span><%=request.getParameter("nombre")%></span></a>
                        </div>

                        <div class="clearfix"></div>

                        <!-- menu profile quick info -->
                        <div class="profile clearfix">
                            <div class="profile_pic">
                                <img src="<%=imagen%>" alt="..." class="img-circle profile_img">
                            </div>
                            <div class="profile_info">
                                <span>Bienvenido,</span>
                                <h2><%=nombres%></h2>
                                <h2>Usuario: <%=session.getAttribute("usuario")%></h2>
                                <h2>Rol: <%=session.getAttribute("nombre_rol")%></h2>
                            </div>
                        </div>
                        <!-- /menu profile quick info -->

                        <br />

                        <!-- sidebar menu -->
                        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                            <div class="menu_section">
                                <h3>General</h3>
                                <ul class="nav side-menu">
                                    <li><a href="pagina_principal.jsp"><i class="fa fa-home"></i> Página Principal</a>

                                    </li>
                                    <li><a href="Atencion_Citas.jsp"><i class="fa fa-heartbeat"></i>Atencion Citas </a></li>
                                    <li><a href="Facturacion.jsp"><i class="fa fa-money"></i>Facturación </a></li>
                                    <li><a href="Historial_Pacientes.jsp"><i class="fa fa-book"></i>Historial de Pacientes </a></li>
                                    <li><a href="RegistroFacturas.jsp"><i class="fa fa-folder"></i>Registro de Facturas </a></li>
                                    <li><a><i class="fa fa-edit"></i> Administración <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="AdminCitas.jsp">Citas</a></li>
                                            <li><a href="AdminServicios.jsp">Servicios</a></li>
                                            <li><a href="AdminEspecialidades.jsp">Especialidades</a></li>
                                            <li><a href="AdminMedicos.jsp">Medicos</a></li>
                                            <li><a href="AdminEnfermeras.jsp">Enfermeras</a></li>
                                            <li><a href="AdminEspecialidadesMedico.jsp">Especialidades de Médico</a></li>
                                            <li><a href="AdminEspecialidadesServicios.jsp">Especialidades de Servicios</a></li>
                                            <li><a href="AdminPacientes.jsp">Pacientes</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-clone"></i>Sistema <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="AdminUsuarios.jsp">Usuarios</a></li>
                                            <li><a href="Respaldo_Restauracion.jsp">Respaldo y Restauración</a></li>
                                            <li><a href="VistaBitacora.jsp">Bitácora</a></li>
                                            <li><a href="AdminDatosFluctuantes.jsp">Datos Fluctuantes</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-cog"></i>Configuración <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="AdminRoles.jsp">Roles</a></li>
                                            <li><a href="AdminPermisos.jsp">Permisos</a></li>
                                        </ul>
                                    </li>
                                </ul>

                            </div>
                            <div class="menu_section">
                                <h3>Clinica</h3>  

                                <ul class="nav side-menu">
                                    <li><a href="DatosClinica.jsp"><i class="fa fa-hospital-o"></i> Datos Clínica </a></li>
                                </ul>
                            </div>

                        </div>
                        <!-- /sidebar menu -->

                        <!-- /menu footer buttons -->
                        <div class="sidebar-footer hidden-small">
                            <a data-toggle="tooltip" data-placement="top" title="Settings">
                                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                            </a>
                            <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                            </a>
                            <a data-toggle="tooltip" data-placement="top" title="Lock">
                                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                            </a>
                            <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                            </a>
                        </div>
                        <!-- /menu footer buttons -->
                    </div>
                </div>

                <!-- top navigation -->
                <div class="top_nav">
                    <div class="nav_menu">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
                        <nav class="nav navbar-nav">
                            <ul class=" navbar-right">
                                <li class="nav-item dropdown open" style="padding-left: 15px;">
                                    <a href="javascript:;" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false">
                                        <img src="<%=imagen%>" alt=""><%=session.getAttribute("usuario")%>
                                    </a>
                                    <div class="dropdown-menu dropdown-usermenu pull-right" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item"  href="MiPerfil.jsp"> Mi Perfil</a>
                                        <a class="dropdown-item"  href="Sesion"><i class="fa fa-sign-out pull-right"></i> Cerrar Sesión</a>
                                    </div>
                                </li>

                                <li role="presentation" class="nav-item dropdown open">
                                    <!-- <a href="javascript:;" class="dropdown-toggle info-number" id="navbarDropdown1" data-toggle="dropdown" aria-expanded="false">
                                         <i class="fa fa-envelope-o"></i>
                                         <span class="badge bg-green">6</span>
                                     </a>
                                     <ul class="dropdown-menu list-unstyled msg_list" role="menu" aria-labelledby="navbarDropdown1">
                                         <li class="nav-item">
                                             <a class="dropdown-item">
                                                 <span class="image"><img src="plantillas/gentelella-alela/production/images/img.jpg" alt="Profile Image" /></span>
                                                 <span>
                                                     <span>John Smith</span>
                                                     <span class="time">3 mins ago</span>
                                                 </span>
                                                 <span class="message">
                                                     Film festivals used to be do-or-die moments for movie makers. They were where...
                                                 </span>
                                             </a>
                                         </li>
                                         <li class="nav-item">
                                             <a class="dropdown-item">
                                                 <span class="image"><img src="plantillas/gentelella-alela/production/images/img.jpg" alt="Profile Image" /></span>
                                                 <span>
                                                     <span>John Smith</span>
                                                     <span class="time">3 mins ago</span>
                                                 </span>
                                                 <span class="message">
                                                     Film festivals used to be do-or-die moments for movie makers. They were where...
                                                 </span>
                                             </a>
                                         </li>
                                         <li class="nav-item">
                                             <a class="dropdown-item">
                                                 <span class="image"><img src="plantillas/gentelella-alela/production/images/img.jpg" alt="Profile Image" /></span>
                                                 <span>
                                                     <span>John Smith</span>
                                                     <span class="time">3 mins ago</span>
                                                 </span>
                                                 <span class="message">
                                                     Film festivals used to be do-or-die moments for movie makers. They were where...
                                                 </span>
                                             </a>
                                         </li>
                                         <li class="nav-item">
                                             <a class="dropdown-item">
                                                 <span class="image"><img src="plantillas/gentelella-alela/production/images/img.jpg" alt="Profile Image" /></span>
                                                 <span>
                                                     <span>John Smith</span>
                                                     <span class="time">3 mins ago</span>
                                                 </span>
                                                 <span class="message">
                                                     Film festivals used to be do-or-die moments for movie makers. They were where...
                                                 </span>
                                             </a>
                                         </li>
                                         <li class="nav-item">
                                             <div class="text-center">
                                                 <a class="dropdown-item">
                                                     <strong>See All Alerts</strong>
                                                     <i class="fa fa-angle-right"></i>
                                                 </a>
                                             </div>
                                         </li>
                                     </ul>
                                    -->
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- /top navigation -->
                <!-- page content -->
                <div class="right_col" role="main">