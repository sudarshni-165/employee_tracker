<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.User" %>
<%@ page import="com.example.model.Task" %>
<%@ page import="com.dao.TaskDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container">
    <h2>Welcome, <%= user.getUsername() %></h2>
    <a href="logout.jsp">Logout</a>
    <h3>Your Tasks</h3>
    <form action="task" method="post">
        <label for="category">category:</label>
        <input type="text" id="category" name="category" required><br>
        <label for="description">description:</label>
        <input type="text" id="description" name="description" required><br>
        <input type="hidden" name="userId" value="<%= user.getId() %>">
        <button type="submit">Add Task</button>
    </form>
    <table>
        <tr>
            <th>category</th>
            <th>description</th>
            <th>Start Time</th>
            <th>End Time</th>
        </tr>
        <%
            List<Task> tasks = new TaskDAO().getTasksByUserId(user.getId());
            for (Task task : tasks) {
        %>
        <tr>
            <td><%= task.getCategory() %></td>
            <td><%= task.getDescription() %></td>
            <td><%= task.getStartTime() %></td>
            <td><%= task.getEndTime() %></td>
        </tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>