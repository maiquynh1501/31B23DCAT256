package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

// Lớp thực thể: Hóa đơn nhập phụ tùng (bảng tblImportInvoice6), gồm nhà cung cấp, nhân viên kho và các dòng chi tiết.
public class ImportInvoice6 implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String invoiceCode;
	private Date invoiceDate;
	private int totalQuantity;
	private float totalAmount;
	private Supplier6 supplier;
	private WarehouseStaff6 warehouseStaff;
	private ArrayList<InvoiceDetail6> invoiceDetails = new ArrayList<InvoiceDetail6>();

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public ImportInvoice6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getInvoiceCode() {
		return invoiceCode;
	}

	public void setInvoiceCode(String invoiceCode) {
		this.invoiceCode = invoiceCode;
	}

	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Supplier6 getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier6 supplier) {
		this.supplier = supplier;
	}

	public WarehouseStaff6 getWarehouseStaff() {
		return warehouseStaff;
	}

	public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) {
		this.warehouseStaff = warehouseStaff;
	}

	public ArrayList<InvoiceDetail6> getInvoiceDetails() {
		return invoiceDetails;
	}

	public void setInvoiceDetails(ArrayList<InvoiceDetail6> invoiceDetails) {
		this.invoiceDetails = invoiceDetails;
	}
}
