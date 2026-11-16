<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dao.*,model.*"%>
<%
	// Trang xử lý đăng nhập: đóng gói username, password -> StaffDAO6 kiểm tra
	ManagementStaff6 staff = new ManagementStaff6();
	staff.setUsername(request.getParameter("inUsername"));
	staff.setPassword(request.getParameter("inPassword"));
	StaffDAO6 dao = new StaffDAO6();
	if (dao.checkLogin(staff)) { // đúng: lưu nhân viên vào session, các trang quản lý đọc lại để biết đã đăng nhập
		session.setAttribute("management", staff);
		response.sendRedirect("../managementstaff/ManagementMainView6.jsp");
	} else { // sai: quay lại trang đăng nhập kèm thông báo
		response.sendRedirect("LoginView6.jsp?err=fail");
	}
%>
