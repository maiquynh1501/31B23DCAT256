package dao;

import java.sql.Connection;
import java.sql.DriverManager;

// Lớp cha của mọi lớp DAO: giữ một kết nối CSDL dùng chung (cách làm như trong giáo trình).
public class DAO6 {
	// static: mọi đối tượng DAO dùng chung 1 kết nối, chỉ mở một lần
	public static Connection con;

	// Hàm khởi tạo: nếu chưa có kết nối thì nạp driver MySQL và mở kết nối tới garage_db
	public DAO6() {
		if (con == null) {
			String dbUrl = "jdbc:mysql://localhost:3306/garage_db?autoReconnect=true&useSSL=false"
					+ "&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=UTF-8";
			String dbClass = "com.mysql.cj.jdbc.Driver";

			try {
				Class.forName(dbClass);
				con = DriverManager.getConnection(dbUrl, "root", "123456");
			} catch (Exception e) { // sai mật khẩu, MySQL chưa chạy... -> in lỗi, con vẫn null
				e.printStackTrace();
			}
		}
	}
}
