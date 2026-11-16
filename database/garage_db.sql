-- =====================================================================
-- CSDL he thong quan ly Garage - De 31 (theo muc 4.2 Thiet ke CSDL)
-- Chay toan bo file nay trong MySQL Workbench (Ctrl+Shift+Enter)
-- =====================================================================
DROP DATABASE IF EXISTS garage_db;
CREATE DATABASE garage_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE garage_db;

-- ---------------------------------------------------------------- Bang
CREATE TABLE tblStaff6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staffCode VARCHAR(20) NOT NULL UNIQUE,
  fullName VARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);
CREATE TABLE tblSaleStaff6 (
  tblStaff6id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblManagementStaff6 (
  tblStaff6id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblWarehouseStaff6 (
  tblStaff6id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblTechnicalStaff6 (
  tblStaff6id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblCustomer6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customerCode VARCHAR(20) UNIQUE,
  fullName VARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(15) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL,
  address VARCHAR(255) NOT NULL
);
CREATE TABLE tblService6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  serviceCode VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) NULL,
  price FLOAT NOT NULL
);
CREATE TABLE tblServiceRequest6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  requestCode VARCHAR(20) NOT NULL UNIQUE,
  requestDate DATE NOT NULL,
  status VARCHAR(50) NOT NULL,
  tblCustomer6id INT NOT NULL,
  tblService6id INT NOT NULL,
  tblSaleStaff6id INT NOT NULL,
  tblTechnicalStaff6id INT NULL,
  FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(id),
  FOREIGN KEY (tblService6id) REFERENCES tblService6(id),
  FOREIGN KEY (tblSaleStaff6id) REFERENCES tblSaleStaff6(tblStaff6id),
  FOREIGN KEY (tblTechnicalStaff6id) REFERENCES tblTechnicalStaff6(tblStaff6id)
);
CREATE TABLE tblAppointment6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  appointmentCode VARCHAR(20) UNIQUE,
  appointmentDate DATE NOT NULL,
  appointmentTime TIME NOT NULL,
  status VARCHAR(50) NOT NULL,
  tblCustomer6id INT NOT NULL,
  UNIQUE (appointmentDate, appointmentTime),
  FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(id)
);
CREATE TABLE tblSparePart6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sparePartCode VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) NULL,
  unit VARCHAR(20) NOT NULL,
  unitPrice FLOAT NOT NULL
);
CREATE TABLE tblSparePartRequest6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  requestCode VARCHAR(20) NOT NULL UNIQUE,
  requestDate DATE NOT NULL,
  quantity INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  tblCustomer6id INT NOT NULL,
  tblSparePart6id INT NOT NULL,
  tblSaleStaff6id INT NOT NULL,
  FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(id),
  FOREIGN KEY (tblSparePart6id) REFERENCES tblSparePart6(id),
  FOREIGN KEY (tblSaleStaff6id) REFERENCES tblSaleStaff6(tblStaff6id)
);
CREATE TABLE tblPayment6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tblCustomer6id INT NOT NULL,
  tblSaleStaff6id INT NOT NULL,
  FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(id),
  FOREIGN KEY (tblSaleStaff6id) REFERENCES tblSaleStaff6(tblStaff6id)
);
CREATE TABLE tblSupplier6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  supplierCode VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL,
  address VARCHAR(255) NOT NULL
);
-- totalAmount da bi loai o Buoc 5 (thuoc tinh dan xuat)
CREATE TABLE tblImportInvoice6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoiceCode VARCHAR(20) NOT NULL UNIQUE,
  invoiceDate DATE NOT NULL,
  tblSupplier6id INT NOT NULL,
  tblWarehouseStaff6id INT NOT NULL,
  FOREIGN KEY (tblSupplier6id) REFERENCES tblSupplier6(id),
  FOREIGN KEY (tblWarehouseStaff6id) REFERENCES tblWarehouseStaff6(tblStaff6id)
);
-- amount da bi loai o Buoc 5 (= importedQuantity * unitPrice)
CREATE TABLE tblInvoiceDetail6 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  importedQuantity INT NOT NULL,
  unitPrice FLOAT NOT NULL,
  tblImportInvoice6id INT NOT NULL,
  tblSparePart6id INT NOT NULL,
  FOREIGN KEY (tblImportInvoice6id) REFERENCES tblImportInvoice6(id),
  FOREIGN KEY (tblSparePart6id) REFERENCES tblSparePart6(id)
);

