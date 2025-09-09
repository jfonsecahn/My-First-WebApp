$("#formulario_citas ,#formulario_actualizar_cita").submit(function (event) {
    var form_id = $(this).attr("id");
    event.preventDefault();
    var content_type = {};
    var accion = $(this).attr("id") === "formulario_citas" ? "ingresar" : "actualizar";
    var id_modificar = $("input[name='id']", this).val();
    var id_actualizar = $(this).attr("id") === "formulario_citas" ? "3_input" : "fechainput";
    var fecha = moment($("#" + id_actualizar).val(), 'YYYY/MM/DD hh:mm A').format("YYYY/MM/DD HH:mm")
    $("#" + id_actualizar).val(fecha);
    var data = $(this).attr("enctype") === "" ? $(this).serialize() + "&tabla=" + $("#variables").attr("modulo") + "&accion=" + accion : new FormData(document.getElementById($(this).attr("id")))
    var validated = validar_datos($(this).attr("id"));
    if (!validated) {
        guardar_registro(accion, content_type, data, id_modificar, form_id, null, null, null, null);
    }
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
            $('#3input').val("")
            $('#fechainput').val("")
           // $('.datetime').data("DateTimePicker").date(moment().format('YYYY/MM/DD hh:mm'));
        }
    });
}