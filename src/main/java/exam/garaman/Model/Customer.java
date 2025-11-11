package exam.garaman.Model;

import java.util.Date;

public class Customer extends Member {
    private String idCustomer;

    public Customer() {
        super();
    }

    public Customer(int id, String username, String password, Date dob, String address, String phoneNum, String idCustomer) {
        super(id, username, password, dob, address, phoneNum);
        this.idCustomer = idCustomer;
    }

    public String getIdCustomer() {
        return idCustomer;
    }

    public void setIdCustomer(String idCustomer) {
        this.idCustomer = idCustomer;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "idCustomer='" + idCustomer + '\'' +
                ", " + super.toString() +
                '}';
    }

}
