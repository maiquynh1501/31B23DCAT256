<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
	// Lấy nhân viên quản lý đã đăng nhập; chưa đăng nhập (hoặc hết phiên) -> về trang đăng nhập
	ManagementStaff6 manager = (ManagementStaff6) session.getAttribute("management");
	if (manager == null) {
		response.sendRedirect("../staff/LoginView6.jsp?err=timeout");
		return;
	}

	// Bước 29: nhận thuộc tính ẩn trên link: id hóa đơn
	int invId;

	try {
		invId = Integer.parseInt(request.getParameter("hiddenInvoiceId"));
	} catch (Exception e) { // thiếu hoặc sai id -> về trang thống kê
		response.sendRedirect("SupplierStatisticsView6.jsp");
		return;
	}

	// Bước 30–31: gọi ImportInvoiceDAO6 lấy chi tiết hóa đơn (null nếu không có)
	ImportInvoice6 inv = (new ImportInvoiceDAO6()).getImportInvoiceDetails(invId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chi tiet hoa don nhap</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<% if (inv == null) { %>
	<div class="ttl">Chi tiết hóa đơn nhập</div>
	<div class="c">
		<p class="error">Không tìm thấy hóa đơn nhập.</p><%-- ngoại lệ 12.1 --%>
	<% } else { %>
	<div class="ttl">Chi tiết hóa đơn nhập <%=inv.getInvoiceCode()%></div>
	<div class="c">
		<%-- bước 36: thông tin chung của hóa đơn, nhà cung cấp, nhân viên kho --%>
		<table class="list kv">
			<tr><td>Mã hóa đơn</td><td id="outInvoiceCode"><%=inv.getInvoiceCode()%></td></tr>
			<tr><td>Ngày hóa đơn</td><td id="outInvoiceDate"><%=fmtDate(inv.getInvoiceDate())%></td></tr>
			<tr><td>Mã nhà cung cấp</td><td id="outSupplierCode"><%=inv.getSupplier().getSupplierCode()%></td></tr>
			<tr><td>Tên nhà cung cấp</td><td id="outSupplierName"><%=esc(inv.getSupplier().getName())%></td></tr>
			<tr><td>Số điện thoại nhà cung cấp</td><td id="outSupplierPhone"><%=inv.getSupplier().getPhoneNumber()%></td></tr>
			<tr><td>Địa chỉ nhà cung cấp</td><td id="outSupplierAddress"><%=esc(inv.getSupplier().getAddress())%></td></tr>
			<tr><td>Mã nhân viên kho</td><td id="outStaffCode"><%=inv.getWarehouseStaff().getStaffCode()%></td></tr>
			<tr><td>Tên nhân viên kho</td><td id="outStaffName"><%=esc(inv.getWarehouseStaff().getFullName())%></td></tr>
		</table>

		<%-- bước 36: bảng các phụ tùng trong hóa đơn, dòng cuối là tổng --%>
		<table class="list" id="outSparePartList">
			<tr><th>STT</th><th>Mã phụ tùng</th><th>Tên phụ tùng</th><th>Đơn vị</th>
				<th class="n">Số lượng</th><th class="n">Đơn giá</th><th class="n">Thành tiền</th></tr>
			<%
				ArrayList<InvoiceDetail6> lineList = inv.getInvoiceDetails();
				for (int i = 0; i < lineList.size(); i++) {
					InvoiceDetail6 det = lineList.get(i);
			%>
			<tr>
				<td><%=(i + 1)%></td>
				<td><%=det.getSparePart().getSparePartCode()%></td>
				<td><%=esc(det.getSparePart().getName())%></td>
				<td><%=det.getSparePart().getUnit()%></td>
				<td class="n"><%=det.getImportedQuantity()%></td>
				<td class="n"><%=fmtMoney(det.getUnitPrice())%></td>
				<td class="n"><%=fmtMoney(det.getAmount())%></td>
			</tr>
			<% } %>
			<tr><th colspan="4" class="n">Tổng (chưa bao gồm thuế)</th><th class="n" id="outTotalQuantity"><%=inv.getTotalQuantity()%></th>
				<th></th><th class="n" id="outTotalAmount"><%=fmtMoney(inv.getTotalAmount())%></th></tr>
		</table>

		<%-- thuộc tính ẩn: id hóa đơn --%>
		<input type="hidden" name="hiddenInvoiceId" id="hiddenInvoiceId" value="<%=invId%>" />
	<% } %>

		<%-- Quay lại trang thông tin nhà cung cấp --%>
		<button class="btn gray" name="btnBack" id="btnBack" onclick="history.back()">Quay lại</button>
	</div>
</div>
</body>
</html>
