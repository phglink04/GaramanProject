package exam.garaman.Model;

public class Supplier {
    private int id;
    private String nameSupplier;
    private String address;
    private String phoneNumber;
    // Constructor không đối số
    public Supplier(int id, String nameSupplier) {
        this.id = id;
        this.nameSupplier = nameSupplier;
    }
    // Constructor với các tham số
    public Supplier(int id, String nameSupplier, String address, String phoneNumber) {
        this.id = id;
        this.nameSupplier = nameSupplier;
        this.address = address;
        this.phoneNumber = phoneNumber;
    }
    // Getter và Setter cho các thuộc tính
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNameSupplier() { return nameSupplier; }
    public void setNameSupplier(String name) { this.nameSupplier = nameSupplier; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    @Override
    public String toString() {
        return "Supplier{" +
                "id=" + id +
                ", name='" + nameSupplier + '\'' +
                ", address='" + address + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}
