package exam.garaman.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    private static final String JDBC_URL =
            "jdbc:mysql://localhost:3306/garamandb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "123456";

    protected Connection con;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
    }

    public DAO() {
        try {
            con = DAO.getConnection();
            System.out.println("Kết nối DB thành công!");
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Lỗi kết nối DB: " + ex);
        }
    }

    public DAO(Connection con) {
        this.con = con;
    }

    public static void main(String[] args) {
        DAO a = new DAO();
    }
}
