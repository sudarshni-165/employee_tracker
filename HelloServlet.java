package com.example.sec2;

import java.io.IOException;
import java.sql.SQLException;
import com.example.dao.jdbc;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "HelloServlet", value = "/login-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Vanthuten";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String acc = request.getParameter("accountNo");
        String pass = request.getParameter("password");
        jdbc j = new jdbc();

        try {
            if (j.checkPassword(Integer.parseInt(acc), pass)) {
                System.out.println(message);
                response.sendRedirect("secondpg.jsp");
            } else {
                response.sendRedirect("index.jsp");
                System.out.println("Wrong password or user id doesn't match");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void destroy() {
    }
}
