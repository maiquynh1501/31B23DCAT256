<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.*"%>
<%
	// Bước 32: lấy lịch hẹn vừa lưu mà doSaveAppointment6.jsp để trong session
	Appointment6 ap = (Appointment6) session.getAttribute("newAppointment");
	if (ap == null) { // mở thẳng trang khi chưa đặt lịch -> về trang chủ khách hàng
		response.sendRedirect("CustomerMainView6.jsp");
		return;
	}
	Customer6 cus = ap.getCustomer(); // khách hàng đã được gắn vào lịch hẹn lúc đóng gói
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ket qua dat lich</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Đặt lịch hẹn thành công</div>
	<div class="c">
		<p class="notice">Đặt lịch hẹn thành công! Garage sẽ liên hệ với Quý khách qua số <%=esc(cus.getPhoneNumber())%>.</p>

		<%-- bước 32: hiển thị 8 thông tin của lịch hẹn vừa đặt, gồm mã lịch hẹn và trạng thái --%>
		<table class="list kv">
			<tr><td>Mã lịch hẹn</td><td id="outAppointmentCode"><%=ap.getAppointmentCode()%></td></tr>
			<tr><td>Ngày hẹn</td><td id="outAppointmentDate"><%=fmtDate(ap.getAppointmentDate())%></td></tr>
			<tr><td>Giờ hẹn</td><td id="outAppointmentTime"><%=fmtTime(ap.getAppointmentTime())%></td></tr>
			<tr><td>Họ và tên</td><td id="outFullName"><%=esc(cus.getFullName())%></td></tr>
			<tr><td>Số điện thoại</td><td id="outPhoneNumber"><%=esc(cus.getPhoneNumber())%></td></tr>
			<tr><td>Email</td><td id="outEmail"><%=esc(cus.getEmail())%></td></tr>
			<tr><td>Địa chỉ</td><td id="outAddress"><%=esc(cus.getAddress())%></td></tr>
			<tr><td>Trạng thái</td><td id="outStatus"><%=ap.getStatus()%></td></tr>
		</table>

		<%-- Về trang chủ: nút chỉ chuyển trang --%>
		<button class="btn pri" name="btnBackToHome" id="btnBackToHome" onclick="openPage('CustomerMainView6.jsp')" autofocus>Về trang chủ</button>
	</div>
</div>
</body>
</html>
