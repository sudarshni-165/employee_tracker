package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaskDataUtil {

    public static List<Map<String, Object>> getTaskData(int userId, String type) throws SQLException {
        List<Map<String, Object>> taskData = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String querySql = "";
            switch (type) {
                case "daily":
                    querySql = "SELECT date, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS duration " +
                            "FROM tasks WHERE user_id = ? GROUP BY date";
                    break;
                case "weekly":
                    querySql = "SELECT YEARWEEK(date, 1) AS week, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS duration " +
                            "FROM tasks WHERE user_id = ? GROUP BY week";
                    break;
                case "monthly":
                    querySql = "SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS duration " +
                            "FROM tasks WHERE user_id = ? GROUP BY month";
                    break;
            }
            stmt = conn.prepareStatement(querySql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> dataPoint = new HashMap<>();
                if ("daily".equals(type)) {
                    dataPoint.put("label", rs.getDate("date").toString());
                } else if ("weekly".equals(type)) {
                    dataPoint.put("label", "Week " + rs.getInt("week"));
                } else if ("monthly".equals(type)) {
                    dataPoint.put("label", rs.getString("month"));
                }
                dataPoint.put("duration", rs.getInt("duration") / 60.0); // Convert minutes to hours
                taskData.add(dataPoint);
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return taskData;
    }
}