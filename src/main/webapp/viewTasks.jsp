<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2c3e50; /* Dark navy background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            color: #ecf0f1; /* Light text color */
        }

        h1 {
            color: #9b59b6; /* Purple color for heading */
            margin-bottom: 20px;
            font-size: 2em; /* Font size adjusted */
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
        }

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        .input-container {
            background-color: #34495e; /* Darker background color for input container */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .input-container label {
            color: #ecf0f1; /* Light color for labels */
            margin-bottom: 10px;
            font-weight: bold;
        }

        .input-container input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #1a252f; /* Dark border */
            border-radius: 4px;
            color: #34495e; /* Dark text inside text boxes */
            background-color: #ecf0f1; /* Light background for text boxes */
        }

        .input-container input[type="submit"] {
            padding: 15px 30px;
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.2em;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }

        .input-container input[type="submit"]:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Slightly darker gradient for hover effect */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        .table-container {
            width: 80%;
            max-width: 1000px;
            margin-bottom: 20px;
            overflow-x: auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #34495e; /* Darker blue-gray border */
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #34495e; /* Darker blue-gray background for table headers */
            color: #ecf0f1; /* Light text color */
        }

        td {
            color: #2c3e50; /* Dark color for text to contrast with white background */
            background-color: #ffffff; /* White background for table cells */
        }

        td:nth-child(odd) {
            background-color: #f9f9f9; /* Light gray background for odd rows */
            color: #2c3e50; /* Dark color for text */
        }


        .button-container {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }

        button:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Slightly darker gradient for hover effect */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        form {
            display: inline;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

    </style>
    <script>
        function goBack() {
            window.location.href = 'addTask.jsp';
        }

        function viewEmployeeChart() {
            window.location.href = 'adminCharts.jsp';
        }
    </script>
</head>
<body>
<h1>View Tasks</h1>

<div class="form-container">
    <div class="input-container">
        <form action="viewTasks.jsp" method="get">
            <label for="user_id">Enter User ID:</label>
            <input type="text" id="user_id" name="user_id" required>
            <input type="submit" value="View Tasks">
        </form>
    </div>
</div>

<%
    String userIdParam = request.getParameter("user_id");

    if (userIdParam != null && !userIdParam.trim().isEmpty()) {
        int userId;
        try {
            userId = Integer.parseInt(userIdParam);

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
<div class='table-container'>
    <table>
        <tr>
            <th>User ID</th>
            <th>Task ID</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Category</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            do {
        %>
        <tr>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getInt("task_id") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getTime("start_time") %></td>
            <td><%= rs.getTime("end_time") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("description") %></td>
            <td class='actions'>
                <form action='editTask.jsp' method='get'>
                    <input type='hidden' name='task_id' value='<%= rs.getInt("task_id") %>'>
                    <input type='hidden' name='user_id' value='<%= rs.getInt("user_id") %>'>
                    <input type='submit' value='Edit'>
                </form>
                <form action='deleteTask.jsp' method='post' onsubmit='return confirm("Are you sure you want to delete this task?");'>
                    <input type='hidden' name='task_id' value='<%= rs.getInt("task_id") %>'>
                    <input type='hidden' name='user_id' value='<%= rs.getInt("user_id") %>'>
                    <input type='submit' value='Delete'>
                </form>
            </td>
        </tr>
        <%
            } while (rs.next());
        %>
    </table>
</div>
<%
                } else {
                    System.out.println("<p>No tasks found for User ID: " + userId + "</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } catch (NumberFormatException e) {
            System.out.println("<p>Invalid User ID format.</p>");
        }
    }
%>

<div class="button-container">
    <button onclick="goBack()">Go Back</button>
    <button onclick="viewEmployeeChart()">View Employee Chart</button>
</div>
</body>
</html>
