<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.*"%>
<%
	// Lấy nhân viên quản lý đã đăng nhập; chưa đăng nhập (hoặc hết phiên) -> về trang đăng nhập
	ManagementStaff6 manager = (ManagementStaff6) session.getAttribute("management");
	if (manager == null) {
		response.sendRedirect("../staff/LoginView6.jsp?err=timeout");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chu quan ly</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Trang chủ nhân viên quản lý</div>
	<div class="c">
		<div class="menu">
			<%-- Hình 29, bước 1–2: click Báo cáo thống kê -> sang trang chọn loại thống kê --%>
			<button class="btn pri" name="btnStatisticsReport" id="btnStatisticsReport" onclick="openPage('StatisticsSelectionView6.jsp')">Báo cáo thống kê</button>

			<%-- các chức năng khác của quản lý, không thuộc bài này --%>
			<button class="btn gray" onclick="alert('Chức năng chưa được cài đặt trong bài này')">Quản lý thông tin dịch vụ</button>
			<button class="btn gray" onclick="alert('Chức năng chưa được cài đặt trong bài này')">Quản lý thông tin phụ tùng</button>
		</div>
	</div>
</div>
</body>
</html>
