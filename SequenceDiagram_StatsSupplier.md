# SƠ ĐỒ TUẦN TỰ (SEQUENCE DIAGRAM) - MODULE THỐNG KÊ NHÀ CUNG CẤP THEO LƯỢNG HÀNG NHẬP

## Mô tả tổng quan
Module này cho phép Manager xem thống kê nhà cung cấp theo lượng hàng nhập trong một khoảng thời gian, xem chi tiết từng nhà cung cấp và xem chi tiết từng hóa đơn nhập.

---

## SƠ ĐỒ TUẦN TỰ (Sequence Diagram)

```
┌────────┐    ┌──────────────┐    ┌──────────────────┐    ┌──────────────────────┐    ┌─────────────────┐    ┌──────────┐
│ Manager│    │SelectStatsUI │    │SelectDateStatsUI │    │StatsSupplierServlet  │    │StatsSupplierDAO │    │ Database │
└───┬────┘    └──────┬───────┘    └────────┬─────────┘    └──────────┬───────────┘    └────────┬────────┘    └────┬─────┘
    │                │                      │                          │                         │                  │
    │ 1. Chọn xem    │                      │                          │                         │                  │
    │    thống kê    │                      │                          │                         │                  │
    ├───────────────>│                      │                          │                         │                  │
    │                │                      │                          │                         │                  │
    │                │ 2. Click "Xem thống kê                          │                         │                  │
    │                │    NCC theo lượng nhập"                         │                         │                  │
    │                ├─────────────────────>│                          │                         │                  │
    │                │                      │                          │                         │                  │
    │                │                      │ 3. Hiển thị form         │                         │                  │
    │                │                      │    chọn ngày             │                         │                  │
    │                │<─────────────────────┤                          │                         │                  │
    │                │                      │                          │                         │                  │
    │ 4. Nhập ngày bắt đầu                  │                          │                         │                  │
    │    và ngày kết thúc                   │                          │                         │                  │
    ├──────────────────────────────────────>│                          │                         │                  │
    │                │                      │                          │                         │                  │
    │                │                      │ 5. Submit form           │                         │                  │
    │                │                      │    (POST startDate,      │                         │                  │
    │                │                      │     endDate)             │                         │                  │
    │                │                      ├─────────────────────────>│                         │                  │
    │                │                      │                          │                         │                  │
    │                │                      │                          │ 6. Validate dates       │                  │
    │                │                      │                          │    (endDate > startDate)│                  │
    │                │                      │                          ├─────────┐               │                  │
    │                │                      │                          │         │               │                  │
    │                │                      │                          │<────────┘               │                  │
    │                │                      │                          │                         │                  │
    │                │                      │                          │ 7. Lưu dates vào session│                  │
    │                │                      │                          ├─────────┐               │                  │
    │                │                      │                          │         │               │                  │
    │                │                      │                          │<────────┘               │                  │
    │                │                      │                          │                         │                  │
    │                │                      │                          │ 8. getSupplierListByImport()              │
    │                │                      │                          │         (startDate, endDate)               │
    │                │                      │                          ├────────────────────────>│                  │
    │                │                      │                          │                         │                  │
    │                │                      │                          │                         │ 9. SELECT Query: │
    │                │                      │                          │                         │    JOIN Supplier,│
    │                │                      │                          │                         │    ImportInvoice,│
    │                │                      │                          │                         │    ImportDetail  │
    │                │                      │                          │                         ├─────────────────>│
    │                │                      │                          │                         │                  │
    │                │                      │                          │                         │ 10. ResultSet    │
    │                │                      │                          │                         │<─────────────────┤
    │                │                      │                          │                         │                  │
    │                │                      │                          │ 11. List<StatsSupplier> │                  │
    │                │                      │                          │<────────────────────────┤                  │
    │                │                      │                          │                         │                  │
    │                │                      │                          │ 12. Lưu suppliersList   │                  │
    │                │                      │                          │     vào session         │                  │
    │                │                      │                          ├─────────┐               │                  │
    │                │                      │                          │         │               │                  │
    │                │                      │                          │<────────┘               │                  │
    │                │                      │                          │                         │                  │
    │                │                      │ 13. Forward to           │                         │                  │
    │                │                      │     StatsSupplierUI.jsp  │                         │                  │
    │                │                      │<─────────────────────────┤                         │                  │
    │                │                      │                          │                         │                  │
    │ 14. Hiển thị bảng thống kê            │                          │                         │                  │
    │     (danh sách NCC, số lượng,         │                          │                         │                  │
    │      tổng tiền)                       │                          │                         │                  │
    │<──────────────────────────────────────┤                          │                         │                  │
    │                │                      │                          │                         │                  │
    │ 15. Click "Xem chi tiết"              │                          │                         │                  │
    │     của NCC (supplierId)              │                          │                         │                  │
    ├──────────────────────────────────────>│                          │                         │                  │
    │                │                      │                          │                         │                  │
```

