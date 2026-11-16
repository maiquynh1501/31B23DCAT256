package model;

import java.io.Serializable;

// Lớp thực thể: Nhà cung cấp phụ tùng (bảng tblSupplier6).
public class Supplier6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String supplierCode;
	private String name;
	private String phoneNumber;
	private String email;
	private String address;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public Supplier6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
