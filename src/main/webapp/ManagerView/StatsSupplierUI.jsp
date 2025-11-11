<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.Date, java.util.List" %>
<%@ page import="exam.garaman.Model.StatsSupplier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Danh Sách Nhà Cung Cấp</title>
    <style>
        /* General styling for the body */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #E3F2FD; /* Light blue background */
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        th, td {
            border: 1px solid #90CAF9; /* Light blue border */
            /*text-align: left;*/
            padding: 12px;
        }

        th {
            background-color: #1976D2; /* Vibrant blue for header */
            color: white;
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: #E3F2FD; /* Light blue for alternate rows */
        }

        /* Button styling */
        .btn-back {
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #42A5F5; /* Lighter blue */
            border: none;
            border-bottom: 3px solid #0D47A1; /* Add underline border */
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: block;
            width: 100px;
            text-align: center;
            text-decoration: none;
        }

        .btn-back:hover {
            background-color: #1976D2; /* Darker blue on hover */
        }

        .date-info {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }

        /* Title styling */
        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: 700;
            text-align: center;
        }

        /* Currency formatting */
        .currency {
            text-align: right;
        }

        /* Button styling to match SupplierDetailUI.jsp */
        button {
            padding: 8px 12px;
            background-color: #0277BD;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        button:hover {
            background-color: #01579B;
        }
    </style>
    <script>
        // Function to format number with comma separators
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount) + ' VND';
        }

        // Function to format date to dd-mm-yyyy
        function formatDate(dateString) {
            if (!dateString || dateString === 'N/A') return dateString;

            // Check if date is already in dd-mm-yyyy format
            if (dateString.match(/^\d{2}-\d{2}-\d{4}$/)) {
                return dateString;
            }

            // Convert yyyy-mm-dd to dd-mm-yyyy
            if (dateString.match(/^\d{4}-\d{2}-\d{2}$/)) {
                const parts = dateString.split('-');
                return parts[2] + '-' + parts[1] + '-' + parts[0];
            }

            return dateString;
        }

        // Apply formatting when page loads
        window.onload = function() {
            // Format currency
            const currencyCells = document.querySelectorAll('.currency');
            currencyCells.forEach(function(cell) {
                const amount = parseInt(cell.textContent);
                if (!isNaN(amount)) {
                    cell.textContent = formatCurrency(amount);
                }
            });

            // Format dates
            const dateSpans = document.querySelectorAll('.date-span');
            dateSpans.forEach(function(span) {
                span.textContent = formatDate(span.textContent.trim());
            });
        };
    </script>
</head>
<body>
<h1>THỐNG KÊ NHÀ CUNG CẤP THEO LƯỢNG HÀNG NHẬP</h1>

<%
    String startDate = (String) session.getAttribute("startDate");
    String endDate = (String) session.getAttribute("endDate");
%>

<div class="date-info" style="text-align: center; margin-bottom: 20px;">
    <strong>Thời gian thống kê: </strong>
    <span style="color: #1976D2;" class="date-span">
        <%= startDate != null ? startDate : "N/A" %>
    </span>
    <strong> đến </strong>
    <span style="color: #1976D2;" class="date-span">
        <%= endDate != null ? endDate : "N/A" %>
    </span>
</div>

<table>
    <thead>
    <tr style="text-align: center;">
        <th>ID NCC</th>
        <th>Tên NCC</th>
        <th>Số lượng hàng nhập</th>
        <th>Tổng tiền</th>
        <th>Chi tiết</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<StatsSupplier> suppliers = (List<StatsSupplier>) session.getAttribute("suppliersList");
        if (suppliers == null) {
            suppliers = (List<StatsSupplier>) session.getAttribute("suppliersList");
        }

        int totalQuantity = 0;
        long totalAmount = 0;

        if (suppliers != null && !suppliers.isEmpty()) {
            for (StatsSupplier s : suppliers) {
                totalQuantity += s.getQuantityImported();
                totalAmount += s.getTotalAmount();
    %>
    <tr>
        <td style="text-align: center;"><%= s.getId() %></td>
        <td><%= s.getNameSupplier() %></td>
        <td style="text-align: center;"><%= s.getQuantityImported() %></td>
        <td style="text-align: right;" class="currency"><%= s.getTotalAmount() %></td>
        <td style="text-align: center;">
            <form action="${pageContext.request.contextPath}/importInvoice" method="post">
                <input type="hidden" name="supplierId" value="<%= s.getId() %>" />
                <button type="submit">Xem chi tiết</button>
            </form>
        </td>
    </tr>
    <%
            }
    %>
    </tbody>
    <tfoot>
    <tr style="background-color: #1976D2; color: white; font-weight: bold; border-top: 3px solid #0D47A1;">
        <td style="text-align: center; font-size: 16px;" colspan="2">TỔNG CỘNG</td>
        <td style="text-align: center; font-size: 16px;"><%= totalQuantity %></td>
        <td style="text-align: right; font-size: 16px;" class="currency"><%= totalAmount %></td>
        <td style="text-align: center; font-size: 16px;">-</td>
    </tr>
    </tfoot>
    <%
        } else {
    %>
    <tbody>
    <tr><td colspan="5" style="text-align:center;">Không có dữ liệu nhà cung cấp</td></tr>
    </tbody>
    <% } %>
</table>

<a href="${pageContext.request.contextPath}/ManagerView/SelectDateStatsUI.jsp" class="btn-back">Quay lại</a>

</body>
</html>