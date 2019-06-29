<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="${pageContext.request.contextPath}/resources/js/canvas2image.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/base64.js" type="text/javascript"></script>

 <video id='video' autoplay width=320 height=240></video> 

<canvas id='captureVideo' width=320 height=240></canvas>

<a href="javascript:capture();"> 촬 영 </a> 
<a href="javascript:captureClear();"> 취 소 </a>

<script type="text/javascript">
 //비디오
 var video = document.getElementsByTagName('video')[0];
 

 navigator.getUserMedia({video:true}, successCallback, errorCallback);

 function successCallback(stream) {
  video.src = URL.createObjectURL(stream);
 }
 function errorCallback(error) {
  }

 //canvas
 var captureVideo = document.getElementById('captureVideo');
 var c = document.getElementById('captureVideo');
 var ctx = captureVideo.getContext("2d");
 
 function capture() { // capture를 잡기위해 이 함수를 호출해주면 된다.
   
   ctx.drawImage(video, 0, 0, video.width, video.height);

   Canvas2Image.saveAsJPEG(captureVideo);   
  };
 
 function captureClear(){ // capture이미지 지우기
  ctx.fillStyle = "rgb(255,255,255)";
  ctx.fillRect(0,0,320,240);
 }
</script>











