<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2e2e2e; /* Dark ash background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: #ecf0f1; /* Light text color */
        }

        h1 {
            color: #8e44ad; /* Soft purple color for heading */
            margin-bottom: 20px;
            font-size: 2em;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5); /* Enhanced shadow for depth */
            text-align: center;
        }

        .form-container {
            background: linear-gradient(135deg, #34495e, #2c3e50); /* Dark gradient background for form */
            padding: 30px;
            border: 1px solid #1a252f; /* Dark border */
            border-radius: 10px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5); /* Shadow for depth */
            width: 350px; /* Increased width for a better layout */
            text-align: center;
            transition: background 0.3s ease; /* Smooth background transition on hover */
        }

        .form-container:hover {
            background: linear-gradient(135deg, #2c3e50, #34495e); /* Slightly lighter gradient on hover */
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #ecf0f1; /* Light color for labels */
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #1a252f; /* Dark border */
            border-radius: 5px;
            color: #34495e; /* Dark text inside text boxes */
            background-color: #ecf0f1; /* Light background for text boxes */
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
            color: #ffffff; /* White text color */
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient */
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Slightly darker gradient for hover effect */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        input[type="button"] {
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient */
            margin-top: 10px;
        }

        input[type="button"]:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Slightly darker gradient for hover effect */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        textarea {
            resize: vertical; /* Allow vertical resize for textarea */
            height: 100px; /* Set a minimum height for textarea */
        }
    </style>
    <script>
        function goBack() {
            window.location.href = 'addView.jsp';
        }
    </script>
</head>
<body>
<h1>Add Task</h1>
<div class="form-container">
    <form action="addTask.jsp" method="post">
        <label for="user_id">User ID:</label>
        <input type="text" id="user_id" name="user_id" required><br>

        <label for="role">Role:</label>
        <input type="text" id="role" name="role" required><br>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br>

        <label for="start_time">Start Time:</label>
        <input type="time" id="start_time" name="start_time" required><br>

        <label for="end_time">End Time:</label>
        <input type="time" id="end_time" name="end_time" required><br>

        <label for="category">Category:</label>
        <input type="text" id="category" name="category" required><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br>

        <input type="submit" value="Add Task">
    </form>
    <input type="button" value="Go Back" onclick="goBack()">
</div>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String message = "";
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String role = request.getParameter("role");
            Date date = Date.valueOf(request.getParameter("date"));
            Time startTime = Time.valueOf(request.getParameter("start_time") + ":00");
            Time endTime = Time.valueOf(request.getParameter("end_time") + ":00");
            String category = request.getParameter("category");
            String description = request.getParameter("description");

            conn = DBUtil.getConnection();

            // Validate the user ID and role
            String validateUserSql = "SELECT role FROM users WHERE userid = ?";
            stmt = conn.prepareStatement(validateUserSql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String userRole = rs.getString("role");

                if (userRole.equals(role)) {
                    // Insert task if validation is successful
                    String insertSql = "INSERT INTO tasks (user_id, role, date, start_time, end_time, category, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(insertSql);
                    stmt.setInt(1, userId);
                    stmt.setString(2, role);
                    stmt.setDate(3, date);
                    stmt.setTime(4, startTime);
                    stmt.setTime(5, endTime);
                    stmt.setString(6, category);
                    stmt.setString(7, description);

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        message = "Successfully added the task.";
                    } else {
                        message = "Error adding task.";
                    }
                } else {
                    message = "Role does not match the user ID.";
                }
            } else {
                message = "User ID does not exist.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
%>
<p><%= message %></p>
<%
    }
%>
</body>
</html>
