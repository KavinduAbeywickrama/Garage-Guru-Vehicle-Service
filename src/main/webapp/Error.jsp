<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
</head>
<body>

<center>
		<h1>Error!</h1>
		<h2>An unknown error occurred.</h2>
		<h2><%=exception.getMessage() %></h2>
        
</center>
</body>
</html>