---

## SƠ ĐỒ TUẦN TỰ (Tiếp theo - Xem chi tiết NCC)

```
┌────────┐    ┌─────────────────┐    ┌──────────────────────┐    ┌─────────────────┐    ┌──────────┐
│ Manager│    │StatsSupplierUI  │    │ImportInvoiceServlet  │    │StatsImportDAO   │    │ Database │
└───┬────┘    └────────┬────────┘    └──────────┬───────────┘    └────────┬────────┘    └────┬─────┘
    │                  │                         │                         │                  │
    │                  │                         │                         │                  │
    │ 16. POST supplierId                        │                         │                  │
    │                  ├────────────────────────>│                         │                  │
    │                  │                         │                         │                  │
    │                  │                         │ 17. Lấy dates từ session│                  │
    │                  │                         │     và suppliersList    │                  │
    │                  │                         ├─────────┐               │                  │
    │                  │                         │         │               │                  │
    │                  │                         │<────────┘               │                  │
    │                  │                         │                         │                  │
    │                  │                         │ 18. Tìm selectedSupplier│                  │
    │                  │                         │     từ suppliersList    │                  │
    │                  │                         ├─────────┐               │                  │
    │                  │                         │         │               │                  │
    │                  │                         │<────────┘               │                  │
    │                  │                         │                         │                  │
    │                  │                         │ 19. Lưu selectedSupplier│                  │
    │                  │                         │     vào session         │                  │
    │                  │                         ├─────────┐               │                  │
    │                  │                         │         │               │                  │
    │                  │                         │<────────┘               │                  │
    │                  │                         │                         │                  │
    │                  │                         │ 20. getSupplierImportBatches()            │
    │                  │                         │     (startDate, endDate, supplierId)       │
    │                  │                         ├────────────────────────>│                  │
    │                  │                         │                         │                  │
    │                  │                         │                         │ 21. SELECT Query:│
    │                  │                         │                         │     JOIN Invoice,│
    │                  │                         │                         │     ImportDetail │
    │                  │                         │                         │     GROUP BY id  │
    │                  │                         │                         ├─────────────────>│
    │                  │                         │                         │                  │
    │                  │                         │                         │ 22. ResultSet    │
    │                  │                         │                         │<─────────────────┤
    │                  │                         │                         │                  │
    │                  │                         │ 23. List<StatsImport>   │                  │
    │                  │                         │<────────────────────────┤                  │
    │                  │                         │                         │                  │
    │                  │                         │ 24. Set entriesList     │                  │
    │                  │                         │     vào request         │                  │
    │                  │                         ├─────────┐               │                  │
    │                  │                         │         │               │                  │
    │                  │                         │<────────┘               │                  │
    │                  │                         │                         │                  │
    │                  │ 25. Forward to          │                         │                  │
    │                  │     SupplierDetailUI.jsp│                         │                  │
    │                  │<────────────────────────┤                         │                  │
    │                  │                         │                         │                  │
    │ 26. Hiển thị bảng chi tiết                 │                         │                  │
    │     (danh sách lần nhập, số lượng,         │                         │                  │
    │      tổng tiền, thời gian)                 │                         │                  │
    │<─────────────────┤                         │                         │                  │
    │                  │                         │                         │                  │
```

---

## SƠ ĐỒ TUẦN TỰ (Tiếp theo - Xem hóa đơn chi tiết)

