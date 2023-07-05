<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="myJava.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
</head>
<body>
	<jsp:include page="header.jsp" />

<%
	session.invalidate();
    response.sendRedirect("home.html");		
%>
</body>
</html>