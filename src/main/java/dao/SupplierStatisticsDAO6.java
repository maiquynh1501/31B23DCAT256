package dao;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.SupplierStatistic6;

// Lớp lấy số liệu thống kê nhà cung cấp theo số lượng nhập. Kế thừa DAO6 để dùng chung kết nối con.
public class SupplierStatisticsDAO6 extends DAO6 {
	// Hàm khởi tạo: gọi DAO6() để mở kết nối CSDL nếu chưa có
	public SupplierStatisticsDAO6() {
		super();
	}

	/**
	 * Thống kê nhà cung cấp theo tổng số lượng nhập trong khoảng thời gian,
	 * sắp xếp giảm dần theo tổng số lượng nhập (Hình 29, bước 12–18).
	 * @param startDate ngày bắt đầu thống kê
	 * @param endDate ngày kết thúc thống kê
	 * @return danh sách thống kê, null nếu không có dữ liệu hoặc khoảng thời gian sai
	 */
	public ArrayList<SupplierStatistic6> getSupplierStatistics(Date startDate, Date endDate) {
		ArrayList<SupplierStatistic6> result = null;

		// Kiểm tra đầu vào: phải có đủ 2 ngày và ngày bắt đầu không sau ngày kết thúc
		if (startDate == null || endDate == null || startDate.after(endDate)) return null;
		String sql = "{call getSupplierStatistics(?,?)}"; // bước 13: stored procedure cộng số lượng nhập theo NCC, ORDER BY giảm dần

		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setDate(1, startDate);
			cs.setDate(2, endDate);
			ResultSet rs = cs.executeQuery();

			// Mỗi dòng kết quả là 1 nhà cung cấp, thứ tự dòng đã được procedure sắp xếp sẵn
			while (rs.next()) {
				if (result == null) result = new ArrayList<SupplierStatistic6>(); // có ít nhất 1 dòng mới tạo danh sách

				// Bước 14–16: đóng gói 1 dòng thành đối tượng SupplierStatistic6
				SupplierStatistic6 stat = new SupplierStatistic6();
				stat.setId(rs.getInt("id"));
				stat.setSupplierCode(rs.getString("supplierCode"));
				stat.setName(rs.getString("name"));
				stat.setPhoneNumber(rs.getString("phoneNumber"));
				stat.setEmail(rs.getString("email"));
				stat.setAddress(rs.getString("address"));
				stat.setStartDate(startDate);
				stat.setEndDate(endDate);
				stat.setTotalImportedQuantity(rs.getInt("totalImportedQuantity"));
				stat.setTotalImportAmount(rs.getFloat("totalImportAmount"));
				result.add(stat);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = null;
		}

		return result; // bước 17: trả danh sách về SupplierStatisticsView6.jsp (null = không có dữ liệu, ngoại lệ 8.4)
	}
}
