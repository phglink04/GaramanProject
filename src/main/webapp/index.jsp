<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Trang Chủ</title>
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

        /* Container for the content */
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 420px;
            text-align: center;
        }

        /* Heading styling */
        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        /* Link styling */
        a {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1976D2; /* Vibrant blue for button */
            border: none;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        /* Hover effect for link */
        a:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Chào mừng đến với GaraMan!</h1>
    <a href="Login.jsp">Đăng nhập vào hệ thống</a>
</div>
</body>
</html>