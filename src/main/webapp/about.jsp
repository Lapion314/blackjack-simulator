<%@page import="myJava.*"%>
<%@page import="myJava.User"%>
<%@page import="myJava.UserDao"%>
<head>
	<title>Game.</title>
	<link rel = "stylesheet" href = "style.css">
	<link rel="icon" type="image/x-icon" href="images/icon.png">
</head>
<body style = "background: darkslategray;">

          	<center>
	            <img class="icon" src="images/icon.png" alt="crying" style = "width: 10%;">
	        </center>
		<%
        String email=(String)session.getAttribute("email");
		User user;
		if(email == null) {%>
			<div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	            <a href="login.html">Log In</a>
	            <a href="signup.html">Sign Up</a>
	            <a href="home.html">Home</a>
	            <a href="userlist.jsp">Users List</a>
	        </div>
		<%} else{ %>
			<br>
	          <div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	            <a href="signout.jsp">Sign Out</a>
	            <a href="header.jsp">Home</a>
	            <a href="games.html">Games</a>
	            <a href="userlist.jsp">Users List</a>
	          </div>
		<%} %>
          <br>

    <p style = "font-family: sans-serif;
    margin-left: auto;
    margin-right: auto;
    color: white;
    font-size: 30px;
    text-align: center;
    margin-left: -40;"
    >About Us </p>
    <Br><Br><br>
    <p style = "font-family: sans-serif;
    margin-left: auto;
    margin-right: auto;
    color: white;
    font-size: 20px;
    text-align: center;
    margin-left: -40;">
        this is a basic games website
        <br>
        currently all you can find here is a low quality blackjack game.
        <br>
        <Br>
        Why Should I sign up?
        <br>
        you get a personal welcome when entering the website.
        <br><br><br><Br>
        About the company
        <br>
        CEO of game. (INC all rights reserved): Yanai Maman. 
        <br>
        Co-CEO of game. (INC all rights reserved): Tomer Raz Zarbiv.
    </p>
    <center style="color:lightskyblue;
        font-family: sans-serif;">
    <br><br>
	
	<script>
	  function goBack() {
	    window.history.go(-1);
	  }
	</script>
    </center>
</body>