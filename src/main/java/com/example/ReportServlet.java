package com.example;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.model.Task;
import com.dao.TaskDAO;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            Map<String, Long> reportData;
            switch (reportType) {
                case "daily":
                    String date = request.getParameter("date");
                    reportData = getDailyReport(userId, date);
                    break;
                case "weekly":
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    reportData = getWeeklyReport(userId, startDate, endDate);
                    break;
                case "monthly":
                    String month = request.getParameter("month");
                    String year = request.getParameter("year");
                    reportData = getMonthlyReport(userId, month, year);
                    break;
                default:
                    throw new IllegalArgumentException("Invalid report type");
            }

            String json = convertMapToJson(reportData);
            response.setContentType("application/json");
            response.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private Map<String, Long> getDailyReport(int userId, String date) throws SQLException {
        List<Task> tasks = taskDAO.getTasksByUserIdAndDate(userId, date);
        return tasks.stream()
                .collect(Collectors.groupingBy(Task::getCategory, Collectors.summingLong(Task::getDuration)));
    }

    private Map<String, Long> getWeeklyReport(int userId, String startDate, String endDate) throws SQLException {
        List<Task> tasks = taskDAO.getTasksByUserIdAndDateRange(userId, startDate, endDate);
        return tasks.stream()
                .collect(Collectors.groupingBy(Task::getCategory, Collectors.summingLong(Task::getDuration)));
    }

    private Map<String, Long> getMonthlyReport(int userId, String month, String year) throws SQLException {
        List<Task> tasks = taskDAO.getTasksByUserIdAndMonth(userId, month, year);
        return tasks.stream()
                .collect(Collectors.groupingBy(Task::getCategory, Collectors.summingLong(Task::getDuration)));
    }

    private String convertMapToJson(Map<String, Long> reportData) {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{");
        for (Map.Entry<String, Long> entry : reportData.entrySet()) {
            jsonBuilder.append("\"").append(entry.getKey()).append("\":").append(entry.getValue()).append(",");
        }
        // Remove the last comma if present
        if (jsonBuilder.length() > 1) {
            jsonBuilder.setLength(jsonBuilder.length() - 1);
        }
        jsonBuilder.append("}");
        return jsonBuilder.toString();
    }
}