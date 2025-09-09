function validar_sesion() {
    if ($("#variables").attr("usuario") === "null") {
        Swal.fire({
            icon: "warning",
            title: "Autenticación Requerida",
            text: "Debes iniciar Sesión para continuar en esta página"

        }).then(() => {
            window.location.href = 'inicio_sesion.jsp'
        }
        )
    }
}
$(document).ready(function () {
    validar_sesion();

    $("#medico").on("change", function (e) {
        $("#datetimecontainer").show();
    });
});

function validar_disponibilidad(usuario, fecha) {
    $.ajax({
        type: "GET",
        url: 'ControladorCRUD',
        data: {"modulo": 'validar_disponibilidad',
            "busqueda": usuario + ' and fecha>="' + fecha + '" and fecha<=date_add("' + fecha + '", interval 45 MINUTE) and estado="Sin Atender"'},
        dataType: "json",
        encode: true,
    }).done(function (data) {
        if (data.data.length) {
            Swal.fire({
                title: 'Fecha y Hora Ocupada',
                icon: "warning",
                text: 'El Médico que seleccionó, se encuentra ocupado en la fecha y hora seleccionada',
                allowOutsideClick: false
            })
            $('#fecha').val("")
            //$('.datetime').data("DateTimePicker").date(moment().format('YYYY/MM/DD hh:mm'));
        }
    });
}
$("#formulario_citas , #formulario_citas_actualizar").submit(function (event) {
    var form_id = $(this).attr("id");
    event.preventDefault();
    var content_type = {};
    var accion = $(this).attr("id") === "formulario_citas" ? "ingresar" : "actualizar";
    var id_modificar = $("input[name='id']", this).val();
    var extra = "&fecha=" + moment($("#fecha").val(), 'YYYY/MM/DD hh:mm A').format("YYYY/MM/DD HH:mm");
    if (accion === "actualizar") {
        extra += "&id=" + $("#id").val()
    }
    var data = $(this).attr("enctype") === "" ? "medico=" + $("#medico").val() + "&servicio=" + $("#servicio").val() + "&usuario=" + $("#variables").attr("id_usuario") + "&tabla=" + $("#variables").attr("modulo") + "&accion=" + accion + extra : new FormData(document.getElementById($(this).attr("id")))
    var validated = validar_datos($(this).attr("id"));
    if (!validated) {
        guardar_registro(accion, content_type, data, id_modificar, form_id, null, null, null, accion === "ingresar" ? {url: 'Mis_Citas.jsp'} : null);
    }
});