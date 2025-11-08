package exam.garaman.DAO;

import exam.garaman.Model.Customer;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO extends DAO {
    public LoginDAO() throws ClassNotFoundException {
        super();
    }
    // Get user id by username and password, if no user found, return -1
    public int getIDMember(String username, String password) {
        String sql = "SELECT id FROM tblMember WHERE username = ? AND password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Check user is NhanVien or not
    public boolean isStaff(int id) {
        String sql = "SELECT * FROM tblNhanVien670 WHERE tblThanhVien670id = " + id;
        try {
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Customer getCustomer(int id) {
        String sql = "SELECT * FROM tblMember, tblCustomer " +
                "WHERE tblMember.id = tblCustomer.tblMemberid " +
                "AND tblMember.id = ?";
        try {
            System.out.print("Linh");
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id); // Truyền tham số id một cách an toàn
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("id"),                     // id của khách hàng
                        rs.getString("username"),            // tên đăng nhập
                        rs.getString("password"),            // mật khẩu
                        rs.getDate("dob"),              // ngày sinh, kiểu Date
                        rs.getString("address"),              // địa chỉ
                        rs.getString("phoneNum"),         // số điện thoại
                        rs.getString("idCustomer")          // mã khách hàng
                );
                return customer;
            }

            // Đóng tài nguyên
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy khách hàng
    }
}
