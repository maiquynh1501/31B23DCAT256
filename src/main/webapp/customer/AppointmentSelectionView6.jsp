<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
	// Bước 3: gọi AppointmentDAO6 lấy danh sách ngày, giờ hẹn còn trống (null nếu hết chỗ)
	ArrayList<Appointment6> listSlot = (new AppointmentDAO6()).getAvailableSlots();

	// Giá trị đã chọn trước đó (khi bấm Hủy ở CustomerInformationView6.jsp quay lại đây) để chọn sẵn
	String selectedDate = request.getParameter("inoutAppointmentDate");
	String selectedTime = request.getParameter("inoutAppointmentTime");

	// Mã lỗi do doSaveAppointment6.jsp gửi về khi lưu không được
	String error = request.getParameter("err");

	// Lọc ra các ngày còn khung trống (không trùng lặp, giữ thứ tự tăng dần) để đổ vào ô chọn ngày
	LinkedHashSet<String> dateList = new LinkedHashSet<String>();
	if (listSlot != null)
		for (Appointment6 ap : listSlot)
			dateList.add(ap.getAppointmentDate().toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chon ngay gio hen</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Đặt lịch hẹn – Chọn ngày và giờ hẹn</div>
	<div class="c">
		<%-- thông báo lỗi khi bị đưa quay lại từ doSaveAppointment6.jsp --%>
		<% if ("slotTaken".equals(error)) { %>
		<p class="error">Ngày giờ bạn chọn vừa có người đặt. Vui lòng chọn ngày giờ khác.</p><%-- ngoại lệ 8.2 --%>
		<% } else if ("invalid".equals(error)) { %>
		<p class="error">Thông tin lịch hẹn không hợp lệ. Vui lòng đặt lại.</p>
		<% } else if ("saveFail".equals(error)) { %>
		<p class="error">Không lưu được thông tin. Vui lòng thử lại.</p>
		<% } %>
		<% if (listSlot == null) { %>
		<p class="error">Hiện không còn lịch hẹn trống. Vui lòng quay lại sau.</p><%-- ngoại lệ 2.1 --%>
		<button class="btn cancel" name="btnCancel" id="btnCancel" onclick="openPage('CustomerMainView6.jsp')">Hủy</button>
		<% } else { %>

		<%-- bước 9: hiển thị ngày, giờ còn trống; bước 10–11: submit sang CustomerInformationView6.jsp --%>
		<form name="selectSlot" action="CustomerInformationView6.jsp" method="post">
			<div class="row"><label>Ngày hẹn (*):</label>
				<%-- ô chọn ngày: đổi ngày thì gọi filterTimes() để lọc lại ô giờ --%>
				<select class="in" name="inoutAppointmentDate" id="inoutAppointmentDate" onchange="filterTimes()" required autofocus>
					<% for (String day : dateList) { %>
					<option value="<%=day%>" <%=day.equals(selectedDate) ? "selected" : ""%>><%=fmtDate(java.sql.Date.valueOf(day))%></option>
					<% } %>
				</select></div>
			<div class="row"><label>Giờ hẹn (*):</label>
				<%-- ô chọn giờ: chứa mọi khung trống, mỗi option ghi ngày của nó trong data-day --%>
				<select class="in" name="inoutAppointmentTime" id="inoutAppointmentTime" required>
					<% for (Appointment6 ap : listSlot) {
						String slot = fmtTime(ap.getAppointmentTime()); %>
					<option value="<%=slot%>" data-day="<%=ap.getAppointmentDate()%>"
						<%=(ap.getAppointmentDate().toString().equals(selectedDate) && slot.equals(selectedTime)) ? "selected" : ""%>><%=slot%></option>
					<% } %>
				</select></div>
			<div class="row"><label></label>
				<input class="btn ok" type="submit" name="subContinue" id="subContinue" value="Tiếp tục" />

				<%-- ngoại lệ 3.1: Hủy -> về trang chủ khách hàng --%>
				<button type="button" class="btn cancel" name="btnCancel" id="btnCancel" onclick="openPage('CustomerMainView6.jsp')">Hủy</button>
			</div>
		</form>
		<script type="text/javascript">
			// Chỉ hiện các giờ còn trống của ngày đang chọn, ẩn và khóa giờ của ngày khác
			function filterTimes() {
				var day = document.getElementById("inoutAppointmentDate").value;
				var slot = document.getElementById("inoutAppointmentTime");
				var found = false;
				for (var i = 0; i < slot.options.length; i++) {
					var o = slot.options[i];
					var show = o.getAttribute("data-day") == day;
					o.hidden = !show;
					o.disabled = !show;
					if (show && o.selected) found = true;
				}

				// giờ đang chọn không thuộc ngày mới -> tự chọn giờ đầu tiên của ngày mới
				if (!found) {
					for (var i = 0; i < slot.options.length; i++)
						if (!slot.options[i].disabled) { slot.selectedIndex = i; break; }
				}
			}
			filterTimes(); // lọc ngay khi trang vừa mở
		</script>
		<% } %>
	</div>
</div>
</body>
</html>
