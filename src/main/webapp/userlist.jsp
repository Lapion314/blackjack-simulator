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
		
	if (email != null && email.equals("yanaimaman5@gmail.com"))
	{
		%> 
	<div class="container" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	<center>
		  <h2>Users</h2>
	  <table class="table">
	    <thead>
	      <tr>
	        <th>User ID</th>
	        <th>Full Name</th>
	        <th>Email</th>
	        <th>Password</th>
	        <th>Balance</th>
	      </tr>
	    </thead>
	    <tbody>
		<%
		    for(int i=0; i< users.length; i++)
		    {
	%>
		
			<tr>
	          <td><%out.print(users[i].getId());%></td>
	          <td><%out.print(users[i].getFullName());%></td>
	          <td><%out.print(users[i].getEmail());%></td>
	          <td><%out.print(users[i].getPassword());%></td>
	          <td><% out.print(users[i].getBalance() + "$" );%></td>
              <td>
              <%if (!users[i].getEmail().equals("yanaimaman5@gmail.com")){ %>
              <a href="userdel.jsp?id=<%out.print(users[i].getId());%>" style="color:lightskyblue;
        font-family: sans-serif;"
                 onclick="return confirm('Do you want to delete this user?')">Delete</a></td>
                 <%} %>
	        </tr>
	        </center>
<%
		    }
	}
	else {
		%>        
		
		<center style = "color: white; 
                      text-align: center; 
                      font-family: sans-serif; 
                      font-size: 30px;  ">
                You don't have premission to access this DATA.
        </center> <% 
	}
%>
    
    </tbody>
  </table>
</div>
	  	        <center>
	  	        <Br>
	        		 <a href="#" onclick="goBack()" style="color:lightskyblue;
				        font-family: sans-serif;">Back home</a>
					
					<script>
					  function goBack() {
					    window.history.go(-1);
					  }
					</script>
	        </center>
</body>
</html>