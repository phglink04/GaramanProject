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
            background-color: #E3F2FD; /* Light blue background */
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #90CAF9; /* Light blue border */
            border-radius: 6px;
            background-color: #E3F2FD; /* Light blue for inputs */
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Label styling */
        label {
            font-size: 15px;
            color: #0D47A1; /* Deep blue for labels */
            display: block;
            text-align: left;
            margin-bottom: 6px;
            margin-top: 10px;
            font-weight: bold;
        }

        .btn {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1976D2; /* Vibrant blue for button */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        .btn:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Back button styling */
        .btn-back {
            padding: 12px;
            font-size: 16px;
            color: #ffffff;
            background-color: #42A5F5; /* Lighter blue */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
            width: 100%;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease;
            box-sizing: border-box;
        }

        .btn-back:hover {
            background-color: #1976D2; /* Darker blue on hover */
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
    <h1>CHỌN NGÀY GIỜ</h1>

    <!-- Form gửi đến Servlet -->
    <form action="${pageContext.request.contextPath}/statsSupplier" method="post" onsubmit="return validateDates()">
        <label for="start-date">Chọn ngày bắt đầu:</label>
        <input type="date" id="start-date" name="startDate" required>

        <label for="end-date">Chọn ngày kết thúc:</label>
        <input type="date" id="end-date" name="endDate" required>

        <button type="submit" class="btn">Tiếp tục</button>
        <p id="error-message" class="error-message" style="${empty errorMessage ? 'display:none;' : ''}">
            ${errorMessage}
        </p>
    </form>

    <!-- Nút quay lại -->
    <a href="${pageContext.request.contextPath}/ManagerView/SelectStatsUI.jsp" class="btn-back">Quay lại</a>
</div>
</body>
</html>