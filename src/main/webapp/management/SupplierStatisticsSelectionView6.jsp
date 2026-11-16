<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.*"%>
<%
	// Lấy nhân viên quản lý đã đăng nhập; chưa đăng nhập (hoặc hết phiên) -> về trang đăng nhập
	ManagementStaff6 manager = (ManagementStaff6) session.getAttribute("management");
	if (manager == null) {
		response.sendRedirect("../LoginView6.jsp?err=timeout");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chon tieu chi thong ke nha cung cap</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Thống kê nhà cung cấp – Chọn tiêu chí</div>
	<div class="c">
		<%-- Hình 29, bước 6–8: hiển thị tiêu chí; click Thống kê theo số lượng nhập -> sang trang thống kê --%>
		<table class="list" id="outsubStatisticsCriteria">
			<tr><th style="width:50px">STT</th><th>Tiêu chí thống kê</th><th>Mô tả</th></tr>
			<tr><td>1</td><td><a href="SupplierStatisticsView6.jsp">Thống kê theo số lượng nhập</a></td>
				<td>Tổng số lượng phụ tùng đã nhập từ mỗi nhà cung cấp trong khoảng thời gian chọn</td></tr>
		</table>
		<button class="btn gray" name="btnBack" id="btnBack" onclick="openPage('StatisticsSelectionView6.jsp')">Quay lại</button>
	</div>
</div>
</body>
</html>
