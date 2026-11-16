<%@ page pageEncoding="UTF-8"%>
<%-- Phần dùng chung, được mọi trang chèn vào bằng chỉ thị include:
     các hàm định dạng, CSS, hàm openPage, thanh tiêu đề "Xin chào ..." --%>
<%!
	// định dạng tiền: 13000000 -> 13,000,000
	String fmtMoney(float x) {
		return String.format("%,.0f", x);
	}

	// định dạng ngày: 2026-09-05 -> 05/09/2026
	String fmtDate(java.sql.Date d) {
		return d == null ? "" : new java.text.SimpleDateFormat("dd/MM/yyyy").format(d);
	}

	// định dạng giờ: 09:00:00 -> 09:00
	String fmtTime(java.sql.Time t) {
		return t == null ? "" : t.toString().substring(0, 5);
	}

	// chống chèn mã HTML khi in dữ liệu người dùng nhập (đổi < > & " thành mã HTML)
	String esc(String s) {
		if (s == null) return "";
		return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
	}
%>

<%-- giao diện chung: khung cửa sổ, bảng, nút, ô nhập, thông báo lỗi --%>
<style>
body{margin:0;font-family:Arial,Helvetica,sans-serif;font-size:15px;background:#eef1f5;color:#222}
.win{max-width:820px;margin:20px auto;background:#fff;border:1px solid #888}
.top{background:#1f4e79;color:#fff;padding:10px 14px;display:flex;justify-content:space-between;align-items:center}
.top b{font-size:17px}.top span{font-size:14px}.top a{color:#fff}
.ttl{background:#deebf7;padding:8px 14px;font-weight:bold;font-size:16px;border-bottom:1px solid #9dc3e6}
.c{padding:14px}
table.list{border-collapse:collapse;width:100%;margin:8px 0}
table.list th,table.list td{border:1px solid #999;padding:6px 8px;text-align:left}
table.list th{background:#f2f2f2}
.n{text-align:right !important}
.kv td:first-child{width:240px;background:#fafafa;font-weight:bold}
a{color:#0645ad;text-decoration:underline;cursor:pointer}
.btn{display:inline-block;padding:7px 18px;border-radius:4px;color:#fff;font-weight:bold;font-size:15px;margin-right:10px;border:1px solid #333;cursor:pointer}
.ok{background:#2e7d32}.cancel{background:#c62828}.pri{background:#1565c0}.gray{background:#6d6d6d}
.row{display:flex;align-items:center;margin:8px 0}
.row label{width:170px}
.in{border:1px solid #555;background:#fff;padding:5px 8px;width:240px;font-size:15px;box-shadow:inset 1px 1px 2px #bbb}
.menu .btn{display:block;width:260px;margin:10px 0;text-align:center}
.note{color:#555;font-size:13px;font-style:italic}
.error{color:#c62828;font-weight:bold}
.error-field{color:#c62828;font-size:13px;margin-left:10px}
.notice{color:#2e7d32;font-weight:bold}
</style>
<script type="text/javascript">
	// nút chỉ chuyển trang (btn...) gọi hàm này để mở trang p
	function openPage(p) {
		window.location.href = p;
	}
</script>
<%
	// Lời chào: trang quản lý đã đăng nhập thì chào tên quản lý, trang khách hàng thì chào Quý khách
	model.ManagementStaff6 hdrManager = (model.ManagementStaff6) session.getAttribute("management");
	boolean hdrManagerPage = request.getRequestURI().contains("/management/");
	String hdrCtx = request.getContextPath();
%>
<div class="top">
	<b>GARAGE ABC</b>
	<span>
	<% if (hdrManagerPage && hdrManager != null) { %>
		Xin chào, Quản lý <u><%=esc(hdrManager.getFullName())%></u> &nbsp;|&nbsp; <a href="<%=hdrCtx%>/doLogout6.jsp">Đăng xuất</a>
	<% } else { %>
		Xin chào, Quý khách &nbsp;|&nbsp; <a href="<%=hdrCtx%>/index.jsp">Trang chủ</a>
	<% } %>
	</span>
</div>
