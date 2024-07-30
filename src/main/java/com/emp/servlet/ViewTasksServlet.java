package com.emp.servlet;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;


@WebServlet("/viewTasks")
public class ViewTasksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");

        // Retrieve tasks for the given user ID from the database or any data source
        // For demonstration, let's assume we have some tasks as a string
        String tasks = getTasksForUser(userId);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>View Tasks</title></head><body>");
        out.println("<h1>Tasks for User ID: " + userId + "</h1>");
        out.println("<p>" + tasks + "</p>");
        out.println("</body></html>");
    }

    private String getTasksForUser(String userId) {
        // Dummy data for demonstration purposes
        // In a real application, you would query the database for the tasks
        if (userId.equals("123")) {
            return "Task 1, Task 2, Task 3";
        } else {
            return "No tasks found for this user ID.";
        }
    }
}
