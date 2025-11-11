package exam.garaman.Model;

import java.util.Date;

public class ImportInvoice {
    private int id;
    private Date time;
    private int totalAmount;
    private int WarehouseStaffId;
    private int SupplierId;
    // Constructor không đối số
    public ImportInvoice(int id, Date day, int totalAmount) {
        this.id = id;
        this.time = day;
        this.totalAmount = totalAmount;
    }
    // Constructor với các tham số
    public ImportInvoice(int id, Date time, int totalAmount, int warehouseStaffId, int supplierId) {
        this.id = id;
        this.time = time;
        this.totalAmount = totalAmount;
        this.WarehouseStaffId = warehouseStaffId;
        this.SupplierId = supplierId;
    }
    // Getter và Setter cho các thuộc tính
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getTime() { return time; }
    public void setTime(Date time) { this.time = time; }
    public double getTotal() { return totalAmount; }
    public void setTotal(int totalAmount) { this.totalAmount = totalAmount; }
    public int getWarehouseStaffId() { return WarehouseStaffId; }
    public void setWarehouseStaffId(int warehouseStaffId) { WarehouseStaffId = warehouseStaffId; }
    public int getSupplierId() { return SupplierId; }
    public void setSupplierId(int supplierId) { SupplierId = supplierId; }

    @Override
    public String toString() {
        return "ImportInvoice{" +
                "id=" + id +
                ", time=" + time +
                ", total=" + totalAmount +
                ", WarehouseStaffId=" + WarehouseStaffId +
                ", SupplierId=" + SupplierId +
                '}';
    }
}
