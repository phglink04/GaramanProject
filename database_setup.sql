

-- Tạo 12 Thành viên (Members)
INSERT INTO `tblMember` (`id`, `username`, `password`, `name`, `dob`, `address`, `phoneNumber`) VALUES
                                                                                                    (1, 'manager1', '123', 'Nguyễn Văn Hùng', '1985-01-15', '101 Cầu Giấy, Hà Nội', '0912345601'),
                                                                                                    (2, 'manager2', '123', 'Trần Thị Bích', '1988-02-20', '102 Hoàng Mai, Hà Nội', '0912345602'),
                                                                                                    (3, 'kho_a', '123', 'Lê Minh Hải', '1992-11-30', '103 Thanh Xuân, Hà Nội', '0912345603'),
                                                                                                    (4, 'kho_b', '123', 'Phạm Đức Anh', '1995-03-10', '104 Hà Đông, Hà Nội', '0912345604'),
                                                                                                    (5, 'kho_c', '123', 'Vũ Thùy Dương', '1998-07-25', '105 Long Biên, Hà Nội', '0912345605'),
                                                                                                    (6, 'khach1', '123', 'Hoàng Văn Nam', '1991-03-12', '106 Đống Đa, Hà Nội', '0912345606'),
                                                                                                    (7, 'khach2', '123', 'Bùi Thu Trang', '2000-10-05', '107 Ba Đình, Hà Nội', '0912345607'),
                                                                                                    (8, 'khach3', '123', 'Ngô Mạnh Sơn', '1988-12-17', '108 Tây Hồ, Hà Nội', '0912345608'),
                                                                                                    (9, 'khach4', '123', 'Lý Thị Huyền', '1994-08-08', '109 Hai Bà Trưng, Hà Nội', '0912345609'),
                                                                                                    (10, 'khach5', '123', 'Đỗ Quốc Việt', '1997-04-30', '110 Hoàn Kiếm, Hà Nội', '0912345610'),
                                                                                                    (11, 'khach6', '123', 'Nông Phương Thảo', '1999-09-09', '111 Nam Từ Liêm, Hà Nội', '0912345611'),
                                                                                                    (12, 'kien_nd', '123', 'Nguyễn Đình Kiên', '1993-06-18', '112 Bắc Từ Liêm, Hà Nội', '0912345612');

-- Tạo Nhân viên (Staff) - 2 Quản lý, 3 Kho
INSERT INTO `tblStaff` (`id`, `tblMemberid`, `role`) VALUES
                                                         (1, 1, 'manager'),         -- Nguyễn Văn Hùng (Quản lý)
                                                         (2, 2, 'manager'),         -- Trần Thị Bích (Quản lý)
                                                         (3, 3, 'warehouse_staff'), -- Lê Minh Hải (Nhân viên kho)
                                                         (4, 4, 'warehouse_staff'), -- Phạm Đức Anh (Nhân viên kho)
                                                         (5, 5, 'warehouse_staff'); -- Vũ Thùy Dương (Nhân viên kho)

-- Tạo 6 Khách hàng (Customer) - Lấy từ Member
INSERT INTO `tblCustomer` (`id`, `CustomerID`, `tblMemberid`) VALUES
                                                                  (1, 'KH001', 6),
                                                                  (2, 'KH002', 7),
                                                                  (3, 'KH003', 8),
                                                                  (4, 'KH004', 9),
                                                                  (5, 'KH005', 10),
                                                                  (6, 'KH006', 11);

-- Tạo 6 Nhà cung cấp (Supplier)
INSERT INTO `tblSupplier` (`id`, `name`, `address`, `phoneNumber`) VALUES
                                                                       (1, 'Phụ tùng Vinh An', '300 Láng, Hà Nội', '0987654301'),
                                                                       (2, 'Công ty TNHH Đức Long', '55 Giải Phóng, Hà Nội', '0987654302'),
                                                                       (3, 'Nhà phân phối Toàn Cầu', '12 Kim Ngưu, Hà Nội', '0987654303'),
                                                                       (4, 'Phụ tùng ô tô Minh Phát', '88 Trần Khát Chân, Hà Nội', '0987654304'),
                                                                       (5, 'Tổng kho Phụ tùng Thăng Long', '245 Nguyễn Xiển, Hà Nội', '0987654305'),
                                                                       (6, 'Công ty phụ tùng ATK', 'KCN Thăng Long, Hà Nội', '0987654306');

