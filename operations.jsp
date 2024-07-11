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
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
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
            <input type="text" name="user_id" placeholder="User ID" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="user_name" placeholder="User Name" required>
            <input type="text" name="role" placeholder="Role" required>
            <input type="date" name="date" placeholder="Date" required>
            <input type="text" name="task_category" placeholder="Task Category" required>
            <textarea name="description" placeholder="Description of Task" required></textarea>
            <input type="text" name="project" placeholder="Project Name" required>
            <button type="submit">Submit</button>
        </form>
    </div>
</div>
</body>
</html>
