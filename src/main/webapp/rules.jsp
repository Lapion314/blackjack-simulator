        
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
          <br>

    <p style = "font-family: sans-serif;
    margin-left: auto;
    margin-right: auto;
    color: white;
    font-size: 30px;
    text-align: center;
    margin-left: -40;"
    >Blackjack rules </p>
    <Br><Br><br>
    <p style = "font-family: sans-serif;
    margin-left: auto;
    margin-right: auto;
    color: white;
    font-size: 20px;
    text-align: center;
    margin-left: -40;">
        <br>
			the goal: the closer you get to sum cards of 21 the better.
			<br>
			you passed 21? you lost!
			<br>
			the game goes by the player. you. getting 2 cards right away while the dealer only gets one that is shown on board.
			<Br>
			you may press hit as many times as you feel like. but be careful! it gets more risky as you hit.
			<br>
			you're fine with the cards you currently have? stay!
			<br>
			as soon as you stay the dealer will go and play his turn.
			he will try to beat your sum. but he will satisfy with a draw(in this particular 1v1 mode).
			<br>
			because you might say the dealer has an advantage on the player by showing only one card and playing lastly,
			<br>
			the player has an instant win no matter what. by getting 21 with only using two cards
			<br>
			that can happen by getting an Ace card and a card that has a numeric value of ten(10, J, Q, K)
			<br>
			have fun!
    </p>
    </center>
            <center>
             <a href="games.html" style="color:lightskyblue;
		        font-family: sans-serif;">Back to games</a>
		        <br><Br>
            <a href="header.jsp" style="color:lightskyblue;
		        font-family: sans-serif;">Back home</a>
		 </center>
</body>