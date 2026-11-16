<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Garage ABC</title>
</head>
<body>
<div class="win">
	<%@include file="header.jsp"%>
	<div class="ttl">Hệ thống quản lý Garage ABC</div>
	<div class="c">
		<%-- trang đầu: chọn vào phần khách hàng hoặc đăng nhập nhân viên --%>
		<div class="menu">
			<button class="btn pri" onclick="openPage('customer/CustomerMainView6.jsp')">Khách hàng – Đặt lịch hẹn</button>
			<button class="btn gray" onclick="openPage('LoginView6.jsp')">Nhân viên – Đăng nhập</button>
		</div>
	</div>
</div>
</body>
</html>
