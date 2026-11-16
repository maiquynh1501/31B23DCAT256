package model;

import java.io.Serializable;

// Lớp thực thể: Phụ tùng (bảng tblSparePart6).
public class SparePart6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String sparePartCode;
	private String name;
	private String description;
	private String unit;
	private float unitPrice;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public SparePart6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSparePartCode() {
		return sparePartCode;
	}

	public void setSparePartCode(String sparePartCode) {
		this.sparePartCode = sparePartCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public float getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(float unitPrice) {
		this.unitPrice = unitPrice;
	}
}
