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
<title>Chon loai thong ke</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Báo cáo thống kê – Chọn loại thống kê</div>
	<div class="c">
		<p>Chọn loại thống kê muốn xem:</p>

		<%-- Hình 29, bước 3: bảng các loại thống kê; chỉ dòng 4 (nhà cung cấp) thuộc bài này --%>
		<table class="list" id="outsubStatisticsTypeList">
			<tr><th style="width:50px">STT</th><th>Loại thống kê</th><th>Mô tả</th></tr>
			<tr><td>1</td><td><a onclick="alert('Chức năng chưa được cài đặt trong bài này')">Thống kê dịch vụ</a></td><td>Thống kê các dịch vụ garage đã cung cấp</td></tr>
			<tr><td>2</td><td><a onclick="alert('Chức năng chưa được cài đặt trong bài này')">Thống kê phụ tùng</a></td><td>Thống kê các phụ tùng đã bán / sử dụng</td></tr>
			<tr><td>3</td><td><a onclick="alert('Chức năng chưa được cài đặt trong bài này')">Thống kê khách hàng</a></td><td>Thống kê khách hàng theo doanh thu</td></tr>
			<%-- bước 4–5: click Thống kê nhà cung cấp -> sang trang chọn tiêu chí --%>
			<tr><td>4</td><td><a href="SupplierStatisticsSelectionView6.jsp">Thống kê nhà cung cấp</a></td><td>Thống kê nhà cung cấp theo số lượng phụ tùng nhập</td></tr>
		</table>
		<button class="btn gray" name="btnBack" id="btnBack" onclick="openPage('ManagementMainView6.jsp')">Quay lại</button>
	</div>
</div>
</body>
</html>
