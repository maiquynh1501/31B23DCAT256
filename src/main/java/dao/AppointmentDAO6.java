package dao;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;

import model.Appointment6;

// Lớp truy cập bảng tblAppointment6 (lịch hẹn). Kế thừa DAO6 để dùng chung kết nối con.
public class AppointmentDAO6 extends DAO6 {
	// Hàm khởi tạo: gọi DAO6() để mở kết nối CSDL nếu chưa có
	public AppointmentDAO6() {
		super();
	}

	/**
	 * Lấy danh sách ngày, giờ hẹn còn trống trong 7 ngày tới (Hình 27, bước 4–8).
	 * @return danh sách Appointment6 (chỉ có appointmentDate, appointmentTime), null nếu hết chỗ
	 */
	public ArrayList<Appointment6> getAvailableSlots() {
		ArrayList<Appointment6> result = null;

		// Các giờ garage nhận lịch hẹn trong ngày, và số ngày tới khách hàng được chọn
		String[] workingHours = { "08:00", "09:00", "10:00", "11:00", "13:30", "14:30", "15:30", "16:30" };
		int bookingDaysAhead = 7;
		String sql = "{call getBookedSlots()}"; // bước 5: gọi stored procedure lấy các khung đã có người đặt

		try {
			// Bước 5: đọc các cặp "ngày giờ" đã đặt vào tập booked để tra nhanh
			HashSet<String> booked = new HashSet<String>();
			CallableStatement cs = con.prepareCall(sql);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				booked.add(rs.getDate("appointmentDate").toString() + " " + rs.getTime("appointmentTime").toString().substring(0, 5));
			}

			// Sinh mọi khung ngày–giờ từ ngày mai đến 7 ngày tới, bỏ qua khung đã có trong booked
			LocalDate today = LocalDate.now();
			for (int i = 1; i <= bookingDaysAhead; i++) {
				Date day = Date.valueOf(today.plusDays(i));
				for (String slot : workingHours) {
					if (booked.contains(day.toString() + " " + slot)) continue; // khung đã đặt -> bỏ qua
					if (result == null) result = new ArrayList<Appointment6>(); // có ít nhất 1 khung trống mới tạo danh sách

					// Bước 5–6: đóng gói mỗi khung trống thành một đối tượng Appointment6
					Appointment6 ap = new Appointment6();
					ap.setAppointmentDate(day);
					ap.setAppointmentTime(Time.valueOf(slot + ":00"));
					result.add(ap);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = null; // lỗi CSDL -> coi như không có khung trống
		}

		return result; // bước 7–8: trả danh sách về AppointmentSelectionView6.jsp (null = hết chỗ, ngoại lệ 2.1)
	}

	/**
	 * Lưu lịch hẹn đã được đóng gói (khách hàng phải đã có id) (Hình 27, bước 28–30).
	 * Kết quả: ap được gán id và appointmentCode.
	 * @param ap lịch hẹn
	 * @return true nếu lưu thành công; false nếu thiếu thông tin hoặc khung giờ đã bị đặt
	 */
	public boolean saveAppointment(Appointment6 ap) {
		// Kiểm tra đầu vào: phải có ngày, giờ và khách hàng đã được lưu (id > 0)
		if (ap == null || ap.getAppointmentDate() == null || ap.getAppointmentTime() == null
				|| ap.getCustomer() == null || ap.getCustomer().getId() <= 0) return false;
		boolean result = false;
		String sqlInsert = "INSERT INTO tblAppointment6(appointmentDate, appointmentTime, status, tblCustomer6id) VALUES(?,?,?,?)";
		String sqlCode = "UPDATE tblAppointment6 SET appointmentCode = ? WHERE id = ?";

		try {
			// Thêm lịch hẹn mới, yêu cầu MySQL trả lại id tự tăng vừa sinh
			PreparedStatement ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
			ps.setDate(1, ap.getAppointmentDate());
			ps.setTime(2, ap.getAppointmentTime());
			ps.setString(3, ap.getStatus());
			ps.setInt(4, ap.getCustomer().getId());
			ps.executeUpdate(); // ngoại lệ 8.2: trùng (appointmentDate, appointmentTime) -> lỗi UNIQUE -> nhảy vào catch
			ResultSet key = ps.getGeneratedKeys();
			if (key.next()) {
				// Gán id vừa sinh, rồi tạo mã lịch hẹn dạng APP001 từ id và ghi lại vào CSDL
				ap.setId(key.getInt(1));
				ap.setAppointmentCode(String.format("APP%03d", ap.getId()));
				PreparedStatement psCode = con.prepareStatement(sqlCode);
				psCode.setString(1, ap.getAppointmentCode());
				psCode.setInt(2, ap.getId());
				psCode.executeUpdate();
				result = true; // bước 30: lưu thành công
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = false; // lưu thất bại (khung giờ vừa bị người khác đặt, hoặc lỗi CSDL)
		}

		return result;
	}
}
