package exam.garaman.Model;

import java.util.Date;

public class Staff  extends Member {
    private String role;

    public Staff(int id, String username, String password, Date dob, String address, String numberPhone, String role) {
        super(id, username, password, dob, address, numberPhone);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
