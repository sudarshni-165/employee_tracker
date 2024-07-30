<!DOCTYPE html>
<html>
<head>
    <title>Manager Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background: #2e2e2e; /* Dark ash background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: #e0e0e0; /* Light text color */
        }

        h1 {
            margin-bottom: 30px;
            color: #8e44ad; /* Purple for heading */
            font-size: 2.5em;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5); /* Enhanced text shadow */
            font-weight: 700;
        }

        .login-box {
            position: relative;
            background-color: #263238; /* Darker background color */
            padding: 30px;
            border: 2px solid #1b2a38; /* Darker border for a subtle outline */
            border-radius: 15px; /* Rounded corners */
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5); /* Enhanced shadow for depth */
            width: 320px;
            text-align: center;
            overflow: hidden;
            transition: box-shadow 0.3s ease, background-color 0.3s ease;
        }

        .login-box:hover {
            background-color: #2c3e50; /* Slightly lighter background on hover */
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.7); /* More prominent shadow */
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #e0e0e0; /* Light color for labels */
        }

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #1b2a38;
            border-radius: 8px;
            color: #263238; /* Darker text inside text boxes */
            background-color: #e0e0e0; /* Light background for text boxes */
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #8e44ad; /* Purple border on focus */
            outline: none;
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient for submit button */
            color: #ffffff;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #7d3f8c, #2980b9); /* Darker gradient for hover effect */
            transform: scale(1.03);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        input[type="button"] {
            margin-top: 10px;
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Purple to blue gradient for back button */
            color: #ffffff;
        }

        input[type="button"]:hover {
            background: linear-gradient(135deg, #7d3f8c, #2980b9); /* Darker gradient for hover effect */
            transform: scale(1.03);
        }
    </style>
    <script>
        function goBack() {
            window.location.href = 'index.jsp';
        }

        function redirectToAddTask() {
            window.location.href = 'addView.jsp';
        }
    </script>
</head>
<body>
<h1>Manager Login</h1>
<div class="login-box">
    <form onsubmit="redirectToAddTask(); return false;">
        <label for="manager-username">Username:</label>
        <input type="text" id="manager-username" name="username" required><br>
        <label for="manager-password">Password:</label>
        <input type="password" id="manager-password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <input type="button" value="Go Back" onclick="goBack()">
</div>
</body>
</html>
