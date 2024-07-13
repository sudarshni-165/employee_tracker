<!DOCTYPE html>
<html>
<head>
    <title>Operations</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
        .form-box {
            text-align: center;
            background-color: #f0f0f0;
            padding: 30px;
            border-radius: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 500px;
        }
        .form-box input, .form-box select, .form-box textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-box button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-box button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-box">
        <h2>Add Information</h2>
        <form action="test" method="post">
            <label for ="user_id">User ID:</label>
            <input type="text" id="user_id" placeholder="User ID" name="user_id" required>
            <label for ="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Password" required>
            <label for ="Employeename">Employee Name:</label>
            <input type="text" id="Employeename" name="Employeename" placeholder="Employee Name" required>
            <label for ="role">Role:</label>
            <input type="text" id="role" name="role" placeholder="Role" required>
            <label for ="date">Date:</label>
            <input type="date" id = "date" name="date" placeholder="Date" required>
            <label for ="starttime">Start time:</label>
            <input type="time" id = "starttime" name="starttime" placeholder="starting time" required>
            <label for ="endtime">End time:</label>
            <input type="time" id = "endtime" name="endtime" placeholder="Ending time" required>
            <label for ="task_category">Task Category:</label>
            <input type="text" id = "task_category"name="task_category" placeholder="Task Category" required>
            <label for ="description">Description of the session:</label>
            <textarea name="description" id="description" placeholder="Description of Task" required></textarea>
            <input type="text" name="project" placeholder="Project Name" required>
            <button type="submit">Submit</button>
        </form>
    </div>
</div>
</body>
</html>
