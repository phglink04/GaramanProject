package exam.garaman.Model;

public class StatsSupplier extends Supplier {
    private int quantityImported;
    private int totalAmount;
    public StatsSupplier(int id, String name, String address, String phoneNumber, int quantityImported, int totalAmount) {
        super(id, name, address, phoneNumber);
        this.quantityImported = quantityImported;
        this.totalAmount = totalAmount;
    }
    public StatsSupplier(int SupplierId, String nameSupplier, int quantityImported, int totalAmount) {
        super(SupplierId, nameSupplier);
        this.quantityImported = quantityImported;
        this.totalAmount = totalAmount;
    }
    public int getQuantityImported() {
        return quantityImported;
    }
    public void setQuantityImported(int quantityImported) {
        this.quantityImported = quantityImported;
    }
    public int getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

}
