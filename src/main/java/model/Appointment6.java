package model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

// Lớp thực thể: Lịch hẹn sửa xe của khách hàng (bảng tblAppointment6). customer: khách hàng đặt lịch.
public class Appointment6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String appointmentCode;
	private Date appointmentDate;
	private Time appointmentTime;
	private String status;
	private Customer6 customer;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public Appointment6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAppointmentCode() {
		return appointmentCode;
	}

	public void setAppointmentCode(String appointmentCode) {
		this.appointmentCode = appointmentCode;
	}

	public Date getAppointmentDate() {
		return appointmentDate;
	}

	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	public Time getAppointmentTime() {
		return appointmentTime;
	}

	public void setAppointmentTime(Time appointmentTime) {
		this.appointmentTime = appointmentTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Customer6 getCustomer() {
		return customer;
	}

	public void setCustomer(Customer6 customer) {
		this.customer = customer;
	}
}
