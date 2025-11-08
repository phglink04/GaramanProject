package exam.garaman.Model;

import java.util.Date;

public class Member {
    private static int id;
    private String username;
    private String password;
    private Date dob;
    private String address;
    private String phoneNum;
    public Member(){
    }
    public Member(int id, String username, String password, Date dob, String address, String phoneNum) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.dob = dob;
        this.address = address;
        this.phoneNum = phoneNum;
    }

    // Getters and setters
    public static int getId() { return id; }
    public void setId(int id) { this.id = id;}
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhoneNum() { return phoneNum; }
    public void setPhoneNum(String phoneNum) { this.phoneNum = phoneNum; }

    @Override
    public String toString() {
        return "Member{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", dob=" + dob +
                ", address='" + address + '\'' +
                ", phoneNum='" + phoneNum + '\'' +
                '}';
    }
}
