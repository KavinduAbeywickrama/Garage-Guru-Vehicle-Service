<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<%
// Retrieve the email from the session attribute
String userEmail = (String) session.getAttribute("userEmail");
%>

<html>
<head>
<title>Vehicle Service Reservation</title>	
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  
 
</head>
<body>

	<header>
		
		
		
		<nav class="navbar navbar-inverse">

			<!--passing the email into Servlet class to retrive all service records from this email.-->
			<%
    
    			String useremail = (String) session.getAttribute("userEmail"); // Get the user's email from the session
			%>
	
		  <div class="container-fluid">
		    <div class="navbar-header">      
		      <a class="navbar-brand" href="home.jsp">Garage Guru</a>
		    </div>
		    <div class="collapse navbar-collapse" id="myNavbar">
		      <ul class="nav navbar-nav"> 
		      	<li ><a href="home.jsp">Home</a></li>                  
		        <li><a href="" class="active" style="background-color: #000000">New Reservations</a></li> 
		      </ul>
		      <ul class="nav navbar-nav navbar-right">       
		        <li><a href="home.jsp"><span class="glyphicon glyphicon-log-in"></span> Back</a></li>
		      </ul>
		    </div>
		  </div>
		</nav>
					
		
	</header>
	<br>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				
				<c:if test="${vehicleService == null}">
					<form action="insert" method="post">
						</c:if>
		
						<caption>
							<h2>
								<c:if test="${vehicleService == null}">
		            			Add New Reservation
		            		</c:if>
							</h2>
						</caption>
		
					
						
						<fieldset class="form-group">
		    				<label>Username (Authenticated User)</label>
		    				<input type="text"  class="form-control" name="username" value="<%=userEmail%>" required="required" readonly>
						</fieldset>
						
						<fieldset class="form-group">
		    				<label>Date of Service Reservation</label>
		    				<input type="date" class="form-control" name="date" required="required" min="<%=java.time.LocalDate.now()%>" onblur="validateDate(this)" oninput="validateSunday(this)">
						</fieldset>
						<script>
						    function validateSunday(input) {
						        // Get the selected date from the input field
						        var selectedDate = new Date(input.value);
						        
						        // Check if the selected date is a Sunday (day 0 in JavaScript Date object)
						        if (selectedDate.getDay() === 0) {
						            alert("Sundays are not allowed. Please select a different date.");
						            input.value = ""; // Clear the input field
						        }
						    }
						</script>
						<fieldset class="form-group">
		    				<label>Preferred Time</label>
		    				<select class="form-control" name="time" required="required">
						        <option value="15:30:00">10 AM</option>
						        <option value="16:30:00">11 AM</option>
						        <option value="17:30:00">12 PM</option>
		    				</select>
						</fieldset>
						
						<fieldset class="form-group">
					    	<label>Preferred Location</label>
					    	<select class="form-control" name="location" required="required">
						        
						        <option value="Ampara">Ampara</option>
						        <option value="Anuradhapura">Anuradhapura</option>
						        <option value="Badulla">Badulla</option>
						        <option value="Batticaloa">Batticaloa</option>
						        <option value="Colombo">Colombo</option>
						        <option value="Galle">Galle</option>
						        <option value="Gampaha">Gampaha</option>
						        <option value="Hambanthota">Hambanthota</option>
						        <option value="Jaffna">Jaffna</option>
						        <option value="Kaluthara">Kaluthara</option>
						        <option value="Kandy">Kandy</option>
						        <option value="District 12">Kegalle</option>
						        <option value="Kegalle">kilinochchi</option>
						        <option value="Kurunegala">Kurunegala</option>
						        <option value="Mannar">Mannar</option>
						        <option value="Mathale">Mathale</option>
						        <option value="Matara">Matara</option>
						        <option value="Monaragala">Monaragala</option>
						        <option value="Mullaitivu">Mullaitivu</option>
						        <option value="Nuwara Eliya">Nuwara Eliya</option>
						        <option value="Pollonnaruwa">Pollonnaruwa</option>
						        <option value="Puttalam">Puttalam</option>
						        <option value="Ratnapura">Ratnapura</option>
						        <option value="Trincomalee">Trincomalee</option>
						        <option value="Vavuniya">Vavuniya</option>
					        
					    	</select>
						</fieldset>
						
						
						<fieldset class="form-group">
						    <label>Vehicle Registration Number</label>
						    <input type="text" class="form-control" name="vehicle_no" required="required">
						</fieldset>
		
						<fieldset class="form-group">
		    				<label>Current Mileage</label>
		    				<input type="number" class="form-control" name="mileage" required="required">
						</fieldset>
						
						<fieldset class="form-group">
		    				<label>Message</label>
		    				<textarea class="form-control" name="message" required="required"></textarea>
						</fieldset>
		
						<button type="submit" class="btn btn-success">Save</button>

					</form>
			</div>
		</div>
	</div>
</body>
</html>