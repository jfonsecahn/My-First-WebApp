function grafico_lineal(labels, values) {
    if ($('#mybarChart').length) {

        var ctx = document.getElementById("mybarChart");
        var mybarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                        label: 'Cantidad Total de Ventas',
                        backgroundColor: "#03586A",
                        data: values
                    }]
            },

            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            }
        });

    }
}
function grafico_pastel(labels, data) {
    if ($('.canvasDoughnut').length) {
        var chart_doughnut_settings = {
            type: 'doughnut',
            tooltipFillColor: "rgba(51, 51, 51, 0.55)",
            data: {
                labels: labels,
                datasets: [{
                        data: data,
                        backgroundColor: [
                            "#BDC3C7",
                            "#9B59B6",
                            "#E74C3C",
                            "#26B99A",
                            "#3498DB"
                        ],
                        hoverBackgroundColor: [
                            "#CFD4D8",
                            "#B370CF",
                            "#E95E4F",
                            "#36CAAB",
                            "#49A9EA"
                        ]
                    }]
            },
            options: {
                legend: false,
                responsive: false
            }
        }

        $('.canvasDoughnut').each(function () {

            var chart_element = $(this);
            var chart_doughnut = new Chart(chart_element, chart_doughnut_settings);

        });

    }
}

$(document).ready(function () {
    if ($("#variables").attr("grafico1") === "true")
    {
        $.ajax({
            dataType: 'json',
            type: "GET",
            url: "ControladorGraficos",
            data: {"grafico": "2"},
        }).done(function (data) {
            var labels = data.data.map(info => info[0])
            var values = data.data.map(info => {
                var percent = (parseFloat(info[1]) / parseFloat(info[2])) * 100
                return percent.toFixed(2)
            })
            grafico_pastel(labels, values)
        });
    }
    if ($("#variables").attr("grafico2") === "true")
    {
        $.ajax({
            dataType: 'json',
            type: "GET",
            url: "ControladorGraficos",
            data: {"grafico": "1"},
        }).done(function (data) {
            var labels = data.data.map(info => info[0])
            var values = data.data.map(info => info[1])
            grafico_lineal(labels, values)
        });
    }
});