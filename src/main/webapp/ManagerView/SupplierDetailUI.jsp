<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="exam.garaman.Model.StatsSupplier" %>
<%@ page import="exam.garaman.Model.StatsImport" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Chi Tiết Nhà Cung Cấp</title>
    <style>
        /* General styling for the body */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #FAF3E0; /* Light, warm background color */
        }

        /* Label styling */
        .supplier-name {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #BF360C; /* Rich color */
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #D84315;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Button styling */
        .btn-back {
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #8D6E63; /* Muted brown color */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: block;
            width: 100px;
            text-align: center;
        }

        /* Hover effect for back button */
        .btn-back:hover {
            background-color: #6D4C41;
        }
    </style>
</head>
<body>
<%
    StatsSupplier selectedSupplier = (StatsSupplier) session.getAttribute("selectedSupplier");
    List<StatsImport> entries = (List<StatsImport>) request.getAttribute("entriesList");
%>

<h1>Tên Nhà Cung Cấp: <%= selectedSupplier != null ? selectedSupplier.getNameSupplier() : "Không xác định" %></h1>

<table>
    <thead>
    <tr>
        <th>ID Lần Nhập</th>
        <th>Số Lượng Hàng Nhập</th>
        <th>Tổng Tiền</th>
        <th>Thời Gian</th>
        <th>Xem Hóa Đơn</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (entries != null && !entries.isEmpty()) {
            for (StatsImport e : entries) {
    %>
    <tr>
        <td><%= e.getId() %></td>
        <td><%= e.getQuantity() %></td>
        <td><%= e.getTotal() %></td>
        <td><%= e.getTime() %></td>
        <td>
            <form action="${pageContext.request.contextPath}/ImportDetail" method="post">
                <input type="hidden" name="idLannhap" value="<%= e.getId() %>" />
                <button type="submit">Xem Hóa Đơn</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="5" style="text-align:center;">Không có dữ liệu lần nhập</td></tr>
    <% } %>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/ManagerView/StatsSupplierUI.jsp" class="btn-back">Quay Lại</a>
</body>
</html>