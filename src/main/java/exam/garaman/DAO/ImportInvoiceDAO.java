package exam.garaman.DAO;

import exam.garaman.Model.ImportDetail;
import exam.garaman.Model.ImportInvoice;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ImportInvoiceDAO extends DAO{
    public ImportInvoiceDAO() {
        super();
    }
    public List<ImportDetail> getImportDetails(int importBatchId) throws SQLException {
        List<ImportDetail> resultList = new ArrayList<>();

        // Truy vấn để lấy chi tiết các phụ tùng trong hóa đơn nhập dựa trên importBatchId
        String importDetailQuery = """
        SELECT imd.id AS detailId,
               sp.name AS partName,
               imd.quantity AS quantity,
               imd.totalAmount AS totalAmount
        FROM tblImportDetail AS imd
        JOIN tblSparePart AS sp ON imd.tblSparePartid = sp.id
        WHERE imd.tblImportInvoiceid = ?
    """;

        try (PreparedStatement stmtImportDetail = con.prepareStatement(importDetailQuery)) {
            // Set query parameter
            stmtImportDetail.setInt(1, importBatchId);

            try (ResultSet rsImportDetail = stmtImportDetail.executeQuery()) {
                while (rsImportDetail.next()) {
                    int detailId = rsImportDetail.getInt("detailId");
                    String nameSparePart = rsImportDetail.getString("partName");
                    int quantity = rsImportDetail.getInt("quantity");
                    int totalAmount = rsImportDetail.getInt("totalAmount");
                    ImportDetail detail = new ImportDetail(detailId, nameSparePart, quantity, totalAmount);
                    resultList.add(detail);
                }
            }
        }

        return resultList;
    }

    public static void main(String[] args) throws SQLException {
        ImportInvoiceDAO dao = new ImportInvoiceDAO();

        int importBatchId = 3;  // Example import batch ID

        // Call the function to get invoice details of an import batch
        List<ImportDetail> importDetails = dao.getImportDetails(importBatchId);

        // Print the results
        System.out.println("Import invoice details:");
        for (ImportDetail detail : importDetails) {
            System.out.println(detail);
        }
    }
}
