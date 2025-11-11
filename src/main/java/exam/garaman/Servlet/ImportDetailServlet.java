package exam.garaman.Servlet;

import exam.garaman.DAO.ImportInvoiceDAO;
import exam.garaman.Model.ImportDetail;
// import exam.garaman.Model.StatsSupplier; // Không cần dòng này
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
// import jakarta.servlet.http.HttpSession; // Không cần Session ở đây

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ImportDetail")
public class ImportDetailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Đọc request (form)
        response.setContentType("text/html; charset=UTF-8"); // Gửi response
        response.setCharacterEncoding("UTF-8"); // Gửi response

        HttpSession session = request.getSession();

        String idLannhapStr = request.getParameter("idLannhap");
        String importDateStr = request.getParameter("importDate");

        if (idLannhapStr != null && !idLannhapStr.isEmpty()) {
            try {
                int idLannhap = Integer.parseInt(idLannhapStr);
                ImportInvoiceDAO dao = new ImportInvoiceDAO();
                List<ImportDetail> listImportDetail = null;

                listImportDetail = dao.getImportDetails(idLannhap);

                request.setAttribute("listImportDetail", listImportDetail);
                request.setAttribute("idLannhap", idLannhap); // Gửi id qua request
                session.setAttribute("importDate", importDateStr);


                RequestDispatcher rd = request.getRequestDispatcher("/ManagerView/ImportDetailUI.jsp");
                rd.forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Lỗi SQL khi lấy chi tiết", e);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                throw new ServletException("Lỗi: ID lần nhập không phải là số", e);
            }
        } else {
            // SỬA LỖI LOGIC: Chuyển về trang chủ an toàn, không phải chính nó
            response.sendRedirect(request.getContextPath() + "/ManagerView/ManagerMainUI.jsp");
        }
    }

    // Thêm doGet để xử lý nếu người dùng gõ URL thẳng
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/ManagerView/ManagerMainUI.jsp");
    }
}