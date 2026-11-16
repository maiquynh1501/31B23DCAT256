package model;

import java.sql.Date;

// Lớp thực thể: Kết quả thống kê 1 nhà cung cấp: kế thừa Supplier6, thêm khoảng thời gian, tổng số lượng nhập và tổng tiền (không có bảng riêng, tính từ CSDL).
public class SupplierStatistic6 extends Supplier6 {
	private Date startDate;
	private Date endDate;
	private int totalImportedQuantity;
	private float totalImportAmount;

	// Hàm khởi tạo không tham số; giá trị được gán qua các hàm set
	public SupplierStatistic6() {
		super();
	}

	// Các hàm get/set để đọc, gán từng thuộc tính private
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getTotalImportedQuantity() {
		return totalImportedQuantity;
	}

	public void setTotalImportedQuantity(int totalImportedQuantity) {
		this.totalImportedQuantity = totalImportedQuantity;
	}

	public float getTotalImportAmount() {
		return totalImportAmount;
	}

	public void setTotalImportAmount(float totalImportAmount) {
		this.totalImportAmount = totalImportAmount;
	}
}
