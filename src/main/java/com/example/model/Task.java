package com.example.model;

import java.sql.Timestamp;
import java.util.Date;

public class Task {
    private int taskId;
    private int userId;
    private String taskName;
    private String description;
    private Date date; // Assuming this is java.util.Date
    private Timestamp startTime; // Change to Timestamp
    private Timestamp endTime; // Change to Timestamp
    private String category;

    public long getDuration() {
        if (startTime != null && endTime != null) {
            return (endTime.getTime() - startTime.getTime()) / (1000 * 60); // Duration in minutes
        }
        return 0; // Or handle it as per your requirement
    }

    // Getters and setters
    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


}