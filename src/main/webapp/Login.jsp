<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Đăng nhập</title>
    <style>
        /* Main body styling */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E3F2FD; /* Light blue background */
        }

        /* Container for the login form */
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 420px;
            text-align: center;
        }

        /* Logo and heading styling */
        .logo img {
            width: 300px;
            margin-bottom: 20px;
        }

        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        /* Label styling */
        label {
            font-size: 15px;
            color: #0D47A1; /* Deep blue for labels */
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-weight: bold;
        }

        /* Input styling */
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #90CAF9;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #E3F2FD; /* Light blue for inputs */
        }

        /* Button styling */
        .btn-login {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1976D2; /* Vibrant blue for button */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        /* Hover effect for button */
        .btn-login:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
        }

        /* Error message styling */
        .error {
            color: #D32F2F; /* Red for error message */
            font-size: 14px;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Logo Section -->
    <!-- Page Title -->
    <h1>Đăng nhập</h1>

    <!-- Login Form -->
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username"
                   placeholder="Nhập tên đăng nhập" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password"
                   placeholder="Nhập mật khẩu" required>
        </div>

        <button type="submit" class="btn-login">Đăng nhập</button>
    </form>

        <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <p style="color: red;"><%= errorMessage %></p>
        <%
        }
    %>

</body>
</html>