```
┌────────┐    ┌──────────────────┐    ┌─────────────────────┐    ┌──────────────────┐    ┌──────────┐
│ Manager│    │SupplierDetailUI  │    │ImportDetailServlet  │    │ImportInvoiceDAO  │    │ Database │
└───┬────┘    └────────┬─────────┘    └──────────┬──────────┘    └────────┬─────────┘    └────┬─────┘
    │                  │                          │                        │                   │
    │ 27. Click "Xem Hóa Đơn"                     │                        │                   │
    │     (idLannhap, importDate)                 │                        │                   │
    │                  ├─────────────────────────>│                        │                   │
    │                  │                          │                        │                   │
    │                  │                          │ 28. Parse idLannhap    │                   │
    │                  │                          ├─────────┐              │                   │
    │                  │                          │         │              │                   │
    │                  │                          │<────────┘              │                   │
    │                  │                          │                        │                   │
    │                  │                          │ 29. Lưu importDate     │                   │
    │                  │                          │     vào session        │                   │
    │                  │                          ├─────────┐              │                   │
    │                  │                          │         │              │                   │
    │                  │                          │<────────┘              │                   │
    │                  │                          │                        │                   │
    │                  │                          │ 30. getImportDetails(idLannhap)            │
    │                  │                          ├───────────────────────>│                   │
    │                  │                          │                        │                   │
    │                  │                          │                        │ 31. SELECT Query: │
    │                  │                          │                        │     JOIN         │
    │                  │                          │                        │     ImportDetail,│
    │                  │                          │                        │     SparePart    │
    │                  │                          │                        ├──────────────────>│
    │                  │                          │                        │                   │
    │                  │                          │                        │ 32. ResultSet     │
    │                  │                          │                        │<──────────────────┤
    │                  │                          │                        │                   │
    │                  │                          │ 33. List<ImportDetail> │                   │
    │                  │                          │<───────────────────────┤                   │
    │                  │                          │                        │                   │
    │                  │                          │ 34. Set listImportDetail                   │
    │                  │                          │     và idLannhap vào   │                   │
    │                  │                          │     request            │                   │
    │                  │                          ├─────────┐              │                   │
    │                  │                          │         │              │                   │
    │                  │                          │<────────┘              │                   │
    │                  │                          │                        │                   │
    │                  │ 35. Forward to           │                        │                   │
    │                  │     ImportDetailUI.jsp   │                        │                   │
    │                  │<─────────────────────────┤                        │                   │
    │                  │                          │                        │                   │
    │ 36. Hiển thị chi tiết hóa đơn               │                        │                   │
    │     (tên phụ tùng, số lượng, đơn giá,       │                        │                   │
    │      tổng tiền từng item)                   │                        │                   │
    │<─────────────────┤                          │                        │                   │
    │                  │                          │                        │                   │
    │ 37. Click "Quay lại"                        │                        │                   │
    ├─────────────────>│                          │                        │                   │
    │                  │ (javascript:history.back())                       │                   │
    │                  │                          │                        │                   │
```

---

## LUỒNG DỮ LIỆU (DATA FLOW)

### 1. Từ SelectDateStatsUI.jsp → StatsSupplierServlet
- **Method**: POST
- **Parameters**: 
  - `startDate` (String, format: yyyy-mm-dd)
  - `endDate` (String, format: yyyy-mm-dd)

### 2. Trong StatsSupplierServlet
- **Session attributes được lưu**:
  - `startDate`: String
  - `endDate`: String
  - `suppliersList`: List<StatsSupplier>

### 3. Từ StatsSupplierUI.jsp → ImportInvoiceServlet
- **Method**: POST
- **Parameters**: 
  - `supplierId` (int)

### 4. Trong ImportInvoiceServlet
- **Session attributes được sử dụng**:
  - `startDate` (đọc)
  - `endDate` (đọc)
  - `suppliersList` (đọc)
  - `selectedSupplier` (ghi)
- **Request attributes được set**:
  - `entriesList`: List<StatsImport>

### 5. Từ SupplierDetailUI.jsp → ImportDetailServlet
- **Method**: POST
- **Parameters**: 
  - `idLannhap` (int)
  - `importDate` (String)

### 6. Trong ImportDetailServlet
- **Session attributes được set**:
  - `importDate` (ghi)
- **Request attributes được set**:
  - `listImportDetail`: List<ImportDetail>
  - `idLannhap`: int

---

## CÁC THÀNH PHẦN THAM GIA

### 1. JSP Pages (View Layer)
- **SelectStatsUI.jsp**: Trang chọn loại thống kê
- **SelectDateStatsUI.jsp**: Form nhập khoảng thời gian
- **StatsSupplierUI.jsp**: Hiển thị danh sách NCC và thống kê tổng
- **SupplierDetailUI.jsp**: Hiển thị chi tiết các lần nhập của 1 NCC
- **ImportDetailUI.jsp**: Hiển thị chi tiết hóa đơn (các phụ tùng)

