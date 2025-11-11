<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Giao Diện Chính Nhân Viên Quản Lý</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        /* General styling for the body */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E3F2FD; /* Light blue background */
            padding: 20px;
            line-height: 1.6;
        }

        /* Container styling */
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
        }

        /* Header styling */
        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 28px;
            margin-bottom: 30px;
            font-weight: 700;
        }

        /* Button styling */
        .btn {
            display: block;
            padding: 15px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #1976D2; /* Vibrant blue for button */
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-bottom: 15px;
            width: 100%;
            text-decoration: none;
            text-align: center;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Hover effect for buttons */
        .btn:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Separate styling for back button */
        .btn-back {
            background-color: #42A5F5; /* Lighter blue color */
            margin-top: 20px;
        }

        /* Hover effect for back button */
        .btn-back:hover {
            background-color: #1976D2;
        }

        /* Responsive design */
        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                max-width: 350px;
            }

            h1 {
                font-size: 24px;
                margin-bottom: 25px;
            }

            .btn {
                padding: 12px 16px;
                font-size: 15px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Page title -->
    <h1>GIAO DIỆN CHÍNH<br>NHÂN VIÊN QUẢN LÝ</h1>

    <!-- Buttons for management functions -->
    <a href="${pageContext.request.contextPath}/ManagerView/SelectStatsUI.jsp" class="btn">Xem Thống Kê</a>
    <a href="${pageContext.request.contextPath}/ManagerView/SelectStatsUI.jsp" class="btn">Quản Lý Dịch Vụ</a>
    <a href="${pageContext.request.contextPath}/ManagerView/SelectStatsUI.jsp" class="btn">Quản Lý Phụ Tùng</a>
    <a href="${pageContext.request.contextPath}/Login.jsp" class="btn btn-back">Đăng xuất</a>
</div>
</body>
</html>