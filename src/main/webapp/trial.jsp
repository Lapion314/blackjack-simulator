<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="myJava.*"%>
<%@page import="myJava.User"%>
<%@page import="myJava.UserDao"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
	String email = (String)session.getAttribute("email");
	String fullname = (String)session.getAttribute("fullname");
	User user = null;
	int balance = 0;
	if (email != null) {	
		user = UserDao.getUser(email);
		balance = user.getBalance();
		fullname = user.getFullName();
%>
	<html>
	<head>
  	<title>Game. BJ</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
	<link rel = "stylesheet" href = "style.css">
</head>
<body style="background-color: darkslategray;">
	

  <div>
    <p style="color: white; text-align: center; font-family: sans-serif; font-size: 30px;">Have fun, <%= fullname %></p>
  </div>
  	          <div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
	            <a href="signout.jsp">Sign Out</a>
	            <a href="about.jsp">About</a>
	            <a href="games.html">Games</a>
	            <a href="userlist.jsp">Users List</a>
	          </div>
	          <BR>

  <center>

	<style>
        .log-container {
        	margin-left:200px;
        	margin-top: 540px;
        	margin-left:600px;
            width: 180px; /* Adjust the width as per your requirements */
            height: 74px; /* Adjust the height based on the canvas size and the distance from the canvas */
            border: 1px solid #ccc;
            background-color: gray;
            overflow-y: scroll; /* Enable vertical scrolling */
            text-align: left;
            position: absolute;
            margin-top: 440;
            top: 30px; /* Adjust the top position based on the distance from the canvas */
            right: 20px; /* Adjust the right position based on the distance from the canvas */
        }

        /* CSS for the log items */
        .log-item {
            background-color: white;
            color: black;
            font-family: sans-serif;
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
    .bar-container {
      width: 400px;
      height: 40px;
      background-color: #f2f2f2;
      position: relative;
    }

    .bar-indicator {
      width: 20px;
      height: 40px;
      background-color: #4CAF50;
      position: absolute;
      top: 0;
      left: 0;
      cursor: grab;
    }

    .bet-amount {
      font-size: 18px;
      margin-top: 10px;
    }
  </style>
    <form id = "form" method="post">
    	<label for="number" style="color: white; text-align: center; font-family: sans-serif;">Bet Amount:</label>
    	<input name="number">
    	<input id = "bet" type="submit" value="Bet">
  	</form>
   <p style="color: white; text-align: center; font-family: sans-serif;">Money: <%=balance %>$ </p>
   <%
   int updatedBal = 0;
   int betAmount = 0;
   int savedBetAmount = 0;
   boolean balanceUpdated = false;
   String userInput = request.getParameter("number");   
   
   if (userInput != null) {
	        try {
	            // Set the session attribute to indicate submission
	            session.setAttribute("submitted", true);
	            betAmount = Integer.parseInt(userInput);
	            
	            if (!(betAmount > user.getBalance()) && betAmount > 0 && balanceUpdated == false) {
	            	balanceUpdated = true;
	                balance -= betAmount;
	                user.setBalance(balance);
	                UserDao.updateUser(user);
	                savedBetAmount = betAmount;
	                betAmount = 0;
	                %>
	                <script>
	                	document.getElementById("bet").disabled = true;
	                </script>
	                <p style="color: white; text-align: center; font-family: sans-serif;">Updated balance: <%= balance %>$</p>
	                
	                <%
	            } else {
	                %>
	                <p style="color: white; text-align: center; font-family: sans-serif;">an error occurred. please try a different value</p>
	                <%
	            }
	        } catch (NumberFormatException e) {
	            // Handle the case where the input is not a valid integer
	            %>
	            <p style="color: white; text-align: center; font-family: sans-serif;">Invalid input. Please enter a valid integer.</p>
	            <%
	        }
	    if(savedBetAmount > 0 && savedBetAmount < user.getBalance() ){
		    %>
		    <p style="color: white; text-align: center; font-family: sans-serif;">bet amount: <%= savedBetAmount %>$</p>
		    <%	
	    }
	}
	%>
	
		<form action = "userBal.jsp" method = "post">
			<input type = "hidden" name = "savedBetAmount" id = "betAmount" value = "<%= savedBetAmount %>">
		
			<input type = "hidden" name = "case" style="font-family: sans-serif; font-size: 20px;" id = "get" value = "<%= savedBetAmount %>">
			<input type = "submit" value = "get money" id = "getMoney">
		</form>
		
		<br>
  
      <input id="startButton" onclick="startGame(); this.onclick=null;" type="submit" name="button" value="Genreate cards" style="font-family: sans-serif; font-size: 30px; "/>

    <input id="hitButton" type="submit" name="button" value="hit" style="font-family: sans-serif; font-size: 30px;" />

    <input id="stayButton" type="submit" name="button" value="stay" style="font-family: sans-serif; font-size: 30px; width: 75px;" />

    <button id = "playAgain" style = "width: 100px; height: 35px" onClick="window.location.reload();document.getElementById('startButton').disabled = false;">Play again</button>
    
    <Br>
    
    <canvas id="ctx" width="500" height="500" style="margin-top: 30; border: 1px solid #000000; background-color: white;"></canvas>

  <script>
  	document.getElementById("startButton").disabled = false;
	document.getElementById("getMoney").disabled = true;
    document.getElementById("hitButton").disabled = true;
    document.getElementById("stayButton").disabled = true;
    document.getElementById("playAgain").disabled = true;
  	
    document.getElementById("bet").onclick = function() {
    	document.getElementById("startButton").disabled = true;
        document.getElementById("playAgain").disabled = false;
      	balance = <%= balance%>;
        betAmount = <%= betAmount %>;
        balance = balance - betAmount;
    }
    
    document.getElementById("getMoney").onclick = function() {
    	document.getElementById('bet').disabled = false;
    }
                    var ctx = document.getElementById("ctx").getContext("2d");
                    //every new game output:
                    ctx.font = '30px Arial';
                    ctx.fillText('Dealer\'s Side', 320, 30);
                    ctx.fillText('Player\'s Side', 5, 490);
                    //when the variables are initiated outside of the functions they can be accessed anywhere:
                    	
                    var get = document.getElementById('get');
                    var betAmount2 = document.getElementById('betAmount');
                    
                    var sum = 0;
                    var d_card1_num = 0;
                    var biggerSum = 0;
                    var biggerSumEligible = true;
                    var d_card2_letter = 0;
                    var d_card2 = 0;
                    var d_card2_num = 0;
                    var biggerDealerSumEligible = true;
                    var a_letter = 0;
                    var sumDealer = 0;
                    var biggerDealerSum = 0;
                    var countHitClicks = 0;
                    var alreadyPrinted = false;
            
                    var d_card1 = Math.round(Math.random() * (13 - 1) + 1);
                    
                    var p_card1 = Math.round(Math.random() * (13 - 1) + 1);
                    var p_card2 = Math.round(Math.random() * (13 - 1) + 1);
            
                    function calcAndPrintSum(p_card1, p_card2){
//changing Jack(11), Queen(12) and King(13) to their valid value (10):
                        if (p_card1 > 10){
                            p_card1_num = 10;
                        }
                        else{
                            p_card1_num = p_card1;
                        }
                        if (p_card2 > 10){
                            p_card2_num = 10;
                        }
                        else{
                            p_card2_num = p_card2;
                        }
//calculating sum and bigger sum:
                            if(p_card1_num == 1){
                                biggerSum = p_card2_num + 11;
                                }
                            if (p_card2_num == 1){
                                biggerSum = p_card1_num + 11;
                            }
                            sum = p_card1_num + p_card2_num;
//blackjack:
                            if(biggerSum == 21){
                                sum = 21;
                                biggerSum = 0;
                                ctx.font = '30px Arial';
                                ctx.fillStyle = "green";
                                ctx.fillText("Blackjack! you've won!", 90, 270);
                                
                                get.value = '1'
                                
                                document.getElementById('getMoney').disabled = false;
                                
                                blackjack = true;
                                
                                disableButtons()
                            }
                        if (biggerSum != 0){
                            ctx.font = '20px Arial';
                            ctx.fillStyle = "black";
                            ctx.fillText("(sum cards: " + sum + " or " + biggerSum + ")", 320, 490);
                        }
                        else{
                            ctx.font = '20px Arial';
                            ctx.fillStyle = "black";
                            ctx.fillText("(sum cards: " + sum + ")", 360, 490);//sum
                        }
                    }
                    function startGame() {
                    	document.getElementById("startButton").disabled = true;
//unlocking the hit and stay buttons because the game has started:
                        document.getElementById("hitButton").disabled = false;
                        document.getElementById("stayButton").disabled = false;
                        calcAndPrintSum(p_card1, p_card2)
                        d_card1_num = d_card1;
//switch statements turns numbers to card letters
                        switch(p_card1){
                            case 1: p_card1 = 'A'; break;
                            case 11: p_card1 = 'J'; break;
                            case 12: p_card1 = 'Q'; break;
                            case 13: p_card1 = 'K'; break;
                            default: break;
                        }
                        switch(p_card2){
                            case 1: p_card2 = 'A'; break;
                            case 11: p_card2 = 'J'; break;
                            case 12: p_card2 = 'Q'; break;
                            case 13: p_card2 = 'K'; break;
                            default: break;
                        }
                        switch(d_card1){
                            case 1: d_card1 = 'A'; break;
                            case 11: d_card1 = 'J'; break;
                            case 12: d_card1 = 'Q'; break;
                            case 13: d_card1 = 'K'; break;
                            default: break;
                        }
//player cards and 1 dealer card output        
                        ctx.font = '40px Arial';
                        ctx.fillText(d_card1, 400, 80);
                        ctx.fillText(p_card1 + ',' + p_card2, 70, 450);
                    }
                    //hit function
                    document.getElementById('hitButton').onclick = function() { 
                        
                        while(sum < 22){
                            countHitClicks ++;
                            var a_card = Math.round(Math.random() * (13 - 1) + 1);
                            
                            switch(a_card){
                                case 1: var a_letter = "A"; break;
                                case 11: var a_letter = "J"; break;
                                case 12: var a_letter = "Q"; break;
                                case 13: var a_letter = "K"; break;
                                default: a_letter = a_card;
                            }
                            if(a_card > 10){
                                a_card = 10;
                            }

                            sum += a_card;
                            ctx.font = '40px Arial';
                            ctx.fillText(", " + a_letter, 100 + 45 * countHitClicks , 450);
                            
                            if(biggerSum != 0){
                                biggerSum += a_card;
                                if(biggerSum > 21){
                                    biggerSumEligible = false;
                                }
                            }
                            //updated sum output:
                            if(biggerSumEligible && biggerSum != 0){
                                ctx.font = '20px Arial';
                                ctx.fillText("(sum cards: " + sum + " or " + biggerSum +")", 315, 490 - countHitClicks * 25);
                            }
                            else{
                                ctx.font = '20px Arial';
                                ctx.fillText("(sum cards: " + sum + ")", 360, 490 - countHitClicks * 25);   
                            }
                            if(sum > 21){
                                    ctx.font = '30px Arial';
                                    ctx.fillStyle = "red";
                                    ctx.fillText("you passed 21, you lost!", 90, 250);
                                    
                                    get.value = '4'
                                    
                                    document.getElementById('bet').disabled = false;
                                    
                                    disableButtons()
                                    
                                    break;
                            }
                            
                            setTimeout(resolve, 1000);

                        }
                        
                    }
                    document.getElementById('stayButton').onclick = function() {
                        ctx.font = '30px Arial';
                        ctx.fillStyle = "black";
                        ctx.fillText("you chose to stay! dealer's turn!", 50, 230);
                        document.getElementById('hitButton').disabled = true;
                        document.getElementById('stayButton').disabled = true;

                        handleDealer();
                    };
                    function handleDealer(){

                        if(biggerSumEligible && biggerSum > 0){
                            sum = biggerSum;
                        }

                        d_card2 = Math.round(Math.random() * (13 - 1) + 1);

                        d_card2_num = d_card2;

                        switch (d_card2) {
                            case 1:
                                d_card2_letter = 'A'; break;
                            case 11:
                                d_card2_letter = 'J'; break;
                            case 12:
                                d_card2_letter = 'Q'; break;
                            case 13:
                                d_card2_letter = 'K'; break;
                            default:
                                d_card2_letter = d_card2;
                        }
                        if(d_card2 > 10){
                            d_card2 = 10;
                        }

                        ctx.font = '40px Arial';
                        ctx.fillText(d_card2_letter + ",", 345, 80);
                        calcAndPrintDealerSum(d_card1_num, d_card2_num)
                        
                        countHitClicks = 0;
                        while(sumDealer < 22){
                            countHitClicks ++;
                            var a_card = Math.round(Math.random() * (13 - 1) + 1);
                            
                            switch(a_card){
                                case 1: var a_letter = "A"; break;
                                case 11: var a_letter = "J"; break;
                                case 12: var a_letter = "Q"; break;
                                case 13: var a_letter = "K"; break;
                                default: a_letter = a_card;
                            }
                            if(a_card > 10){
                                a_card = 10;
                            }
                            if((sumDealer > sum && sumDealer < 22) || (biggerDealerSumEligible && biggerDealerSum > sum)){
                                ctx.fillText("sumDealer: " + sumDealer + " sum: " + sum, 100, 390);
                                if(!alreadyPrinted){
                                    ctx.font = '30px Arial';
                                    ctx.fillStyle = "red";
                                    ctx.fillText("busted by the dealer, you lost!", 50, 250);
                                    get.value = '4'
                                }
                                
                                document.getElementById('getMoney').disabled = false;
                                
                                disableButtons()
                                break;
                            }
                            if(sumDealer == sum || (biggerDealerSum == sum && biggerDealerSumEligible)|| (biggerSumEligible && sumDealer == biggerSum) || (biggerSumEligible && biggerSum == sumDealer)){
                                if(!alreadyPrinted){
                                    ctx.font = '30px Arial';
                                    ctx.fillStyle = "purple";
                                    ctx.fillText("It's a tie!", 50, 250);
                                    get.value = '2'
                                    
                                    document.getElementById('getMoney').disabled = false;
                                }
                                
								
                                disableButtons()
                                break;
                            }

                            sumDealer += a_card;
                            ctx.font = '40px Arial';
                            ctx.fillText(a_letter + "," , 345 - 50 * countHitClicks , 80);

                            if(biggerDealerSum != 0){
                                biggerDealerSum += a_card;
                                if(biggerDealerSum > 21){
                                    biggerDealerSumEligible = false;
                                }
                            }
                            //updated sum output:
                            if(biggerDealerSumEligible && biggerDealerSum != 0){
                                ctx.font = '20px Arial';
                                ctx.fillText("(sum cards: " + sumDealer + " or " + biggerDealerSum +")", 40, 40 + countHitClicks * 25);
                            }
                            else{
                                ctx.font = '20px Arial';
                                ctx.fillText("(sum cards: " + sumDealer + ")", 40, 40 + countHitClicks * 25);   
                            }
                            
                            if(sumDealer > 21){
                                ctx.font = '30px Arial';
                                ctx.fillStyle = "green";
                                ctx.fillText("Dealer went over 21, you won!", 50, 250);
                                
                                document.getElementById('getMoney').disabled = false;
                                
                                get.value = '3'
      						  
                                disableButtons()
                                break;
                            }
                        }

                    }
                    function calcAndPrintDealerSum(d_card1, d_card2){
                        if (d_card1 > 10){
                            d_card1_num = 10;
                        }
                        else{
                            d_card1_num = d_card1;
                        }
                        if (d_card2 > 10){
                            d_card2_num = 10;
                        }
                        else{
                            d_card2_num = d_card2;
                        }
//calculating sum and bigger sum:
                            if(d_card1_num == 1){
                                biggerDealerSum = d_card2_num + 11;
                            }
                            if (d_card2_num == 1){
                                biggerDealerSum = d_card1_num + 11;
                            }
//blackjack:
                            if(biggerDealerSum == 21){
                                ctx.font = '30px Arial';
                                ctx.fillStyle = "red";
                                ctx.fillText("Dealer has a blackjack! you lost!", 90, 270);
                                
                                document.getElementById("bet").disabled = false;
                                
                                get.value = '4'
                                
                                disableButtons()
                                alreadyPrinted = true;
                            }
                        sumDealer = d_card1_num + d_card2_num;
                        if (biggerDealerSum != 0){
                            ctx.font = '20px Arial';
                            ctx.fillStyle = "black";
                            ctx.fillText("(sum cards: " + sumDealer+ " or " + biggerDealerSum + ")", 40, 40);
                        }
                        else{
                            ctx.font = '20px Arial';
                            ctx.fillStyle = "black";
                            ctx.fillText("(sum cards: " + sumDealer + ")", 40, 40);//sum
                        }
                    }
                    //the function is being called when the game is over:
                    function disableButtons(){
                        //document.getElementById('playAgain').disabled = false;
                        document.getElementById('hitButton').disabled = true;
                        document.getElementById('stayButton').disabled = true;
                        document.getElementById('startButton').disabled = true;
                    }
                    
        </script>
        
    </center>
    </body>
</html>
	
<%
	} else {
%>
	<html>
	
			<head>
	  	<title>Game. error</title>
		<link rel="icon" type="image/x-icon" href="images/icon.png">
		<link rel = "stylesheet" href = "style.css">
		</head>
		<body style="background-color: darkslategray;">
		<center>	
			<img class="icon" src="images/icon.png" alt="crying" style = "width: 10%;">
		<br>
		</center>
			<p style="color: white; text-align: center; font-family: sans-serif; font-size: 30px;">you have to log in to enter this page.</p>
			
			<br>
			
						<div class="toolbar" style="color: white; font-family: sans-serif; text-align: center; font-size: 30px;">
			            <a href="login.html">Log In</a>
			            <a href="signup.html">Sign Up</a>
			            <a href = "home.html">Home</a>
			            <a href="about.jsp">About</a>
			            <a href="userlist.jsp">Users List</a>
			        </div>
		</body> 
	</html>
	<%
	} 
	%>
