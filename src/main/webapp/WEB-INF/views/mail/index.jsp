<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Gmail API Quickstart</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <p>Gmail API Quickstart</p>

    <!--Add buttons to initiate auth sequence and sign out-->
    <button id="authorize_button" style="display: none;">Authorize</button>
    <button id="signout_button" style="display: none;">Sign Out</button>

    <pre id="content" style="white-space: pre-wrap;"></pre>

    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '59793012465-jun36gssdt2iha2gf092io9p7bib63jo.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyCpZXrhpdMbiYms3XBVVqyysB4L3IqdUAw';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/gmail/v1/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = 'https://www.googleapis.com/auth/gmail.readonly';

      var authorizeButton = document.getElementById('authorize_button');
      var signoutButton = document.getElementById('signout_button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          listLabels();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

      /**
       * Print all Labels in the authorized user's inbox. If no labels
       * are found an appropriate message is printed.
       */
      function listLabels() {
        gapi.client.gmail.users.labels.list({
          'userId': 'me'
        }).then(function(response) {
          var labels = response.result.labels;
          appendPre('Labels:');

          if (labels && labels.length > 0) {
            for (i = 0; i < labels.length; i++) {
              var label = labels[i];
              appendPre(label.name)
            }
          } else {
            appendPre('No Labels found.');
          }
        });
      }

      
      function listMessages(userId, query, callback) {
    	  var getPageOfMessages = function(request, result) {
    	    request.execute(function(resp) {
    	      result = result.concat(resp.messages);
    	      var nextPageToken = resp.nextPageToken;
    	      if (nextPageToken) {
    	        request = gapi.client.gmail.users.messages.list({
    	          'userId': userId,
    	          'pageToken': nextPageToken,
    	          'q': query
    	        });
    	        getPageOfMessages(request, result);
    	      } else {
    	        callback(result);
    	      }
    	    });
    	  };
    	  var initialRequest = gapi.client.gmail.users.messages.list({
    	    'userId': userId,
    	    'q': query
    	  });
    	  getPageOfMessages(initialRequest, []);
    	}
      function listMessageCallback(result){
    	  console.log(result);
      }
      
      function getMessage(userId, messageId, callback) {
    	  var request = gapi.client.gmail.users.messages.get({
    	    'userId': userId,
    	    'id': messageId/*,
    	    "format" : "RAW" */
    	  });
    	  request.execute(callback);
    	}
      
      function getMessageCallback(data){
    	  console.log("test");
      }
    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
    <script src="/js/base64.js"></script>
  </body>
</html>