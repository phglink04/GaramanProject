<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="exam.garaman.DAO.ImportInvoiceDAO" %>
<%@ page import="exam.garaman.Model.ImportDetail" %>
<%@ page import="exam.garaman.Model.StatsSupplier" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Thông Tin Lần Nhập</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #E3F2FD; /* Light blue background */
        }

        .entry-info {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #1A237E; /* Dark blue for branding */
        }

        /* Title styling */
        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: 700;
            text-align: center;
        }

        /* Paragraph styling */
        p {
            color: #0D47A1; /* Deep blue for text */
            font-weight: bold;
            margin-bottom: 10px;
        }

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
            text-align: left;
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

        .btn-back {
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #42A5F5; /* Lighter blue */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: inline-block;
            text-decoration: none;
            width: 100px;
            text-align: center;
        }

        .btn-back:hover {
            background-color: #1976D2; /* Darker blue on hover */
        }

        /* Currency formatting */
        .currency {
            text-align: right;
        }

        /* Date info styling */
        .date-info {
            margin-bottom: 20px;
            font-size: 16px;
            color: #333;
            text-align: center;
        }

        /* Supplier info styling */
        .supplier-info {
            margin-bottom: 20px;
            font-size: 18px;
            color: #1A237E;
            text-align: center;
            font-weight: bold;
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
<%
    StatsSupplier selectedSupplier = (StatsSupplier) session.getAttribute("selectedSupplier");
    List<ImportDetail> importDetails = (List<ImportDetail>) request.getAttribute("listImportDetail");

    Integer importIdObj = (Integer) request.getAttribute("idLannhap");
    int importId = (importIdObj != null) ? importIdObj : 0;

    String startDate = (String) request.getAttribute("startDate");
    String endDate = (String) request.getAttribute("endDate");
%>

<h1>Chi tiết hóa đơn nhập <%= importId %></h1>

<!-- Import date display -->
<div class="date-info">
    <strong>Ngày nhập: </strong>
    <%
        // Get import date from session (set from previous page)
        String importDate = "N/A";
        Object importDateObj = session.getAttribute("importDate");
        if (importDateObj != null) {
            importDate = importDateObj.toString();
        }
    %>
    <span style="color: #1976D2;" class="date-span">
        <%= importDate %>
    </span>
</div>

<!-- Supplier information -->
<div class="supplier-info">
    Nhà Cung Cấp:
    <%= selectedSupplier != null ? selectedSupplier.getNameSupplier() : "Không xác định" %>
</div>

<table>
    <thead>
    <tr>
        <th >Mã phụ tùng</th>
        <th>Tên phụ tùng</th>
        <th>Số Lượng</th>
        <th >Tổng Tiền</th>
    </tr>
    </thead>
    <tbody>
    <%
        long totalQuantity = 0;
        long totalAmount = 0;

        if (importDetails != null && !importDetails.isEmpty()) {
            for (ImportDetail detail : importDetails) {
                totalQuantity += detail.getQuantity();
                totalAmount += detail.getTotalAmount();
    %>
    <tr>
        <td style="text-align: center;"><%= detail.getId() %></td>
        <td><%= detail.getNameSparePart() %></td>
        <td style="text-align: center;"><%= detail.getQuantity() %></td>
        <td style="text-align: right;" class="currency"><%= detail.getTotalAmount() %></td>
    </tr>
    <%
            }
        } else {
    %>
    <tr><td colspan="4" style="text-align:center;">Không có dữ liệu phụ tùng cho lần nhập này</td></tr>
    <%
        }
    %>
    </tbody>

    <!-- Total row -->
    <% if (importDetails != null && !importDetails.isEmpty()) { %>
    <tfoot>
    <tr style="background-color: #1976D2; color: white; font-weight: bold; border-top: 3px solid #0D47A1;">
        <td style="text-align: center; font-size: 16px;" colspan="2">TỔNG CỘNG</td>
        <td style="text-align: center; font-size: 16px;"><%= totalQuantity %></td>
        <td style="text-align: right; font-size: 16px;" class="currency"><%= totalAmount %></td>
    </tr>
    </tfoot>
    <% } %>
</table>

<a href="javascript:history.back()" class="btn-back">Quay Lại</a>
</body>
</html>