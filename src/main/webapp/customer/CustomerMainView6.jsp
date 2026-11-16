<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- Trang chủ khách hàng: điểm bắt đầu của module Đặt lịch hẹn (Hình 27, bước 1–2) --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chu khach hang</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Trang chủ khách hàng</div>
	<div class="c">
		<div class="menu">
			<%-- chức năng khác của khách hàng, không thuộc bài này --%>
			<button class="btn gray" onclick="alert('Chức năng chưa được cài đặt trong bài này')">Tìm kiếm thông tin dịch vụ</button>

			<%-- bước 1–2: click Đặt lịch hẹn -> chuyển sang trang chọn ngày giờ --%>
			<button class="btn pri" name="btnBookAppointment" id="btnBookAppointment" onclick="openPage('AppointmentSelectionView6.jsp')">Đặt lịch hẹn</button>
		</div>
	</div>
</div>
</body>
</html>
