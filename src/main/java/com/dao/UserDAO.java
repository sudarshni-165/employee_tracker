package com.dao;

import com.example.model.User;
import com.example.model.Task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // Method to get User by username and password
    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<Task> getTasksByUserId(int userId) {
        List<Task> tasks = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM tasks WHERE user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Task task = new Task();
                task.setTaskId(resultSet.getInt("task_id"));
                task.setUserId(resultSet.getInt("user_id"));
                task.setDate(resultSet.getDate("date"));
                task.setStartTime(resultSet.getTimestamp("start_time"));
                task.setEndTime(resultSet.getTimestamp("end_time"));
                task.setCategory(resultSet.getString("category"));
                task.setDescription(resultSet.getString("description"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public static List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM tasks";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Task task = new Task();
                task.setTaskId(resultSet.getInt("id"));
                task.setUserId(resultSet.getInt("user_id"));
                task.setTaskName(resultSet.getString("task_name"));
                task.setDescription(resultSet.getString("task_description"));
                task.setStartTime(resultSet.getTimestamp("start_time"));
                task.setEndTime(resultSet.getTimestamp("end_time"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public void saveTask(Task task) {
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "INSERT INTO tasks (user_id, task_name, task_description, start_time, end_time) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, task.getUserId());
            statement.setString(2, task.getTaskName());
            statement.setString(3, task.getDescription());
            statement.setTimestamp(4, task.getStartTime());
            statement.setTimestamp(5, task.getEndTime()); // End time can be null initially
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}