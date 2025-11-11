-- -----------------------------------------------------------------
-- BƯỚC 1: THIẾT LẬP VÀ DỌN DẸP DỮ LIỆU CŨ
-- -----------------------------------------------------------------
SET NAMES 'utf8mb4';
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE tblAppointment;
TRUNCATE TABLE tblCustomer;
TRUNCATE TABLE tblImportDetail;
TRUNCATE TABLE tblImportInvoice;
TRUNCATE TABLE tblMember;
TRUNCATE TABLE tblSparePart;
TRUNCATE TABLE tblStaff;
TRUNCATE TABLE tblSupplier;

SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------------------
-- BƯỚC 2: TẠO DỮ LIỆU CỐ ĐỊNH (VỚI 4 ROLES)
-- -----------------------------------------------------------------

-- Tạo 13 Thành viên (Member) (7 cho Staff, 6 cho Customer)
INSERT INTO `tblMember` (`id`, `username`, `password`, `name`, `dob`, `address`, `phoneNumber`) VALUES
                                                                                                    (1, 'manager1', '123', 'Nguyễn Văn Hùng', '1985-01-15', '101 Cầu Giấy, Hà Nội', '0912345601'),
                                                                                                    (2, 'warehouse1', '123', 'Lê Minh Hải', '1992-11-30', '103 Thanh Xuân, Hà Nội', '0912345603'),
                                                                                                    (3, 'warehouse2', '123', 'Phạm Đức Anh', '1995-03-10', '104 Hà Đông, Hà Nội', '0912345604'),
                                                                                                    (4, 'sales1', '123', 'Vũ Thùy Dương', '1998-07-25', '105 Long Biên, Hà Nội', '0912345605'),
                                                                                                    (5, 'tech1', '123', 'Trần Trung Kiên', '1990-06-15', '106 Cầu Giấy, Hà Nội', '0912345615'),
                                                                                                    (6, 'sales2', '123', 'Bùi Lan Hương', '1997-02-20', '107 Đống Đa, Hà Nội', '0912345616'),
                                                                                                    (7, 'tech2', '123', 'Mai Văn Dũng', '1991-09-01', '108 Tây Hồ, Hà Nội', '0912345617'),
                                                                                                    (8, 'khach1', '123', 'Hoàng Văn Nam', '1991-03-12', '110 Đống Đa, Hà Nội', '0912345606'),
                                                                                                    (9, 'khach2', '123', 'Bùi Thu Trang', '2000-10-05', '111 Ba Đình, Hà Nội', '0912345607'),
                                                                                                    (10, 'khach3', '123', 'Ngô Mạnh Sơn', '1988-12-17', '112 Tây Hồ, Hà Nội', '0912345608'),
                                                                                                    (11, 'khach4', '123', 'Lý Thị Huyền', '1994-08-08', '113 Hai Bà Trưng, Hà Nội', '0912345609'),
                                                                                                    (12, 'khach5', '123', 'Đỗ Quốc Việt', '1997-04-30', '114 Hoàn Kiếm, Hà Nội', '0912345610'),
                                                                                                    (13, 'khach6', '123', 'Nông Phương Thảo', '1999-09-09', '115 Nam Từ Liêm, Hà Nội', '0912345611');

-- Tạo 7 Nhân viên (Staff) với 4 vai trò
INSERT INTO `tblStaff` (`id`, `tblMemberid`, `role`) VALUES
                                                         (1, 1, 'manager'),
                                                         (2, 2, 'warehouse_staff'),
                                                         (3, 3, 'warehouse_staff'),
                                                         (4, 4, 'Sales Staff'),
                                                         (5, 5, 'Technician'),
                                                         (6, 6, 'Sales Staff'),
                                                         (7, 7, 'Technician');

-- Tạo 6 Khách hàng (Sử dụng Member ID từ 8 đến 13)
INSERT INTO `tblCustomer` (`id`, `CustomerID`, `tblMemberid`) VALUES
                                                                  (1, 'KH001', 8), (2, 'KH002', 9), (3, 'KH003', 10), (4, 'KH004', 11), (5, 'KH005', 12), (6, 'KH006', 13);

