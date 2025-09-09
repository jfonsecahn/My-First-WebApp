$(".form").submit(function (event) {
    event.preventDefault();
    $.ajax({
        type: "POST",
        url: "Correo_Servlet",
        data: $(this).serialize() + "&accion=EnviarNuevaClave",
        dataType: "json",
        encode: true,
        beforeSend: function () {
            $(".login_button").prop("disabled", true);
            $(".login_button").html('Enviando...');
        },

    }).done(function (data) {
        $(".login_button").prop("disabled", false);
        $(".login_button").html('Recuperar Clave');
        var tipo = "error";
        var mensaje = "Falló Envio de Correo de Contraseña";
        var text="El corrreo que brindaste no esta registrado"
        if (data.resultado && data.correo) {
            tipo = "success"
            mensaje = "Se envió la nueva contraseña a tu correo"
            text="Puedes ingresar con la nueva contraseña"
            $(".login_button").prop("disabled", false);
            $(".login_button").html('Recuperar Clave');
          
            if (data.resultado) {
                setTimeout(() => {
                    $(this).trigger("reset");
                    window.location.href = "index.jsp";
                }, 5000);
            }
        } 
          Swal.fire({
                icon: tipo,
                title: mensaje,
                text: text,
                timer: "2000"
            })
    }
    );
});