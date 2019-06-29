<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>WebcamJS Test Page</title>
	<!-- First, include the Webcam.js JavaScript Library -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/webcam.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
	<script type="text/javascript">
	var fac1;
	var fac2;
		function take_snapshot() {
			var data1;
			// take snapshot and get image data
			Webcam.snap( function(data_uri) {
				// display results in page
				document.getElementById('results').innerHTML = 
					'<h2>Here is your image:</h2>' + 
					'<img src="'+data_uri+'"/>';
					 data1= data_uri;
					  var params = {
					            // Request parameters
					            "returnFaceId": "true",
					            "returnFaceLandmarks": "false",
					            "returnFaceAttributes":"age,gender,headPose,smile,facialHair,glasses,emotion," +
					            "hair,makeup,occlusion,accessories,blur,exposure,noise"
					        };

					        	var baseimg=data1;
					     		var sourceImageUrl=baseimg;
// 					            document.querySelector("#sourceImage").src = sourceImageUrl;
					            
					        	function mkblob(dataURL) {
					            var BASE64_MARKER = ';base64,';
					            if (dataURL.indexOf(BASE64_MARKER) == -1) {
					                var parts = dataURL.split(',');
					                var contentType = parts[0].split(':')[1];
					                var raw = decodeURIComponent(parts[1]);
					                return new Blob([raw], { type: contentType });
					            }
					            var parts = dataURL.split(BASE64_MARKER);
					            var contentType = parts[0].split(':')[1];
					            var raw = window.atob(parts[1]);
					            var rawLength = raw.length;

					            var uInt8Array = new Uint8Array(rawLength);

					            for (var i = 0; i < rawLength; ++i) {
					                uInt8Array[i] = raw.charCodeAt(i);
					            }

//					             return new Blob(uInt8Array, { type: contentType });
					            return uInt8Array;
					        }
					        	
// 					        	alert(mkblob(baseimg));
// 					        	console.log($.param(params));
					        	
					        $.ajax({
					            url: "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?" + $.param(params),
					            beforeSend: function(xhrObj){
					                // Request headers
					                xhrObj.setRequestHeader("Content-Type","application/octet-stream");
					                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key","b74721472f9443ceb2f7902b00ce7724");
					            },
					            type:"POST",
					            // Request body
					            data:mkblob(baseimg),
					            processData: false,
					            success : function(resp){
					            	fac1 = resp[0].faceId;
					            } 
					        })
					        .done(function(data) {
					            alert("success");
					        })
					        .fail(function() {
					            alert("error");
					        });
			} );
			
			
		}
		
		function take_snapshot2() {
			var data2;
			// take snapshot and get image data
			Webcam.snap( function(data_uri) {
				// display results in page
				document.getElementById('results2').innerHTML = 
					'<h2>Here is your image:</h2>' + 
					'<img src="'+data_uri+'"/>';
					 data2= data_uri;
					  var params = {
					            // Request parameters
					            "returnFaceId": "true",
					            "returnFaceLandmarks": "false",
					            "returnFaceAttributes":"age,gender,headPose,smile,facialHair,glasses,emotion," +
					            "hair,makeup,occlusion,accessories,blur,exposure,noise"
					        };

					        	var baseimg=data2;
					     		var sourceImageUrl=baseimg;
//					            document.querySelector("#sourceImage").src = sourceImageUrl;
					            
					        	function mkblob(dataURL) {
					            var BASE64_MARKER = ';base64,';
					            if (dataURL.indexOf(BASE64_MARKER) == -1) {
					                var parts = dataURL.split(',');
					                var contentType = parts[0].split(':')[1];
					                var raw = decodeURIComponent(parts[1]);
					                return new Blob([raw], { type: contentType });
					            }
					            var parts = dataURL.split(BASE64_MARKER);
					            var contentType = parts[0].split(':')[1];
					            var raw = window.atob(parts[1]);
					            var rawLength = raw.length;

					            var uInt8Array = new Uint8Array(rawLength);

					            for (var i = 0; i < rawLength; ++i) {
					                uInt8Array[i] = raw.charCodeAt(i);
					            }

//					             return new Blob(uInt8Array, { type: contentType });
					            return uInt8Array;
					        }
					        	
//					        	alert(mkblob(baseimg));
//					        	console.log($.param(params));
					        	
					        $.ajax({
					            url: "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?" + $.param(params),
					            beforeSend: function(xhrObj){
					                // Request headers
					                xhrObj.setRequestHeader("Content-Type","application/octet-stream");
					                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key","b74721472f9443ceb2f7902b00ce7724");
					            },
					            type:"POST",
					            // Request body
					            data:mkblob(baseimg),
					            processData: false,
					            success : function(resp){
					            	fac2 = resp[0].faceId;
					            } 
					        })
					        .done(function(data) {
					            alert("success");
					        })
					        .fail(function() {
					            alert("error");
					        });
			});
		}
		
		
		
		function result(){
			  $.ajax({
		            url: "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/verify",
		            beforeSend: function(xhrObj){
		                // Request headers
		                xhrObj.setRequestHeader("Content-Type","application/json");
		                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key","b74721472f9443ceb2f7902b00ce7724");
		            },
		            type: "POST",
		            // Request body
		            data:'{"faceId1":'+'"'+ fac1+'","faceId2" :' + '"'+fac2+'"}',
		            success : function(resp){
		            	result=resp.isIdentical;
		            	if(result==true){
		            		alert("같은사람입니다.");
		            	}else{
		            		alert("다른사람입니다.");
		            	}
		            	
		            } 
		            
		        })
		        .done(function(data) {
		            alert("success");
		        })
		        .fail(function() {
		            alert("error");
		        });
			 
		}
		
	</script>
	
	<style type="text/css">
		body { font-family: Helvetica, sans-serif; }
		h2, h3 { margin-top:0; }
		form { margin-top: 15px; }
		form > input { margin-right: 15px; }
		#results { float:right; margin:20px; padding:20px; border:1px solid; background:#ccc; }
	</style>
</head>
<body>
	<div id="results">Your captured image will appear here...</div>
	
	
	<h1>WebcamJS Test Page</h1>
	<h3>Demonstrates 240x240 cropped capture &amp; display</h3>
	
	<div id="my_camera"></div>
	
	<div id="results2">Your captured image will appear here...2</div>
	
	
	
	<!-- Configure a few settings and attach camera -->
	<script language="JavaScript">
		Webcam.set({
			// live preview size
			width: 320,
			height: 240,
			
			// device capture size
			dest_width: 320,
			dest_height: 240,
			
			// final cropped size
			crop_width: 240,
			crop_height: 240,
			
			// format and quality
			image_format: 'jpeg',
			jpeg_quality: 90
		});
		
		Webcam.attach( '#my_camera' );
	</script>
	
	<!-- A button for taking snaps -->
	<form>
		<input type=button value="Take Snapshot" onClick="take_snapshot()">
	</form>
	
	<form>
		<input type=button value="Take Snapshot" onClick="take_snapshot2()">
	</form>
	<!-- Code to handle taking the snapshot and displaying it locally -->
	
	<input type=button value="result" onClick="result()">
	<br/>
	<br/>
	
	
</body>
</html>
