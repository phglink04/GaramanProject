package exam.garaman.Model;

import java.util.Date;

public class StatsImport extends  ImportInvoice{
    private int quantity;

    public StatsImport(int importInvoiceId, Date dayImport,int quantity, int totalAmount) {
        super(importInvoiceId, dayImport, totalAmount);
        this.quantity = quantity;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
