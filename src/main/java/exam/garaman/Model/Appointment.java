package exam.garaman.Model;

import java.sql.Timestamp;

public class Appointment {
    private int id;
    private Timestamp appointmentTime;
    private String status;
    private int tblCustomerid; // ID của khách hàng

    // Constructor không đối số
   public Appointment() {
    }

    // Constructor với các tham số
    public Appointment(int id, Timestamp appointmentTime, String status, int tblCustomerid) {
        this.id = id;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.tblCustomerid = tblCustomerid;
    }
    // Getter và Setter cho các thuộc tính
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Timestamp getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(Timestamp appointmentTime) { this.appointmentTime = appointmentTime; }
    public String getStatus() { return status;}
    public void setStatus(String status) { this.status = status; }
    public int getTblCustomerid() { return tblCustomerid; }
    public void setTblCustomerid(int tblCustomerid) { this.tblCustomerid = tblCustomerid; }
}
