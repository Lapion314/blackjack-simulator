<%@page import="myJava.*"%>
<%@page import="myJava.User"%>
<%@page import="myJava.UserDao"%>

<head>
	<link rel = "stylesheet" href = "style.css">
	<title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
	
</head>
<body style = "background-color: darkslategray;">
			   <center>
	            <img class="icon" src="images/icon.png" alt="crying" style = "width: 10%;">
	        </center>

	<%
	String email=(String)session.getAttribute("email");
	User user;
	%>
	<p style = "color: white; font-family: sans-serif;">
	<%		
		if (email == null) {
	%>
			<div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	            <a href="login.html">Log In</a>
	            <a href="signup.html">Sign Up</a>
	            <a href="about.jsp">About</a>
	            <a href="userlist.jsp">Users List</a>
	            <a href="scoreboard.jsp">Users Balance</a>
	        </div>
	<%
		} else {
	%>
	   		<br>
	
	          <div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	            <a href="signout.jsp">Sign Out</a>
	            <a href="about.jsp">About</a>
	            <a href="games.html">Games</a>
	            <a href="userlist.jsp">Users List</a>
	            <a href="scoreboard.jsp">Users Balance</a>
	          </div>
	
	          <br>
	<%
		}
		if (email != null) {
			user = UserDao.getUser(email);
			%>
		    <p style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
		    Welcome <%= session.getAttribute("user") %>!</p>
	
				<br>
				<br>
		<%		
			} 
	%>
		    <center>
	            <img class="image1" src="images/crying.jpg" alt="crying">
	        </center>
	   
	</p>
</body>
