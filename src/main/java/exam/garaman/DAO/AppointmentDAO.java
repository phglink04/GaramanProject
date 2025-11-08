package exam.garaman.DAO;

import exam.garaman.Model.Appointment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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
}
