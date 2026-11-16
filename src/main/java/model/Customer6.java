package model;

import java.io.Serializable;

// Lớp thực thể: Khách hàng (bảng tblCustomer6).
public class Customer6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String customerCode;
	private String fullName;
	private String phoneNumber;
	private String email;
	private String address;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public Customer6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
