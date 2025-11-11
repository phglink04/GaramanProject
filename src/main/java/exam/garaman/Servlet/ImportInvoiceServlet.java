package exam.garaman.Servlet;

import exam.garaman.DAO.StatsImportDAO;
import exam.garaman.Model.StatsImport;
import exam.garaman.Model.StatsSupplier; // <-- Bây giờ chúng ta cần import cái này
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

@WebServlet("/importInvoice")
public class ImportInvoiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8"); // Đọc request (form)
        response.setContentType("text/html; charset=UTF-8"); // Gửi response
        response.setCharacterEncoding("UTF-8"); // Gửi response

        HttpSession session = request.getSession();

        // 1. Lấy dữ liệu từ SESSION
        String startDateStr = (String) session.getAttribute("startDate");
        String endDateStr = (String) session.getAttribute("endDate");

        // 2. Lấy DANH SÁCH NCC TỔNG (đã lưu từ servlet trước)
        List<StatsSupplier> suppliers = (List<StatsSupplier>) session.getAttribute("suppliersList");

        // 3. Lấy ID NCC đang chọn TỪ FORM
        String supplierIdStr = request.getParameter("supplierId");

        // 4. Kiểm tra nếu session hết hạn hoặc thiếu dữ liệu
        if (startDateStr == null || endDateStr == null || supplierIdStr == null || suppliers == null || suppliers.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ManagerView/ManagerMainUI.jsp");
            return;
        }

        try {
            int supplierId = Integer.parseInt(supplierIdStr);
            Date startDate = java.sql.Date.valueOf(startDateStr);
            Date endDate = java.sql.Date.valueOf(endDateStr);

            // 5. TÌM VÀ LƯU SUPPLIER ĐANG CHỌN (ĐỂ JSP HIỂN THỊ TÊN)
            StatsSupplier selectedSupplier = null;
            for (StatsSupplier s : suppliers) {
                if (s.getId() == supplierId) {
                    selectedSupplier = s;
                    // LƯU VÀO SESSION (để JSP đọc được)
                    session.setAttribute("selectedSupplier", selectedSupplier);
                    break;
                }
            }

            // Nếu tìm thấy
            if (selectedSupplier != null) {
                // 6. Gọi DAO để lấy danh sách chi tiết các HÓA ĐƠN
                StatsImportDAO dao = new StatsImportDAO();
                List<StatsImport> entries = dao.getSupplierImportBatches(startDate, endDate, supplierId);

                // 7. Gửi danh sách HÓA ĐƠN qua REQUEST
                request.setAttribute("entriesList", entries);

                // 8. Chuyển tiếp đến JSP
                RequestDispatcher rd = request.getRequestDispatcher("/ManagerView/SupplierDetailUI.jsp");
                rd.forward(request, response);

            } else {
                // Lỗi: Không tìm thấy supplierId trong danh sách (session)
                response.sendRedirect(request.getContextPath() + "/ManagerView/ManagerMainUI.jsp");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi khi xử lý chi tiết nhà cung cấp", e);
        }
    }
}