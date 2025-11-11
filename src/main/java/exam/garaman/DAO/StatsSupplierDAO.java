package exam.garaman.DAO;

import exam.garaman.Model.StatsSupplier;

import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class StatsSupplierDAO extends DAO {
    public StatsSupplierDAO() {
        super();
    }

    /**
     * Lấy danh sách thống kê TẤT CẢ nhà cung cấp (kể cả người có 0 đơn)
     * trong một khoảng thời gian.
     * Đã tối ưu, chỉ sử dụng 1 câu truy vấn duy nhất.
     */
    public List<StatsSupplier> getSupplierListByImport(Date startDate, Date endDate) throws SQLException {
        List<StatsSupplier> resultList = new ArrayList<>();


        String optimizedQuery = """
            SELECT
                sup.id,
                sup.name,
                SUM(imd.quantity) AS totalQuantity,
                SUM(imd.totalAmount) AS totalAmount
            FROM
                tblSupplier AS sup
            JOIN
                tblImportInvoice AS ipi ON sup.id = ipi.tblSupplierid
                AND ipi.time BETWEEN ? AND ?
            JOIN
                tblImportDetail AS imd ON ipi.id = imd.tblImportInvoiceid
            GROUP BY
                sup.id, sup.name
            ORDER BY
                totalQuantity DESC
        """;

        // Chỉ cần 1 khối try-with-resources
        try (PreparedStatement stmt = con.prepareStatement(optimizedQuery)) {

            // Set 2 tham số ngày tháng
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                // Duyệt qua kết quả và thêm vào danh sách
                while (rs.next()) {
                    int supplierId = rs.getInt("id");
                    String supplierName = rs.getString("name");
                    int totalQuantity = rs.getInt("totalQuantity");
                    int totalAmount = rs.getInt("totalAmount");

                    StatsSupplier supplier = new StatsSupplier(supplierId, supplierName, totalQuantity, totalAmount);
                    resultList.add(supplier);
                }
            }
        }

        return resultList;
    }

    public static void main(String[] args) throws SQLException {
        // (Phần main của bạn đã chính xác, giữ nguyên)
        StatsSupplierDAO dao = new StatsSupplierDAO();

        Calendar cal = Calendar.getInstance();
        cal.set(2024, Calendar.JANUARY, 1);  // Test cho năm 2024
        Date startDate = new Date(cal.getTimeInMillis());

        cal.set(2024, Calendar.DECEMBER, 31); // Test cho năm 2024
        Date endDate = new Date(cal.getTimeInMillis());

        List<StatsSupplier> supplierList = dao.getSupplierListByImport(startDate, endDate);

        System.out.println("Supplier list and statistics (Optimized):");
        for (StatsSupplier supplier : supplierList) {
            System.out.println(supplier);
        }
    }
}