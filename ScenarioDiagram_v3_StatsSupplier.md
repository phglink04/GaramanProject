# SƠ ĐỒ KỊCH BẢN V3.0 (SCENARIO DIAGRAM) - MODULE THỐNG KÊ NHÀ CUNG CẤP

## MÔ TẢ CHI TIẾT LUỒNG HOẠT ĐỘNG

---

## 📊 KỊCH BẢN 1: XEM THỐNG KÊ NHÀ CUNG CẤP THEO THỜI GIAN

### Bước 1: Manager truy cập trang chọn loại thống kê

**📄 Trang**: `SelectStatsUI.jsp`

**🎯 Mục đích**: Hiển thị menu chọn loại thống kê

**💻 Nội dung hiển thị**:
- Tiêu đề: "XEM THỐNG KÊ"
- 2 buttons:
  - "Xem thống kê nhà cung cấp theo lượng nhập" → Link đến `SelectDateStatsUI.jsp`
  - "Xem thống kê khách hàng" → Link đến `SelectDateStatsUI.jsp`
- Button "Quay lại giao diện chính" → Link về `ManagerMainUI.jsp`

**🔗 Navigation**:
```
ManagerMainUI.jsp 
    ↓ (User click)
SelectStatsUI.jsp
```

**📌 Dữ liệu cần**: Không cần dữ liệu

