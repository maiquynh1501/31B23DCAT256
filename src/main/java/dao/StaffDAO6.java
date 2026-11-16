package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

import model.ManagementStaff6;

// Lớp truy cập bảng tblStaff6, dùng cho đăng nhập nhân viên quản lý. Kế thừa DAO6 để dùng chung kết nối con.
public class StaffDAO6 extends DAO6 {
	// Hàm khởi tạo: gọi DAO6() để mở kết nối CSDL nếu chưa có
	public StaffDAO6() {
		super();
	}

	/**
	 * Kiểm tra đăng nhập của nhân viên quản lý.
	 * @param staff đối tượng đã có username, password
	 * @return true nếu đúng, đồng thời gán id, mã, họ tên... cho staff
	 */
	public boolean checkLogin(ManagementStaff6 staff) {
		boolean result = false;
		if (staff.getUsername() == null || staff.getPassword() == null) return false; // thiếu tên hoặc mật khẩu
		String sql = "{call checkLogin(?,?)}"; // stored procedure tìm nhân viên quản lý khớp username, password

		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setString(1, staff.getUsername());
			cs.setString(2, staff.getPassword());
			ResultSet rs = cs.executeQuery();
			if (rs.next()) { // có dòng trả về -> đăng nhập đúng, nạp thông tin nhân viên vào staff
				staff.setId(rs.getInt("id"));
				staff.setStaffCode(rs.getString("staffCode"));
				staff.setFullName(rs.getString("fullName"));
				staff.setPhoneNumber(rs.getString("phoneNumber"));
				staff.setEmail(rs.getString("email"));
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}

		return result;
	}
}
