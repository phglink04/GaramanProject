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
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #FAF3E0; /* Light, warm background color */
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Container styling */
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        /* Title styling */
        h1 {
            color: #BF360C; /* Rich color */
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* Button styling */
        .btn {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #D84315;
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
            background-color: #BF360C;
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
</div>
</body>
</html>