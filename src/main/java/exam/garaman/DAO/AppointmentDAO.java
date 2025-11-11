package exam.garaman.DAO;

import exam.garaman.Model.Appointment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;

public class AppointmentDAO extends DAO {
    public AppointmentDAO() throws ClassNotFoundException {
        super();
    }

    // Hàm kiểm tra thời gian hợp lệ
    public boolean checkTime(Date appointmentTime, int tblCustomerid) {
        try {
            // Kiểm tra thời gian có lớn hơn thời gian hiện tại hay không
            LocalDateTime currentTime  = LocalDateTime.now();
            LocalDateTime inputTime  = appointmentTime.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            if (inputTime .isBefore(currentTime )) {
                System.out.println("Thời gian không hợp lệ: phải lớn hơn thời gian hiện tại.");
                return false;
            }

            // Kiểm tra trong database xem thời gian và id khách hàng có tồn tại hay không
            String sql = "SELECT COUNT(*) FROM tblAppointment WHERE appointmentTime = ? AND tblCustomerid = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(appointmentTime.getTime()));
            ps.setInt(2, tblCustomerid);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("Thời gian đã tồn tại trong hệ thống cho khách hàng này.");
                return false;
            }
            return true; // Thời gian hợp lệ
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Có lỗi xảy ra
    }

    // Hàm lưu lịch hẹn nếu thời gian hợp lệ
    public boolean saveAppoint(Appointment appointment) {
        if (!checkTime(appointment.getAppointmentTime(), appointment.getTblCustomerid())) {
            return false; // Không lưu nếu thời gian không hợp lệ
        }
        String sql = "INSERT INTO tblAppointment (appointmentTime, status, tblCustomerid) VALUES ( ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(appointment.getAppointmentTime().getTime()));
            ps.setString(2, appointment.getStatus());
            ps.setInt(3, appointment.getTblCustomerid());
            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách giờ trống cho một ngày cụ thể
    // Trả về danh sách chuỗi theo định dạng "HH:mm"
    public List<String> getEmptyTime(Date date) throws SQLException {
        // Danh sách khung giờ làm việc (có thể thay đổi nếu cần)
        List<String> allSlots = Arrays.asList(
                "08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30",
                "12:00","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00"
        );

        // Lấy các thời điểm đã được đặt trong ngày
        String sql = "SELECT TIME(appointmentTime) AS t FROM tblAppointment WHERE DATE(appointmentTime) = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setDate(1, new java.sql.Date(date.getTime()));
        ResultSet rs = ps.executeQuery();

        Set<String> booked = new HashSet<>();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        while (rs.next()) {
            Time t = rs.getTime("t");
            if (t != null) {
                String s = sdf.format(new java.util.Date(t.getTime()));
                booked.add(s);
            }
        }

        // Lọc các khung giờ chưa bị đặt
        List<String> available = new ArrayList<>();
        for (String slot : allSlots) {
            if (!booked.contains(slot)) {
                available.add(slot);
            }
        }

        return available;
    }
}
