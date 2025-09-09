
<!-- Footer Start -->
<div class="container-fluid bg-dark text-light mt-5 py-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-6 col-md-6">
                <h4 class="d-inline-block text-primary text-uppercase border-bottom border-5 border-secondary mb-4">Mantente en Contacto</h4>
                <p class="mb-4"><%=request.getParameter("pie")%></p>
                <p class="mb-2"><i class="fa fa-map-marker-alt text-primary me-3"></i><%=request.getParameter("direccion")%></p>
                <p class="mb-2"><i class="fa fa-envelope text-primary me-3"></i><%=request.getParameter("correo")%></p>
                <p class="mb-0"><i class="fa fa-phone-alt text-primary me-3"></i><%=request.getParameter("telefono")%></p>
            </div>
            <div class="col-lg-6 col-md-6">
                <h6 class="text-primary text-uppercase mt-4 mb-3">Encuentranos en</h6>
                <div class="d-flex">
                    <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="#"><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="#"><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a class="btn btn-lg btn-primary btn-lg-square rounded-circle" href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid bg-dark text-light border-top border-secondary py-4">
    <div class="container">
        <div class="row g-5">
            <div class="col-md-12 text-center text-md-start">
                <p class="mb-md-0">&copy; <a class="text-primary" href="#"><%=request.getParameter("nombre")%></a>. Derechos Reservados.</p>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="plantillas/hospital-website-template/lib/easing/easing.min.js"></script>
<script src="plantillas/hospital-website-template/lib/waypoints/waypoints.min.js"></script>
<script src="plantillas/hospital-website-template/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="plantillas/hospital-website-template/lib/tempusdominus/js/moment.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
<script src="plantillas/gentelella-alela/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/locale/es.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
<!-- Template Javascript -->
<script src="plantillas/hospital-website-template/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.1/viewer.js" integrity="sha512-Dva44qcvJr8coihlPYbKakmOWeGCUIBC8Qyf4HlPLOc7SCB+RoXcwbtFZg0Fi8zgphF8WAXhATDMs92UpCFvhw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<%
    if (request.getParameter("js") != null) {
        String archivos[] = request.getParameter("js").split(";");
        for (int x = 0; x < archivos.length; x++) {%>
<script src="js/<%=archivos[x]%>"  charset="utf-8"></script>
<%  }
    }
%>
</body>

</html>