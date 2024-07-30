<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif; /* Modern font */
            background-color: #2e2e2e; /* Dark ash background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: #ecf0f1; /* Light text color for contrast */
        }

        h1 {
            color: #8e44ad; /* Soft purple color for heading */
            margin-bottom: 40px;
            font-size: 2.5em;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5); /* Enhanced shadow for depth */
            font-weight: 700;
        }

        .button-box {
            background: linear-gradient(135deg, #1c1c1c, #2e2e2e); /* Gradient box background */
            border-radius: 15px;
            padding: 60px 40px; /* Increased padding for a larger container */
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5); /* Shadow for depth */
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px; /* Space between buttons */
            transition: background 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transitions */
        }

        .button-box:hover {
            background: linear-gradient(135deg, #2e2e2e, #3a3a3a); /* Slightly lighter gradient on hover */
            transform: scale(1.05); /* Slightly larger box on hover */
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.7); /* More prominent shadow on hover */
        }

        .button {
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Gradient button background */
            color: #ffffff;
            border: none;
            border-radius: 10px; /* Rounded corners */
            padding: 15px 30px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            text-align: center;
            display: inline-block;
            text-decoration: none; /* Remove underline from links */
        }

        .button:hover {
            background: linear-gradient(135deg, #7d3f8c, #2980b9); /* Slightly darker gradient on hover */
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Box shadow for depth */
        }

        .button:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(142, 68, 173, 0.5); /* Purple focus effect */
        }
    </style>
</head>
<body>
<h1>Task Management</h1>
<div class="button-box">
    <a href="addTask.jsp" class="button">Add Task</a>
    <a href="viewTasks.jsp" class="button">View Tasks</a>
</div>
</body>
</html>
