
var disponible = 0;
var table_detalle_factura = $("#detalle_factura").length ? $("#detalle_factura").DataTable({
    autowidth: true,
    responsive: true,
    "initComplete": function (settings, json) {
        // totalizar();
    },
    "language": {
        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
    }
}) : null;
var table_buscar = $("#lista_de_resultados").length ? $("#lista_de_resultados").DataTable({
    autowidth: true,
    responsive: true,
    "language": {
        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
    }
}) : null;
$("#formulario_buscar").submit(function (event) {
    event.preventDefault();
    var validated = validar_datos("formulario_buscar");
    if (!validated) {
        var filtrado = "citas_facturar";
        iniciar_tabla_resultados(filtrado, $("input[name='nombre']", this).val());
    }
});

function iniciar_tabla_resultados(filtrado, busqueda) {
    /*if (table_buscar) {
     $('#lista_de_resultados').dataTable().fnClearTable();
     $('#lista_de_resultados').dataTable().fnDestroy();
     }*/
    $.ajax({
        type: "GET",
        url: "ControladorCRUD",
        data: {"modulo": filtrado,
            "busqueda": busqueda},
        dataType: "json",
        encode: true,
        async: false,
    }).done(function (data) {
        var {data} = data;
        var contador = 0;
        table_buscar.clear().draw();
        var result = data
        result.map(info => {
            table_buscar.row.add([
                info[0],
                info[1],
                info[2],
                info[4],
                info[5],
                info[6],
                info[3],
                info[7], "<button type='button' class='btn waves-effect waves-light btn-success agregar' id='agregar'>" +
                        "<i class='fa fa-plus' aria-hidden='true'></i>" +
                        "</button>"
            ]).draw(false);
            table_buscar.columns.adjust();
            contador++;
        })
        //iniciar_datetimepicker();
    });
}
$('#modal_insertar').on('shown.bs.modal', function () {
    resetear_formulario("formulario_buscar");
    table_buscar.columns.adjust();
    table_buscar.clear().draw();
});
$('#modal_insertar').on('hidden.bs.modal', function () {
    resetear_formulario("formulario_buscar");
    table_buscar.columns.adjust();
    table_buscar.clear().draw();
});
$('#lista_de_resultados tbody').on('click', '.agregar', function () {
    var validador = 0;
    var index = $(this).closest('tr').index()
    var rowData = table_buscar.row(index).data();
    var cantidad_fecha = rowData[5]
    if ($("#fila-" + index + "-cantidad_fecha").attr("type") == "number" && /^\d*$/.test(cantidad_fecha)) {
        if (parseInt(cantidad_fecha) > parseInt(rowData[2] == 'Servicio' ? 1000 : rowData[4]) || parseInt(cantidad_fecha) < 0) {
            validador = 1;
        }
        table_detalle_factura.rows().every(function (rowIdx, tableLoop, rowLoop) {
            var data = this.data();
            if (data[0] == rowData[0] && (parseInt(data[2]) + parseInt(cantidad_fecha)) > parseInt(rowData[2]))
            {
                validador = 1
            }
        });
    } else if ($("#fila-" + index + "-cantidad_fecha").attr("type") == "text" && cantidad_fecha == "") {
        validador = 1;
    } else if (parseInt(cantidad_fecha) < 0) {
        validador = 1;
    }
    if (!validador) {
        var actualizacion = actualizar_cantidad_detalle(cantidad_fecha, rowData[0], true);
        if (!actualizacion) {
            table_detalle_factura.row.add([
                rowData[0],
                rowData[1],
                rowData[2],
                cantidad_fecha,
                rowData[7],
                (cantidad_fecha * parseFloat(rowData[7].replace("Lps. ", ''))).toFixed(2).toLocaleString('es'),
                "<button type='button' class='btn btn-danger eliminar'>" +
                        "<i class=\"fa fa-trash\"></i>" +
                        "</button>"
            ]).draw(false);
        }
        var articulos = "Citas";
        Swal.fire({
            title: '¿Desea añadir mas ' + articulos + '?',
            icon: "warning",
            showCancelButton: true,
            cancelButtonText: "No",
            confirmButtonText: 'S\u00ED',
        }).then((result) => {
            if (!result.isConfirmed) {
                $("#modal_insertar").modal('hide');
            } else if (result.isConfirmed) {
                $("#fila-" + index + "-cantidad_fecha").val("");
            }
        })
    } else {
        Swal.fire({
            title: "Cantidad errónea o vacía",
            icon: "Verifique los datos Ingresados",
            showCancelButton: false,
        })
    }
    disponible = $("#fila-" + index + "-cantidad_fecha").attr("max")
    totalizar();
});
function actualizar_cantidad_detalle(nueva_cantidad, id, add) {
    var indice = -1;
    var nueva_fila = null;
    if (table_detalle_factura) {
        table_detalle_factura.rows().every(function (rowIdx, tableLoop, rowLoop) {
            var data = this.data();
            if (data[0] === id)
            {
                indice = rowIdx;
                nueva_fila = this.data();
            }
        });
        if (add && nueva_fila) {
            nueva_fila[3] = parseInt(nueva_fila[3]) + parseInt(nueva_cantidad);
            if (!isNaN(nueva_cantidad)) {
                nueva_fila[5] = (parseInt(nueva_fila[3]) * parseFloat(nueva_fila[4])).toFixed(2)
            }
        } else if (nueva_fila) {
            nueva_fila[3] = nueva_cantidad;
            if (!isNaN(nueva_cantidad)) {
                nueva_fila[5] = (parseInt(nueva_cantidad) * parseFloat(nueva_fila[4])).toFixed(2)
            }
        }
        if (nueva_fila) {
            nueva_fila[6] = "<button type=\"button\" class='btn waves-effect waves-light btn-warning btn-outline-warning mb-1' onclick=\"editar('id;cantidad','" + nueva_fila[0] + "&" + nueva_fila[3] + "')\"  data-toggle='modal' data-target='#modal_editar'>" +
                    "<i class=\"fas fa-edit\"></i>" +
                    "</button>" +
                    "<button type='button' class='btn waves-effect waves-light btn-danger btn-outline-danger eliminar'>" +
                    "<i class=\"fas fa-trash\"></i>" +
                    "</button>";
            table_detalle_factura.row(indice).data(nueva_fila).draw();
        }
    }
    return nueva_fila;
}
function totalizar() {
    var total = 0;
    var impuesto = $("#variables").attr("impuesto");
    table_detalle_factura.rows().every(async function (rowIdx, tableLoop, rowLoop) {
        var data = this.data();
        total += parseFloat(data[5]);
    });
    $("#subtotal").html(total.toFixed(2) - (total * (impuesto / 100)).toFixed(2));
    $("#impuesto").html((total * (impuesto / 100)).toFixed(2));
    $("#total").html(total.toFixed(2));
}
$("#formulario_actualizar_detalle").submit(function (event) {
    event.preventDefault();
    var validated = validar_datos("formulario_actualizar_detalle");
    if (!validated) {
        var id = $("input[name='id']", this).val();
        var nueva_cantidad = $("input[name='cantidad']", this).val();
        if (parseInt(disponible) >= parseInt(nueva_cantidad)) {
            Swal.fire({
                icon: "success",
                title: "Actualización Satisfactoria",
                "text": "Se Modificó correctamente el registro",
                showCancelButton: false,
            })
            actualizar_cantidad_detalle(nueva_cantidad, id);
            $("#modal_editar").modal('hide');
            totalizar();
        } else {
            Swal.fire({
                icon: "warning",
                title: "Actualización Sin éxito",
                "text": "Verifique Nuevamente los datos",
                showCancelButton: false,
            })
        }

    }

});
$('#detalle_factura tbody').on('click', '.eliminar', function () {
    Swal.fire({
        title: '¿Seguro que desea eliminar?',
        icon: "warning",
        showCancelButton: true,
        cancelButtonText: "Cancelar",
        confirmButtonText: 'S\u00ED, eliminar',
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            table_detalle_factura
                    .row($(this).parents('tr'))
                    .remove()
                    .draw();
            totalizar();
            Swal.fire({
                title: "Eliminación Satisfactoria",
                text: "Se eliminó correctamente el registro",
                icon: "success",
                showCancelButton: false,
            })

        }
    })

});

