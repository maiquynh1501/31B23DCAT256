<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.sql.Date,dao.*,model.*"%>
<%
	// Lấy nhân viên quản lý đã đăng nhập; chưa đăng nhập (hoặc hết phiên) -> về trang đăng nhập
	ManagementStaff6 manager = (ManagementStaff6) session.getAttribute("management");
	if (manager == null) {
		response.sendRedirect("../LoginView6.jsp?err=timeout");
		return;
	}

	// Bước 10–11: trang submit vào chính nó; có tham số ngày nghĩa là vừa click Xem thống kê -> xử lý
	String sStart = request.getParameter("inStartDate");
	String sEnd = request.getParameter("inEndDate");
	ArrayList<SupplierStatistic6> listStat = null; // kết quả thống kê (null = chưa có / không có dữ liệu)
	String error = null; // thông báo lỗi sẽ in ra dưới form
	Date fromDate = null, toDate = null;
	if (sStart != null || sEnd != null) {
		if (sStart == null || sStart.isEmpty() || sEnd == null || sEnd.isEmpty()) {
			error = "Vui lòng chọn đầy đủ Ngày bắt đầu và Ngày kết thúc."; // ngoại lệ 8.2
		} else {
			// Đổi chuỗi yyyy-MM-dd sang kiểu Date
			try {
				fromDate = Date.valueOf(sStart);
				toDate = Date.valueOf(sEnd);
			} catch (Exception e) {
				error = "Ngày không đúng định dạng.";
			}
			if (error == null) {
				Date today = new Date(System.currentTimeMillis());
				if (fromDate.after(toDate)) {
					error = "Ngày bắt đầu phải nhỏ hơn hoặc bằng Ngày kết thúc."; // ngoại lệ 8.1
				} else if (toDate.toLocalDate().isAfter(today.toLocalDate())) {
					error = "Không thể thống kê cho ngày trong tương lai."; // ngoại lệ 8.3
				} else {
					// Bước 12: ngày hợp lệ -> gọi SupplierStatisticsDAO6 lấy danh sách thống kê
					listStat = (new SupplierStatisticsDAO6()).getSupplierStatistics(fromDate, toDate);

					// Lưu kết quả vào session để SupplierDetailsView6.jsp lấy lại thông tin nhà cung cấp
					session.setAttribute("listSupplierStat", listStat);
					if (listStat == null) {
						error = "Không có dữ liệu nhập hàng từ " + fmtDate(fromDate) + " đến " + fmtDate(toDate) + "."; // ngoại lệ 8.4
					}
				}
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thong ke nha cung cap</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Thống kê nhà cung cấp theo số lượng nhập</div>
	<div class="c">
		<%-- bước 9: ô chọn 2 ngày và nút Xem thống kê; action là chính trang này (đường tự nối) --%>
		<form name="statistics" action="SupplierStatisticsView6.jsp" method="get">
			<div class="row"><label>Ngày bắt đầu (*):</label>
				<input class="in" type="date" name="inStartDate" id="inStartDate" value="<%=sStart == null ? "" : esc(sStart)%>" required autofocus /></div>
			<div class="row"><label>Ngày kết thúc (*):</label>
				<input class="in" type="date" name="inEndDate" id="inEndDate" value="<%=sEnd == null ? "" : esc(sEnd)%>" required /></div>
			<div class="row"><label></label>
				<input class="btn pri" type="submit" name="subViewStatistics" id="subViewStatistics" value="Xem thống kê" />
				<button type="button" class="btn gray" name="btnBack" id="btnBack" onclick="openPage('SupplierStatisticsSelectionView6.jsp')">Quay lại</button>
			</div>
		</form>
		<% if (error != null) { %>
		<p class="error"><%=error%></p>
		<% } %>
		<%
			// Bước 18: có kết quả -> in bảng, đồng thời cộng dồn dòng Tổng ở cuối bảng
			if (listStat != null) {
				int totalQty = 0;
				float totalAmount = 0;
		%>
		<p><b>Kết quả thống kê từ <%=fmtDate(fromDate)%> đến <%=fmtDate(toDate)%></b> (sắp xếp giảm dần theo tổng số lượng nhập)</p>
		<table class="list" id="outsubSupplierList">
			<tr><th>STT</th><th>Mã NCC</th><th>Tên nhà cung cấp</th><th>Số điện thoại</th><th>Địa chỉ</th>
				<th class="n">Tổng số lượng nhập</th><th class="n">Tổng tiền<br>(chưa bao gồm thuế)</th></tr>
			<%
				for (int i = 0; i < listStat.size(); i++) {
					SupplierStatistic6 stat = listStat.get(i);
					totalQty += stat.getTotalImportedQuantity();
					totalAmount += stat.getTotalImportAmount();
			%>
			<tr>
				<td><%=(i + 1)%></td>
				<td><%=stat.getSupplierCode()%></td>
				<td><a href="SupplierDetailsView6.jsp?hiddenSupplierId=<%=stat.getId()%>&hiddenStartDate=<%=fromDate%>&hiddenEndDate=<%=toDate%>"><%=esc(stat.getName())%></a></td><%-- bước 19–20: click tên NCC -> xem hóa đơn của NCC --%>
				<td><%=stat.getPhoneNumber()%></td>
				<td><%=stat.getAddress()%></td>
				<td class="n"><%=stat.getTotalImportedQuantity()%></td>
				<td class="n"><%=fmtMoney(stat.getTotalImportAmount())%></td>
			</tr>
			<% } %>
			<tr><th colspan="5" class="n">Tổng</th><th class="n"><%=totalQty%></th><th class="n"><%=fmtMoney(totalAmount)%></th></tr>
		</table>
		<p class="note">Click vào tên nhà cung cấp để xem danh sách hóa đơn nhập.</p>
		<% } %>
	</div>
</div>
</body>
</html>