-- Tạo 20 Nhà cung cấp (Giữ nguyên như cũ)
INSERT INTO `tblSupplier` (`id`, `name`, `address`, `phoneNumber`) VALUES
                                                                       (1, 'Phụ tùng Vinh An', '300 Láng, Hà Nội', '0987654301'),
                                                                       (2, 'Công ty TNHH Đức Long', '55 Giải Phóng, Hà Nội', '0987654302'),
                                                                       (3, 'Nhà phân phối Toàn Cầu', '12 Kim Ngưu, Hà Nội', '0987654303'),
                                                                       (4, 'Phụ tùng ô tô Minh Phát', '88 Trần Khát Chân, Hà Nội', '0987654304'),
                                                                       (5, 'Tổng kho Thăng Long', '245 Nguyễn Xiển, Hà Nội', '0987654305'),
                                                                       (6, 'Công ty phụ tùng ATK', 'KCN Thăng Long, Hà Nội', '0987654306'),
                                                                       (7, 'Phụ tùng Hoàng Hà', '120 Lạc Long Quân, Hà Nội', '0987654307'),
                                                                       (8, 'Công ty Cổ phần VAG', '50 Nguyễn Trãi, Hà Nội', '0987654308'),
                                                                       (9, 'Phụ tùng An Phát', '33 Lê Văn Lương, Hà Nội', '0987654309'),
                                                                       (10, 'Nhà phân phối Đông Á', '77 Trường Chinh, Hà Nội', '0987654310'),
                                                                       (11, 'Công ty TNHH Hà Thành', '210 Đại Cồ Việt, Hà Nội', '0987654311'),
                                                                       (12, 'Phụ tùng Việt Nhật', '88 Phạm Hùng, Hà Nội', '0987654312'),
                                                                       (13, 'Tổng kho phụ tùng Sài Gòn', 'KCN Tân Bình, TPHCM', '0987654313'),
                                                                       (14, 'Công ty TNHH An Toàn', '150 Võ Thị Sáu, TPHCM', '0987654314'),
                                                                       (15, 'Phụ tùng Hợp Nhất', '22 Lý Thường Kiệt, TPHCM', '0987654315'),
                                                                       (16, 'Phụ tùng Hải Phòng', '1 Cù Chính Lan, Hải Phòng', '0987654316'),
                                                                       (17, 'Công ty TNHH Đà Nẵng Auto', '30 Nguyễn Hữu Thọ, Đà Nẵng', '0987654317'),
                                                                       (18, 'Phụ tùng Thái Nguyên', '50 Lương Ngọc Quyến, Thái Nguyên', '0987654318'),
                                                                       (19, 'Công ty TNHH Hưng Yên', 'KCN Phố Nối A, Hưng Yên', '0987654319'),
                                                                       (20, 'Nhà phân phối Dầu Nhờn', '100 Nguyễn Văn Cừ, Hà Nội', '0987654320');

-- Tạo 30 Phụ tùng mẫu (Giữ nguyên như cũ)
INSERT INTO `tblSparePart` (`id`, `name`, `stockRemain`, `note`) VALUES
                                                                     (1, 'Lọc dầu (Oil Filter)', 50, 'Honda/Toyota'), (2, 'Lọc gió động cơ (Air Filter)', 30, 'Ford/Mazda'), (3, 'Lọc gió điều hòa (Cabin Filter)', 40, 'Tất cả các dòng'), (4, 'Bugi (Spark Plug)', 100, 'Iridium, NGK'), (5, 'Má phanh trước (Front Brake Pad)', 25, 'Hàng chính hãng'), (6, 'Má phanh sau (Rear Brake Pad)', 20, 'Hàng chính hãng'), (7, 'Dầu động cơ (Engine Oil)', 80, 'Castrol 5W-30 (Can 4L)'), (8, 'Dầu hộp số (Transmission Fluid)', 30, 'ATF-WS'), (9, 'Nước làm mát (Coolant)', 50, 'Loại màu hồng (Can 5L)'), (10, 'Gạt mưa (Wiper Blade)', 60, 'Bosch, 24 inch'), (11, 'Bơm xăng (Fuel Pump)', 15, 'Denso'), (12, 'Giảm xóc trước (Front Shock)', 10, 'Kayaba'), (13, 'Giảm xóc sau (Rear Shock)', 10, 'Kayaba'), (14, 'Rô-tuyn (Ball Joint)', 30, 'Hàng OEM'), (15, 'Cảm biến oxy (O2 Sensor)', 18, 'Bosch'), (16, 'Đèn pha Halogen (Headlight Bulb)', 50, 'H4 55/60W'), (17, 'Đèn hậu (Tail Light)', 12, 'Toyota Vios 2018'), (18, 'Ắc quy (Battery)', 20, 'GS 12V-60Ah'), (19, 'Lốp xe (Tire)', 40, 'Bridgestone 185/65R15'), (20, 'Còi (Horn)', 30, 'Denso, loại đĩa'), (21, 'Cảm biến ABS (ABS Sensor)', 20, 'Hàng OEM'), (22, 'Mobin đánh lửa (Ignition Coil)', 30, 'Hàng OEM'), (23, 'Bơm nước (Water Pump)', 10, 'GMB'), (24, 'Dây curoa Cam (Timing Belt)', 15, 'Gates'), (25, 'Dây curoa Tổng (Serpentine Belt)', 25, 'Gates'), (26, 'Lọc xăng (Fuel Filter)', 30, 'Hàng OEM'), (27, 'Rotuyn lái (Tie Rod End)', 20, 'CTR'), (28, 'Bạc đạn bánh xe (Wheel Bearing)', 15, 'Koyo'), (29, 'Van hằng nhiệt (Thermostat)', 25, 'Hàng OEM'), (30, 'Kim phun (Fuel Injector)', 10, 'Denso');

-- -----------------------------------------------------------------
-- BƯỚC 3: TẠO THỦ TỤC (ĐÃ CẬP NHẬT LOGIC CHỌN NHÂN VIÊN)
-- -----------------------------------------------------------------
DELIMITER $$

-- Xóa procedure cũ nếu tồn tại
DROP PROCEDURE IF EXISTS sp_GenerateImportData;

