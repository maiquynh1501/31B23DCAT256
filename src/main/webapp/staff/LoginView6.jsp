<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dang nhap</title>
</head>
<body>
<div class="win">
	<%@include file="../header.jsp"%>
	<div class="ttl">Đăng nhập nhân viên quản lý</div>
	<div class="c">
		<%
			// err=timeout: chưa đăng nhập hoặc hết phiên; err=fail: sai tên hoặc mật khẩu
			String err = request.getParameter("err");
			if ("timeout".equalsIgnoreCase(err)) {
		%>
		<p class="error">Hết phiên làm việc. Vui lòng đăng nhập lại!</p>
		<%
			} else if ("fail".equalsIgnoreCase(err)) {
		%>
		<p class="error">Sai tên đăng nhập hoặc mật khẩu!</p>
		<%
			}
		%>

		<%-- gửi tên đăng nhập, mật khẩu sang doLogin6.jsp để kiểm tra --%>
		<form name="login" action="doLogin6.jsp" method="post">
			<div class="row"><label>Tên đăng nhập (*):</label><input class="in" type="text" name="inUsername" id="inUsername" required autofocus /></div>
			<div class="row"><label>Mật khẩu (*):</label><input class="in" type="password" name="inPassword" id="inPassword" required /></div>
			<div class="row"><label></label>
				<input class="btn ok" type="submit" name="subLogin" id="subLogin" value="Đăng nhập" />
				<button type="button" class="btn cancel" onclick="openPage('../index.jsp')">Hủy</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>
