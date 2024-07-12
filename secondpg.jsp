<%--
  Created by IntelliJ IDEA.
  User: sudarshni
  Date: 10/07/24
  Time: 9:41 am
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: sudarshni
  Date: 10/07/24
  Time: 9:41 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>next page</title>
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
<h1>Click to modify</h1>
<div class="container">
    <div class="button-box">
        <a href="operations.jsp"> <button >Add</button></a>
        <a href="useredit.jsp"><button>Edit</button></a>
        <a href="useredit.jsp"><button>Delete</button></a>
    </div>
</div>

<script>
    function addAction() {
        alert('Add button clicked');
    }

    function editAction() {
        alert('Edit button clicked');
    }

    function deleteAction() {
        alert('Delete button clicked');
    }
</script>
</body>
</html>

