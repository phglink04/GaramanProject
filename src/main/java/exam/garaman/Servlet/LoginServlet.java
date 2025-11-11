package exam.garaman.Servlet;

import exam.garaman.DAO.LoginDAO;
import exam.garaman.Model.Customer;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet  extends HttpServlet {
    @Override
    public void init() throws ServletException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Khởi tạo DAO
        LoginDAO dao = new LoginDAO();

        // 3. Gọi DAO để kiểm tra thông tin đăng nhập
        int result = dao.getIDMember(username, password);

        // 4. Xử lý kết quả trả về từ DAO
        if (result != -1) { // Đăng nhập thành công
            if (dao.isStaff(result)) {
                // Là nhân viên -> Chuyển hướng đến trang quản lý
                response.sendRedirect("ManagerView/ManagerMainUI.jsp");
            } else {
                // Là khách hàng -> Lấy thông tin và lưu vào session
                Customer customer = dao.getCustomer(result);
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);

                // Chuyển hướng đến trang khách hàng
                response.sendRedirect("CustomerView/CustomerMainUI.jsp");
            }
        } else {
            // 5. Đăng nhập thất bại
            // Gửi thông báo lỗi về lại trang đăng nhập
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác!");

            // Forward (chuyển tiếp) yêu cầu trở lại trang JSP để hiển thị lỗi
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }

    }
}