-- Tạo procedure mới
CREATE PROCEDURE sp_GenerateImportData()
BEGIN
    -- Biến đếm
    DECLARE v_supplier_id INT DEFAULT 1;
    DECLARE v_import_loop INT DEFAULT 1;
    DECLARE v_detail_loop INT DEFAULT 1;

    -- Biến dữ liệu
    DECLARE v_staff_id INT;
    DECLARE v_part_id INT;
    DECLARE v_part_price INT;
    DECLARE v_part_qty INT;
    DECLARE v_line_total INT;
    DECLARE v_invoice_total INT;
    DECLARE v_new_invoice_id INT;
    DECLARE v_import_date DATE;

    -- Vòng lặp 20 Nhà Cung Cấp
    WHILE v_supplier_id <= 20 DO

            SET v_import_loop = 1;
            -- Vòng lặp 10 Hóa Đơn cho mỗi NCC
            WHILE v_import_loop <= 10 DO

                    SET v_invoice_total = 0;

                    -- *** ĐÂY LÀ LOGIC ĐÃ SỬA ***
                    -- Lấy ngẫu nhiên MỘT ID nhân viên kho
                    SELECT id INTO v_staff_id FROM tblStaff
                    WHERE role = 'warehouse_staff'
                    ORDER BY RAND() -- Sắp xếp ngẫu nhiên
                    LIMIT 1;        -- Chỉ lấy 1 người

                    -- Chọn ngày ngẫu nhiên trong 365 ngày qua (từ 11/2024 - 11/2025)
                    SET v_import_date = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY);

                    -- 1. Tạo Hóa đơn (với tổng tiền = 0)
                    INSERT INTO tblImportInvoice (time, totalAmount, tblWarehouseStaffid, tblSupplierid)
                    VALUES (v_import_date, 0, v_staff_id, v_supplier_id);

                    SET v_new_invoice_id = LAST_INSERT_ID();

                    SET v_detail_loop = 1;
                    -- Vòng lặp 5 Phụ tùng cho mỗi Hóa đơn
                    WHILE v_detail_loop <= 5 DO

                            -- Chọn ngẫu nhiên 1 trong 30 phụ tùng (ID 1-30)
                            SET v_part_id = (FLOOR(RAND() * 30) + 1);
                            -- Số lượng ngẫu nhiên (từ 1 đến 10)
                            SET v_part_qty = (FLOOR(RAND() * 10) + 1);
                            -- Giá ngẫu nhiên (từ 50,000 đến 2,050,000)
                            SET v_part_price = (FLOOR(RAND() * 200) + 5) * 10000;

                            SET v_line_total = v_part_qty * v_part_price;

                            -- 2. Tạo Chi tiết hóa đơn
                            INSERT INTO tblImportDetail (quantity, price, totalAmount, tblImportInvoiceid, tblSparePartid)
                            VALUES (v_part_qty, v_part_price, v_line_total, v_new_invoice_id, v_part_id);

                            -- Cộng dồn vào tổng tiền của hóa đơn
                            SET v_invoice_total = v_invoice_total + v_line_total;

                            SET v_detail_loop = v_detail_loop + 1;
                        END WHILE; -- Hết 5 phụ tùng

                    -- 3. Cập nhật Tổng tiền chính xác cho Hóa đơn
                    UPDATE tblImportInvoice SET totalAmount = v_invoice_total WHERE id = v_new_invoice_id;

                    SET v_import_loop = v_import_loop + 1;
                END WHILE; -- Hết 10 hóa đơn

            SET v_supplier_id = v_supplier_id + 1;
        END WHILE; -- Hết 20 nhà cung cấp

END$$

DELIMITER ;

-- -----------------------------------------------------------------
-- BƯỚC 4: THỰC THI THỦ TỤC ĐỂ TẠO DỮ LIỆU
-- -----------------------------------------------------------------

SELECT 'Bắt đầu tạo 200 hóa đơn và 1000 chi tiết...' AS 'Trạng thái';

CALL sp_GenerateImportData();

SELECT 'Tạo dữ liệu thành công!' AS 'Kết quả';

-- -----------------------------------------------------------------
-- BƯỚC 5: XÓA THỦ TỤC (DỌN DẸP)
-- -----------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_GenerateImportData;

-- -----------------------------------------------------------------
-- BƯỚC 6: KIỂM TRA NHANH
-- -----------------------------------------------------------------
SELECT 'Kiểm tra thành viên:', COUNT(*) FROM tblMember;
SELECT 'Kiểm tra nhân viên:', COUNT(*) FROM tblStaff;
SELECT 'Kiểm tra khách hàng:', COUNT(*) FROM tblCustomer;
SELECT 'Kiểm tra nhà cung cấp:', COUNT(*) FROM tblSupplier;
SELECT 'Kiểm tra phụ tùng:', COUNT(*) FROM tblSparePart;
SELECT 'Kiểm tra tổng số hóa đơn:', COUNT(*) FROM tblImportInvoice;
SELECT 'Kiểm tra tổng số chi tiết:', COUNT(*) FROM tblImportDetail;