</div>  
<!-- footer content -->
<footer>
    <div class="pull-right">
        <%=request.getParameter("nombre")%> - Todos los Derechos son Reservados
    </div>
    <div class="clearfix"></div>
</footer>
<!-- /footer content -->
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
<!-- Chart.js -->
<script src="plantillas/gentelella-alela/vendors/Chart.js/dist/Chart.min.js"></script>
<!-- gauge.js -->
<script src="plantillas/gentelella-alela/vendors/gauge.js/dist/gauge.min.js"></script>
<!-- bootstrap-progressbar -->
<script src="plantillas/gentelella-alela/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- iCheck -->
<script src="plantillas/gentelella-alela/vendors/iCheck/icheck.min.js"></script>
<!-- Skycons -->
<script src="plantillas/gentelella-alela/vendors/skycons/skycons.js"></script>
<!-- Flot -->
<script src="plantillas/gentelella-alela/vendors/Flot/jquery.flot.js"></script>
<script src="plantillas/gentelella-alela/vendors/Flot/jquery.flot.pie.js"></script>
<script src="plantillas/gentelella-alela/vendors/Flot/jquery.flot.time.js"></script>
<script src="plantillas/gentelella-alela/vendors/Flot/jquery.flot.stack.js"></script>
<script src="plantillas/gentelella-alela/vendors/Flot/jquery.flot.resize.js"></script>
<!-- Flot plugins -->
<script src="plantillas/gentelella-alela/vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
<script src="plantillas/gentelella-alela/vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/flot.curvedlines/curvedLines.js"></script>
<!-- DateJS -->
<script src="plantillas/gentelella-alela/vendors/DateJS/build/date.js"></script>
<!-- JQVMap -->
<script src="plantillas/gentelella-alela/vendors/jqvmap/dist/jquery.vmap.js"></script>
<script src="plantillas/gentelella-alela/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
<script src="plantillas/gentelella-alela/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="plantillas/gentelella-alela/vendors/moment/min/moment.min.js"></script>
<script src="plantillas/gentelella-alela//vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="plantillas/gentelella-alela/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="plantillas/gentelella-alela/build/js/custom.js"></script>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>

<script src="plantillas/gentelella-alela/vendors/switchery/dist/switchery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.1/viewer.js" integrity="sha512-Dva44qcvJr8coihlPYbKakmOWeGCUIBC8Qyf4HlPLOc7SCB+RoXcwbtFZg0Fi8zgphF8WAXhATDMs92UpCFvhw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/locale/es.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script src="js/common.js" charset="utf-8"></script>
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
