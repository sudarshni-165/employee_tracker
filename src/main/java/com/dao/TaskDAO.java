package com.dao;

import com.example.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public void addTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (date, start_time, end_time, category, description) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(task.getDate().getTime()));
            stmt.setTimestamp(2, task.getStartTime());
            stmt.setTimestamp(3, task.getEndTime());
            stmt.setString(4, task.getCategory());
            stmt.setString(5, task.getDescription());
            stmt.executeUpdate();
        }
    }

    public void editTask(Task task) throws SQLException {
        String sql = "UPDATE tasks SET date=?, start_time=?, end_time=?, category=?, description=? WHERE task_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(task.getDate().getTime()));
            stmt.setTimestamp(2, task.getStartTime());
            stmt.setTimestamp(3, task.getEndTime());
            stmt.setString(4, task.getCategory());
            stmt.setString(5, task.getDescription());
            stmt.setInt(6, task.getTaskId());
            stmt.executeUpdate();
        }
    }

    public void deleteTask(int taskId) throws SQLException {
        String sql = "DELETE FROM tasks WHERE task_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
        }
    }

    public List<Task> getTasksByUserId(int userId) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setUserId(rs.getInt("user_id"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTimestamp("start_time"));
                task.setEndTime(rs.getTimestamp("end_time"));
                task.setCategory(rs.getString("category"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }
        }
        return tasks;
    }

    public List<Task> getTasksByUserIdAndMonth(int userId, String month, String year) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id=? AND MONTH(date)=? AND YEAR(date)=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, Integer.parseInt(month));
            stmt.setInt(3, Integer.parseInt(year));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setUserId(rs.getInt("user_id"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTimestamp("start_time"));
                task.setEndTime(rs.getTimestamp("end_time"));
                task.setCategory(rs.getString("category"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }
        }
        return tasks;
    }
    public List<Task> getTasksByUserIdAndDate(int userId, String date) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id=? AND date=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setDate(2, Date.valueOf(date));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setUserId(rs.getInt("user_id"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTimestamp("start_time"));
                task.setEndTime(rs.getTimestamp("end_time"));
                task.setCategory(rs.getString("category"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }
        }
        return tasks;
    }
    public List<Task> getTasksByUserIdAndDateRange(int userId, String startDate, String endDate) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id=? AND date BETWEEN ? AND ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setDate(2, Date.valueOf(startDate));
            stmt.setDate(3, Date.valueOf(endDate));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setUserId(rs.getInt("user_id"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTimestamp("start_time"));
                task.setEndTime(rs.getTimestamp("end_time"));
                task.setCategory(rs.getString("category"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }
        }
        return tasks;
    }
}
