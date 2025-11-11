<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="exam.garaman.Model.StatsSupplier" %>
<%@ page import="exam.garaman.Model.StatsImport" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Chi Tiết Nhà Cung Cấp</title>

    <%-- (CSS và JS của bạn - Giữ nguyên, đã đúng) --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #E3F2FD;
        }
        .supplier-name {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #1A237E;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        h1 {
            color: #1A237E;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: 700;
            text-align: center;
        }
        th, td {
            border: 1px solid #90CAF9;
            text-align: left;
            padding: 12px;
        }
        th {
            background-color: #1976D2;
            text-align: center;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #E3F2FD;
        }
        .btn-back {
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #42A5F5;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: inline-block;
            width: 100px;
            text-align: center;
            text-decoration: none;
        }
        .btn-back:hover {
            background-color: #1976D2;
        }
        .currency {
            text-align: right;
        }
        .date-info {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
        button {
            padding: 8px 12px;
            background-color: #0277BD;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
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
            if (dateString.match(/^\d{2}-\d{2}-\d{4}$/)) {
                return dateString;
            }
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
                const amount = parseInt(cell.textContent.trim());
                if (!isNaN(amount)) {
                    cell.textContent = formatCurrency(amount);
                }
            });

            // Format dates
            const dateSpans = document.querySelectorAll('.date-span');
            dateSpans.forEach(function(span) {
                span.textContent = formatDate(span.textContent.trim());
            });

            const dateCells = document.querySelectorAll('.date-cell');
            dateCells.forEach(function(cell) {
                cell.textContent = formatDate(cell.textContent.trim());
            });
        };
    </script>
</head>
<body>
<%
    StatsSupplier selectedSupplier = (StatsSupplier) session.getAttribute("selectedSupplier");
    List<StatsImport> entries = (List<StatsImport>) request.getAttribute("entriesList");

    String startDate = (String) session.getAttribute("startDate");
    String endDate = (String) session.getAttribute("endDate");
%>

<h1>Thống kê số lần nhập của nhà cung cấp <br> <%= selectedSupplier != null ? selectedSupplier.getNameSupplier() : "Không xác định" %></h1>

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
        // Get totals from selectedSupplier object (good logic)
        long totalQuantity = selectedSupplier != null ? selectedSupplier.getQuantityImported() : 0;
        long totalAmount = selectedSupplier != null ? selectedSupplier.getTotalAmount() : 0;

        if (entries != null && !entries.isEmpty()) {
            for (StatsImport entry : entries) {
    %>
    <tr>
        <td style="text-align: center;"><%= entry.getId() %></td>
        <td style="text-align: center;"><%= entry.getQuantity() %></td>

        <!-- Currency column with proper right alignment -->
        <td style="text-align: right;" class="currency"><%= entry.getTotalAmount() %></td>

        <td style="text-align: center;" class="date-cell"><%= entry.getTime() %></td>
        <td style="text-align: center;">
            <form action="${pageContext.request.contextPath}/ImportDetail" method="post" style="margin: 0;">
                <input type="hidden" name="idLannhap" value="<%= entry.getId() %>" />
                <input type="hidden" name="importDate" value="<%= entry.getTime() %>" />
                <button type="submit">Xem Hóa Đơn</button>
            </form>
        </td>
    </tr>
    <%
        } // End FOR loop
    } else {
    %>
    <tr><td colspan="5" style="text-align:center;">Không có dữ liệu lần nhập</td></tr>
    <%
        } // End IF/ELSE block
    %>
    </tbody>

    <!-- Only show total row if there is data -->
    <% if (entries != null && !entries.isEmpty()) { %>
    <tfoot>
    <tr style="background-color: #1976D2; color: white; font-weight: bold; border-top: 3px solid #0D47A1;">
        <td style="text-align: center; font-size: 16px;" colspan="1">TỔNG CỘNG</td>
        <td style="text-align: center; font-size: 16px;"><%= totalQuantity %></td>
        <td style="text-align: right; font-size: 16px;" class="currency"><%= totalAmount %></td>
        <td style="text-align: center; font-size: 16px;">-</td>
        <td style="text-align: center; font-size: 16px;">-</td>
    </tr>
    </tfoot>
    <% } %>

</table>

<!-- Back button with proper navigation -->
<a href="javascript:history.back()" class="btn-back">Quay Lại</a>

</body>
</html>