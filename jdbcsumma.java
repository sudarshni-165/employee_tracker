package com.example.dao;

import java.sql.*;
public class jdbc {
    // Assuming you have a method to get the database connection
    private Statement statement;
    public String username;
    Connection conn = null;

    public jdbc (){

        try {
            String username = "root";
            String password = "Tiger.01";
            String url = "jdbc:mysql://localhost:3306/Emp";
            conn = DriverManager.getConnection(url, username, password);
            statement = conn.createStatement();
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            System.out.println("Vendor Error: " + e.getErrorCode());
        }

    }


    public boolean addUser(String user_id, String password, String employeename, String role, String date,
                           String taskCategory, String description, String project, String startTime, String endTime)throws SQLException {
        String sql = "INSERT INTO user_Table (user_id,password,Employeename, project, role, starttime, endtime, taskCategory, description, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user_id);
            stmt.setString(2, password);
            stmt.setString(3, employeename);
            stmt.setString(4, project);
            stmt.setString(5, role);
            stmt.setString(6, startTime);
            stmt.setString(7, endTime);
            stmt.setString(8, taskCategory);
            stmt.setString(9, description);
            stmt.setString(10, date);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public boolean checkPassword(int user_id, String password) throws SQLException {
        ResultSet resultSet = statement.executeQuery(
                "SELECT password, user_id FROM user_Table WHERE user_id = " + user_id
        );
        resultSet.next();

        if (resultSet.getString("password").equals(password)) {
            System.out.println("Password Matched");
            username = resultSet.getString("user_id");
            return true;
        }

        System.out.println("Password Not Matched");
        return false;
    }
}



