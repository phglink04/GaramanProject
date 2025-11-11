<%@ page import="exam.garaman.Model.Customer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Giao Diện Khách Hàng</title>
    <style>
        /* General styling for the body */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E3F2FD; /* Light blue background */
        }
        /* Container styling */

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        /* Title styling */
        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        /* Button styling */
        .btn {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1976D2; /* Vibrant blue for button */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            margin-top: 10px;
            width: 100%;
        }

        /* Hover effect for buttons */
        .btn:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
        }

        /* Form styling to center forms */
        form {
            display: flex;
            justify-content: center;
            margin-bottom: 15px;
        }

        form:last-child {
            margin-bottom: 0;
        }

        /* Logout button styling */
        .btn-logout {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #42A5F5;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            margin-top: 10px;
            width: 100%;
        }

        /* Hover effect for logout button */
        .btn-logout:hover {
            background-color: #1565C0;
        }
    </style>
</head>
<body>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>
<div class="container">
    <h1>Giao Diện Khách Hàng</h1>
    <form action="${pageContext.request.contextPath}/appointment" method="get">
        <button type="submit" class="btn">Tìm Kiếm Dịch Vụ</button>
    </form>

    <form action="${pageContext.request.contextPath}/appointment" method="get">
        <button type="submit" class="btn">Đặt lịch hẹn</button>
    </form>

    <!-- Logout form -->
    <form action="${pageContext.request.contextPath}/login" method="post">
        <button type="submit" class="btn-logout">Đăng xuất</button>
    </form>
</div>
</body>
</html>