
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <title><%=request.getParameter("nombre")%> - <%=request.getParameter("pagina")%></title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link rel="icon" href="imagenes/clinica.jpg" type="image/ico" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@400;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">  

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

        <!-- Libraries Stylesheet -->
        <link href="plantillas/hospital-website-template/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="plantillas/hospital-website-template/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="plantillas/hospital-website-template/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->

        <link  href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .hero-header {
                background: url(<%=request.getParameter("imagen")%>) top right no-repeat;
                background-size: cover;
            }
        </style>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.2.4/css/fixedHeader.bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.3.0/css/responsive.bootstrap.min.css">
        <link href="plantillas/hospital-website-template/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.1/viewer.min.css" integrity="sha512-XHhuZDcgyu28Fsd75blrhZKbqqWCXaUCOuy2McB4doeSDu34BgydakOK71TH/QEhr0nhiieBNhF8yWS8thOGUg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>

    <body>
        <!-- Topbar Start -->
        <div class="container-fluid py-2 border-bottom d-none d-lg-block">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-lg-start mb-2 mb-lg-0">
                        <div class="d-inline-flex align-items-center">
                            <a class="text-decoration-none text-body pe-3" href=""><i class="bi bi-telephone me-2"></i><%=request.getParameter("telefono")%> </a>
                            <span class="text-body">|</span>
                            <a class="text-decoration-none text-body px-3" href=""><i class="bi bi-envelope me-2"></i><%=request.getParameter("correo")%> </a>
                        </div>
                    </div>
                    <div class="col-md-6 text-center text-lg-end">
                        <div class="d-inline-flex align-items-center">
                            <a class="text-body px-2" href="">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a class="text-body px-2" href="">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a class="text-body px-2" href="">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                            <a class="text-body px-2" href="">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a class="text-body ps-2" href="">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Topbar End -->


        <!-- Navbar Start -->
        <div class="container-fluid sticky-top bg-white shadow-sm">
            <div class="container">
                <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0">
                    <a href="index.jsp" class="navbar-brand">
                        <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-clinic-medical me-2"></i><%=request.getParameter("nombre")%> </h1>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="index.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("principal")) ? "active" : ""%>">Página Principal</a>
                            <a href="servicios.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("servicios")) ? "active" : ""%>">Servicios</a>
                            <a href="medicos.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("medicos")) ? "active" : ""%>">Médicos</a>
                            <%if (session.getAttribute("usuario") != null) {%>
                            <a href="Realizar_Cita.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("citas")) ? "active" : ""%>">Agendar Cita</a>
                            <a href="Mis_Citas.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("citas")) ? "active" : ""%>">Mis Citas</a>
                            <a href="Mi_Perfil.jsp" class="nav-item nav-link <%=(request.getParameter("pagina") != null && request.getParameter("pagina").equals("citas")) ? "active" : ""%>">Mi Perfil</a>
                            <%}%>
                            <a href="<%=session.getAttribute("usuario") != null ? "Sesion" : "inicio_sesion.jsp"%>" class="nav-item nav-link"><%=session.getAttribute("usuario") != null ? session.getAttribute("usuario") + " <i class='fa fa-chevron-left' aria-hidden='true'></i>" : "Inicio de Sesión <i class='fa fa-chevron-right' aria-hidden='true'></i>"%></a>
                        </div>

                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        <%if (request.getParameter("usar_header") != null && request.getParameter("usar_header").equals("si")) {%>
        <!-- Hero Start -->
        <div class="container-fluid bg-primary py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row justify-content-start">
                    <div class="col-lg-8 text-center text-lg-start">
                        <h5 class="d-inline-block text-primary text-uppercase border-bottom border-5" style="border-color: rgba(256, 256, 256, .3) !important;">Bienvenido a <%=request.getParameter("nombre")%></h5>
                        <h1 class="display-1 text-white mb-md-4"><%=request.getParameter("eslogan")%></h1>
                        <div class="pt-2">
                            <a href="Medicos.jsp" class="btn btn-light rounded-pill py-md-3 px-md-5 mx-2">Ver Médicos</a>
                            <a href="Realizar_Cita.jsp" class="btn btn-outline-light rounded-pill py-md-3 px-md-5 mx-2">Citas</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <!-- Hero End -->