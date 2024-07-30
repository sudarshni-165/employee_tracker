
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.TaskDataUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Charts</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h1>Task Charts</h1>
<%
    String userIdParam = request.getParameter("user_id");
    String type = request.getParameter("type");
    

    if (userIdParam == null || userIdParam.trim().isEmpty() || type == null || type.trim().isEmpty()) {
        System.out.println("<p>Invalid parameters.</p>");
        return;
    }

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
        return;
    }

    String labels = "";
    String data = "";
    for (Map<String, Object> dataPoint : taskData) {
        labels += "'" + dataPoint.get("label") + "',";
        data += dataPoint.get("duration") + ",";
    }
    labels = labels.substring(0, labels.length() - 1); // Remove trailing comma
    data = data.substring(0, data.length() - 1); // Remove trailing comma
%>
<canvas id="taskChart"></canvas>
<script>
    var ctx = document.getElementById('taskChart').getContext('2d');
    var chartType = '<%= "daily".equals(type) ? "pie" : "bar" %>';
    var chart = new Chart(ctx, {
        type: chartType,
        data: {
            labels: [<%= labels %>],
            datasets: [{
                label: 'Task Duration (hours)',
                data: [<%= data %>],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
