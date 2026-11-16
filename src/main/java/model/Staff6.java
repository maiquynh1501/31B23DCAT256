package model;

import java.io.Serializable;

// Lớp thực thể: Nhân viên (bảng tblStaff6), lớp cha của ManagementStaff6 và WarehouseStaff6.
public class Staff6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String staffCode;
	private String fullName;
	private String phoneNumber;
	private String email;
	private String username;
	private String password;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public Staff6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStaffCode() {
		return staffCode;
	}

	public void setStaffCode(String staffCode) {
		this.staffCode = staffCode;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
