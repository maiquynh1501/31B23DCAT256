<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// Thuộc tính ẩn: ngày, giờ hẹn đã chọn.
	// Lần đầu đến từ AppointmentSelectionView6.jsp thì tên là inout..., các lần submit sau thì là hidden...
	String appointmentDate = request.getParameter("hiddenAppointmentDate");
	if (appointmentDate == null) appointmentDate = request.getParameter("inoutAppointmentDate");
	String appointmentTime = request.getParameter("hiddenAppointmentTime");
	if (appointmentTime == null) appointmentTime = request.getParameter("inoutAppointmentTime");

	// Không có hoặc sai định dạng ngày giờ (mở thẳng trang) -> quay về bước chọn ngày giờ
	if (appointmentDate == null || !appointmentDate.matches("\\d{4}-\\d{2}-\\d{2}")
			|| appointmentTime == null || !appointmentTime.matches("\\d{2}:\\d{2}")) {
		response.sendRedirect("AppointmentSelectionView6.jsp");
		return;
	}

	// Dữ liệu đã nhập: lấy từ ô in... (khi trang submit vào chính nó),
	// nếu không có thì lấy từ hidden... (khi bấm Hủy ở trang xác nhận quay lại – ngoại lệ 7.1)
	String fullName = request.getParameter("inFullName");
	if (fullName == null) fullName = request.getParameter("hiddenFullName");
	String phoneNumber = request.getParameter("inPhoneNumber");
	if (phoneNumber == null) phoneNumber = request.getParameter("hiddenPhoneNumber");
	String email = request.getParameter("inEmail");
	if (email == null) email = request.getParameter("hiddenEmail");
	String address = request.getParameter("inAddress");
	if (address == null) address = request.getParameter("hiddenAddress");
	String errFullName = null, errPhone = null, errEmail = null; // thông báo lỗi cạnh từng ô

	// Bước 13–14: click Đặt lịch (subBook) thì trang submit vào chính nó và tự kiểm tra dữ liệu
	if (request.getParameter("subBook") != null) {
		fullName = fullName == null ? "" : fullName.trim();
		phoneNumber = phoneNumber == null ? "" : phoneNumber.trim();
		email = email == null ? "" : email.trim();
		address = address == null ? "" : address.trim();
		if (fullName.isEmpty()) errFullName = "Vui lòng nhập họ và tên"; // ngoại lệ 6.1
		if (!phoneNumber.matches("0\\d{9}")) errPhone = "Số điện thoại phải gồm 10 chữ số, bắt đầu bằng 0"; // ngoại lệ 6.2
		if (!email.matches("[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+")) errEmail = "Email không đúng định dạng"; // ngoại lệ 6.3
		if (errFullName == null && errPhone == null && errEmail == null) {
			// Bước 15: hợp lệ -> chuyển tiếp (forward) toàn bộ tham số sang trang xác nhận
			request.getRequestDispatcher("AppointmentConfirmationView6.jsp").forward(request, response);
			return;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thong tin khach hang</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Đặt lịch hẹn – Thông tin khách hàng</div>
	<div class="c">
		<p>Lịch hẹn đã chọn: <b><%=fmtDate(java.sql.Date.valueOf(appointmentDate))%> – <%=esc(appointmentTime)%></b></p>

		<%-- bước 12: biểu mẫu thông tin khách hàng; action là chính trang này (đường tự nối) --%>
		<form name="info" action="CustomerInformationView6.jsp" method="post">
			<%-- thuộc tính ẩn: mang ngày, giờ đã chọn qua các lần submit --%>
			<input type="hidden" name="hiddenAppointmentDate" id="hiddenAppointmentDate" value="<%=esc(appointmentDate)%>" />
			<input type="hidden" name="hiddenAppointmentTime" id="hiddenAppointmentTime" value="<%=esc(appointmentTime)%>" />

			<%-- 4 ô nhập; giữ lại giá trị đã nhập và hiện lỗi cạnh ô nếu có --%>
			<div class="row"><label>Họ và tên (*):</label><input class="in" type="text" name="inFullName" id="inFullName" maxlength="100" value="<%=esc(fullName)%>" autofocus />
				<% if (errFullName != null) { %><span class="error-field"><%=errFullName%></span><% } %></div>
			<div class="row"><label>Số điện thoại (*):</label><input class="in" type="text" name="inPhoneNumber" id="inPhoneNumber" maxlength="10" value="<%=esc(phoneNumber)%>" />
				<% if (errPhone != null) { %><span class="error-field"><%=errPhone%></span><% } %></div>
			<div class="row"><label>Email (*):</label><input class="in" type="text" name="inEmail" id="inEmail" maxlength="100" value="<%=esc(email)%>" />
				<% if (errEmail != null) { %><span class="error-field"><%=errEmail%></span><% } %></div>
			<div class="row"><label>Địa chỉ:</label><input class="in" type="text" name="inAddress" id="inAddress" maxlength="255" value="<%=esc(address)%>" /></div>
			<p class="note">(*) bắt buộc nhập</p>
			<input class="btn ok" type="submit" name="subBook" id="subBook" value="Đặt lịch" />

			<%-- Hủy: quay lại chọn ngày giờ, gửi kèm ngày giờ đã chọn để trang đó chọn sẵn --%>
			<button type="button" class="btn cancel" name="btnCancel" id="btnCancel"
				onclick="openPage('AppointmentSelectionView6.jsp?inoutAppointmentDate=<%=esc(appointmentDate)%>&inoutAppointmentTime=<%=esc(appointmentTime)%>')">Hủy</button>
		</form>
	</div>
</div>
</body>
</html>