-- Tạo 20 Phụ tùng (SparePart) mẫu
INSERT INTO `tblSparePart` (`id`, `name`, `stockRemain`, `note`) VALUES
                                                                     (1, 'Lọc dầu (Oil Filter)', 50, 'Honda/Toyota'),
                                                                     (2, 'Lọc gió động cơ (Air Filter)', 30, 'Ford/Mazda'),
                                                                     (3, 'Lọc gió điều hòa (Cabin Filter)', 40, 'Tất cả các dòng'),
                                                                     (4, 'Bugi (Spark Plug)', 100, 'Iridium, NGK'),
                                                                     (5, 'Má phanh trước (Front Brake Pad)', 25, 'Hàng chính hãng'),
                                                                     (6, 'Má phanh sau (Rear Brake Pad)', 20, 'Hàng chính hãng'),
                                                                     (7, 'Dầu động cơ (Engine Oil)', 80, 'Castrol 5W-30 (Can 4L)'),
                                                                     (8, 'Dầu hộp số (Transmission Fluid)', 30, 'ATF-WS'),
                                                                     (9, 'Nước làm mát (Coolant)', 50, 'Loại màu hồng (Can 5L)'),
                                                                     (10, 'Gạt mưa (Wiper Blade)', 60, 'Bosch, 24 inch'),
                                                                     (11, 'Bơm xăng (Fuel Pump)', 15, 'Denso'),
                                                                     (12, 'Giảm xóc trước (Front Shock)', 10, 'Kayaba'),
                                                                     (13, 'Giảm xóc sau (Rear Shock)', 10, 'Kayaba'),
                                                                     (14, 'Rô-tuyn (Ball Joint)', 30, 'Hàng OEM'),
                                                                     (15, 'Cảm biến oxy (O2 Sensor)', 18, 'Bosch'),
                                                                     (16, 'Đèn pha Halogen (Headlight Bulb)', 50, 'H4 55/60W'),
                                                                     (17, 'Đèn hậu (Tail Light)', 12, 'Toyota Vios 2018'),
                                                                     (18, 'Ắc quy (Battery)', 20, 'GS 12V-60Ah'),
                                                                     (19, 'Lốp xe (Tire)', 40, 'Bridgestone 185/65R15'),
                                                                     (20, 'Còi (Horn)', 30, 'Denso, loại đĩa');

-- -----------------------------------------------------------------
-- BƯỚC 3: TẠO HÓA ĐƠN VÀ CHI TIẾT (ĐẢM BẢO TOÀN VẸN)
-- Yêu cầu: 6 NCC, 3-4 lần nhập/NCC, 3-4 phụ tùng/lần
-- Kịch bản: 6 NCC, 3 lần nhập/NCC, 3 phụ tùng/lần
-- Tổng cộng: 18 Hóa đơn, 54 Chi tiết hóa đơn
-- -----------------------------------------------------------------