-- ---------------------------------------------------- Du lieu mau (seed)
INSERT INTO tblStaff6(id, staffCode, fullName, phoneNumber, email, username, password) VALUES
 (1, 'EMP001', 'Nguyen Van A', '0901000001', 'kho@garage.vn',    'kho',    '123456'),
 (2, 'EMP002', 'Trần Văn Nam', '0901000002', 'quanly@garage.vn', 'quanly', '123456'),
 (3, 'EMP003', 'Lê Thị Hoa',   '0901000003', 'banhang@garage.vn','banhang','123456'),
 (4, 'EMP004', 'Phạm Văn Kỹ',  '0901000004', 'kythuat@garage.vn','kythuat','123456');
INSERT INTO tblWarehouseStaff6 VALUES (1);
INSERT INTO tblManagementStaff6 VALUES (2);
INSERT INTO tblSaleStaff6 VALUES (3);
INSERT INTO tblTechnicalStaff6 VALUES (4);

INSERT INTO tblCustomer6(id, customerCode, fullName, phoneNumber, email, address) VALUES
 (1, 'CUS001', 'Tran Thi B', '0911111111', 'tranthib@gmail.com', 'Hà Nội');

INSERT INTO tblService6(serviceCode, name, description, price) VALUES
 ('DV001', 'Thay dầu động cơ', 'Thay dầu và lọc dầu', 300000),
 ('DV002', 'Bảo dưỡng định kỳ', NULL, 1200000);

INSERT INTO tblSupplier6(id, supplierCode, name, phoneNumber, email, address) VALUES
 (1, 'SUP001', 'ABC Parts', '0123456789', 'abc@parts.vn', 'Hà Nội'),
 (2, 'SUP002', 'XYZ Parts', '0987654321', 'xyz@parts.vn', 'Hải Phòng'),
 (3, 'SUP003', 'DEF Auto',  '0909090909', 'def@auto.vn',  'Đà Nẵng');

INSERT INTO tblSparePart6(id, sparePartCode, name, description, unit, unitPrice) VALUES
 (1, 'SP001', 'Dầu động cơ', NULL, 'Chai', 250000),
 (2, 'SP002', 'Lọc dầu',     NULL, 'Cái',  125000),
 (3, 'SP003', 'Lọc gió',     NULL, 'Cái',  100000),
 (4, 'SP004', 'Má phanh',    NULL, 'Bộ',   400000),
 (5, 'SP005', 'Ắc quy',      NULL, 'Cái', 1500000);

-- Trong khoang 01/09/2026 - 21/09/2026:
--   SUP001: IMP001 (80 cai, 13,000,000) + IMP002 (50 cai, 12,000,000) = 130 cai, 25,000,000
--   SUP002: IMP003 (80 cai, 36,000,000) + IMP004 (80 cai,  2,000,000) = 160 cai, 38,000,000
-- IMP005 ngay 25/09/2026 nam ngoai khoang (dung de test)
INSERT INTO tblImportInvoice6(id, invoiceCode, invoiceDate, tblSupplier6id, tblWarehouseStaff6id) VALUES
 (1, 'IMP001', '2026-09-05', 1, 1),
 (2, 'IMP002', '2026-09-20', 1, 1),
 (3, 'IMP003', '2026-09-10', 2, 1),
 (4, 'IMP004', '2026-09-18', 2, 1),
 (5, 'IMP005', '2026-09-25', 1, 1);
