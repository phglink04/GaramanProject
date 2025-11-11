<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Garaman - Xem Thống Kê</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #FAF3E0;
            padding: 20px;
            line-height: 1.6;
        }

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
        }

        h1 {
            color: #BF360C;
            font-size: 28px;
            margin-bottom: 30px;
            font-weight: bold;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .btn {
            display: block;
            padding: 15px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #D84315;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-bottom: 15px;
            width: 100%;
            text-decoration: none;
            text-align: center;
            font-family: inherit;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn:hover {
            background-color: #BF360C;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-back {
            background-color: #8D6E63;
            margin-top: 20px;
        }

        .btn-back:hover {
            background-color: #6D4C41;
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
    <h1>📊 Xem Thống Kê</h1>

    <a href="${pageContext.request.contextPath}/ManagerView/SelectDateStatsUI.jsp" class="btn">
        📈 Xem Thống Kê Nhà Cung Cấp Theo Lượng Nhập
    </a>

    <a href="${pageContext.request.contextPath}/ManagerView/SelectDateStatsUI.jsp" class="btn">
        👥 Xem Thống Kê Khách Hàng
    </a>

    <a href="${pageContext.request.contextPath}/ManagerView/ManagerMainUI.jsp" class="btn btn-back">
        ◀️ Quay Lại
    </a>
</div>
</body>
</html>