**🎨 Style**: Light blue theme (#E3F2FD background, #1976D2 buttons)

---

### Bước 2: Manager chọn xem thống kê NCC và nhập khoảng thời gian

**📄 Trang**: `SelectDateStatsUI.jsp`

**🎯 Mục đích**: Cho phép user nhập khoảng thời gian để thống kê

**💻 Nội dung hiển thị**:
- Tiêu đề: "THỐNG KÊ NCC THEO LƯỢNG HÀNG NHẬP" và "Chọn ngày giờ"
- Form với:
  - Input `startDate` (type="date", required)
  - Input `endDate` (type="date", required)
  - Button "Tiếp tục" (submit)
  - Button "Quay lại" → Link về `SelectStatsUI.jsp`
- Hiển thị error message nếu có (màu đỏ)

**🔗 Navigation**:
```
SelectStatsUI.jsp 
    ↓ (User click "Xem thống kê NCC")
SelectDateStatsUI.jsp
```

**📋 Form Details**:
- **Action**: `${pageContext.request.contextPath}/statsSupplier`
- **Method**: POST
- **Parameters**:
  - `startDate`: String (yyyy-mm-dd)
  - `endDate`: String (yyyy-mm-dd)

**✅ Validation (JavaScript)**:
- Function: `validateDates()`
- Kiểm tra: `endDate > startDate`
- Nếu sai: Hiển thị message "Ngày kết thúc phải lớn hơn ngày bắt đầu!"
- Return: `false` (prevent submit) hoặc `true` (allow submit)

**📌 Dữ liệu nhận từ server**:
- `${errorMessage}` (nếu validation ở server fail)

**🎨 Style**: Form centered, input fields có background #E3F2FD

---

### Bước 3: Servlet xử lý và lấy danh sách NCC

**☕ Class**: `StatsSupplierServlet.java`

**📍 URL Mapping**: `@WebServlet("/statsSupplier")`

**🔄 Method Flow**:

#### **doPost() Method**:

```java
1. Set encoding: UTF-8 cho request và response
   - request.setCharacterEncoding("UTF-8")
   - response.setContentType("text/html; charset=UTF-8")
   - response.setCharacterEncoding("UTF-8")

2. Lấy parameters từ form:
   - String startDate = request.getParameter("startDate")
   - String endDate = request.getParameter("endDate")

3. Validate dates:
   if (startDate != null && endDate != null && endDate.compareTo(startDate) > 0) {
       // OK → Tiếp tục
   } else {
       // FAIL → Set error và quay lại form
   }

4. Nếu validation OK:
   - Lưu vào session:
     session.setAttribute("startDate", startDate)
     session.setAttribute("endDate", endDate)
   
   - Gọi doGet() để xử lý tiếp

5. Nếu validation FAIL:
   - setAttribute("errorMessage", "Ngày kết thúc phải lớn hơn ngày bắt đầu!")
   - forward về "ManagerView/SelectDateStatsUI.jsp"
```

#### **doGet() Method**:

```java
1. Set encoding: UTF-8

2. Lấy dates từ session:
   - String startDateStr = session.getAttribute("startDate")
   - String endDateStr = session.getAttribute("endDate")

3. Khởi tạo: List<StatsSupplier> suppliers = null

4. Nếu có dates trong session:
   - Convert String → Date:
     Date startDate = java.sql.Date.valueOf(startDateStr)
     Date endDate = java.sql.Date.valueOf(endDateStr)
   
   - Tạo DAO và gọi method:
     StatsSupplierDAO dao = new StatsSupplierDAO()
     suppliers = dao.getSupplierListByImport(startDate, endDate)

5. Lưu kết quả vào session:
   - session.setAttribute("suppliersList", suppliers)

6. Forward đến JSP:
   - RequestDispatcher rd = request.getRequestDispatcher("/ManagerView/StatsSupplierUI.jsp")
   - rd.forward(request, response)
```

**🔗 Navigation**:
```
SelectDateStatsUI.jsp (form submit)
    ↓ POST /statsSupplier
StatsSupplierServlet.doPost()
    ↓ (if valid)
StatsSupplierServlet.doGet()
    ↓ forward
StatsSupplierUI.jsp
```

**📊 DAO Call**: `StatsSupplierDAO.getSupplierListByImport(startDate, endDate)`

---

### Bước 4: DAO truy vấn database

**☕ Class**: `StatsSupplierDAO.java`

**📦 Package**: `exam.garaman.DAO`

**🔧 Method**: `getSupplierListByImport(Date startDate, Date endDate)`

**📥 Input**:
- `Date startDate`: Ngày bắt đầu
- `Date endDate`: Ngày kết thúc

**📤 Output**:
- `List<StatsSupplier>`: Danh sách nhà cung cấp có thống kê

**🗄️ SQL Query**:
```sql
SELECT
    sup.id,
    sup.name,
    SUM(imd.quantity) AS totalQuantity,
    SUM(imd.totalAmount) AS totalAmount
FROM
    tblSupplier AS sup
JOIN
    tblImportInvoice AS ipi ON sup.id = ipi.tblSupplierid
    AND ipi.time BETWEEN ? AND ?
JOIN
    tblImportDetail AS imd ON ipi.id = imd.tblImportInvoiceid
GROUP BY
    sup.id, sup.name
ORDER BY
    totalQuantity DESC
```

**🔍 Query Explanation**:
1. JOIN 3 bảng: tblSupplier, tblImportInvoice, tblImportDetail
2. Filter: Chỉ lấy hóa đơn trong khoảng thời gian (time BETWEEN ? AND ?)
3. Aggregate: SUM quantity và totalAmount
4. Group by: Theo từng supplier
5. Order by: Sắp xếp theo số lượng nhập (giảm dần)

**📋 Parameters**:
- `stmt.setDate(1, new java.sql.Date(startDate.getTime()))`
- `stmt.setDate(2, new java.sql.Date(endDate.getTime()))`

**🔄 Processing**:
```java
while (rs.next()) {
    int supplierId = rs.getInt("id")
    String supplierName = rs.getString("name")
    int totalQuantity = rs.getInt("totalQuantity")
    int totalAmount = rs.getInt("totalAmount")
    
    StatsSupplier supplier = new StatsSupplier(
        supplierId, supplierName, totalQuantity, totalAmount
    )
    resultList.add(supplier)
}
```

**💾 Database Tables Used**:
- `tblSupplier`: id, name, address, phoneNumber
- `tblImportInvoice`: id, time, tblSupplierid
- `tblImportDetail`: id, tblImportInvoiceid, tblSparePartid, quantity, unitPrice, totalAmount

---

### Bước 5: Hiển thị danh sách NCC với thống kê

**📄 Trang**: `StatsSupplierUI.jsp`

**🎯 Mục đích**: Hiển thị bảng thống kê tổng hợp tất cả NCC

**💻 Nội dung hiển thị**:

#### **1. Header Section**:
```jsp
<h1>THỐNG KÊ NHÀ CUNG CẤP THEO LƯỢNG HÀNG NHẬP</h1>

<!-- Hiển thị khoảng thời gian -->
<div class="date-info">
    Thời gian thống kê: 
    <startDate> đến <endDate>
    (format: dd-mm-yyyy)
</div>
```

#### **2. Data Table**:

**Columns**:
| ID NCC | Tên NCC | Số lượng hàng nhập | Tổng tiền | Chi tiết |
|--------|---------|-------------------|-----------|----------|
| Center | Left    | Center            | Right     | Center   |

**Table Structure**:
```jsp
<table>
    <thead>
        <tr>
            <th>ID NCC</th>
            <th>Tên NCC</th>
            <th>Số lượng hàng nhập</th>
            <th>Tổng tiền</th>
            <th>Chi tiết</th>
        </tr>
    </thead>
    <tbody>
        <!-- Loop qua suppliersList -->
        <% for (StatsSupplier s : suppliers) { %>
        <tr>
            <td><%= s.getId() %></td>
            <td><%= s.getNameSupplier() %></td>
            <td><%= s.getQuantityImported() %></td>
            <td class="currency"><%= s.getTotalAmount() %></td>
            <td>
                <form action="/importInvoice" method="post">
                    <input type="hidden" name="supplierId" value="<%= s.getId() %>" />
                    <button type="submit">Xem chi tiết</button>
                </form>
            </td>
        </tr>
        <% } %>
    </tbody>
    <tfoot>
        <!-- Tổng cộng -->
        <tr>
            <td colspan="2">TỔNG CỘNG</td>
            <td><%= totalQuantity %></td>
            <td class="currency"><%= totalAmount %></td>
            <td>-</td>
        </tr>
    </tfoot>
</table>
```

#### **3. JavaScript Processing**:

**Function `formatCurrency(amount)`**:
```javascript
// Format: 1000000 → 1,000,000 VND
return new Intl.NumberFormat('vi-VN').format(amount) + ' VND';
```

**Function `formatDate(dateString)`**:
```javascript
// Convert: 2024-01-15 → 15-01-2024
if (dateString.match(/^\d{4}-\d{2}-\d{2}$/)) {
    const parts = dateString.split('-');
    return parts[2] + '-' + parts[1] + '-' + parts[0];
}
```

**window.onload**:
```javascript
// Áp dụng format cho tất cả ô tiền tệ
document.querySelectorAll('.currency').forEach(cell => {
    const amount = parseInt(cell.textContent);
    cell.textContent = formatCurrency(amount);
});

// Áp dụng format cho tất cả ngày tháng
document.querySelectorAll('.date-span').forEach(span => {
    span.textContent = formatDate(span.textContent.trim());
});
```

#### **4. Calculation Logic**:
```jsp
<%
    List<StatsSupplier> suppliers = (List<StatsSupplier>) session.getAttribute("suppliersList");
    int totalQuantity = 0;
    long totalAmount = 0;
    
    for (StatsSupplier s : suppliers) {
        totalQuantity += s.getQuantityImported();
        totalAmount += s.getTotalAmount();
    }
%>
```

#### **5. Navigation**:
```jsp
<a href="SelectDateStatsUI.jsp" class="btn-back">Quay lại</a>
```

**📌 Dữ liệu cần từ session**:
- `startDate`: String
- `endDate`: String
- `suppliersList`: List<StatsSupplier>

**🎨 Style Features**:
- Alternating row colors (even rows: #E3F2FD)
- Header: #1976D2 background, white text
- Currency: Right-aligned
- Footer: Bold, dark blue border, white text on blue background

---

## 📊 KỊCH BẢN 2: XEM CHI TIẾT CÁC LẦN NHẬP CỦA MỘT NHÀ CUNG CẤP

### Bước 1: User click "Xem chi tiết" của một NCC

**📄 Trang hiện tại**: `StatsSupplierUI.jsp`

**🎯 Hành động**: Submit form với supplierId

**📋 Form Details**:
```jsp
<form action="${pageContext.request.contextPath}/importInvoice" method="post">
    <input type="hidden" name="supplierId" value="<%= s.getId() %>" />
    <button type="submit">Xem chi tiết</button>
</form>
```

**📤 Data gửi đi**:
- `supplierId`: int (ID của nhà cung cấp được chọn)

**🔗 Navigation**:
```
StatsSupplierUI.jsp (click button)
    ↓ POST /importInvoice
ImportInvoiceServlet.doPost()
```

---

### Bước 2: Servlet xử lý request và lấy chi tiết lần nhập

**☕ Class**: `ImportInvoiceServlet.java`

**📍 URL Mapping**: `@WebServlet("/importInvoice")`

**🔄 Method Flow - doPost()**:

```java
1. Set encoding: UTF-8

2. Lấy session:
   - HttpSession session = request.getSession()

3. Lấy dữ liệu từ SESSION (đã lưu trước đó):
   - String startDateStr = session.getAttribute("startDate")
   - String endDateStr = session.getAttribute("endDate")
   - List<StatsSupplier> suppliers = session.getAttribute("suppliersList")

4. Lấy parameter từ FORM:
   - String supplierIdStr = request.getParameter("supplierId")

5. Validate session data:
   if (startDateStr == null || endDateStr == null || 
       supplierIdStr == null || suppliers == null || suppliers.isEmpty()) {
       // Session hết hạn → Redirect về trang chủ
       response.sendRedirect("/ManagerView/ManagerMainUI.jsp")
       return
   }

6. Parse và convert data:
   - int supplierId = Integer.parseInt(supplierIdStr)
   - Date startDate = java.sql.Date.valueOf(startDateStr)
   - Date endDate = java.sql.Date.valueOf(endDateStr)

7. TÌM NHÀ CUNG CẤP được chọn trong danh sách:
   StatsSupplier selectedSupplier = null
   for (StatsSupplier s : suppliers) {
       if (s.getId() == supplierId) {
           selectedSupplier = s
           break
       }
   }

8. Nếu tìm thấy:
   - Lưu vào session:
     session.setAttribute("selectedSupplier", selectedSupplier)
   
   - Gọi DAO để lấy danh sách lần nhập:
     StatsImportDAO dao = new StatsImportDAO()
     List<StatsImport> entries = dao.getSupplierImportBatches(
         startDate, endDate, supplierId
     )
   
   - Set vào request:
     request.setAttribute("entriesList", entries)
   
   - Forward đến JSP:
     RequestDispatcher rd = request.getRequestDispatcher(
         "/ManagerView/SupplierDetailUI.jsp"
     )
     rd.forward(request, response)

9. Nếu không tìm thấy:
   - Redirect về trang chủ
```

**📊 DAO Call**: `StatsImportDAO.getSupplierImportBatches(startDate, endDate, supplierId)`

**🔗 Navigation**:
```
ImportInvoiceServlet.doPost()
    ↓ (if found)
    ↓ forward
SupplierDetailUI.jsp
```

---

### Bước 3: DAO lấy danh sách các lần nhập

**☕ Class**: `StatsImportDAO.java`

**🔧 Method**: `getSupplierImportBatches(Date startDate, Date endDate, int supplierId)`

**📥 Input**:
- `Date startDate`: Ngày bắt đầu
- `Date endDate`: Ngày kết thúc
- `int supplierId`: ID nhà cung cấp

**📤 Output**:
- `List<StatsImport>`: Danh sách các lần nhập hàng

**🗄️ SQL Query**:
```sql
SELECT 
    imi.id AS importInvoiceId,
    imi.time AS importDate,
    SUM(imd.quantity) AS totalQuantity,
    SUM(imd.totalAmount) AS totalAmount
FROM 
    tblImportInvoice AS imi
JOIN 
    tblImportDetail AS imd ON imi.id = imd.tblImportInvoiceid
WHERE 
    imi.tblSupplierid = ? 
    AND imi.time BETWEEN ? AND ?
GROUP BY 
    imi.id, imi.time
```

**🔍 Query Explanation**:
1. JOIN 2 bảng: tblImportInvoice, tblImportDetail
2. Filter: Theo supplierId và khoảng thời gian
3. Aggregate: SUM quantity và totalAmount cho mỗi lần nhập
4. Group by: Theo từng hóa đơn nhập (importInvoice id)

**📋 Parameters**:
```java
stmtImportBatch.setInt(1, supplierId)
stmtImportBatch.setDate(2, new java.sql.Date(startDate.getTime()))
stmtImportBatch.setDate(3, new java.sql.Date(endDate.getTime()))
```

**🔄 Processing**:
```java
while (rsImportBatch.next()) {
    int importInvoiceId = rsImportBatch.getInt("importInvoiceId")
    Date importDate = rsImportBatch.getDate("importDate")
    int totalQuantity = rsImportBatch.getInt("totalQuantity")
    int totalAmount = rsImportBatch.getInt("totalAmount")
    
    StatsImport importBatch = new StatsImport(
        importInvoiceId, importDate, totalQuantity, totalAmount
    )
    resultList.add(importBatch)
}
```

---

### Bước 4: Hiển thị chi tiết các lần nhập của NCC

**📄 Trang**: `SupplierDetailUI.jsp`

**🎯 Mục đích**: Hiển thị chi tiết tất cả các lần nhập hàng của 1 nhà cung cấp

**💻 Nội dung hiển thị**:

#### **1. Header Section**:
```jsp
<h1>Thống kê số lần nhập của nhà cung cấp<br>
    <%= selectedSupplier.getNameSupplier() %>
</h1>

<!-- Hiển thị khoảng thời gian -->
<div class="date-info">
    Thời gian thống kê: 
    <startDate> đến <endDate>
    (format: dd-mm-yyyy)
</div>
```

#### **2. Data Table**:

**Columns**:
| ID Lần Nhập | Số Lượng Hàng Nhập | Tổng Tiền | Thời Gian | Xem Hóa Đơn |
|-------------|-------------------|-----------|-----------|-------------|
| Center      | Center            | Right     | Center    | Center      |

**Table Structure**:
```jsp
<table>
    <thead>
        <tr>
            <th>ID Lần Nhập</th>
            <th>Số Lượng Hàng Nhập</th>
            <th>Tổng Tiền</th>
            <th>Thời Gian</th>
            <th>Xem Hóa Đơn</th>
        </tr>
    </thead>
    <tbody>
        <% for (StatsImport entry : entries) { %>
        <tr>
            <td><%= entry.getId() %></td>
            <td><%= entry.getQuantity() %></td>
            <td class="currency"><%= entry.getTotalAmount() %></td>
            <td class="date-cell"><%= entry.getTime() %></td>
            <td>
                <form action="/ImportDetail" method="post">
                    <input type="hidden" name="idLannhap" value="<%= entry.getId() %>" />
                    <input type="hidden" name="importDate" value="<%= entry.getTime() %>" />
                    <button type="submit">Xem Hóa Đơn</button>
                </form>
            </td>
        </tr>
        <% } %>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="1">TỔNG CỘNG</td>
            <td><%= totalQuantity %></td>
            <td class="currency"><%= totalAmount %></td>
            <td>-</td>
            <td>-</td>
        </tr>
    </tfoot>
</table>
```

#### **3. Calculation Logic**:
```jsp
<%
    StatsSupplier selectedSupplier = (StatsSupplier) session.getAttribute("selectedSupplier");
    List<StatsImport> entries = (List<StatsImport>) request.getAttribute("entriesList");
    
    // Lấy tổng từ selectedSupplier object (đã tính sẵn)
    long totalQuantity = selectedSupplier.getQuantityImported();
    long totalAmount = selectedSupplier.getTotalAmount();
%>
```

#### **4. Navigation**:
```jsp
<a href="javascript:history.back()" class="btn-back">Quay Lại</a>
```

**📌 Dữ liệu cần**:
- **Từ session**:
  - `startDate`: String
  - `endDate`: String
  - `selectedSupplier`: StatsSupplier
- **Từ request**:
  - `entriesList`: List<StatsImport>

**🎨 Style**: Giống StatsSupplierUI.jsp (cùng theme màu)

---

## 📊 KỊCH BẢN 3: XEM CHI TIẾT MỘT HÓA ĐƠN NHẬP

### Bước 1: User click "Xem Hóa Đơn" của một lần nhập

**📄 Trang hiện tại**: `SupplierDetailUI.jsp`

**🎯 Hành động**: Submit form với idLannhap và importDate

**📋 Form Details**:
```jsp
<form action="${pageContext.request.contextPath}/ImportDetail" method="post">
    <input type="hidden" name="idLannhap" value="<%= entry.getId() %>" />
    <input type="hidden" name="importDate" value="<%= entry.getTime() %>" />
    <button type="submit">Xem Hóa Đơn</button>
</form>
```

**📤 Data gửi đi**:
- `idLannhap`: int (ID của lần nhập/hóa đơn)
- `importDate`: String (Ngày nhập hàng)

**🔗 Navigation**:
```
SupplierDetailUI.jsp (click button)
    ↓ POST /ImportDetail
ImportDetailServlet.doPost()
```

---

### Bước 2: Servlet xử lý và lấy chi tiết hóa đơn

**☕ Class**: `ImportDetailServlet.java`

**📍 URL Mapping**: `@WebServlet("/ImportDetail")`

**🔄 Method Flow - doPost()**:

```java
1. Set encoding: UTF-8

2. Lấy session:
   - HttpSession session = request.getSession()

3. Lấy parameters từ form:
   - String idLannhapStr = request.getParameter("idLannhap")
   - String importDateStr = request.getParameter("importDate")

4. Validate parameters:
   if (idLannhapStr != null && !idLannhapStr.isEmpty()) {
       // OK → Tiếp tục
   } else {
       // FAIL → Redirect về trang chủ
       response.sendRedirect("/ManagerView/ManagerMainUI.jsp")
       return
   }

5. Parse và lấy dữ liệu:
   - int idLannhap = Integer.parseInt(idLannhapStr)
   
   - Gọi DAO:
     ImportInvoiceDAO dao = new ImportInvoiceDAO()
     List<ImportDetail> listImportDetail = dao.getImportDetails(idLannhap)

6. Lưu dữ liệu:
   - request.setAttribute("listImportDetail", listImportDetail)
   - request.setAttribute("idLannhap", idLannhap)
   - session.setAttribute("importDate", importDateStr)

7. Forward đến JSP:
   - RequestDispatcher rd = request.getRequestDispatcher(
       "/ManagerView/ImportDetailUI.jsp"
     )
   - rd.forward(request, response)

8. Exception handling:
   - SQLException → throw ServletException
   - NumberFormatException → throw ServletException
```

**📊 DAO Call**: `ImportInvoiceDAO.getImportDetails(idLannhap)`

**🔗 Navigation**:
```
ImportDetailServlet.doPost()
    ↓ forward
ImportDetailUI.jsp
```

---

### Bước 3: DAO lấy chi tiết các phụ tùng trong hóa đơn

**☕ Class**: `ImportInvoiceDAO.java`

**🔧 Method**: `getImportDetails(int idLannhap)`

**📥 Input**:
- `int idLannhap`: ID của lần nhập (import invoice ID)

**📤 Output**:
- `List<ImportDetail>`: Danh sách chi tiết các phụ tùng trong hóa đơn

**🗄️ SQL Query**:
```sql
SELECT 
    imd.tblSparePartid,
    imd.tblImportInvoiceid,
    imd.quantity,
    imd.unitPrice,
    imd.totalAmount,
    sp.name AS partName
FROM 
    tblImportDetail AS imd
JOIN 
    tblSparePart AS sp ON imd.tblSparePartid = sp.id
WHERE 
    imd.tblImportInvoiceid = ?
```

**🔍 Query Explanation**:
1. JOIN 2 bảng: tblImportDetail, tblSparePart
2. Filter: Theo import invoice ID
3. Lấy thông tin: Phụ tùng, số lượng, đơn giá, tổng tiền

**📋 Parameters**:
```java
stmt.setInt(1, idLannhap)
```

**🔄 Processing**:
```java
while (rs.next()) {
    int sparePartId = rs.getInt("tblSparePartid")
    int invoiceId = rs.getInt("tblImportInvoiceid")
    int quantity = rs.getInt("quantity")
    int unitPrice = rs.getInt("unitPrice")
    int totalAmount = rs.getInt("totalAmount")
    String partName = rs.getString("partName")
    
    ImportDetail detail = new ImportDetail(
        sparePartId, invoiceId, quantity, unitPrice, totalAmount, partName
    )
    resultList.add(detail)
}
```

---

### Bước 4: Hiển thị chi tiết hóa đơn

**📄 Trang**: `ImportDetailUI.jsp`

**🎯 Mục đích**: Hiển thị tất cả phụ tùng trong một hóa đơn nhập

**💻 Nội dung hiển thị**:

#### **1. Header Section**:
```jsp
<h1>Chi Tiết Hóa Đơn Nhập Hàng</h1>

<div class="entry-info">
    <p>ID Lần Nhập: <%= idLannhap %></p>
    <p>Ngày Nhập: <%= importDate %></p>
    <p>Nhà Cung Cấp: <%= selectedSupplier.getNameSupplier() %></p>
</div>
```

#### **2. Data Table**:

**Columns**:
| STT | Tên Phụ Tùng | Số Lượng | Đơn Giá | Tổng Tiền |
|-----|-------------|----------|---------|-----------|
| Center | Left     | Center   | Right   | Right     |

**Table Structure**:
```jsp
<table>
    <thead>
        <tr>
            <th>STT</th>
            <th>Tên Phụ Tùng</th>
            <th>Số Lượng</th>
            <th>Đơn Giá</th>
            <th>Tổng Tiền</th>
        </tr>
    </thead>
    <tbody>
        <%
            int stt = 1;
            int totalQuantity = 0;
            long totalAmount = 0;
            
            for (ImportDetail detail : listImportDetail) {
                totalQuantity += detail.getQuantity();
                totalAmount += detail.getTotalAmount();
        %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= detail.getPartName() %></td>
            <td><%= detail.getQuantity() %></td>
            <td class="currency"><%= detail.getUnitPrice() %></td>
            <td class="currency"><%= detail.getTotalAmount() %></td>
        </tr>
        <% } %>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2">TỔNG CỘNG</td>
            <td><%= totalQuantity %></td>
            <td>-</td>
            <td class="currency"><%= totalAmount %></td>
        </tr>
    </tfoot>
</table>
```

#### **3. Navigation**:
```jsp
<a href="javascript:history.back()" class="btn-back">Quay Lại</a>
```

**📌 Dữ liệu cần**:
- **Từ session**:
  - `importDate`: String
  - `selectedSupplier`: StatsSupplier
- **Từ request**:
  - `listImportDetail`: List<ImportDetail>
  - `idLannhap`: int

---

## 🔄 TỔNG KẾT LUỒNG DỮ LIỆU

### Flow Chart Tổng Thể:

```
┌─────────────────────┐
│  SelectStatsUI.jsp  │
│  (Menu chọn stats)  │
└──────────┬──────────┘
           │
           ↓ (User chọn "Xem thống kê NCC")
┌──────────────────────────┐
│  SelectDateStatsUI.jsp   │
│  (Form nhập ngày)        │
└──────────┬───────────────┘
           │
           ↓ POST {startDate, endDate}
┌──────────────────────────┐
│  StatsSupplierServlet    │
│  - Validate dates        │
│  - Save to session       │
│  - Call DAO              │
└──────────┬───────────────┘
           │
           ↓ getSupplierListByImport()
┌──────────────────────────┐
│  StatsSupplierDAO        │
│  - Query database        │
│  - JOIN 3 tables         │
│  - Return List           │
└──────────┬───────────────┘
           │
           ↓ List<StatsSupplier>
┌──────────────────────────┐
│  StatsSupplierUI.jsp     │
│  - Display table         │
│  - Show totals           │
│  - "Xem chi tiết" button │
└──────────┬───────────────┘
           │
           ↓ POST {supplierId}
┌──────────────────────────┐
│  ImportInvoiceServlet    │
│  - Find selected NCC     │
│  - Get import batches    │
└──────────┬───────────────┘
           │
           ↓ getSupplierImportBatches()
┌──────────────────────────┐
│  StatsImportDAO          │
│  - Query by supplier     │
│  - Return batches        │
└──────────┬───────────────┘
           │
           ↓ List<StatsImport>
┌──────────────────────────┐
│  SupplierDetailUI.jsp    │
│  - Display import times  │
│  - "Xem Hóa Đơn" button  │
└──────────┬───────────────┘
           │
           ↓ POST {idLannhap, importDate}
┌──────────────────────────┐
│  ImportDetailServlet     │
│  - Get invoice details   │
└──────────┬───────────────┘
           │
           ↓ getImportDetails()
┌──────────────────────────┐
│  ImportInvoiceDAO        │
│  - Query spare parts     │
│  - Return details        │
└──────────┬───────────────┘
           │
           ↓ List<ImportDetail>
┌──────────────────────────┐
│  ImportDetailUI.jsp      │
│  - Display invoice items │
│  - Show spare parts      │
└──────────────────────────┘
```

---

## 📊 BẢNG TỔNG HỢP DỮ LIỆU

### Session Attributes:

| Tên biến | Type | Lưu ở đâu | Dùng ở đâu | Mục đích |
|----------|------|-----------|------------|----------|
| `startDate` | String | StatsSupplierServlet | StatsSupplierUI, ImportInvoiceServlet | Khoảng thời gian thống kê |
| `endDate` | String | StatsSupplierServlet | StatsSupplierUI, ImportInvoiceServlet | Khoảng thời gian thống kê |
| `suppliersList` | List<StatsSupplier> | StatsSupplierServlet | StatsSupplierUI, ImportInvoiceServlet | Danh sách tất cả NCC |
| `selectedSupplier` | StatsSupplier | ImportInvoiceServlet | SupplierDetailUI, ImportDetailUI | NCC đang được xem |
| `importDate` | String | ImportDetailServlet | ImportDetailUI | Ngày nhập hàng của hóa đơn |

### Request Attributes:

| Tên biến | Type | Set ở đâu | Dùng ở đâu | Mục đích |
|----------|------|-----------|------------|----------|
| `errorMessage` | String | StatsSupplierServlet | SelectDateStatsUI | Hiển thị lỗi validation |
| `entriesList` | List<StatsImport> | ImportInvoiceServlet | SupplierDetailUI | Danh sách lần nhập của NCC |
| `listImportDetail` | List<ImportDetail> | ImportDetailServlet | ImportDetailUI | Chi tiết phụ tùng trong hóa đơn |
| `idLannhap` | int | ImportDetailServlet | ImportDetailUI | ID hóa đơn đang xem |

---

## 🗄️ DATABASE SCHEMA SUMMARY

### Các bảng liên quan:

```
tblSupplier
├── id (PK)
├── name
├── address
└── phoneNumber

tblImportInvoice
├── id (PK)
├── time
└── tblSupplierid (FK → tblSupplier.id)

tblImportDetail
├── id (PK)
├── tblImportInvoiceid (FK → tblImportInvoice.id)
├── tblSparePartid (FK → tblSparePart.id)
├── quantity
├── unitPrice
└── totalAmount

tblSparePart
├── id (PK)
├── name
├── manufacturer
└── price
```

### Relationships:

```
tblSupplier (1) ──< (N) tblImportInvoice
tblImportInvoice (1) ──< (N) tblImportDetail
tblSparePart (1) ──< (N) tblImportDetail
```

---

## 🎨 UI/UX FEATURES

### 1. Responsive Design:
- Tất cả trang đều có max-width và padding phù hợp
- Mobile-friendly với @media queries

### 2. Color Scheme:
- **Primary**: #1976D2 (Blue)
- **Background**: #E3F2FD (Light Blue)
- **Text**: #1A237E (Dark Blue)
- **Hover**: #1565C0 (Darker Blue)
- **Accent**: #42A5F5 (Light Blue for back buttons)

### 3. Data Formatting:
- **Currency**: 1,000,000 VND (comma separators)
- **Date**: dd-mm-yyyy (Vietnamese format)
- **Alignment**: 
  - Numbers: Center or Right
  - Text: Left
  - Actions: Center

### 4. User Experience:
- Clear navigation with "Quay lại" buttons
- Consistent button styles
- Error messages in red
- Alternating row colors for readability
- Total rows highlighted with different styling

---

## ✅ VALIDATION & ERROR HANDLING

### 1. Client-side (JavaScript):
- Ngày kết thúc phải > ngày bắt đầu
- Required fields validation

### 2. Server-side (Servlets):
- Date comparison validation
- Session data existence check
- Parameter validation (not null, not empty)
- Number format validation

### 3. Error Responses:
- **Validation fail**: Forward back với error message
- **Session timeout**: Redirect về ManagerMainUI.jsp
- **SQL errors**: throw ServletException
- **Empty data**: Hiển thị "Không có dữ liệu"

---

## 🔐 SECURITY CONSIDERATIONS

1. **UTF-8 Encoding**: Tất cả request/response đều set UTF-8
2. **Hidden Inputs**: Sử dụng hidden fields để truyền IDs
3. **Session Management**: Data lưu trong session, không expose qua URL
4. **SQL Injection Prevention**: Sử dụng PreparedStatement với parameters

---

## 📈 PERFORMANCE OPTIMIZATION

1. **Single Query Optimization**: StatsSupplierDAO dùng 1 query với JOIN thay vì nhiều queries
2. **Session Storage**: Tái sử dụng data từ session thay vì query lại database
3. **Lazy Loading**: Chỉ load chi tiết khi user click
4. **Aggregate at Database**: Tính SUM ở database level, không phải trong Java

---

## 🎯 KẾT LUẬN

Module này thực hiện workflow 3 cấp độ:
1. **Cấp 1**: Tổng quan tất cả NCC (StatsSupplierUI)
2. **Cấp 2**: Chi tiết các lần nhập của 1 NCC (SupplierDetailUI)
3. **Cấp 3**: Chi tiết các phụ tùng trong 1 hóa đơn (ImportDetailUI)

**Ưu điểm**:
- ✅ Tuân thủ MVC architecture
- ✅ Tối ưu database queries
- ✅ Responsive và user-friendly
- ✅ Validation đầy đủ
- ✅ Error handling tốt
- ✅ Code clean và dễ maintain

**Tech Stack**:
- JSP + Servlet (Java EE)
- MySQL Database
- JavaScript (client-side)
- CSS (inline styling)

