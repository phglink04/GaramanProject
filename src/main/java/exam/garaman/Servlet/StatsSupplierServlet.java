package exam.garaman.Servlet;

import exam.garaman.DAO.StatsSupplierDAO;
import exam.garaman.Model.StatsSupplier;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import java.util.List;

@WebServlet("/statsSupplier")
public class StatsSupplierServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Đọc request (form)
        response.setContentType("text/html; charset=UTF-8"); // Gửi response
        response.setCharacterEncoding("UTF-8"); // Gửi response

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Kiểm tra dữ liệu
        if (startDate != null && endDate != null && endDate.compareTo(startDate) > 0) {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            // Lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("startDate", startDate);
            session.setAttribute("endDate", endDate);

            // Chuyển hướng sang trang thống kê
            doGet(request, response);
        } else {
            // Nếu lỗi: đặt thông báo và quay lại JSP
            request.setAttribute("errorMessage", "Ngày kết thúc phải lớn hơn ngày bắt đầu!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("ManagerView/SelectDateStatsUI.jsp");
            dispatcher.forward(request, response);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String startDateStr = (String) session.getAttribute("startDate");
        String endDateStr = (String) session.getAttribute("endDate");

        List<StatsSupplier> suppliers = null;

        if (startDateStr != null && endDateStr != null) {
            Date startDate = java.sql.Date.valueOf(startDateStr);
            Date endDate = java.sql.Date.valueOf(endDateStr);

            StatsSupplierDAO dao = new StatsSupplierDAO();
            try {
                suppliers = dao.getSupplierListByImport(startDate, endDate);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        session.setAttribute("suppliersList", suppliers);
        RequestDispatcher rd = request.getRequestDispatcher("/ManagerView/StatsSupplierUI.jsp");
        rd.forward(request, response);
    }

}