INSERT INTO tblInvoiceDetail6(importedQuantity, unitPrice, tblImportInvoice6id, tblSparePart6id) VALUES
 (30, 250000, 1, 1), (20, 125000, 1, 2), (30, 100000, 1, 3),
 (10, 400000, 2, 4), (40, 200000, 2, 1),
 (20, 1500000, 3, 5), (60, 100000, 3, 3),
 (80, 25000, 4, 2),
 (10, 250000, 5, 1);

-- ------------------------------------------------- Stored procedure
DELIMITER $$

CREATE PROCEDURE checkLogin(IN usr VARCHAR(50), IN pwd VARCHAR(255))
BEGIN
  SELECT s.* FROM tblStaff6 s, tblManagementStaff6 m
  WHERE m.tblStaff6id = s.id AND s.username = usr AND s.password = pwd;
END$$

-- cac cap (ngay, gio) da co lich hen tu hom nay tro di
CREATE PROCEDURE getBookedSlots()
BEGIN
  SELECT appointmentDate, appointmentTime FROM tblAppointment6 WHERE appointmentDate >= CURDATE();
END$$

-- thong ke nha cung cap theo so luong nhap, giam dan
CREATE PROCEDURE getSupplierStatistics(IN fromDate DATE, IN toDate DATE)
BEGIN
  SELECT s.*, SUM(d.importedQuantity) AS totalImportedQuantity,
         SUM(d.importedQuantity * d.unitPrice) AS totalImportAmount
  FROM tblSupplier6 s, tblImportInvoice6 i, tblInvoiceDetail6 d
  WHERE i.tblSupplier6id = s.id AND d.tblImportInvoice6id = i.id
    AND i.invoiceDate BETWEEN fromDate AND toDate
  GROUP BY s.id
  ORDER BY totalImportedQuantity DESC, totalImportAmount DESC;
END$$

-- danh sach hoa don nhap cua 1 nha cung cap trong khoang thoi gian
CREATE PROCEDURE getSupplierInvoices(IN supplierId INT, IN fromDate DATE, IN toDate DATE)
BEGIN
  SELECT i.id, i.invoiceCode, i.invoiceDate,
         SUM(d.importedQuantity) AS totalQuantity,
         SUM(d.importedQuantity * d.unitPrice) AS totalAmount
  FROM tblImportInvoice6 i, tblInvoiceDetail6 d
  WHERE i.tblSupplier6id = supplierId AND d.tblImportInvoice6id = i.id
    AND i.invoiceDate BETWEEN fromDate AND toDate
  GROUP BY i.id, i.invoiceCode, i.invoiceDate
  ORDER BY i.invoiceDate;
END$$

-- thong tin chung cua hoa don (nha cung cap, nhan vien kho)
CREATE PROCEDURE getInvoiceInfo(IN invId INT)
BEGIN
  SELECT i.id, i.invoiceCode, i.invoiceDate,
         s.id AS supplierId, s.supplierCode, s.name AS supplierName, s.phoneNumber AS supplierPhone,
         s.email AS supplierEmail, s.address AS supplierAddress,
         n.id AS staffId, n.staffCode, n.fullName AS staffName
  FROM tblImportInvoice6 i, tblSupplier6 s, tblStaff6 n
  WHERE i.id = invId AND s.id = i.tblSupplier6id AND n.id = i.tblWarehouseStaff6id;
END$$

-- cac dong chi tiet phu tung cua hoa don
CREATE PROCEDURE getInvoiceLines(IN invId INT)
BEGIN
  SELECT d.id, d.importedQuantity, d.unitPrice,
         p.id AS sparePartId, p.sparePartCode, p.name AS sparePartName, p.description, p.unit, p.unitPrice AS sparePartPrice
  FROM tblInvoiceDetail6 d, tblSparePart6 p
  WHERE d.tblImportInvoice6id = invId AND p.id = d.tblSparePart6id
  ORDER BY d.id;
END$$

DELIMITER ;
