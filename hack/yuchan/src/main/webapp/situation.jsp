<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script> 
    <title>지하 침수 알림</title>
    <script type="text/javascript">
        function showClock(){
          var currentDate = new Date();
          var divClock = document.getElementById('divClock');
          var msg = "현재 시간 : ";
          if(currentDate.getHours()>12){      //시간이 12보다 크다면 오후 아니면 오전
            msg += "오후 ";
            msg += currentDate.getHours()-12+"시 ";
         }
         else {
           msg += "오전 ";
           msg += currentDate.getHours()+"시 ";
         }
   
          msg += currentDate.getMinutes()+"분 ";
          msg += currentDate.getSeconds()+"초";
   
          divClock.innerText = msg;
          setTimeout(showClock,1000);  //1초마다 갱신
        }
    </script>
</head>
<body onload="showClock()">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <article>
        <div id = "box1">
            <h1>지하 침수 알림</h1>
        </div>
        <div id="item">
            <nav>
                <ul>
                    <li onclick="window.location='index.jsp'"><div>개요</div></li>
                    <li onclick="window.location='list.jsp'">기록조회</li>
                    <li onclick="window.location='situation.jsp'">실시간 현황</li>
                    <li onclick="window.location='index2.jsp'">대피로</li>
                </ul>
            </nav>
        </div>
    </article>
    <section>
        <h1>실시간 현황</h1>
        <div id="divClock" class="clock"></div>
        <script>
			$(document).ready(function() {
	         	setInterval(function() {
	            	$.ajax({
	            		url: "down2.jsp",
	            		method: "GET",
	            		dataType: "text",
	            		success: function(data) {
							var mydata = JSON.parse(data);
	              			console.log(mydata);
							document.getElementById("su").innerText = mydata.label;
							document.getElementById("peo").innerText = mydata.temp;
	            		}
	           		})
	        	},5000);
	      	});
	        //값을 download2에서 json값을 가져와서 받아 저장하고 그래프를 그린다
		</script>
        <table id="tasitu" style="border:none;">
        	<tr>
        		<td>
        			<div id="situ">
			        	<h2>수위</h2>
			        </div>
        		</td>
        		<td>
        			<div id="people">
			        	<h2>사람</h2>
			        </div>
        		</td>
        	</tr>
        	<tr>
        		<td>
	        		<div class="situation" id="su" style="text-align:center">
			        	정상
			        </div>
		   		</td>
		    	<td>
	        		<div class="situation" id="peo" style="text-align:center">
			        	정상
			        </div>
		    	</td>
		    </tr>
        </table>
    	<div style="width:800px;" id="grapgo">
			<canvas id="line1"></canvas>
		</div>
		<script>
			$(document).ready(function() {
	         	setInterval(function() {
	            	$.ajax({
	            		url: "down.jsp",
	            		method: "GET",
	            		dataType: "text",
	            		success: function(data) {
							var mydata = JSON.parse(data);
	              			console.log(mydata);
							chart.data.labels = mydata.label;
							chart.data.datasets[0].data = mydata.temp;
							chart.update();
	            		}
	           		})
	        	},5000);
	      	});
	        //값을 download2에서 json값을 가져와서 받아 저장하고 그래프를 그린다
		</script>
		<script>
			var ctx = document.getElementById('line1').getContext('2d');
			var chart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: ['N-6', 'N-5', 'N-4', 'N-3', 'N-2', 'N-1', 'N'],
				datasets: [
						{
							label: '수위',
							backgroundColor: 'transparent',
							borderColor: "red",
							data: [0, 0, 0, 0, 0, 0, 0]
						}
					]
				},
				options: {}
			});
		</script>
    </section>
</body>
</html>