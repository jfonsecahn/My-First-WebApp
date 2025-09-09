<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Recuperación de Clave | </title>
        <link rel="icon" href="imagenes/clinica.jpg" type="image/ico" />
        <!-- Bootstrap -->
        <link href="plantillas/gentelella-alela/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="plantillas/gentelella-alela/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="plantillas/gentelella-alela/vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- Animate.css -->
        <link href="plantillas/gentelella-alela/vendors/animate.css/animate.min.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="plantillas/gentelella-alela/build/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="login">
        <div>
            <a class="hiddenanchor" id="signup"></a>
            <a class="hiddenanchor" id="signin"></a>

            <div class="login_wrapper">
                <div class="animate form login_form">
                    <section class="login_content">
                        <form id="login">
                            <h1>Usuario</h1>
                            <div id="resultado_operacion_login"></div>
                            <div class="col-md-12 col-sm-12 has-feedback">
                                <input type="text" name="usuario" class="form-control" placeholder="Usuario" required="" />
                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>
                            </div>

                            <div>
                                <button class="btn btn-default submit" type="submit" id="boton_login">Recuperar Contraseña</button>
                            </div>

                            <div class="clearfix"></div>

                            <div class="separator">
                                <p class="change_link">¿Nuevo por aquí?
                                    <a href="inicio_sesion.jsp" class="to_register"> Iniciar Sesión </a>
                                </p>

                                <div class="clearfix"></div>
                                <br />

                                <div>
                                    <h1><i class="fa fa-paw"></i> Recuperacion de Clave</h1>
                                    <p>©2016 Derechos Reservados</p>
                                </div>
                            </div>
                        </form>
                    </section>
                </div>

            </div>
        </div>
    </body>
</html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="plantillas/gentelella-alela/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>

<script>
    $("#login").submit(function (event) {
        event.preventDefault();
        $.ajax({
            type: "POST",
            url: "Controlador_Correo",
            data: $(this).serialize() + "&accion=EnviarNuevaClave",
            dataType: "json",
            encode: true,
            beforeSend: function () {
                $("#boton_login").prop("disabled", true);
                $("#boton_login").html('...');
            }
        }).done(function (data) {
            var mensaje = "";
            $("#boton_login").prop("disabled", false);
            $("#boton_login").html('Ingresar');
            if (data.resultado) {
                mensaje = "Contraseña Reestablecida";
                setTimeout(() => {
                    window.location.href = data.url || 'inicio_sesion.jsp';
                }, 5000)
                $("#resultado_operacion_login").html("<div class='alert alert-success' role='alert'>" +
                        mensaje +
                        "</div>");
            }
            if (!data.resultado) {
                mensaje = "Usuario Incorrecto";
                $("#resultado_operacion_login").html("<div class='alert alert-danger' role='alert'>" +
                        mensaje +
                        "</div>");
            }
        });
    });

</script>
</script>
</html>
