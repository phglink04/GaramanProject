package exam.garaman.DAO;

import exam.garaman.Model.StatsImport;

import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class StatsImportDAO extends DAO{
    public StatsImportDAO() {
        super();
    }

    public List<StatsImport> getSupplierImportBatches(Date startDate, Date endDate, int supplierId) throws SQLException {
        List<StatsImport> resultList = new ArrayList<>();

        // Truy vấn lấy danh sách các lần nhập của nhà cung cấp trong khoảng thời gian
        String importBatchQuery = """
            SELECT imi.id AS importInvoiceId,
                   imi.time AS importDate,
                   SUM(imd.quantity) AS totalQuantity,
                   SUM(imd.totalAmount) AS totalAmount
            FROM tblImportInvoice AS imi
            JOIN tblImportDetail AS imd ON imi.id = imd.tblImportInvoiceid
            WHERE imi.tblSupplierid = ? AND imi.time BETWEEN ? AND ?
            GROUP BY imi.id, imi.time
        """;

        try (PreparedStatement stmtImportBatch = con.prepareStatement(importBatchQuery)) {
            // Đặt các tham số cho truy vấn
            stmtImportBatch.setInt(1, supplierId);
            stmtImportBatch.setDate(2, new java.sql.Date(startDate.getTime()));
            stmtImportBatch.setDate(3, new java.sql.Date(endDate.getTime()));

            try (ResultSet rsImportBatch = stmtImportBatch.executeQuery()) {
                while (rsImportBatch.next()) {
                    int importInvoiceId = rsImportBatch.getInt("importInvoiceId");
                    Date importDate = rsImportBatch.getDate("importDate");
                    int totalQuantity = rsImportBatch.getInt("totalQuantity");
                    int totalAmount = rsImportBatch.getInt("totalAmount");

                    StatsImport importBatch = new StatsImport(importInvoiceId, importDate, totalQuantity, totalAmount);
                    resultList.add(importBatch);
                }
            }
        }

        return resultList;
    }

    public static void main(String[] args) throws SQLException {
        StatsImportDAO dao = new StatsImportDAO();

        // Create start and end dates for testing
        Calendar cal = Calendar.getInstance();
        cal.set(2024, Calendar.JANUARY, 1);  // Assume start date is 1/1/2024
        Date startDate = new Date(cal.getTimeInMillis());

        cal.set(2024, Calendar.DECEMBER, 31);  // Assume end date is 31/12/2024
        Date endDate = new Date(cal.getTimeInMillis());

        int supplierId = 2;  // Example supplier ID

        // Call the method to get import batches for a supplier
        List<StatsImport> importBatchList = dao.getSupplierImportBatches(startDate, endDate, supplierId);

        // Print results
        System.out.println("List of import batches for the supplier:");
        for (StatsImport importBatch : importBatchList) {
            System.out.println(importBatch);
        }
    }

}
