<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="myJava.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
</head>
<body style="background-color: darkslategray;">
  
    <jsp:useBean id="user" class="myJava.User" />

    <jsp:setProperty property="*" name="user" />
<% 

	 if (!request.getParameter("password").equals(request.getParameter("passwordConf"))) { %>
        <p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
            Passwords do not match. Please try again.</p>
          <center>
            <a href="signup.html" style="color: lightskyblue; font-family: sans-serif; text-align: center;">
                <br><br>
                Back to sign up</a>
        </center>
        <% } else {
           user.setBalance(1000);
           int status = UserDao.addUser(user);
           if (status > 0) {
        	   session.setAttribute("email", user.getEmail());
        %>
        <p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
            Welcome! You are successfully registered!</p>
                <center>
        <a href="login.html" style="color: lightskyblue; font-family: sans-serif; text-align: center;">
            <br><br>
            Log In</a>
    </center>
        <%
           } else {
        %>
        <p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
            A problem occurred, please try again later</p>
                <center>
        <a href="signup.html" style="color: lightskyblue; font-family: sans-serif; text-align: center;">
            <br><br>
            Sign u[]</a>
    </center>
        <%
           }
        }
    %>
</body>
</html>