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
	
	<%
		String email = (String)session.getAttribute("email");
		User user = UserDao.getUser(email);
		int balance = user.getBalance();
		
		String case1 = request.getParameter("case");
		
		String savedBetAmount = request.getParameter("savedBetAmount");
		
        int betAmount2 = Integer.parseInt(savedBetAmount);
        
		if ("1".equals(case1)){ //blackjack
			balance += (int)betAmount2 * 2 + betAmount2 * 0.5;
            user.setBalance(balance);
            UserDao.updateUser(user);
		}
		else{
			if("2".equals(case1)){ //tie
				balance += betAmount2;
	            user.setBalance(balance);
	            UserDao.updateUser(user);
			}
			else{
				if("3".equals(case1)){ //win
					balance += betAmount2 * 2;
		            user.setBalance(balance);
		            UserDao.updateUser(user);
				}
				else{
					if("4".equals(case1)){ //lost
						//nothing. balance already got decreased
					}
				}
			}
		}
		response.sendRedirect("trial.jsp");
	%>
</body>
</html>