package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Customer6;

// Lớp truy cập bảng tblCustomer6 (khách hàng). Kế thừa DAO6 để dùng chung kết nối con.
public class CustomerDAO6 extends DAO6 {
	// Hàm khởi tạo: gọi DAO6() để mở kết nối CSDL nếu chưa có
	public CustomerDAO6() {
		super();
	}

	/**
	 * Lưu khách hàng (Hình 27, bước 22–24): nếu số điện thoại đã có thì dùng lại khách hàng cũ
	 * (lấy lại thông tin đã lưu, ngoại lệ 8.1), nếu chưa có thì thêm mới. Kết quả: cus được gán id và customerCode.
	 * @param cus khách hàng đã đóng gói thông tin
	 * @return true nếu lưu thành công
	 */
	public boolean saveCustomer(Customer6 cus) {
		// Kiểm tra đầu vào: bắt buộc có số điện thoại và họ tên
		if (cus == null || cus.getPhoneNumber() == null || cus.getFullName() == null) return false;
		boolean result = false;
		String sqlFind = "SELECT id, customerCode, fullName, email, address FROM tblCustomer6 WHERE phoneNumber = ?";
		String sqlInsert = "INSERT INTO tblCustomer6(fullName, phoneNumber, email, address) VALUES(?,?,?,?)";
		String sqlCode = "UPDATE tblCustomer6 SET customerCode = ? WHERE id = ?";

		try {
			// Tìm khách hàng theo số điện thoại (mỗi số điện thoại chỉ ứng với 1 khách hàng)
			PreparedStatement ps = con.prepareStatement(sqlFind);
			ps.setString(1, cus.getPhoneNumber());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) { // ngoại lệ 8.1: số điện thoại đã tồn tại -> dùng lại khách hàng cũ
				cus.setId(rs.getInt("id"));
				cus.setCustomerCode(rs.getString("customerCode"));
				cus.setFullName(rs.getString("fullName"));
				cus.setEmail(rs.getString("email"));
				cus.setAddress(rs.getString("address"));
			} else { // chưa tồn tại -> thêm khách hàng mới, lấy id tự tăng vừa sinh
				PreparedStatement psInsert = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
				psInsert.setString(1, cus.getFullName());
				psInsert.setString(2, cus.getPhoneNumber());
				psInsert.setString(3, cus.getEmail());
				psInsert.setString(4, cus.getAddress());
				psInsert.executeUpdate();
				ResultSet key = psInsert.getGeneratedKeys();
				if (key.next()) {
					// Gán id, tạo mã khách hàng dạng CUS001 từ id và ghi lại vào CSDL
					cus.setId(key.getInt(1));
					cus.setCustomerCode(String.format("CUS%03d", cus.getId()));
					PreparedStatement psCode = con.prepareStatement(sqlCode);
					psCode.setString(1, cus.getCustomerCode());
					psCode.setInt(2, cus.getId());
					psCode.executeUpdate();
				}
			}
			result = cus.getId() > 0; // có id nghĩa là khách hàng đã nằm trong CSDL
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}

		return result;
	}
}
