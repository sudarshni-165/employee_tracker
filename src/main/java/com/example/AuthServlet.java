
package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.print(username+password);        // Dummy authentication logic
        if ("admin".equals(username) && "admin".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "admin");
            response.sendRedirect("addTask.jsp");
        } else if ("user".equals(username) && "user".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "user");
            response.sendRedirect("viewTasks.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}
