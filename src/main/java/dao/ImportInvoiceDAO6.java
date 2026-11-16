package dao;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.ImportInvoice6;
import model.InvoiceDetail6;
import model.SparePart6;
import model.Supplier6;
import model.WarehouseStaff6;

// Lớp truy cập hóa đơn nhập (tblImportInvoice6, tblInvoiceDetail6). Kế thừa DAO6 để dùng chung kết nối con.
public class ImportInvoiceDAO6 extends DAO6 {
	// Hàm khởi tạo: gọi DAO6() để mở kết nối CSDL nếu chưa có
	public ImportInvoiceDAO6() {
		super();
	}

	/**
	 * Lấy danh sách hóa đơn nhập của nhà cung cấp @supplierId trong khoảng thời gian (Hình 29, bước 21–27).
	 * @param supplierId id nhà cung cấp
	 * @param startDate ngày bắt đầu thống kê
	 * @param endDate ngày kết thúc thống kê
	 * @return danh sách hóa đơn (có tổng số lượng, tổng tiền), null nếu không có
	 */
	public ArrayList<ImportInvoice6> getImportInvoices(int supplierId, Date startDate, Date endDate) {
		ArrayList<ImportInvoice6> result = null;
		if (startDate == null || endDate == null) return null; // thiếu ngày -> không truy vấn
		String sql = "{call getSupplierInvoices(?,?,?)}"; // bước 22: stored procedure lấy hóa đơn kèm tổng số lượng, tổng tiền

		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setInt(1, supplierId);
			cs.setDate(2, startDate);
			cs.setDate(3, endDate);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				if (result == null) result = new ArrayList<ImportInvoice6>(); // có ít nhất 1 hóa đơn mới tạo danh sách

				// Bước 23–25: đóng gói 1 dòng thành đối tượng ImportInvoice6
				ImportInvoice6 inv = new ImportInvoice6();
				inv.setId(rs.getInt("id"));
				inv.setInvoiceCode(rs.getString("invoiceCode"));
				inv.setInvoiceDate(rs.getDate("invoiceDate"));
				inv.setTotalQuantity(rs.getInt("totalQuantity"));
				inv.setTotalAmount(rs.getFloat("totalAmount"));

				// Gắn nhà cung cấp (chỉ cần id, thông tin đầy đủ trang đã có sẵn)
				Supplier6 sup = new Supplier6();
				sup.setId(supplierId);
				inv.setSupplier(sup);
				result.add(inv);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = null;
		}

		return result; // bước 26: trả danh sách về SupplierDetailsView6.jsp
	}

	/**
	 * Lấy chi tiết hóa đơn nhập @invoiceId (Hình 29, bước 30–36).
	 * @param invoiceId id hóa đơn
	 * @return hóa đơn đã chứa nhà cung cấp, nhân viên kho và danh sách chi tiết; null nếu không tồn tại
	 */
	public ImportInvoice6 getImportInvoiceDetails(int invoiceId) {
		ImportInvoice6 result = null;
		String sqlInvoice = "{call getInvoiceInfo(?)}"; // bước 31: procedure lấy thông tin chung của hóa đơn
		String sqlLines = "{call getInvoiceLines(?)}"; // bước 31: procedure lấy các dòng phụ tùng của hóa đơn

		try {
			// 1. Thông tin chung: hóa đơn + nhà cung cấp + nhân viên kho (1 dòng)
			CallableStatement cs = con.prepareCall(sqlInvoice);
			cs.setInt(1, invoiceId);
			ResultSet rs = cs.executeQuery();
			if (rs.next()) { // không có dòng nào -> result giữ null (ngoại lệ 12.1)

				// Bước 32–34: đóng gói hóa đơn
				result = new ImportInvoice6();
				result.setId(rs.getInt("id"));
				result.setInvoiceCode(rs.getString("invoiceCode"));
				result.setInvoiceDate(rs.getDate("invoiceDate"));

				// Đóng gói nhà cung cấp rồi gắn vào hóa đơn
				Supplier6 sup = new Supplier6();
				sup.setId(rs.getInt("supplierId"));
				sup.setSupplierCode(rs.getString("supplierCode"));
				sup.setName(rs.getString("supplierName"));
				sup.setPhoneNumber(rs.getString("supplierPhone"));
				sup.setEmail(rs.getString("supplierEmail"));
				sup.setAddress(rs.getString("supplierAddress"));
				result.setSupplier(sup);

				// Đóng gói nhân viên kho lập hóa đơn rồi gắn vào hóa đơn
				WarehouseStaff6 staff = new WarehouseStaff6();
				staff.setId(rs.getInt("staffId"));
				staff.setStaffCode(rs.getString("staffCode"));
				staff.setFullName(rs.getString("staffName"));
				result.setWarehouseStaff(staff);

				// 2. Danh sách chi tiết: mỗi dòng là 1 phụ tùng đã nhập trong hóa đơn
				CallableStatement csLines = con.prepareCall(sqlLines);
				csLines.setInt(1, invoiceId);
				ResultSet rsLines = csLines.executeQuery();
				int totalQuantity = 0;
				float totalAmount = 0;
				while (rsLines.next()) {
					// Đóng gói 1 dòng chi tiết, thành tiền = số lượng × đơn giá
					InvoiceDetail6 det = new InvoiceDetail6();
					det.setId(rsLines.getInt("id"));
					det.setImportedQuantity(rsLines.getInt("importedQuantity"));
					det.setUnitPrice(rsLines.getFloat("unitPrice"));
					det.setAmount(det.getImportedQuantity() * det.getUnitPrice());

					// Đóng gói phụ tùng của dòng này rồi gắn vào dòng chi tiết
					SparePart6 sp = new SparePart6();
					sp.setId(rsLines.getInt("sparePartId"));
					sp.setSparePartCode(rsLines.getString("sparePartCode"));
					sp.setName(rsLines.getString("sparePartName"));
					sp.setDescription(rsLines.getString("description"));
					sp.setUnit(rsLines.getString("unit"));
					sp.setUnitPrice(rsLines.getFloat("sparePartPrice"));
					det.setSparePart(sp);
					result.getInvoiceDetails().add(det);

					// Cộng dồn để ra tổng số lượng, tổng tiền của cả hóa đơn
					totalQuantity += det.getImportedQuantity();
					totalAmount += det.getAmount();
				}
				result.setTotalQuantity(totalQuantity);
				result.setTotalAmount(totalAmount);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = null;
		}

		return result; // bước 35: trả hóa đơn về ImportInvoiceDetailsView6.jsp (null = không tìm thấy)
	}
}
