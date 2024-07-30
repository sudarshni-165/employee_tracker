<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Task</title>
</head>
<body>
<h1>Delete Task</h1>
<%
    String taskIdParam = request.getParameter("task_id");
    String userIdParam = request.getParameter("user_id");
    

    if (taskIdParam == null || taskIdParam.trim().isEmpty() || userIdParam == null || userIdParam.trim().isEmpty()) {
        System.out.println("<p>Task ID or User ID not provided.</p>");
        return;
    }

    int taskId;
    int userId;
    try {
        taskId = Integer.parseInt(taskIdParam);
        userId = Integer.parseInt(userIdParam);
    } catch (NumberFormatException e) {
        System.out.println("<p>Invalid Task ID or User ID format.</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = DBUtil.getConnection();
        String deleteSql = "DELETE FROM tasks WHERE task_id = ?";
        stmt = conn.prepareStatement(deleteSql);
        stmt.setInt(1, taskId);

        int rowsDeleted = stmt.executeUpdate();
        if (rowsDeleted > 0) {
            response.sendRedirect("viewTasks.jsp?user_id=" + userId);
        } else {
            System.out.println("<p>Error deleting task.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>