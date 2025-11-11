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
        /* ... CSS của bạn ... */
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #FAF3E0; }
        .entry-info { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: #BF360C; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #ffffff; box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2); border-radius: 8px; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 12px; }
        th { background-color: #D84315; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .btn-back { padding: 10px 20px; font-size: 16px; color: #ffffff; background-color: #8D6E63; border: none; border-radius: 6px; cursor: pointer; transition: background-color 0.3s ease; margin-top: 20px; display: inline-block; text-decoration: none; width: 100px; text-align: center; }
        .btn-back:hover { background-color: #6D4C41; }
    </style>
</head>
<body>
<%
    // SỬA LỖI: Đọc từ REQUEST (khớp với Servlet)
    StatsSupplier selectedSupplier = (StatsSupplier) session.getAttribute("selectedSupplier"); // Tên NCC vẫn lấy từ session (đã lưu từ trước)
    List<ImportDetail> dsChiTiet = (List<ImportDetail>) request.getAttribute("dsChiTiet");

    // SỬA LỖI CRASH: Kiểm tra null an toàn
    Integer idLannhapObj = (Integer) request.getAttribute("idLannhap");
    int idLannhap = (idLannhapObj != null) ? idLannhapObj : 0;
%>

<h1>Thông Tin Lần Nhập</h1>
<p><strong>Nhà Cung Cấp:</strong> <%= selectedSupplier != null ? selectedSupplier.getNameSupplier() : "Không xác định" %></p>
<p><strong>ID Lần Nhập:</strong> <%= idLannhap %></p>

<table>
    <thead>
    <tr>
        <th>ID Chi Tiết</th> <th>Tên Phụ Tùng</th>
        <th>Số Lượng</th>
        <th>Tổng Tiền</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (dsChiTiet != null && !dsChiTiet.isEmpty()) {
            for (ImportDetail chiTiet : dsChiTiet) {
    %>
    <tr>
        <td><%= chiTiet.getId() %></td>
        <td><%= chiTiet.getNameSparePart() %></td>
        <td><%= chiTiet.getQuantity() %></td>
        <td><%= chiTiet.getTotalAmount() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="4" style="text-align:center;">Không có dữ liệu phụ tùng cho lần nhập này</td></tr>
    <% } %>
    </tbody>
</table>

<a href="javascript:history.back()" class="btn-back">Quay Lại</a>
</body>
</html>