-- Reset biến đếm
SET @invoice_id = 0;
SET @detail_id = 0;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 1 (Vinh An) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 1 (NCC 1)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-01-05', 0, 3, 1);
-- Chi tiết cho HĐ 1
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 150000, (@line_total := 10 * 150000), @invoice_id, 1), -- Lọc dầu
                                                                                                                     (@detail_id := @detail_id + 1, 10, 200000, (@line_total := @line_total + 10 * 200000), @invoice_id, 2), -- Lọc gió
                                                                                                                     (@detail_id := @detail_id + 1, 5, 800000, (@line_total := @line_total + 5 * 800000), @invoice_id, 5); -- Má phanh trước
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 2 (NCC 1)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-02-10', 0, 4, 1);
-- Chi tiết cho HĐ 2
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 20, 70000, (@line_total := 20 * 70000), @invoice_id, 4), -- Bugi
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 7), -- Dầu động cơ
                                                                                                                     (@detail_id := @detail_id + 1, 15, 120000, (@line_total := @line_total + 15 * 120000), @invoice_id, 10); -- Gạt mưa
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 3 (NCC 1)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-03-15', 0, 5, 1);
-- Chi tiết cho HĐ 3
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 5, 1500000, (@line_total := 5 * 1500000), @invoice_id, 18), -- Ắc quy
                                                                                                                     (@detail_id := @detail_id + 1, 4, 1800000, (@line_total := @line_total + 4 * 1800000), @invoice_id, 12), -- Giảm xóc trước
                                                                                                                     (@detail_id := @detail_id + 1, 4, 1600000, (@line_total := @line_total + 4 * 1600000), @invoice_id, 13); -- Giảm xóc sau
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 2 (Đức Long) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 4 (NCC 2)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-01-10', 0, 3, 2);
-- Chi tiết cho HĐ 4
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 8, 2500000, (@line_total := 8 * 2500000), @invoice_id, 19), -- Lốp xe
                                                                                                                     (@detail_id := @detail_id + 1, 5, 900000, (@line_total := @line_total + 5 * 900000), @invoice_id, 15), -- Cảm biến oxy
                                                                                                                     (@detail_id := @detail_id + 1, 10, 150000, (@line_total := @line_total + 10 * 150000), @invoice_id, 1); -- Lọc dầu
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 5 (NCC 2)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-02-15', 0, 4, 2);
-- Chi tiết cho HĐ 5
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 15, 200000, (@line_total := 15 * 200000), @invoice_id, 2), -- Lọc gió
                                                                                                                     (@detail_id := @detail_id + 1, 15, 200000, (@line_total := @line_total + 15 * 200000), @invoice_id, 3), -- Lọc gió ĐH
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 7); -- Dầu ĐC
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 6 (NCC 2)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-03-22', 0, 5, 2);
-- Chi tiết cho HĐ 6
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 30, 50000, (@line_total := 30 * 50000), @invoice_id, 16), -- Đèn Halogen
                                                                                                                     (@detail_id := @detail_id + 1, 5, 800000, (@line_total := @line_total + 5 * 800000), @invoice_id, 5), -- Má phanh T
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 14); -- Rô-tuyn
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 3 (Toàn Cầu) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 7 (NCC 3)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-02-01', 0, 3, 3);
-- Chi tiết cho HĐ 7
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 650000, (@line_total := 10 * 650000), @invoice_id, 6), -- Má phanh S
                                                                                                                     (@detail_id := @detail_id + 1, 30, 70000, (@line_total := @line_total + 30 * 70000), @invoice_id, 4), -- Bugi
                                                                                                                     (@detail_id := @detail_id + 1, 5, 2200000, (@line_total := @line_total + 5 * 2200000), @invoice_id, 11); -- Bơm xăng
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 8 (NCC 3)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-04-14', 0, 4, 3);
-- Chi tiết cho HĐ 8
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 900000, (@line_total := 10 * 900000), @invoice_id, 15), -- Cảm biến oxy
                                                                                                                     (@detail_id := @detail_id + 1, 20, 180000, (@line_total := @line_total + 20 * 180000), @invoice_id, 20), -- Còi
                                                                                                                     (@detail_id := @detail_id + 1, 10, 1500000, (@line_total := @line_total + 10 * 1500000), @invoice_id, 18); -- Ắc quy
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 9 (NCC 3)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-06-27', 0, 5, 3);
-- Chi tiết cho HĐ 9
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 8, 2500000, (@line_total := 8 * 2500000), @invoice_id, 19), -- Lốp xe
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 7), -- Dầu ĐC
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 14); -- Rô-tuyn
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 4 (Minh Phát) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 10 (NCC 4)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-02-29', 0, 3, 4);
-- Chi tiết cho HĐ 10
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 450000, (@line_total := 10 * 450000), @invoice_id, 8), -- Dầu HS
                                                                                                                     (@detail_id := @detail_id + 1, 10, 250000, (@line_total := @line_total + 10 * 250000), @invoice_id, 9), -- Nước làm mát
                                                                                                                     (@detail_id := @detail_id + 1, 20, 150000, (@line_total := @line_total + 20 * 150000), @invoice_id, 1); -- Lọc dầu
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 11 (NCC 4)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-05-12', 0, 4, 4);
-- Chi tiết cho HĐ 11
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 40, 70000, (@line_total := 40 * 70000), @invoice_id, 4), -- Bugi
                                                                                                                     (@detail_id := @detail_id + 1, 6, 900000, (@line_total := @line_total + 6 * 900000), @invoice_id, 15), -- Cảm biến
                                                                                                                     (@detail_id := @detail_id + 1, 20, 200000, (@line_total := @line_total + 20 * 200000), @invoice_id, 2); -- Lọc gió
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 12 (NCC 4)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-07-15', 0, 5, 4);
-- Chi tiết cho HĐ 12
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 4, 1800000, (@line_total := 4 * 1800000), @invoice_id, 12), -- Giảm xóc T
                                                                                                                     (@detail_id := @detail_id + 1, 4, 1600000, (@line_total := @line_total + 4 * 1600000), @invoice_id, 13), -- Giảm xóc S
                                                                                                                     (@detail_id := @detail_id + 1, 6, 850000, (@line_total := @line_total + 6 * 850000), @invoice_id, 17); -- Đèn hậu
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 5 (Thăng Long) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 13 (NCC 5)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-03-03', 0, 3, 5);
-- Chi tiết cho HĐ 13
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 200000, (@line_total := 10 * 200000), @invoice_id, 3), -- Lọc gió ĐH
                                                                                                                     (@detail_id := @detail_id + 1, 10, 450000, (@line_total := @line_total + 10 * 450000), @invoice_id, 8), -- Dầu HS
                                                                                                                     (@detail_id := @detail_id + 1, 20, 120000, (@line_total := @line_total + 20 * 120000), @invoice_id, 10); -- Gạt mưa
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 14 (NCC 5)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-05-16', 0, 4, 5);
-- Chi tiết cho HĐ 14
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 1500000, (@line_total := 10 * 1500000), @invoice_id, 18), -- Ắc quy
                                                                                                                     (@detail_id := @detail_id + 1, 8, 800000, (@line_total := @line_total + 8 * 800000), @invoice_id, 5), -- Má phanh T
                                                                                                                     (@detail_id := @detail_id + 1, 10, 180000, (@line_total := @line_total + 10 * 180000), @invoice_id, 20); -- Còi
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 15 (NCC 5)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-07-20', 0, 5, 5);
-- Chi tiết cho HĐ 15
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 4, 2500000, (@line_total := 4 * 2500000), @invoice_id, 19), -- Lốp
                                                                                                                     (@detail_id := @detail_id + 1, 4, 2200000, (@line_total := @line_total + 4 * 2200000), @invoice_id, 11), -- Bơm xăng
                                                                                                                     (@detail_id := @detail_id + 1, 8, 850000, (@line_total := @line_total + 8 * 850000), @invoice_id, 17); -- Đèn hậu
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- ---------------------------------------------
-- NHÀ CUNG CẤP 6 (ATK) - 3 HÓA ĐƠN
-- ---------------------------------------------

