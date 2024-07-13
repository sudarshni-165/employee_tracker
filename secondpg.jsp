<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Next Page</title>
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

        .button-box {
            text-align: center;
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .button-box button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-box button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<h1>Click to Modify</h1>
<div class="container">
    <div class="button-box">
        <a href="operations.jsp"><button>Add</button></a>
        <a href="useredit.jsp"><button>Edit</button></a>
        <a href="useredit.jsp"><button>Delete</button></a>
    </div>
</div>
</body>
</html>
