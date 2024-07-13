package com.example.sec2;

import com.example.dao.jdbc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/test")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Test Servlet is working");

        String userId = request.getParameter("user_id");
        String password = request.getParameter("password");
        String userName = request.getParameter("Employeename");
        String role = request.getParameter("role");
        String date = request.getParameter("date");
        String taskCategory = request.getParameter("task_category");
        String description = request.getParameter("description");
        String project = request.getParameter("project");
        String startTime = request.getParameter("starttime");
        String endTime = request.getParameter("endtime");

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

   if (!isValidUserId(userId)) {
       out.println(userId);
            out.println("Invalid User ID: Must be an integer with up to 5 digits.");
            out.flush();
            return;
       }

        if (!isValidPassword(password)) {
            out.println("Invalid Password: Must be an integer with up to 4 digits.");
            out.flush();
            return;
        }

        try {
            jdbc j = new jdbc();
            boolean result = j.addUser(
                    String.valueOf(Integer.parseInt(userId)),
                    password,
                    userName,
                    role,
                    date,
                    taskCategory,
                    description,
                    project,
                    startTime,
                    endTime
            );

            if (result) {
                out.println(userName);
                out.println("Success: Data received.");
            } else {
                out.println("Failure: Failed to insert data.");
            }
        } catch (SQLException e) {

            out.println("Database error: " + e.getMessage());
        }
    }

    private boolean isValidUserId(String userId) {

        try {
            int id = Integer.parseInt(userId);
            System.out.println(id);
            return 10000 <= id && id <= 99999;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isValidPassword(String password) {
        try {
            int pass = Integer.parseInt(password);
            return String.valueOf(pass).length() <= 4;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
