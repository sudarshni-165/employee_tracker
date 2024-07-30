package com.example;

import com.dao.TaskDAO;
import com.example.model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addTask(request, response);
                    break;
                case "edit":
                    editTask(request, response);
                    break;
                case "delete":
                    deleteTask(request, response);
                    break;
                default:
                    throw new ServletException("Invalid action: " + action);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Task task = new Task();
        task.setUserId(getUserId(request));

        task.setDate(java.sql.Date.valueOf(request.getParameter("date"))); // Assuming date is in "yyyy-MM-dd"
        task.setStartTime(convertToTimestamp(request.getParameter("startTime"))); // Assuming format "HH:mm:ss" or "HH:mm"
        task.setEndTime(convertToTimestamp(request.getParameter("endTime"))); // Same format
        task.setCategory(request.getParameter("category"));
        task.setDescription(request.getParameter("description"));
        taskDAO.addTask(task);
        response.sendRedirect("viewTasks.jsp");
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Task task = new Task();
        task.setTaskId(Integer.parseInt(request.getParameter("taskId")));
        task.setUserId(getUserId(request));
        task.setDate(java.sql.Date.valueOf(request.getParameter("date"))); // Assuming date is in "yyyy-MM-dd"
        task.setStartTime(convertToTimestamp(request.getParameter("startTime"))); // Assuming format "HH:mm:ss" or "HH:mm"
        task.setEndTime(convertToTimestamp(request.getParameter("endTime"))); // Same format
        task.setCategory(request.getParameter("category"));
        task.setDescription(request.getParameter("description"));
        taskDAO.editTask(task);
        response.sendRedirect("viewTasks.jsp");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        taskDAO.deleteTask(taskId);
        response.sendRedirect("viewTasks.jsp");
    }

    private int getUserId(HttpServletRequest request) {
        // Dummy logic to get user ID; replace with actual logic.
        return 1; // Replace with actual user ID retrieval logic
    }

    private Timestamp convertToTimestamp(String timeStr) {
        LocalDate currentDate = LocalDate.now();
        LocalTime time;

        if (timeStr.length() == 5) {
            // Format "HH:mm"
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            time = LocalTime.parse(timeStr, timeFormatter);
        } else if (timeStr.length() == 8) {
            // Format "HH:mm:ss"
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            time = LocalTime.parse(timeStr, timeFormatter);
        } else {
            throw new IllegalArgumentException("Invalid time format: " + timeStr);
        }

        LocalDateTime dateTime = LocalDateTime.of(currentDate, time);
        return Timestamp.valueOf(dateTime);
    }
}