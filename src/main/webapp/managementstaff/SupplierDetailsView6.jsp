<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.sql.Date,dao.*,model.*"%>
<%
	// Lấy nhân viên quản lý đã đăng nhập; chưa đăng nhập (hoặc hết phiên) -> về trang đăng nhập
	ManagementStaff6 manager = (ManagementStaff6) session.getAttribute("management");
	if (manager == null) {
		response.sendRedirect("../staff/LoginView6.jsp?err=timeout");
		return;
	}

	// Bước 20: nhận thuộc tính ẩn trên link: id nhà cung cấp, ngày bắt đầu, ngày kết thúc
	int supplierId;
	Date fromDate, toDate;

	try {
		supplierId = Integer.parseInt(request.getParameter("hiddenSupplierId"));
		fromDate = Date.valueOf(request.getParameter("hiddenStartDate"));
		toDate = Date.valueOf(request.getParameter("hiddenEndDate"));
	} catch (Exception e) { // thiếu hoặc sai tham số -> về trang thống kê
		response.sendRedirect("SupplierStatisticsView6.jsp");
		return;
	}

	// Thông tin nhà cung cấp lấy từ kết quả thống kê SupplierStatisticsView6.jsp đã lưu trong session
	SupplierStatistic6 sup = null;
	ArrayList<SupplierStatistic6> listStat = (ArrayList<SupplierStatistic6>) session.getAttribute("listSupplierStat");
	if (listStat != null)
		for (SupplierStatistic6 stat : listStat)
			if (stat.getId() == supplierId) {
				sup = stat;
				break;
			}
	if (sup == null) { // không có trong kết quả thống kê -> về trang thống kê
		response.sendRedirect("SupplierStatisticsView6.jsp");
		return;
	}

	// Bước 21–22: gọi ImportInvoiceDAO6 lấy danh sách hóa đơn nhập của nhà cung cấp trong khoảng thời gian
	ArrayList<ImportInvoice6> listInvoice = (new ImportInvoiceDAO6()).getImportInvoices(supplierId, fromDate, toDate);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thong tin nha cung cap</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Thông tin nhà cung cấp và danh sách hóa đơn nhập</div>
	<div class="c">
		<%-- bước 27: thông tin nhà cung cấp --%>
		<table class="list kv">
			<tr><td>Mã nhà cung cấp</td><td id="outSupplierCode"><%=sup.getSupplierCode()%></td></tr>
			<tr><td>Tên nhà cung cấp</td><td id="outSupplierName"><%=esc(sup.getName())%></td></tr>
			<tr><td>Số điện thoại</td><td id="outPhoneNumber"><%=sup.getPhoneNumber()%></td></tr>
			<tr><td>Địa chỉ</td><td id="outAddress"><%=esc(sup.getAddress())%></td></tr>
			<tr><td>Thời gian thống kê</td><td id="outStatisticsPeriod"><%=fmtDate(fromDate)%> – <%=fmtDate(toDate)%></td></tr>
			<tr><td>Tổng số lượng nhập</td><td id="outTotalImportedQuantity"><%=sup.getTotalImportedQuantity()%></td></tr>
			<tr><td>Tổng tiền (chưa bao gồm thuế)</td><td id="outTotalAmount"><%=fmtMoney(sup.getTotalImportAmount())%></td></tr>
		</table>
		<% if (listInvoice == null) { %>
		<p class="error">Không tải được danh sách hóa đơn, vui lòng thử lại.</p>
		<% } else { %>

		<%-- bước 27: danh sách hóa đơn nhập của nhà cung cấp --%>
		<table class="list" id="outsubImportInvoiceList">
			<tr><th>STT</th><th>Mã hóa đơn</th><th>Ngày hóa đơn</th><th class="n">Số lượng</th><th class="n">Tổng tiền (chưa bao gồm thuế)</th></tr>
			<%
				for (int i = 0; i < listInvoice.size(); i++) {
					ImportInvoice6 inv = listInvoice.get(i);
			%>
			<tr>
				<td><%=(i + 1)%></td>
				<td><a href="ImportInvoiceDetailsView6.jsp?hiddenInvoiceId=<%=inv.getId()%>"><%=inv.getInvoiceCode()%></a></td><%-- bước 28–29: click mã hóa đơn -> xem chi tiết --%>
				<td><%=fmtDate(inv.getInvoiceDate())%></td>
				<td class="n"><%=inv.getTotalQuantity()%></td>
				<td class="n"><%=fmtMoney(inv.getTotalAmount())%></td>
			</tr>
			<% } %>
		</table>
		<p class="note">Click vào mã hóa đơn để xem chi tiết.</p>
		<% } %>

		<%-- thuộc tính ẩn: id nhà cung cấp, ngày bắt đầu, ngày kết thúc --%>
		<input type="hidden" name="hiddenSupplierId" id="hiddenSupplierId" value="<%=supplierId%>" />
		<input type="hidden" name="hiddenStartDate" id="hiddenStartDate" value="<%=fromDate%>" />
		<input type="hidden" name="hiddenEndDate" id="hiddenEndDate" value="<%=toDate%>" />

		<%-- Quay lại trang thống kê (trình duyệt giữ lại kết quả đã xem) --%>
		<button class="btn gray" name="btnBack" id="btnBack" onclick="history.back()">Quay lại</button>
	</div>
</div>
</body>
</html>
