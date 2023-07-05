<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="myJava.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
	<link rel = "stylesheet" href = "style.css">
</head>
<body style = "background: darkslategray; color: white;">

<br><Br><Br>
<%
	String email=(String)session.getAttribute("email");
	
	String id=(String)session.getAttribute("id");
	String errmsg = "";
	User[] users = UserDao.getUsers();
		%> 
	<div class="container" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	<center>
		  <h2>User Balance</h2>
	  <table class="table">
	    <thead>
	      <tr>

	        <th>Full Name</th>
	        <th>Balance</th>
	      </tr>
	    </thead>
	    <tbody>
		<%
		    for(int i=0; i< users.length; i++)
		    {
		%>
			<tr>
	          <td><%out.print(users[i].getFullName() + ": ");%></td>
	          <td><% out.print(users[i].getBalance() + "$" );%></td>
              <td>
	        </tr>
	        </center>
<%
		    }
		%>
    
    </tbody>
  </table>
</div>
	<center>
			        		 <a href="header.jsp" style="color:lightskyblue;
				        font-family: sans-serif;">Back home</a>
	</center>
</body>
</html>