<!DOCTYPE html>
<html>
<head>
    <title>Login Selection</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #1c1c1c, #2a2a2a); /* Gradient dark background */
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            justify-content: center;
            color: #e0e0e0; /* Light text color */
        }

        h1 {
            color: #8e44ad; /* Soft purple color for contrast */
            margin-bottom: 50px;
            font-size: 3em;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7); /* Text shadow for depth */
        }

        .login-container {
            display: flex;
            justify-content: center;
            width: 90%;
            max-width: 800px;
            margin: 0 auto;
            gap: 20px;
        }

        .login-box {
            position: relative;
            background: #2e2e2e; /* Slightly lighter background for the box */
            padding: 30px;
            border: 2px solid #333; /* Darker border for contrast */
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
            width: 45%;
            text-align: center;
            overflow: hidden; /* Ensures the hover effect stays within the box */
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
        }

        .login-box::before {
            content: '';
            position: absolute;
            top: -30px;
            left: -30px;
            right: -30px;
            bottom: -30px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1), rgba(0, 0, 0, 0)); /* Radial gradient light effect */
            border-radius: 20px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .login-box:hover::before {
            opacity: 1;
            transform: scale(1.2);
        }

        .login-box:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.7);
            background: #333; /* Darker background on hover */
        }

        h2 {
            color: #e0e0e0; /* Light text color */
            margin-bottom: 20px;
            font-size: 1.8em;
            font-weight: 500;
        }

        input[type="button"] {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #8e44ad, #3498db); /* Gradient button background */
            color: #fff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1.2em;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        }

        input[type="button"]:hover {
            background: linear-gradient(135deg, #7d3f8c, #2980b9); /* Slightly darker gradient for hover */
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        input[type="button"]:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(142, 68, 173, 0.5); /* Purple focus effect */
        }
    </style>
    <script>
        function redirectTo(page) {
            window.location.href = page;
        }
    </script>
</head>
<body>
<h1>Login Section</h1>
<div class="login-container">
    <div class="login-box" tabindex="0">
        <h2>Employee Login</h2>
        <input type="button" value="Employee Login" onclick="redirectTo('employeelogin.jsp')">
    </div>
    <div class="login-box" tabindex="0">
        <h2>Manager Login</h2>
        <input type="button" value="Manager Login" onclick="redirectTo('managerlogin.jsp')">
    </div>
</div>
</body>
</html>
