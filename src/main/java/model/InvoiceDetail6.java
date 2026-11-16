package model;

import java.io.Serializable;

// Lớp thực thể: Một dòng của hóa đơn nhập: phụ tùng, số lượng, đơn giá, thành tiền (bảng tblInvoiceDetail6).
public class InvoiceDetail6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int importedQuantity;
	private float unitPrice;
	private float amount;
	private SparePart6 sparePart;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public InvoiceDetail6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getImportedQuantity() {
		return importedQuantity;
	}

	public void setImportedQuantity(int importedQuantity) {
		this.importedQuantity = importedQuantity;
	}

	public float getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(float unitPrice) {
		this.unitPrice = unitPrice;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public SparePart6 getSparePart() {
		return sparePart;
	}

	public void setSparePart(SparePart6 sparePart) {
		this.sparePart = sparePart;
	}
}
