
var modulos = $("#variables").attr("modulo");
var lista_modulos = modulos.split(";");
var lista_permisos_editar = $("#variables").attr("puede_editar").split(";");
var lista_permisos_eliminar = $("#variables").attr("puede_eliminar").split(";");

lista_modulos.map((modulo, i) => {
    if (i === 0) {
        actual = modulo;
    }
    if (i === 1) {
        setTimeout(() => {
            load_datatable(modulo, i);
        }, 1500);

    } else {
        load_datatable(modulo, i)
    }


})
function load_datatable(modulo, i) {
    table = $("#" + modulo).DataTable({
        autowidth: true,
        responsive: true,
        ajax: {
            url: 'ControladorCRUD',
            type: "GET",
            data: {"modulo": modulo,
                "editar": lista_permisos_editar[i],
                "eliminar": lista_permisos_eliminar[i],
                "busqueda": $("#variables").attr("busqueda")
            },
        },
        "initComplete": function (settings, json) {
            if (modulo === "recetas_paciente") {
                iniciar_viewer("recetas_paciente", 1);
            }
        },
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
        }
    })
}
function cambiar_actual(nuevo) {
    actual = nuevo;
    table = $("#" + nuevo).DataTable()
}