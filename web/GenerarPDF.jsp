<%@page import="Modelo.ConsultasModelos"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="BD.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.StringReader"%>
<%@page import="com.lowagie.text.html.simpleparser.HTMLWorker"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Date"%>

<%
    ConsultasModelos p = new ConsultasModelos();
    String table = "<br/><br/><br/><table border=\"1\">"
            + "<thead>"
            + "<tr>"
            + "<th>#</th>"
            + "<th># Servicio</th>"
            + "<th>Servicio</th>"
            + "<th>Cantidad</th>"
            + "<th>Precio</th>"
            + "<th>Total Unitario</th>"
            + "</tr>"
            + "</thead>"
            + "<tbody>";;
    ResultSetMetaData rsmd;
    Connection cnx;
    Conexion con = new Conexion();
    PreparedStatement sta;
    ResultSet rs;
    cnx = con.getConexion();
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition",
            "attachment; filename=\"Factura" + request.getParameter("id") + ".pdf\"");
    try {
        //crear y abrir documento tipo pdf
        Document documentoPDF = new Document();
        PdfWriter.getInstance(documentoPDF, response.getOutputStream());
        documentoPDF.open();

        String no_rango = p.obtener_dato_campo("factura", request.getParameter("id"), "no_rango", "id");
        String[] datos = p.obtener_informacion_empresa();
        try {

            sta = cnx.prepareStatement("select df.id as id,s.id as id_servicio,s.nombre as nombre_servicio,concat('Lps. ',df.precio) as precio,cantidad as cantidad,"
                    + "concat('Lps. ',df.total_unitario) as total_unitario from detalle_factura df inner join servicios s on (s.id=df.servicio) where df.factura=" + request.getParameter("id"));
            rs = sta.executeQuery();
            while (rs.next()) {
                table += "<tr>"
                        + "<td>" + rs.getString("id") + "</td>"
                        + "<td><h4>"
                        + rs.getString("id_servicio")
                        + "</h4>"
                        + "</td>"
                        + "<td>" + rs.getString("nombre_servicio") + "</td>"
                        + "<td>" + rs.getString("cantidad") + "</td>"
                        + "<td >" + rs.getString("precio") + "</td>"
                        + "<td >" + rs.getString("total_unitario") + "</td>"
                        + "</tr>";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        table += "</tbody></table>";
        documentoPDF.addAuthor(session.getAttribute("id_usuario").toString());
        documentoPDF.addCreator(session.getAttribute("usuario").toString());
        documentoPDF.addSubject("Factura No." + no_rango);
        documentoPDF.addCreationDate();
        documentoPDF.addTitle("Factura #" + request.getParameter("id") + "-PDF");
        Font font1 = new Font(Font.TIMES_ROMAN, 20, Font.BOLD);
        Paragraph paragraph1 = new Paragraph(datos[1], font1);
        paragraph1.setAlignment(Element.ALIGN_CENTER);
        documentoPDF.add(paragraph1);
        font1 = new Font(Font.TIMES_ROMAN, 18, Font.BOLD);
        paragraph1 = new Paragraph("Factura No." + no_rango, font1);
        paragraph1.setAlignment(Element.ALIGN_CENTER);
        documentoPDF.add(paragraph1);
        font1 = new Font(Font.TIMES_ROMAN, 16, Font.BOLD);
        paragraph1 = new Paragraph(datos[3], font1);
        paragraph1.setAlignment(Element.ALIGN_CENTER);
        documentoPDF.add(paragraph1);
        documentoPDF.add(new Paragraph("\n"));
        Paragraph paragraph2;
        paragraph2 = new Paragraph("Correo: " + datos[4]);
        paragraph2.setAlignment(Element.ALIGN_RIGHT);
        documentoPDF.add(paragraph2);
        paragraph2 = new Paragraph("Teléfono: " + datos[5]);
        paragraph2.setAlignment(Element.ALIGN_RIGHT);
        documentoPDF.add(paragraph2);
        String[] campos = {"RTN", "Rango Autorizado", "CAI", "Fecha", "Fecha Límite Emisión", "Impuesto", "Total", "Cliente"};
        try {
            sta = cnx.prepareStatement("SELECT (select rtn from datos_clinica limit 1) as RTN,rango_autorizado as \"Rango Autorizado\",cai as CAI,concat('Lps. ',impuesto) as Impuesto"
                    + ",DATE_FORMAT(fecha, '%Y/%m/%d %h:%i %p') as Fecha,DATE_FORMAT(fecha_limite, '%Y/%m/%d') as \"Fecha Límite Emisión\",concat('Lps. ',total) as Total,concat(u.id,' ',u.nombres,' ',u.apellidos) as Cliente from factura f inner join usuarios u on (u.id=f.paciente) where f.id=" + request.getParameter("id"));
            rs = sta.executeQuery();
            rsmd = rs.getMetaData();
            while (rs.next()) {
                for (int i = 0; i <= campos.length; i++) {
                    String name = campos[i];
                    paragraph2 = new Paragraph(name + ": " + rs.getString(name));
                    paragraph2.setAlignment(Element.ALIGN_LEFT);
                    documentoPDF.add(paragraph2);
                }

            };
        } catch (Exception e) {
            e.printStackTrace();
        }
        HTMLWorker htmlWorker = new HTMLWorker(documentoPDF);
        String str = "<html>"
                + "<head>"
                + "<link rel='stylesheet' type='text/css' href='vendor/bootstrap/css/bootstrap.min.css'>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='row'>"
                + "<div class='col-lg-12'>"
                + "<div class='row featurette'>"
                + "<div class='col-md-12'>"
                + table
                + "</div>"
                + "</div>"
                + "</div>"
                + "</div>"
                + "</div>"
                + "</body>"
                + "</html>";

        htmlWorker.parse(new StringReader(str));
        // cerrar el documento
        documentoPDF.close();
        cnx.close();
    } catch (DocumentException de) {
        throw new IOException(de.getMessage());
    }
%>

