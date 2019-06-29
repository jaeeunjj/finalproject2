<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script>
  $(document).ready(function() {
		$("#chatBtn").on("click",function(event){
			  var query =$("#query").val();
			  $("#resultArea").append($("<tr><td>").text(query));
	  	$.ajax({
		  type: "POST",
          url: "https://api.dialogflow.com/v1/query?v=20150910",
          contentType: "application/json; charset=utf-8",
          headers: {
              Authorization:"Bearer "+"b586fc1c50494aaabfcb0516c9e772ca"
          },
          data: JSON.stringify({
        	  contexts: [
        	               "shop"
        	             ],
              query: query ,
              lang: "ko",
              sessionId: "12345",
              timezone: "America/New_York"
              
          }),
          success: function(response) {
              console.log("success");
              // Here you will get the response to your query in json, you will have to parse it based on the type it has like text, image, card etc. & show it to user. 
             
//               alert(response.result.fulfillment.messages[0].speech);
              $("#resultArea").append($("<tr><td>").text(response.result.fulfillment.messages[0].speech));
              
              var target = (response.result.parameters.target);
              
              if(target=="학사일정"){
//             	  $("#resultArea").append($("<tr><td>").text("5월 7일은 착수발표입니다."));
            	  $.ajax({
          			url : "${pageContext.request.contextPath}/calender",//요청주소
          			method : "get",
          			dataType : "json", // request header(Accept), response header(Content-Type)
          			success : function(resp) {
          				var testList = resp;
          				$(testList).each(function(idx, test){
          				 $("#resultArea").append($("<tr><td>").text(test.title));
          				 $("#resultArea").append($("<tr><td>").text(test.start));
          				 $("#resultArea").append($("<tr><td>").text(test.end));
          				})

          			},
          			error : function(errorResp) {
          				console.log(errorResp.status);
          			}

          		});

              }
              
              
          },
          error: function() {
              console.log("Error");
          }

		});
	  	
		});
  });

</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<input type="text" id="query">
	<input type="button" id = "chatBtn" value = "전송">
	
	
	<table id = "resultArea">
		
	</table>
	
</body>
</html>