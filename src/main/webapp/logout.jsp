<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session to log the user out
    session.invalidate();

    // Redirect to the login page
    response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container">
    <h2>You have been logged out successfully.</h2>
    <p><a href="index.jsp">Click here to login again</a></p>
</div>
</body>
</html>