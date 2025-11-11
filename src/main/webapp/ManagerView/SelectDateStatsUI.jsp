<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Chọn Ngày Giờ</title>
    <style>
        /* General styling for the body */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #FAF3E0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h1 {
            color: #BF360C;
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #dddddd;
            border-radius: 6px;
        }

        .btn {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #D84315;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
            width: 100%;
        }

        .btn:hover {
            background-color: #BF360C;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
    <script>
        function validateDates() {
            const startDate = document.getElementById("start-date").value;
            const endDate = document.getElementById("end-date").value;
            const errorMessage = document.getElementById("error-message");

            if (startDate && endDate) {
                if (endDate <= startDate) {
                    errorMessage.textContent = "Ngày kết thúc phải lớn hơn ngày bắt đầu!";
                    return false; // Prevent form submission
                } else {
                    errorMessage.textContent = ""; // Clear error message
                    return true; // Allow form submission
                }
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Chọn Ngày Giờ</h1>

    <!-- Form gửi đến Servlet -->
    <form action="${pageContext.request.contextPath}/statsSupplier" method="post" onsubmit="return validateDates()">
        <label for="start-date">Chọn Ngày Bắt Đầu:</label>
        <input type="date" id="start-date" name="startDate" required>

        <label for="end-date">Chọn Ngày Kết Thúc:</label>
        <input type="date" id="end-date" name="endDate" required>

        <button type="submit" class="btn">Tiếp Tục</button>
        <p id="error-message" class="error-message" style="${empty errorMessage ? 'display:none;' : ''}">
            ${errorMessage}
        </p>
    </form>

    <!-- Nút quay lại -->
    <a href="${pageContext.request.contextPath}/ManagerView/SelectStatsUI.jsp" class="btn-back">Quay Lại</a>
</div>
</body>
</html>