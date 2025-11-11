package exam.garaman.Model;

public class ImportDetail {
    private int id;
    private String nameSparePart;
    private int quantity;
    private int price;
    private int totalAmount;
    private int importInvoiceId;
    private int sparePartId;

    public ImportDetail(int id, int quantity, int price, int totalAmount, int importInvoiceId, int sparePartId) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.totalAmount = totalAmount;
        this.importInvoiceId = importInvoiceId;
        this.sparePartId = sparePartId;
    }

    public ImportDetail(int id, String nameSparePart, int quantity, /*int price,*/ int totalAmount) {
        this.id = id;
        this.nameSparePart = nameSparePart;
        this.quantity = quantity;
//        this.price = price;
        this.totalAmount = totalAmount;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNameSparePart() { return nameSparePart; }
    public void setNameSparePart(String nameSparePart) { this.nameSparePart = nameSparePart; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }
    public int getTotalAmount() { return totalAmount; }
    public void setTotalAmount(int totalAmount) { this.totalAmount = totalAmount; }
    public int getImportInvoiceId() { return importInvoiceId; }
    public void setImportInvoiceId(int importInvoiceId) { this.importInvoiceId = importInvoiceId; }
    public int getSparePartId() { return sparePartId; }
    public void setSparePartId(int sparePartId) { this.sparePartId = sparePartId; }

    @Override
    public String toString() {
        return "ImportDetail{" +
                "id=" + id +
                ", nameSparePart='" + nameSparePart + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                ", totalAmount=" + totalAmount +
                ", importInvoiceId=" + importInvoiceId +
                ", sparePartId=" + sparePartId +
                '}';
    }

}
