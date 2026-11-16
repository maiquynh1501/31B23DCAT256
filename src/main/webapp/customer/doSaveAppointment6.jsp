<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.Date,java.sql.Time,dao.*,model.*"%>
<%
	// Trang xử lý, không có giao diện: nhận dữ liệu -> đóng gói -> lưu -> chuyển trang
	// Bước 18: nhận thông tin từ các thuộc tính ẩn của AppointmentConfirmationView6.jsp
	String appointmentDate = request.getParameter("hiddenAppointmentDate");
	String appointmentTime = request.getParameter("hiddenAppointmentTime");
	String fullName = request.getParameter("hiddenFullName");
	String phoneNumber = request.getParameter("hiddenPhoneNumber");
	String email = request.getParameter("hiddenEmail");
	String address = request.getParameter("hiddenAddress");

	// Kiểm tra lại dữ liệu trước khi lưu (không tin dữ liệu gửi lên từ trình duyệt)
	if (appointmentDate == null || !appointmentDate.matches("\\d{4}-\\d{2}-\\d{2}")
			|| appointmentTime == null || !appointmentTime.matches("\\d{2}:\\d{2}")
			|| fullName == null || fullName.trim().isEmpty()
			|| phoneNumber == null || !phoneNumber.matches("0\\d{9}")
			|| email == null || !email.matches("[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+")) {
		response.sendRedirect("AppointmentSelectionView6.jsp?err=invalid");
		return;
	}

	// Bước 19–21: đóng gói thông tin khách hàng vào đối tượng Customer6
	Customer6 cus = new Customer6();
	cus.setFullName(fullName.trim());
	cus.setPhoneNumber(phoneNumber);
	cus.setEmail(email);
	cus.setAddress(address == null ? "" : address.trim());

	// Bước 22–24: lưu khách hàng; sau lệnh này cus có id (ngoại lệ 8.1: số điện thoại đã có -> dùng lại khách hàng cũ)
	if (!(new CustomerDAO6()).saveCustomer(cus)) {
		response.sendRedirect("AppointmentSelectionView6.jsp?err=saveFail");
		return;
	}

	// Bước 25–27: đóng gói lịch hẹn vào đối tượng Appointment6, gắn khách hàng vừa lưu
	Appointment6 ap = new Appointment6();
	ap.setAppointmentDate(Date.valueOf(appointmentDate));
	ap.setAppointmentTime(Time.valueOf(appointmentTime + ":00"));
	ap.setStatus("Đã xác nhận");
	ap.setCustomer(cus);

	// Bước 28–30: lưu lịch hẹn
	if ((new AppointmentDAO6()).saveAppointment(ap)) {
		// Bước 31: lưu ap (đã có mã APPxxx) vào session rồi chuyển sang trang kết quả
		session.setAttribute("newAppointment", ap);
		response.sendRedirect("AppointmentResultView6.jsp");
	} else {
		// ngoại lệ 8.2: khung giờ vừa có người đặt -> quay lại bước chọn ngày giờ kèm thông báo
		response.sendRedirect("AppointmentSelectionView6.jsp?err=slotTaken");
	}
%>
