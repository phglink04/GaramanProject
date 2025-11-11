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
            font-family: Arial, sans-serif;
            background-color: #E3F2FD; /* Light blue background */
            padding: 20px;
            line-height: 1.6;
        }

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
        }

        h1 {
            color: #1A237E; /* Dark blue for branding */
            font-size: 28px;
            margin-bottom: 30px;
            font-weight: 700;
        }

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
            font-family: inherit;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn:hover {
            background-color: #1565C0; /* Slightly darker blue on hover */
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-back {
            background-color: #42A5F5; /* Lighter blue */
            margin-top: 20px;
        }

        .btn-back:hover {
            background-color: #1976D2; /* Darker blue on hover */
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
    <h1>XEM THỐNG KÊ</h1>

    <a href="${pageContext.request.contextPath}/ManagerView/SelectDateStatsUI.jsp" class="btn">
        Xem thống kê nhà cung cấp theo lượng nhập
    </a>

    <a href="${pageContext.request.contextPath}/ManagerView/SelectDateStatsUI.jsp" class="btn">
        Xem thống kê khách hàng
    </a>

    <a href="${pageContext.request.contextPath}/ManagerView/ManagerMainUI.jsp" class="btn btn-back">
        Quay lại giao diện chính
    </a>
</div>
</body>
</html>
