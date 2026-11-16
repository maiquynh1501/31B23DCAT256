<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	session.invalidate(); // hủy phiên làm việc (xóa nhân viên đã đăng nhập) rồi về trang đăng nhập
	response.sendRedirect("LoginView6.jsp");
%>
