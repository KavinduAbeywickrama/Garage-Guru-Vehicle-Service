<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.json.JSONObject" %>

<%
    String code = request.getParameter("code");
    String sessionState = request.getParameter("session_state");
    
    // Set as a session attribute
    session.setAttribute("sessionState", sessionState); 
    
    
    String url = "https://api.asgardeo.io/t/kaviabey/oauth2/token";
    String client_Id = "b25I8I1oYIvMN2pIf5IQvbpPT9sa";
    String client_secret = "0COC9jYTffpjMIfD1J974nawZybccQHloGJK1gviqPka";
    String redirect_uri = "http://localhost:8080/GarageGuru-Vehicle-Reservations/authorization.jsp";
    

    //request body parameters
    String postData = "code=" + URLEncoder.encode(code, "UTF-8");
   
    postData += "&grant_type=authorization_code";
    postData += "&client_id=" + URLEncoder.encode(client_Id, "UTF-8");
    postData += "&client_secret=" + URLEncoder.encode(client_secret, "UTF-8");
    postData += "&redirect_uri=" + URLEncoder.encode(redirect_uri, "UTF-8");
    
    // URL object and open a connection
    URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();

    // Set the HTTP request method to POST
    con.setRequestMethod("POST");

    // Set the request headers
    con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

    // Enable input/output streams
    con.setDoOutput(true);

    // Write the POST data to the output stream
    try (OutputStream os = con.getOutputStream()) {
        byte[] input = postData.getBytes("UTF-8");
        os.write(input, 0, input.length);
    }

    // Get the response code and Read the response data
    int responseCode = con.getResponseCode();

   
    if (responseCode == HttpURLConnection.HTTP_OK) {
        try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
            String inputLine;
            StringBuilder responseData = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                responseData.append(inputLine);
            }

            // Handle the response data here
            String responseDataStr = responseData.toString();
            
            // Parse the response data as JSON
            JSONObject jsonResponse = new JSONObject(responseDataStr);

            // Extract access_token and id_token
            String access_token = jsonResponse.getString("access_token");
            String id_token = jsonResponse.getString("id_token");

            // Store tokens in session attributes
            request.getSession().setAttribute("access_token", access_token);
            request.getSession().setAttribute("id_token", id_token);

            // Redirect to the home.jsp page
            response.sendRedirect("home.jsp");
        }
    } else {
        // Handle errors here
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    
</head>
<body>
    
</body>
</html>