-- Hóa đơn 16 (NCC 6)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-02-14', 0, 3, 6);
-- Chi tiết cho HĐ 16
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 150000, (@line_total := 10 * 150000), @invoice_id, 1), -- Lọc dầu
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 7), -- Dầu ĐC
                                                                                                                     (@detail_id := @detail_id + 1, 20, 70000, (@line_total := @line_total + 20 * 70000), @invoice_id, 4); -- Bugi
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 17 (NCC 6)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-04-26', 0, 4, 6);
-- Chi tiết cho HĐ 17
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 5, 800000, (@line_total := 5 * 800000), @invoice_id, 5), -- Má phanh T
                                                                                                                     (@detail_id := @detail_id + 1, 5, 650000, (@line_total := @line_total + 5 * 650000), @invoice_id, 6), -- Má phanh S
                                                                                                                     (@detail_id := @detail_id + 1, 10, 350000, (@line_total := @line_total + 10 * 350000), @invoice_id, 14); -- Rô-tuyn
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;

-- Hóa đơn 18 (NCC 6)
SET @invoice_id = @invoice_id + 1;
INSERT INTO `tblImportInvoice` (`id`, `time`, `totalAmount`, `tblWarehouseStaffid`, `tblSupplierid`) VALUES (@invoice_id, '2024-07-07', 0, 5, 6);
-- Chi tiết cho HĐ 18
INSERT INTO `tblImportDetail` (`id`, `quantity`, `price`, `totalAmount`, `tblImportInvoiceid`, `tblSparePartid`) VALUES
                                                                                                                     (@detail_id := @detail_id + 1, 10, 250000, (@line_total := 10 * 250000), @invoice_id, 9), -- Nước làm mát
                                                                                                                     (@detail_id := @detail_id + 1, 4, 1800000, (@line_total := @line_total + 4 * 1800000), @invoice_id, 12), -- Giảm xóc T
                                                                                                                     (@detail_id := @detail_id + 1, 5, 900000, (@line_total := @line_total + 5 * 900000), @invoice_id, 15); -- Cảm biến
UPDATE `tblImportInvoice` SET `totalAmount` = @line_total WHERE `id` = @invoice_id;


SELECT 'Tạo dữ liệu mẫu thành công!' AS 'Kết quả';
SELECT 'Tổng số hóa đơn đã tạo:', COUNT(*) FROM tblImportInvoice;
SELECT 'Tổng số chi tiết đã tạo:', COUNT(*) FROM tblImportDetail;