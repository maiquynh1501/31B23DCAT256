# GarageManagement – Đề 31

Cài đặt 2 module của hệ thống quản lý garage:

- **Book an Appointment Online 6**: khách hàng đặt lịch hẹn trực tuyến.
- **View Supplier Statistics 6**: nhân viên quản lý xem thống kê nhà cung cấp theo số lượng nhập.

Công nghệ: Java 17, JSP chạy trên Apache Tomcat 9, JDBC, MySQL 8, Maven. Trang JSP gọi các lớp DAO, DAO truy cập CSDL qua JDBC và đóng gói kết quả thành lớp thực thể.

## Cấu trúc

```
GarageManagement/
├─ database/garage_db.sql      tạo CSDL garage_db, stored procedure và dữ liệu mẫu
├─ src/main/java/
│  ├─ model/                   lớp thực thể
│  └─ dao/                     lớp DAO (DAO6 giữ kết nối dùng chung)
├─ src/main/webapp/
│  ├─ customer/                trang JSP module Book an Appointment Online 6
│  ├─ managementstaff/         trang JSP module View Supplier Statistics 6
│  ├─ staff/                   trang đăng nhập, đăng xuất
│  ├─ header.jsp, index.jsp
│  └─ WEB-INF/web.xml
└─ pom.xml
```

## Cách chạy

1. Chạy file `database/garage_db.sql` trong MySQL để tạo CSDL `garage_db`.
2. Kiểm tra tài khoản MySQL trong `src/main/java/dao/DAO6.java` (mặc định `root` / `123456`).
3. Mở thư mục `GarageManagement` bằng IntelliJ IDEA (dự án Maven), chạy trên Tomcat 9 với context `/GarageManagement`.
4. Mở `http://localhost:<cổng>/GarageManagement/`.

## Dữ liệu dùng thử

- Nhân viên quản lý: tên đăng nhập `quanly`, mật khẩu `123456`.
- Khách hàng không cần đăng nhập.
- Thống kê từ 01/09/2026 đến 21/09/2026: SUP002 XYZ Parts 160, SUP001 ABC Parts 130; hóa đơn IMP001 có 80 phụ tùng, 13,000,000.
