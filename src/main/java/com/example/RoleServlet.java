package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RoleServlet")
public class RoleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        switch (role) {
            case "admin":
                handleAdminAction(request, response, action);
                break;
            case "user":
                handleUserAction(request, response, action);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    private void handleAdminAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws IOException, ServletException {
        switch (action) {
            case "viewReports":
                request.getRequestDispatcher("adminReports.jsp").forward(request, response);
                break;
            case "manageUsers":
                request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("adminDashboard.jsp");
        }
    }

    private void handleUserAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws IOException, ServletException {
        switch (action) {
            case "viewTasks":
                request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
                break;
            case "addTask":
                request.getRequestDispatcher("addTask.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("userDashboard.jsp");
        }
    }
}