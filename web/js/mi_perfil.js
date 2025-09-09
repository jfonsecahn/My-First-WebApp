$("#formulario_cambio_contra").submit(function (event) {
    event.preventDefault();
    verificar_login($(this).attr("id"));
});
function verificar_login(id) {
    var validated = validar_datos(id);
    if (!validated) {
        $.ajax({
            type: "POST",
            url: "Sesion",
            data: {"usuario": $("#variables").attr("usuario"), "contrasenia": $("#contra_actual").val()},
            dataType: "json",
            encode: true,
            beforeSend: function () {
                $("#btn_cambiar").prop("disabled", true);
                $("#btn_cambiar").html('Actualizando... ' + "<div id='spinner_carga' class='spinner-border  text-success spinner-border-sm' role='status'>" +
                        "<span class='sr-only'>...</span>" +
                        '</div>');
            }
        }).done(function (data) {
            if (data.autorizacion) {
                cambiar_contra();
            } else {
                $("#contra_actual").attr("class", "form-control is-invalid")
                Swal.fire({
                    icon: "error",
                    title: "Contraseña Actual Incorrecta",
                    timer: "2000"
                })
                $("#btn_cambiar").prop("disabled", false);
                $("#btn_cambiar").html('<i class="fa fa-save blue1_color"></i> Actualizar');
            }
        });
    }
}
function cambiar_contra() {
    if ($("#contra_nueva").val() == $("#contra_nueva_confirmacion").val()) {
        $.ajax({
            type: "POST",
            url: "ControladorCRUD",
            data: "contrasenia=" + $("#contra_nueva").val() + "&id=" + $("#variables").attr("id_usuario") + "&tabla=usuarios&accion=actualizar",
            dataType: "json",
            encode: true
        }).done(function (data) {
            var tipo = "error";
            var mensaje = "Falló actualización, intente de nuevo";
            if (data.resultado) {
                tipo = "success"
                mensaje = "Contraseña Actualizada exitosamente"
            }
            $("#btn_cambiar").prop("disabled", false);
            $("#btn_cambiar").html('<i class="fa fa-save blue1_color"></i> Actualizar');
                resetear_formulario("formulario_cambio_contra");
            $("#resultado_operacion_contra").html("<div class='alert alert-" + tipo + "' role='alert'>" +
                    mensaje +
                    "</div>");
        });
    } else {
        $("#contra_nueva").attr("class", "form-control is-invalid")
        $("#contra_nueva_confirmacion").attr("class", "form-control is-invalid")
      $("#resultado_operacion_contra").html("<div class='alert alert-warning' role='alert'>Las Nuevas Contraseñas No Coinciden"+
                    "</div>");

    }
}

