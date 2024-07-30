<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee View Tasks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2c2c2c; /* Dark ash color */
            margin: 0;
            padding: 20px;
            color: #f5f5f5; /* Light text color */
        }

        h1 {
            color: #8e44ad; /* Purple color for heading */
            font-size: 2em;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #404040; /* Dark ash color for form background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #444; /* Dark border color */
        }

        th, td {
            padding: 10px;
            text-align: left;
            color: #f5f5f5; /* Light text color */
        }

        th {
            background-color: #333; /* Slightly lighter dark ash for header */
        }

        input[type="submit"], button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background 0.3s;
            margin-top: 20px;
            margin-right: 10px;
        }

        input[type="submit"]:hover, button:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Darker gradient for hover effect */
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .centered-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="centered-container">
    <h1>Employee View Tasks</h1>
    <%
        String userIdParam = request.getParameter("user_id");
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
    %>
    <p>No User ID provided.</p>
    <%
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
    %>
    <p>Invalid User ID format.</p>
    <%
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String querySql = "SELECT * FROM Tasks WHERE user_id = ?";
            stmt = conn.prepareStatement(querySql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
    <form action='employeeViewTasks.jsp' method='post'>
        <input type='hidden' name='user_id' value='<%= userId %>'>
        <table>
            <tr>
                <th>Task ID</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Category</th>
                <th>Description</th>
                <th>Completed</th>
            </tr>
            <%
                do {
                    int taskId = rs.getInt("task_id");
                    boolean isCompleted = rs.getBoolean("completed");
            %>
            <tr>
                <td><%= taskId %></td>
                <td><%= rs.getDate("date") %></td>
                <td><%= rs.getTime("start_time") %></td>
                <td><%= rs.getTime("end_time") %></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <input type='checkbox' name='task_<%= taskId %>' value='completed' <%= isCompleted ? "checked" : "" %>>
                </td>
            </tr>
            <%
                } while (rs.next());
            %>
        </table>
        <input type='submit' value='Update Completion Status'>
    </form>
    <%
    } else {
    %>
    <p>No tasks found for User ID: <%= userId %></p>
    <%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    %>
    <p>Error: <%= e.getMessage() %></p>
    <%
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        if (request.getMethod().equalsIgnoreCase("POST")) {
            userIdParam = request.getParameter("user_id");
            if (userIdParam != null && !userIdParam.trim().isEmpty()) {
                try {
                    userId = Integer.parseInt(userIdParam);

                    conn = DBUtil.getConnection();
                    String querySql = "SELECT task_id FROM Tasks WHERE user_id = ?";
                    stmt = conn.prepareStatement(querySql);
                    stmt.setInt(1, userId);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int taskId = rs.getInt("task_id");
                        boolean isCompleted = request.getParameter("task_" + taskId) != null;

                        String updateSql = "UPDATE Tasks SET completed = ? WHERE task_id = ?";
                        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                        updateStmt.setBoolean(1, isCompleted);
                        updateStmt.setInt(2, taskId);
                        updateStmt.executeUpdate();
                        updateStmt.close();
                    }
    %>
    <p>Task completion status updated successfully.</p>
    <%
    } catch (SQLException e) {
        e.printStackTrace();
    %>
    <p>Error: <%= e.getMessage() %></p>
    <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        }
    %>
    <div class="button-container">
        <button onclick="window.location.href='index.jsp';">Go Back</button>
        <button onclick="window.location.href='adminCharts.jsp';">View Chart</button>
    </div>
</div>
</body>
</html>
