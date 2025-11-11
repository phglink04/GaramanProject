package exam.garaman.DAO;

import exam.garaman.Model.Customer;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO extends DAO {
    public LoginDAO() {
        super();
    }

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

    public boolean isStaff(int memberId) {
        String sql = "SELECT * FROM tblStaff WHERE tblMemberid = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Customer getCustomer(int memberId) {

        // Sửa 1: Dùng JOIN rõ ràng và đặt Alias (bí danh) cho ID
        String sql = "SELECT " +
                "  tblCustomer.id AS customerId, " + // Đặt tên riêng cho ID của Customer
                "  tblMember.username, " +
                "  tblMember.password, " +
                "  tblMember.dob, " +
                "  tblMember.address, " +
                "  tblMember.phoneNumber, " +
                "  tblCustomer.CustomerID " +
                "FROM tblMember " +
                "INNER JOIN tblCustomer ON tblMember.id = tblCustomer.tblMemberid " +
                "WHERE tblMember.id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Sửa 2: Lấy đúng ID thông qua Alias (customerId)
                    Customer customer = new Customer(
                            rs.getInt("customerId"), // <-- Lấy đúng ID của Customer
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getDate("dob"),
                            rs.getString("address"),
                            rs.getString("phoneNumber"),
                            rs.getString("CustomerID")
                    );
                    return customer;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy khách hàng
    }
}