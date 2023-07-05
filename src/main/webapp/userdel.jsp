
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="myJava.UserDao"%>
<%
    String id = request.getParameter("id");
    String errmsg = "";

    if (id == null || id.isEmpty()) {
        errmsg = "Invalid parameter!";
    } else {
        int userid = Integer.parseInt(id);
        if (UserDao.delUser(userid) != 0) {
            response.sendRedirect("userlist.jsp");
        } else {
            errmsg = "Failed to delete user!";
        }
    }

    pageContext.setAttribute("errmsg", errmsg);
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Game.</title>
	<link rel="icon" type="image/x-icon" href="images/icon.png">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
  <p>
    <a href="./home.html">Home</a>
    <a href="./signup.jsp">Signup</a>
    <a href="./userlist.jsp">Users</a>
  </p>
  <div>
    <h3>Delete User</h3>
    <h3 style='color:red'>${errmsg}</h3>
  </div>
</body>
</html>
