<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// Bước 16: nhận dữ liệu từ CustomerInformationView6.jsp (đã kiểm tra hợp lệ, chuyển tiếp bằng forward)
	String appointmentDate = request.getParameter("hiddenAppointmentDate");
	String appointmentTime = request.getParameter("hiddenAppointmentTime");
	String fullName = request.getParameter("inFullName");
	String phoneNumber = request.getParameter("inPhoneNumber");
	String email = request.getParameter("inEmail");
	String address = request.getParameter("inAddress");

	// Mở thẳng trang này mà không qua bước trước -> quay về bước chọn ngày giờ
	if (appointmentDate == null || appointmentTime == null || fullName == null || phoneNumber == null) {
		response.sendRedirect("AppointmentSelectionView6.jsp");
		return;
	}

	// Bỏ khoảng trắng thừa ở đầu, cuối
	fullName = fullName.trim();
	phoneNumber = phoneNumber.trim();
	email = email == null ? "" : email.trim();
	address = address == null ? "" : address.trim();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Xac nhan lich hen</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Đặt lịch hẹn – Xác nhận lịch hẹn</div>
	<div class="c">
		<p>Quý khách vui lòng kiểm tra lại thông tin trước khi xác nhận:</p>

		<%-- bước 16: hiển thị 6 thông tin để khách hàng kiểm tra lại --%>
		<table class="list kv">
			<tr><td>Ngày hẹn</td><td id="outAppointmentDate"><%=fmtDate(java.sql.Date.valueOf(appointmentDate))%></td></tr>
			<tr><td>Giờ hẹn</td><td id="outAppointmentTime"><%=esc(appointmentTime)%></td></tr>
			<tr><td>Họ và tên</td><td id="outFullName"><%=esc(fullName)%></td></tr>
			<tr><td>Số điện thoại</td><td id="outPhoneNumber"><%=esc(phoneNumber)%></td></tr>
			<tr><td>Email</td><td id="outEmail"><%=esc(email)%></td></tr>
			<tr><td>Địa chỉ</td><td id="outAddress"><%=esc(address)%></td></tr>
		</table>

		<%-- bước 17–18: click Xác nhận đặt lịch -> gửi sang doSaveAppointment6.jsp để lưu --%>
		<form name="confirm" action="doSaveAppointment6.jsp" method="post">
			<%-- thuộc tính ẩn: chứa lại toàn bộ dữ liệu để gửi đi --%>
			<input type="hidden" name="hiddenAppointmentDate" id="hiddenAppointmentDate" value="<%=esc(appointmentDate)%>" />
			<input type="hidden" name="hiddenAppointmentTime" id="hiddenAppointmentTime" value="<%=esc(appointmentTime)%>" />
			<input type="hidden" name="hiddenFullName" id="hiddenFullName" value="<%=esc(fullName)%>" />
			<input type="hidden" name="hiddenPhoneNumber" id="hiddenPhoneNumber" value="<%=esc(phoneNumber)%>" />
			<input type="hidden" name="hiddenEmail" id="hiddenEmail" value="<%=esc(email)%>" />
			<input type="hidden" name="hiddenAddress" id="hiddenAddress" value="<%=esc(address)%>" />
			<input class="btn ok" type="submit" name="subConfirmBooking" id="subConfirmBooking" value="Xác nhận đặt lịch" autofocus />

			<%-- ngoại lệ 7.1: Hủy -> gửi cùng form về CustomerInformationView6.jsp (formaction) để giữ dữ liệu đã nhập --%>
			<input class="btn cancel" type="submit" name="subCancel" id="subCancel" value="Hủy" formaction="CustomerInformationView6.jsp" />
		</form>
	</div>
</div>
</body>
</html>
