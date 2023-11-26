<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
    <%@ page import="java.io.BufferedReader" %>
	<%@ page import="java.io.InputStreamReader" %>
	<%@ page import="java.net.HttpURLConnection" %>
	<%@ page import="java.net.URL" %>
	<%@ page import="java.io.IOException" %>
	<%@ page import="org.json.JSONObject" %>
	<%@ page import="java.sql.*, java.util.Date" %>
	<%@ page import="java.util.List" %>
	<%@ page import="java.util.ArrayList" %>

<%
        // Retrieve access_token and id_token from session attributes
        String introUrl = "https://api.asgardeo.io/t/kaviabey/oauth2/introspect";
		String post_logout_redirect_uri = "http://localhost:8080/GarageGuru-Vehicle-Reservations/index.jsp"; 
		String client_id = "b25I8I1oYIvMN2pIf5IQvbpPT9sa";

        String access_token = (String) request.getSession().getAttribute("access_token");
        String id_token = (String) request.getSession().getAttribute("id_token");
        String jsonDataString = ""; // Initialize jsonDataString here
        
        
     	// retriving session state from session attributes
        String sessionState = (String) session.getAttribute("sessionState");


        // Check if the tokens exist in the session
         if (access_token != null && id_token != null) {
        	    String apiUrl = "https://api.asgardeo.io/t/kaviabey/oauth2/userinfo";

        try {
            // Create a URL object
            URL url = new URL(apiUrl);

            // Open a connection to the URL
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set the request method to GET
            connection.setRequestMethod("GET");

            // Set the "Authorization" header with the Bearer token
            connection.setRequestProperty("Authorization", "Bearer " + access_token);

            // Get the response code
            int responseCode = connection.getResponseCode();

            // Check if the response code indicates success (HTTP 200 OK)
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Create a BufferedReader to read the response
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder responseStringBuilder = new StringBuilder();

                // Read the response line by line
                while ((inputLine = in.readLine()) != null) {
                    responseStringBuilder.append(inputLine);
                }
                in.close();

                // Parse the JSON response
                JSONObject jsonResponse = new JSONObject(responseStringBuilder.toString());
					//out.println(jsonResponse);
                // Retrieve user information
                String given_name = jsonResponse.getString("given_name");                
                String country = jsonResponse.getString("country");
                String phone_number = jsonResponse.getString("phone_number");
                String email = jsonResponse.getString("email");

             // Store the email in a session attribute
                session.setAttribute("userEmail", email);            
             	
              
               %>
			 <script>
			 document.addEventListener("DOMContentLoaded", function() {
				    
				  	
				  	var first_name = '<%=given_name%>';
				  	var coun_try = '<%=country %>';
				    var phone_num = '<%=phone_number%>';
				    var e_mail = '<%=email%>';
		
				  
				    // Now you can use these JavaScript variables to update your HTML elements
				    document.getElementById("fName").textContent =  first_name;				  
				    document.getElementById("country").textContent =  coun_try;
				    document.getElementById("phone_no").textContent =  phone_num;
				    document.getElementById("email").textContent =  e_mail;
				});
			</script>
          <%       
            } else {
                // Handle error responses here
                out.println("HTTP Error: " + responseCode);
            }

            
            connection.disconnect();
        } catch (IOException e) {
            
            e.printStackTrace();
        }
    } else {
        // the case when either accessToken or idToken is null
        %>
    	<script>
			alert("Access token is missing");
		</script>
		<% 
    }
    %>
    
    
    
<!DOCTYPE html>
<html>
<head>
<title>Vehicle Service Reservation</title>

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


	<style>
			/* Style the navigation bar */
			.logout-btn-custom {
		    margin-top: 10px; /* Adjust this value to move the button up or down as needed */
		  	}
		  	
		  	
		  	body {
        background-image: url('https://www.canva.com/design/DAFxNtN38ak/nsuVjp3m5cWOR9T9iEy1mQ/edit'); /* Replace 'your-image.jpg' with the actual file name */
        background-size: cover; /* Adjust as needed */
    }
		  		
	</style>
	
		
</head>

<body>

	<header>
		<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      
		      <a class="navbar-brand" href="home.jsp">Garage Guru</a>
		    </div>
		    <div class="collapse navbar-collapse" id="myNavbar">
		      <ul class="nav navbar-nav">
		        <li class="active"><a href="home.jsp">Home</a></li>        
		        <li><a href="<%=request.getContextPath()%>/new">New Reservation</a></li> 
		      </ul>
		      <ul class="nav navbar-nav navbar-right">		          
		        <li>
		        	<form id="logout-form" action="https://api.asgardeo.io/t/kaviabey/oidc/logout" method="POST">
						    <input type="hidden" id="client-id" name="client_id" value="<%= client_id %>">
						    <input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="<%= post_logout_redirect_uri %>">
						    <input type="hidden" id="state" name="state" value="<%= sessionState %>">
				    		<button id="logout-btn" class="logout-btn-custom" type="submit"><span class="glyphicon glyphicon-log-in"></span> Logout</button>
					</form>		
				</li>
		      </ul>
		    </div>
		  </div>
		</nav>
	</header>
	
	<br>
	<div class="container" >
	
     <h2 id="welcome">Hello, <span id="fName"></span>!</h2>
            
  <table class="table" id="info">
    
      <tr>
        <th>Email :</th>
        <td id="email"></td>
        
      </tr>
      <tr>
        
        <th>Phone Number :</th>
        <td id="phone_no"></td>
       
      </tr>
      <tr>
        
        <th>Country :</th>
        <td id="country"></td>
      </tr>         
  </table> 
  <hr>       
	 
	
	</div>

	<div class="row">
		<!-- <div class="alert alert-success" *ngIf='message'>{{message}}</div> -->

		<div class="container">
			<h3 class="text-center">Your Reservations</h3>
			<hr>
			<div class="container text-left">
			
				<%    
    			String useremail = (String) session.getAttribute("userEmail"); // Get the user's email from the session
				%>
			
			
				<a href="<%=request.getContextPath()%>/list?email=<%=useremail%>" class="btn btn-info">View My Reservations</a>
			</div>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr class="warning">
						<th>Booking ID</th>
						<th>Date</th>
						<th>Time</th>
						<th>Location</th>
						<th>Vehicle Number</th>
						<th>Mileage</th>
						<th>Message</th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach var="vehicleService" items="${listVehicleService}">
					
					
						<tr>
							
							<td><c:out value="${vehicleService.booking_id}" /></td>
							<td><c:out value="${vehicleService.date}" /></td>
							<td><c:out value="${vehicleService.time}" /></td>
							<td><c:out value="${vehicleService.location}" /></td>
							<td><c:out value="${vehicleService.vehicle_no}" /></td>
							<td><c:out value="${vehicleService.mileage}" /></td>
							<td><c:out value="${vehicleService.message}" /></td>
							<td><a href="delete?booking_id=<c:out value='${vehicleService.booking_id}' />">Delete</a></td>
						</tr>
					</c:forEach>
		
				</tbody>

			</table>
		</div>
	</div>
	<img alt="" src="https://www.canva.com/design/DAFxNtN38ak/nsuVjp3m5cWOR9T9iEy1mQ/edit">
</body>
</html>