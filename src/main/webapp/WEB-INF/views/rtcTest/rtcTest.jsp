<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2019. 5. 20.      AA      최초작성
* Copyright (c) 2019 by DDIT All right reserved
*
 --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Realtime communication</title>
</head>
<body>
<body>
<h1>Realtime communication</h1>

<div class="video" id="localVideo"></div>
<div class="video" id="remoteVideo"></div>

<div>
  <input id="roomName" placeholder="room name"/>
  <button id="startButton">Start</button>
  <button id="callButton">Call</button>
  <button id="hangupButton">Hang Up</button>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.2.0/socket.io.dev.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script>

</script>
</body>
</html>