### 2. Servlets (Controller Layer)
- **StatsSupplierServlet** (`/statsSupplier`)
  - `doPost()`: Nhận dates, validate, lưu session, gọi doGet()
  - `doGet()`: Lấy dữ liệu từ DAO, forward đến StatsSupplierUI.jsp
  
- **ImportInvoiceServlet** (`/importInvoice`)
  - `doPost()`: Nhận supplierId, tìm supplier, lấy danh sách lần nhập

- **ImportDetailServlet** (`/ImportDetail`)
  - `doPost()`: Nhận idLannhap, lấy chi tiết hóa đơn

### 3. DAOs (Data Access Layer)
- **StatsSupplierDAO**
  - `getSupplierListByImport(Date startDate, Date endDate)`: Trả về List<StatsSupplier>
  - Query: JOIN tblSupplier, tblImportInvoice, tblImportDetail
  - Group by: Supplier ID
  
- **StatsImportDAO**
  - `getSupplierImportBatches(Date startDate, Date endDate, int supplierId)`: Trả về List<StatsImport>
  - Query: JOIN tblImportInvoice, tblImportDetail
  - Group by: Import Invoice ID
  
- **ImportInvoiceDAO**
  - `getImportDetails(int idLannhap)`: Trả về List<ImportDetail>
  - Query: JOIN tblImportDetail, tblSparePart

### 4. Models (Data Objects)
- **StatsSupplier**: id, nameSupplier, quantityImported, totalAmount
- **StatsImport**: id, time, quantity, totalAmount
- **ImportDetail**: tblSparePartid, tblImportInvoiceid, quantity, unitPrice, totalAmount, partName

### 5. Database Tables
- **tblSupplier**: id, name, address, phoneNumber
- **tblImportInvoice**: id, time, tblSupplierid
- **tblImportDetail**: id, tblImportInvoiceid, tblSparePartid, quantity, unitPrice, totalAmount
- **tblSparePart**: id, name, manufacturer, price

---

## XỬ LÝ LỖI

1. **Validation ở SelectDateStatsUI.jsp**:
   - JavaScript kiểm tra endDate > startDate
   - Hiển thị error message nếu không hợp lệ

2. **Validation ở StatsSupplierServlet**:
   - Nếu endDate <= startDate: setAttribute("errorMessage"), forward về SelectDateStatsUI.jsp

3. **Xử lý session hết hạn**:
   - ImportInvoiceServlet: Kiểm tra dates và suppliersList, redirect về ManagerMainUI.jsp nếu null

4. **Xử lý dữ liệu trống**:
   - Các JSP đều có kiểm tra `if (list != null && !list.isEmpty())`
   - Hiển thị thông báo "Không có dữ liệu" nếu danh sách rỗng

---

## ĐỊNH DẠNG VÀ HIỂN THỊ

1. **Format số tiền**: JavaScript function `formatCurrency()` - format theo định dạng VND với dấu phẩy ngăn cách
2. **Format ngày tháng**: JavaScript function `formatDate()` - chuyển từ yyyy-mm-dd sang dd-mm-yyyy
3. **Tính tổng**: Trong JSP, sử dụng vòng lặp để tính `totalQuantity` và `totalAmount`
4. **Hiển thị tổng cộng**: Sử dụng `<tfoot>` với style riêng (màu xanh, bold)

---

## LƯU Ý QUAN TRỌNG

1. **Session Management**: Dữ liệu được truyền qua nhiều trang thông qua session
2. **One Query Optimization**: StatsSupplierDAO sử dụng 1 query duy nhất với JOIN để tối ưu
3. **Cascade Navigation**: Dữ liệu được lọc dần từ tổng quan → chi tiết → chi tiết hơn nữa
4. **UTF-8 Encoding**: Tất cả request/response đều set UTF-8 để hiển thị tiếng Việt
5. **Button Style Consistency**: Tất cả button "Xem chi tiết" có style giống nhau

---

## KẾT LUẬN

Module này thực hiện đúng kiến trúc MVC:
- **Model**: StatsSupplier, StatsImport, ImportDetail
- **View**: Các JSP files
- **Controller**: Các Servlet files
- **DAO**: Tách biệt logic truy vấn database

Dữ liệu được truyền theo chuỗi: Database → DAO → Servlet → JSP → User, và ngược lại khi user tương tác.

