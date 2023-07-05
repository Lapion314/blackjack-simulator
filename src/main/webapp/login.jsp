<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="myJava.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel = "stylesheet" href = "style.css">
	<meta charset="ISO-8859-1">
	<title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
</head>
<body style = "background-color: darkslategray; color: white; font-family: sans-serif;">
<%
	boolean inHeader = false;
	String email=request.getParameter("email");  
	String password=request.getParameter("password");
	
	User user = UserDao.getUser(email);
	
	if (user != null && user.getPassword().equals(password))
	{ 
	    session.setAttribute("email", email);
	    session.setAttribute("user", user.getFullName() );
	    session.setAttribute("balance", user.getBalance());
	    %> 
	    <center>
	    	<p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	    	Successfuly logged in!</p>
	    	<% 
	    	inHeader = true;
	    	session.setAttribute("inHeader", inHeader);
	    	%>
		        <a href="header.jsp" 
		        style="color:lightskyblue;
		        font-family: sans-serif;
                 text-align: center;">
		     	<br><br>
		     	Back home</a>
    	</center>
		<%
	}
	else
	{	
		%>
	    <p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	    Sorry, email or password are not correct, please try again</p>
	   	<center>
		        <a href="login.html" 
		        style="color:lightskyblue;
		        font-family: sans-serif;
                 text-align: center;">
		     	<br><br>
		     	Back to log in</a>
    	</center>
	    <%
	    
    }
%>
</body>
</html>