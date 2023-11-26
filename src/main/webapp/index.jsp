<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
    
    
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="ISO-8859-1">
	<title>Vehicle Service Reservation - Login</title>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	

	
	<style>
	body {
	    background: #fff;
	    background-image: url('images/backgroundimage.jpg'); 
	    background-size: cover;
	}
	
	
	
	html, body {
	    height: 100%;
	    
	}	
	
	.app-name {
	    color: #5663ab;
	}
	
	.container{
	 width:100%;
	 
	}
	
	.login-block {
	    margin: 0;
	    width:100%;
	    hieght: 80%;
	    padding: 6.25rem;
	}
	
	.login-sec {
	    padding: 3.125rem 1.875rem;
	    position: relative;
	    background: #f8f9fa;
	}
	
	#btn-login{
	 margin-top: 15px;
	 margin-left: 120px;
	 width: 100px;
	 font-size: 20px;
	}
	
	.app-icon {
	    text-align: center;
	    width: 7.625rem;
	    height: 7.625rem;
	    line-height: 7.125rem;
	    border-radius: 100%;
	    border: 0.25rem solid #dbe4ec;
	}
	
	.app-icon i {
	    line-height: 7.125rem;
	}
	
	.app-name {
	    font-size: 2rem;
	    font-weight: 800;
	    letter-spacing: 0.2rem;
	    padding: 1.2rem 0 0.2rem 0;
	    color: black;
	}
	
	.app-login-form {
	    margin-bottom: 0;
	    text-align: center;
	}
	
	#tagline{
		display: flex;
        justify-content: center; /* Horizontally center the text */
        align-items: center; /* Vertically center the text */
        font-size: 25px;
        margin-top: 20px;
        font-style: italic;
        color: black;
	}

	</style>
</head>
<body class="app-login">

	
<section class="login-block">
    <div class="container">
        <div class="row">
            <div class="col-sm-9 col-md-4 col-lg-4 mx-auto login-sec">
               
                <div class="app-name text-center">Garage GURU Services</div>
                <div class="inner-div">

					<button id="btn-login" class="btn btn-success" onclick="window.location.href='https://api.asgardeo.io/t/kaviabey/oauth2/authorize?response_type=code&client_id=b25I8I1oYIvMN2pIf5IQvbpPT9sa&scope=openid%20email%20phone%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2FGarageGuru-Vehicle-Reservations%2Fauthorization.jsp'" >
						<span class="btn-text">Login</span>
						<div class="fill-container"></div>
					</button>				
	
				</div>
            </div>
        </div>
    </div>
    <h5><span id="tagline">We are for you..</span></h5>
</section>


</body>
</html>