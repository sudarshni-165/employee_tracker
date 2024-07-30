<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.TaskDataUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin View Employee Tasks</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2c2c2c; /* More dark ash color */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #8e44ad; /* Purple color for heading */
            margin-bottom: 20px;
            font-size: 2em;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }

        form {
            background-color: #404040; /* Dark ash color for container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        label {
            margin: 10px 0;
            font-weight: bold;
            color: #f5f5f5; /* Light text color for labels */
        }

        input[type="text"], select {
            padding: 8px;
            border: 1px solid #8e44ad; /* Purple border for inputs */
            border-radius: 4px;
            background-color: #fff; /* White background for inputs */
            color: #333; /* Dark text color for readability */
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
            margin-top: 10px;
        }

        input[type="submit"]:hover, button:hover {
            background: linear-gradient(135deg, #7d3c77, #2980b9); /* Slightly darker gradient for hover effect */
        }

        canvas {
            width: 600px !important;
            height: 600px !important;
            margin-top: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>
<body>
<h1>Admin View Employee Tasks</h1>
<form action="adminCharts.jsp" method="get">
    <label for="user_id">User ID:</label>
    <input type="text" id="user_id" name="user_id" required><br>
    <label for="type">Chart Type:</label>
    <select id="type" name="type" required>
        <option value="daily">Daily</option>
        <option value="weekly">Weekly</option>
        <option value="monthly">Monthly</option>
    </select><br>
    <input type="submit" value="View Chart">
</form>
<%
    String userIdParam = request.getParameter("user_id");
    String type = request.getParameter("type");

    if (userIdParam != null && !userIdParam.trim().isEmpty() && type != null && !type.trim().isEmpty()) {
        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            System.out.println("<p>Invalid User ID format.</p>");
            return;
        }

        List<Map<String, Object>> taskData;
        try {
            taskData = TaskDataUtil.getTaskData(userId, type);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
            return;
        }

        if (taskData.isEmpty()) {
            System.out.println("<p>No data found for the selected criteria.</p>");
        } else {
            StringBuilder labels = new StringBuilder();
            StringBuilder data = new StringBuilder();
            StringBuilder colors = new StringBuilder();

            for (Map<String, Object> dataPoint : taskData) {
                labels.append("'").append(dataPoint.get("label")).append("',");
                data.append(dataPoint.get("duration")).append(",");
                colors.append("'rgba(").append((int)(Math.random() * 255)).append(", ")
                        .append((int)(Math.random() * 255)).append(", ")
                        .append((int)(Math.random() * 255)).append(", 0.8)',"); // Slightly more opaque colors
            }
            if (labels.length() > 0) {
                labels.setLength(labels.length() - 1); // Remove trailing comma
            }
            if (data.length() > 0) {
                data.setLength(data.length() - 1); // Remove trailing comma
            }
            if (colors.length() > 0) {
                colors.setLength(colors.length() - 1); // Remove trailing comma
            }
%>
<canvas id="taskChart"></canvas>
<script>
    var ctx = document.getElementById('taskChart').getContext('2d');
    var chartType = '<%= "daily".equals(type) ? "pie" : "bar" %>';
    var chart = new Chart(ctx, {
        type: chartType,
        data: {
            labels: [<%= labels.toString() %>],
            datasets: [{
                label: 'Task Duration (hours)',
                data: [<%= data.toString() %>],
                backgroundColor: [<%= colors.toString() %>],
                borderColor: 'rgba(255, 255, 255, 0.8)', /* Light border color for contrast */
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: '#f5f5f5' /* Light color for y-axis labels */
                    }
                },
                x: {
                    ticks: {
                        color: '#f5f5f5' /* Light color for x-axis labels */
                    }
                }
            },
            plugins: {
                legend: {
                    labels: {
                        color: '#f5f5f5' /* Light color for legend labels */
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return tooltipItem.label + ': ' + tooltipItem.raw + ' hours';
                        }
                    }
                }
            }
        }
    });
</script>
<%
        }
    }
%>
<div class="button-container">
    <button onclick="window.location.href='index.jsp';">Go Back</button>
</div>
</body>
</html>
