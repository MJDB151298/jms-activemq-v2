<!DOCTYPE html>
<html lang="sp" xmlns:spring="http://www.w3.org/1999/XSL/Transform">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>BarCamp2020</title>

    <!-- Bootstrap core CSS -->
    <link href="static/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/scrolling-nav.css" rel="stylesheet">

    <!-- Dashboard Core -->
    <link href="/dashboard.css" rel="stylesheet" />

</head>

<body id="page-top">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">Inicio</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/"></a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<header class="bg-primary text-white">
    <div class="container text-center">
        <h1>BarCamp2020</h1>
    </div>
</header>

<div class="page">
    <div class="page-main">
        <div class="header py-4">
            <div class="container">
                <div class="d-flex">
                    <a class="header-brand" href="index.ftl">
                        <h3 class="card-title">Retriever de temperatura y humedad</h3>
                    </a>
                </div>
            </div>
        </div>
        <div class="my-3 my-md-5">
            <div class="container">
                <div class="page-header">
                    <h1 class="page-title">
                        Sensores
                    </h1>
                </div>
                <div class="row row-cards">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Temperatura</h3>
                            </div>
                            <div id="chartContainer" style="height: 300px; width: 100%;"></div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Humedad</h3>
                            </div>
                            <div id="chartContainer2" style="height: 300px; width: 100%;"></div>

                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3">
                        <div class="card p-3">
                            <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-red mr-3">
                          <i class="fas fa-thermometer-full"></i>
                        </span>
                                <div>
                                    <h4 class="m-0"><a href="javascript:void(0)">Readings Temperatura <small id="temp">-1</small></a></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card p-3">
                            <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-blue mr-3">

                            <i class="fas fa-tint"></i>
                        </span>
                                <div>
                                    <h4 class="m-0"><a href="javascript:void(0)">Readings Humedad <small id="hum">-1</small></a></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/jquery.min.js"></script>
<script src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script>
    var webSocket;
    var dps = [];
    var temp = 0;
    var hum = 0;
    var dps2 = [];// dataPoints
    var chart = new CanvasJS.Chart("chartContainer", {
        zoomEnabled: true,
        title :{
            text: "Sensor Temperatura"
        },
        axisX:{
            title: "Fecha",
            interval: 30,
            intervalType: "second"
        },
        axisY: {
            title: "Temperatura",
            includeZero: false
        },
        data: [{
            type: "line",
            dataPoints: dps
        }]
    });
    var chart2 = new CanvasJS.Chart("chartContainer2", {
        zoomEnabled: true,
        title :{
            text: "Sensor Humedad"
        },
        axisX:{
            title: "Fecha",
            interval: 30,
            intervalType: "second"
        },
        axisY: {
            title: "Humedad",
            includeZero: false
        },
        data: [{
            type: "line",
            dataPoints: dps2
        }]
    });
    var updateInterval = 1000;
    var dataLength = 20; // number of dataPoints visible at any point
    var updateChart = function (dataPoints) {
        var dp = JSON.parse(dataPoints);
        console.log(dp);
        dps.push({
            label: dp.fecha,
            y: dp.temperatura
        });
        dps2.push({
            label: dp.fecha,
            y: dp.humedad
        });
        temp = parseInt(document.getElementById("temp").innerText) + 1;
        document.getElementById("temp").innerText = temp.toString();
        hum = parseInt(document.getElementById("hum").innerText) + 1;
        document.getElementById("hum").innerText = temp.toString();
        chart.render();
        chart2.render();
    };
    function socketConnect() {
        webSocket = new WebSocket("ws://" + location.hostname + ":" + location.port + "/sensor_read");
        webSocket.onmessage = function (datos) {
            console.log("I am making a connection");
            updateChart(datos.data);
        };
    }
    function connect() {
        if (!webSocket || webSocket.readyState === 3) {
            socketConnect();

        }
    }
    updateChart(dataLength);
    setInterval(connect, updateInterval);
</script>
</body>
</html>