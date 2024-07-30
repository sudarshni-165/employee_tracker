<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Daily Report</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<form action="ReportServlet" method="post">
    <input type="hidden" name="reportType" value="daily">
    <input type="hidden" name="userId" value="${userId}">
    <label for="date">Date:</label>
    <input type="date" id="date" name="date" required>
    <button type="submit">Generate Report</button>
</form>
<canvas id="dailyChart"></canvas>
<script src="js/charts.js"></script>
<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        event.preventDefault();
        drawDailyChart(document.querySelector('[username=userId]').value, document.querySelector('[username=date]').value);
    });
</script>

<h1>Daily Report</h1>
<!-- Include charts.js and draw the pie chart for daily report -->
<canvas id="dailyChart"></canvas>
<script src="js/charts.js"></script>
</body>
</html>