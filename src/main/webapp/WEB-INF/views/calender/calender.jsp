<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<link href='${pageContext.request.contextPath}/resources/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>

<script>
  $(document).ready(function() {//비동기로 일정데이터를 받아와서 처리해준다.
	  $.ajax({
			url : "${pageContext.request.contextPath}/calender",//요청주소
			method : "get",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : function(resp) {
				$('#calendar').fullCalendar({
//			       defaultDate: '2019-01-12', //달력 시작 기준날짜를 정할 수 있다.
			      editable: false,// 일정수정 가능 여부 true 일 경우
			      					//일정을 드래그해서 옮길 수 있다.
			      eventLimit: true, // allow "more" link when too many events
			      events: resp //응답 데이터는 json으로 받아와야함..
			    });

			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}

		});
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
 <div class="container">
 <div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
<!-- calender id 를 가진 div 요소를 추가해 준다. -->
	<div id='calendar'></div> 
	</div>
	</div>
	</div>
</body>
</html>