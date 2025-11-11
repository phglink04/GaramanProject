package exam.garaman.Servlet;

import exam.garaman.DAO.AppointmentDAO;
import exam.garaman.Model.Appointment;
import exam.garaman.Model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/appointment")
public class BookAppointmentServlet extends HttpServlet {
    public void init() throws ServletException {
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nếu có param date thì dùng param, nếu không dùng session
        String dateParam = request.getParameter("appointmentDate");
        HttpSession session = request.getSession();
        String dateStr = dateParam != null ? dateParam : (String) session.getAttribute("appointmentDate");

        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                Date date = java.sql.Date.valueOf(dateStr);
                AppointmentDAO dao = new AppointmentDAO();
                List<String> availableTimes = dao.getEmptyTime(date);
                request.setAttribute("availableTimes", availableTimes);
                // Lưu ngày vào session để dùng khi submit
                session.setAttribute("appointmentDate", dateStr);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi khi lấy giờ trống: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("CustomerView/BookAppointmentUI.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Đặt UTF-8 để nhận tiếng Việt
        request.setCharacterEncoding("UTF-8");
        try {
            // Lấy customer từ session
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");

            if (customer == null) {
                request.setAttribute("errorMessage", "Vui lòng đăng nhập trước khi đặt lịch.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            // 1. Lấy tất cả dữ liệu từ form JSP
            String date = request.getParameter("appointmentDate");
            String time = request.getParameter("appointmentTime");
            String customerName = request.getParameter("customerName");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            // 2. kết hợp ngày và tháng thành Timestamp
            Timestamp timeA = Timestamp.valueOf(date + " " + time + ":00");

            //3. Tạo đối tượng AppointmentDAO mới
            Appointment appointment = new Appointment();
            appointment.setAppointmentTime(timeA);
            appointment.setStatus("Chờ xác nhận");
            appointment.setTblCustomerid(customer.getId());

            AppointmentDAO appointmentDAO = new AppointmentDAO();
            boolean result = appointmentDAO.saveAppoint(appointment);

            // 4. Điều hướng dựa trên kết quả
            if (result) {
                request.setAttribute("successMessage", "Đặt lịch thành công!");
            } else {
                request.setAttribute("errorMessage", "Đặt lịch thất bại do chọn thời gian trong quá khứ hoặc khách hàng đã đặt lịch trước.");
            }
            request.getRequestDispatcher("CustomerView/BookAppointmentUI.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đặt lịch.");
            request.getRequestDispatcher("CustomerView/BookAppointmentUI.jsp").forward(request, response);
        }
    }

}
