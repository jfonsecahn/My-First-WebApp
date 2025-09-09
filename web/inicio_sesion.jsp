<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Inicio de sesión | </title>
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
                            <h1>Credenciales</h1>
                            <div id="resultado_operacion_login"></div>
                            <div class="col-md-12 col-sm-12 has-feedback">
                                <input type="text" name="usuario" class="form-control" placeholder="Usuario" required="" />
                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>
                            </div>
                            <div class="col-md-12 col-sm-12 has-feedback">
                                <input type="password" name="contrasenia" id="contrasenia" class="form-control" placeholder="Contraseña" required="" />
                                <span class="fa fa-eye form-control-feedback right" id="gicon" aria-hidden="true"></span>
                                <div class="mt-2">
                                    <label>
                                        <input type="checkbox" class="js-switch" onclick="mostrar_contrasenia('contrasenia')"/> Mostrar Contraseña
                                    </label>
                                </div>
                            </div>

                            <div>
                                <button class="btn btn-default submit" type="submit" id="boton_login">Iniciar Sesión</button>
                                <a class="reset_pass" href="Olvidaste_Contrasenia.jsp">¿Olvidaste tu Contraseña?</a>
                            </div>

                            <div class="clearfix"></div>

                            <div class="separator">
                                <p class="change_link">¿Nuevo por aquí?
                                    <a href="#signup" class="to_register"> Crear Cuenta </a>
                                </p>

                                <div class="clearfix"></div>
                                <br />

                                <div>
                                    <h1><i class="fa fa-paw"></i> Inicio de Sesión</h1>
                                    <p>©2016 Derechos Reservados</p>
                                </div>
                            </div>
                        </form>
                    </section>
                </div>

                <div id="register" class="animate form registration_form">
                    <section class="login_content">
                        <form id="formulario_registro" enenctype="multipart/form-data" method="post">
                            <h1>Crear Cuenta</h1>
                            <div id="resultado_operacion_cuenta"></div>
                            <div>
                                <input type="text" name="nombres" class="form-control onlytext" placeholder="Nombres" required="" />
                            </div>
                            <div>
                                <input type="text" name="apellidos" class="form-control onlytext" placeholder="Apellidos" required="" />
                            </div>
                            <div>
                                <input type="text" name="nombre_usuario" class="form-control" placeholder="Nombre de Usuario" required="" />
                            </div>
                            <div>
                                <input type="email" name="correo" class="form-control" placeholder="Correo" required="" />
                            </div>
                            <div>
                                <input type="text" name="telefono" class="form-control mascara-telefono" placeholder="Teléfono" required="" />
                            </div>
                            <div>

                                <input type="password" name="contrasenia"  id="contrasenia_registro" class="form-control" placeholder="Contraseña" required=""  min="8" max="16" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Debe contener una máyuscula y almenos 8 cáracteres" />
                                <div class="mt-2">
                                    <label>
                                        <input type="checkbox" class="js-switch"  onclick="mostrar_contrasenia('contrasenia_registro')"/> Mostrar Contraseña
                                    </label>
                                </div>
                            </div>
                            <br/>
                            <div>
                                <input type="file" name="imagen" class="form-control" placeholder="Imagen" required="" />
                            </div>
                            <div>
                                <button type="submit" class="btn btn-default submit" id="boton_registrar">Registrar</button>
                            </div>

                            <div class="clearfix"></div>

                            <div class="separator">
                                <p class="change_link">¿Ya eres miembro?
                                    <a href="#signin" class="to_register" id="login_link"> Inicio de Sesión </a>
                                </p>

                                <div class="clearfix"></div>
                                <br />

                                <div>
                                    <h1><i class="fa fa-paw"></i></h1>
                                    <p>©Derechos Reservados</p>
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
                                            var intentos = 3;
                                            $("#login").submit(function (event) {
                                                event.preventDefault();
                                                $.ajax({
                                                    type: "POST",
                                                    url: "Sesion",
                                                    data: $(this).serialize(),
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
                                                    if (data.autorizacion) {
                                                        window.location.href = data.url || 'principal.jsp';
                                                    }
                                                    if (!data.autorizacion) {
                                                        mensaje = "Usuario y/o Contraseña Incorrecta";
                                                        $("#resultado_operacion_login").html("<div class='alert alert-danger' role='alert'>" +
                                                                mensaje +
                                                                "</div>");
                                                    }
                                                });
                                            });
                                            function mostrar_contrasenia(id) {
                                                var x = $("#" + id);
                                                var y = $("#gicon")
                                                if (x.attr("type") === "password") {
                                                    x.attr("type", "text")
                                                    y.attr("class", "fa fa-eye-slash form-control-feedback right")
                                                } else {
                                                    x.attr("type", "password")
                                                    y.attr("class", "fa fa-eye form-control-feedback right")

                                                }
                                            }

                                            $(".mascara-telefono").inputmask("(504) 9999-9999")
                                            $("#formulario_registro").submit(function (event) {
                                                var data = new FormData(document.getElementById($(this).attr("id")));
                                                data.append("accion", "ingresar");
                                                data.append("tabla", "usuarios");
                                                data.append("id_rol", "3");
                                                event.preventDefault();
                                                $.ajax({
                                                    type: "POST",
                                                    url: "ControladorCRUD",
                                                    data: data,
                                                    contentType: false,
                                                    processData: false,
                                                    beforeSend: function () {
                                                        $("#boton_registrar").prop("disabled", true);
                                                        $("#boton_registrar").html('...');
                                                    }
                                                }).done(function (data) {
                                                    var tipo = "error";
                                                    var mensaje = "Falló Ingreso, intente con un nombre diferente de usuario";
                                                    if (data?.resultado) {
                                                        tipo = "success"
                                                        mensaje = "Usuario Creado exitosamente, ya puedes ir al Inicio de Sesión"
                                                        $("#formulario_registro").trigger("reset");
                                                    }
                                                    $("#boton_registrar").prop("disabled", false);
                                                    $("#boton_registrar").html('Registrar');

                                                    $("#resultado_operacion_cuenta").html("<div class='alert alert-" + tipo + "' role='alert'>" +
                                                            mensaje +
                                                            "</div>");
                                                });
                                            }
                                            );
                                            $(".onlytext").on('input', function (e) {
                                                $(this).val($(this).val().replace(/[0-9]/g, ''));
                                            });

</script>
</script>
</html>