function realizar_pago() {
    /* if ($("#forma_pago").val() !== "Efectivo") {
     var validated = validar_factura();
     if (!validated) {
     $("#modal_pago_tarjeta").modal('show');
     }
     } else {*/
    guardar_factura();
    // }
}
function validar_factura() {
    var validado = 0;
    var validaciones = ["cliente"];
    validaciones.map(input => {
        if (!$("#" + input).val() || $("#" + input).val() == "") {
            validado = 1;
            $("#" + input).attr("class", "form-control is-invalid");
        } else {
            $("#" + input).attr("class", "form-control is-valid");
        }
    })
    if (!table_detalle_factura.data().count()) {
        validado = 1;
        $("#listamensaje").show();
    } else {
        $("#listamensaje").hide();
    }
    return validado;
}
var cliente = null;
var forma_pago = null;
function guardar_factura() {
    var validated = validar_factura();
    var cai = randomstring(6).toUpperCase() + "-" + randomstring(6).toUpperCase() + "-" + randomstring(6).toUpperCase() + "-" + randomstring(6).toUpperCase() + "-" + randomstring(6).toUpperCase() + "-" + randomstring(2).toUpperCase()
    var extra_info = {"cai": cai, "no_rango": $("#variables").attr("rango_actual"), "rango_autorizado": $("#variables").attr("rango_autorizado"), "fecha_limite": $("#variables").attr("fecha_emision")};
    var data = {"tabla": "factura", "total": $("#total").text(), "impuesto": $("#impuesto").text(), "estado": "Pagada", "accion": "ingresar", "usuario": $("#variables").attr("usuario"), ...extra_info};
    var campos = ["forma_pago", "cliente"];
    campos.map(input => {
        if (input === "cliente") {
            cliente = $("#" + input).val()
        }
        /*else {
         forma_pago = $("#" + input).val()
         }*/
        data[input === "cliente" ? "paciente" : ""] = $("#" + input).val();
    })
    if (!validated) {
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "ControladorCRUD",
            data: data,
            error: function (request, status, error) {
                Swal.fire({
                    icon: "error",
                    title: error,
                    timer: 2000
                })
            },
            beforeSend: function () {
                $("#boton_ingresar_factura").prop("disabled", true);
                $("#boton_ingresar_factura").html('<i class="fa fa-print" aria-hidden="true" ></i>Guardando...');
            }
        }).done(function (data) {
            $("#boton_ingresar_factura").prop("disabled", false);
            $("#boton_ingresar_factura").html('<i class="fa fa-print" aria-hidden="true" ></i>Guardar');
            var tipo, mensaje;
            var verbo = "Factura";
            if (data.resultado) {
                tipo = 'success'
                mensaje = verbo + " Guardada"
            } else {
                tipo = 'error'
                mensaje = verbo + " No Guardada"
            }
            var resultado = data.resultado;
            if (data.resultado) {
                $("#num_factura").html(data.resultado);
                $("#rango").show();
                $("#cai").html(cai);
                $("#cai").show();
                $("#pdf").append('<a class="btn btn-primary pull-right" style="margin-right: 5px;" href="GenerarPDF.jsp?id=' + resultado + '"><i class="fa fa-download"></i> Generar PDF</a>')
                table_detalle_factura.rows().every(async function (rowIdx, tableLoop, rowLoop) {
                    var data = this.data();
                    var campos = ["cita", "servicio", "cantidad", "precio", "total_unitario"];
                    var data_insert = [];
                    data_insert[0] = data[0]
                    data_insert[1] = data[1]
                    data_insert[2] = data[3]
                    data_insert[3] = data[4].replace('Lps. ', '')
                    data_insert[4] = parseInt(data[3]) * parseFloat(data[4].replace('Lps. ', ''));
                    await guardar_detalle(campos, data_insert, resultado);


                });
            }
            if (data.resultado) {
                table_detalle_factura.column(6).visible(false);
                $(".detalle").hide();
                $("#boton_ingresar_factura").hide();
                $("#btn_nuevo").hide();
                $('#modal_insertar').modal('hide');
            }
            Swal.fire({
                title: mensaje,
                icon: tipo,
                showCancelButton: false,
            })
        });
    } else {
        Swal.fire({
            icon: "error",
            title: "Debe escoger el Paciente, detalle de la factura",
            timer: 2000
        })

    }

}
function imprimir_factura(el) {
    $("#btn_nueva_factura").hide();
    $("#btn_imprimir").hide();
    var printcontent = $('.' + el).clone();
    $('body').empty().html(printcontent);
    $("#cliente").val(cliente);
    $("#forma_pago").val(forma_pago);
    window.print();
    location.reload();
}
function guardar_detalle(info, valores, factura) {
    var data = {"tabla": "detalle_factura", "accion": "ingresar", "factura": factura};
    info.map((info, i) => {
        if (valores[i] && valores[i] !== '') {
            data[info] = valores[i]
        }
    })
    $.ajax({
        dataType: 'json',
        type: "POST",
        url: "ControladorCRUD",
        data: data,
        async: false,
        error: function (request, status, error) {
            Swal.fire({
                icon: "error",
                title: error,
                timer: 2000
            })
        }
    })
}
function recargar() {
    location.reload();
}
function validar_tarjeta() {
    $.ajax({
        type: "GET",
        url: "External_Controller",
        data: {"valor": $("#total").html(), "numero": $("input[name='numero_tarjeta']").val(), "cvv": $("input[name='cvv']").val(), "fecha_caducidad": $("input[name='fecha_caducidad']").val()},
        dataType: "json",
        encode: true,
        beforeSend: function () {
            $("#boton_ingresar").prop("disabled", true);
            $("#boton_ingresar").html("Verificando" + "<div id='spinner_carga' class='spinner-border  text-success spinner-border-sm' role='status'>" +
                    "<span class='sr-only'>...</span>" +
                    '</div>');
        },
        error: function (request, status, error) {
            $("#boton_ingresar").prop("disabled", false);
            $("#boton_ingresar").html("Comprar");
        }
    }).done(function (data) {
        $("#boton_ingresar").prop("disabled", false);
        $("#boton_ingresar").html("Comprar");
        var mensaje = "";
        if (data.resultado == 0) {
            mensaje = "Datos de Tarjeta incorrectos"
        } else if (data.resultado == 2) {
            mensaje = "Fondos insuficientes"
        } else {
            $("#modal_pago_tarjeta").modal('hide');
            guardar_factura();
        }
        if (data.resultado != 1) {
            Swal.fire({
                icon: 'warning',
                title: 'El banco emisor respondió',
                text: mensaje,
                timer: "2000"
            })
        }
    });
}
$("#formulario_pago_tarjeta").submit(function (event) {
    event.preventDefault();
    var validated = validar_datos("formulario_pago_tarjeta");
    if (!validated) {
        validar_tarjeta();
    }
})
$('#modal_pago_tarjeta').on('shown.bs.modal', function () {
    resetear_formulario("formulario_pago_tarjeta");
});
$('#modal_pago_tarjeta').on('hidden.bs.modal', function () {
    resetear_formulario("formulario_pago_tarjeta");
});
function iniciar_datepicker(format)
{
    $("input[name='fecha_caducidad']").each(function () {
        $(this).datepicker({
            language: 'es',
            format: format,
            startDate: new Date()
        })
    });
}
function iniciar_mascara() {
    $("input[name='numero_tarjeta']").each(function () {
        $(this).prop("class", "form-control cardnumber-inputmask");
        $(this).prop("type", "text")
    });
    $(".cardnumber-inputmask").inputmask("9999-9999-9999-9999")
}
$(document).ready(function () {
    iniciar_datepicker('mm/yyyy');
    iniciar_mascara();
    var date = moment($("#variables").attr("fecha_emision"))
    var now = moment();
    if (now > date) {
        Swal.fire({
            icon: "error",
            title: "Fecha de Límite Emisión Vencida",
            text: "Debe Actualizar la Fecha Límite de emisión para Facturar",
            allowOutsideClick: false,
            allowEscapeKey: false,
            timer: 86000
        }).then(() => {
            window.location.href = 'AdminDatosFluctuantes.jsp'
        })
    }
    if (parseInt($("#variables").attr("rango_actual")) > parseInt($("#variables").attr("rango_fin")) || $("#variables").attr("rango_fin") === "") {
        Swal.fire({
            icon: "error",
            title: "Rango Autorizado Excede el Límite",
            text: "Debe Actualizar los Rangos Autorizados",
            allowOutsideClick: false,
            allowEscapeKey: false,
            timer: 86000
        }).then(() => {
            window.location.href = 'AdminDatosFluctuantes.jsp'
        })
    }

});
function randomstring(L) {
    var s = '';
    var randomchar = function () {
        var n = Math.floor(Math.random() * 62);
        if (n < 10)
            return n; //1-10
        if (n < 36)
            return String.fromCharCode(n + 55); //A-Z
        return String.fromCharCode(n + 61); //a-z
    }
    while (s.length < L)
        s += randomchar();
    return s;
}