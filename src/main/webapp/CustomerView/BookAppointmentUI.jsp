<%@ page import="exam.garaman.Model.Customer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Đặt Lịch Hẹn</title>
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

        /* Input styling */
        input[type="text"], input[type="tel"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #dddddd;
            border-radius: 6px;
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
<div class="container">
    <h1>Đặt Lịch Hẹn</h1>

    <form action="${pageContext.request.contextPath}/appointment" method="post">

        <label for="appointmentDate">Chọn Ngày:</label>
        <input type="date" id="appointmentDate" name="appointmentDate" required>

        <label for="appointmentTime">Chọn Giờ:</label>
        <select id="appointmentTime" name="appointmentTime" required>
            <option value="">--Chọn Giờ--</option>
            <option value="08:00">08:00</option>
            <option value="08:30">08:30</option>
            <option value="09:00">09:00</option>
            <option value="09:30">09:30</option>
            <option value="10:00">10:00</option>
            <option value="10:30">10:30</option>
            <option value="11:00">11:00</option>
            <option value="11:30">11:30</option>
            <option value="12:00">12:00</option>
            <option value="13:00">13:00</option>
            <option value="13:30">13:30</option>
            <option value="14:00">14:00</option>
            <option value="14:30">14:30</option>
            <option value="15:00">15:00</option>
            <option value="15:30">15:30</option>
            <option value="16:00">16:00</option>
            <option value="16:30">16:30</option>
            <option value="17:00">17:00</option>
        </select>

        <label for="customerName">Họ Tên:</label>
        <input type="text" id="customerName" name="customerName" required>

        <label for="address">Địa Chỉ:</label>
        <input type="text" id="address" name="address" required>

        <label for="phone">Số Điện Thoại:</label>
        <input type="tel" id="phone" name="phone" required pattern="[0-9]{10}" title="Nhập đúng định dạng số điện thoại (10 số)">

        <button type="submit" class="btn">Đặt Lịch</button>
    </form>
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>

    <script>
        window.onload = function() {
            <% if (successMessage != null) { %>
            alert("<%= successMessage %>");
            window.location.href = "<%= request.getContextPath() %>/CustomerView/CustomerMainUI.jsp";
            <% } else if (errorMessage != null) { %>
            alert("<%= errorMessage %>");
            <% } %>
        };
    </script>
</div>

</body>
</html>