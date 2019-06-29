<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="./test.js"></script>
    <!--     optional library    -->
    <!--    <script src="https://momentjs.com/downloads/moment.js"></script>-->

    <!--    필수 라이브러리 추가(실제 차트js 이용하기 위한 것)  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
    <script type="text/javascript">
    </script>
    <style>
        #test {
            width: 500px;
            height: 800px;
            margin-left: 200px;
        }
    </style>
</head>

<body>
    <div id="test">
        <canvas id="myChart"></canvas>
    </div>
    <script>
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],       // x 축
            datasets: [{
            label: 'My First dataset',      //  위에 적는것
            backgroundColor: 'rgb(255, 99, 132)',       // 막대그래프 색
            borderColor: 'rgb(100, 100, 132)',      // 막대그래프 테두리 색
            data: [0, 10, 5, 2, 20, 30, 45]     // 수치 데이터
            }]
        }
        
        var ctx = document.getElementById('myChart').getContext('2d');
//        var chart = new Chart(ctx, {
//            // The type of chart we want to create
//            type: 'line',
//            // The data for our dataset
//            data: data
//            // Configuration options go here
//            options: {}
//        });
        var chart = new Chart(ctx, {
            type: 'bar',           //  보여줄 타입라인 타입
            data: data,             //      그릴 데이터 삽입
            options: {
                animation: {
                    duration:400,        // number     milliseconds
                    easing:'easeInQuad',        // String   data_anitaion ref=>    https://www.chartjs.org/docs/latest/configuration/animations.html#animation-callbacks
                    onProgress: function(animation) {       // 데이터 그릴때마다
//                        var data = animation.chart.data; 
                        console.log('is onProgress data=>'+ data);
                    },
                    onComplete: function(animation) {       // 데이터 다그리고 나서 실행
//                        var data = animation.chart.data; 
                        console.log('onComplete data=>'+ data);    
                    }
                },
                layout:{
                    padding:{       //데이터 그래프가 보여주는 부분에 패딩을 넣는다 HTML태그를 넘어가는곳이 있다면 히든이된다.
                        left:-300,
                        right: 0,
                        top: 0,
                        bottom: 0
                    }
                }
            }
        });
    </script>
</body>

</html>