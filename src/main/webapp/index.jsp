<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>StudentHub - Trang chủ</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f4f6f9;
            margin: 0;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .container {
            padding: 30px;
            text-align: center;
        }

        .card {
            display: inline-block;
            width: 250px;
            margin: 15px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>

<body>

<header>
    <h1>🎓 StudentHub</h1>
    <p>Hệ thống quản lý sinh viên</p>
</header>

<div class="container">

    <div class="card">
        <h3>📋 Danh sách sinh viên</h3>
        <p>Xem, tìm kiếm và sắp xếp sinh viên</p>
        <a class="btn" href="students">Truy cập</a>
    </div>

    <div class="card">
        <h3>📊 Dashboard</h3>
        <p>Xem thống kê tổng quan</p>
        <a class="btn" href="dashboard">Xem báo cáo</a>
    </div>

    <div class="card">
        <h3>🔍 Tìm kiếm nhanh</h3>
        <p>Test filter trực tiếp qua URL</p>
        <a class="btn" href="students?search=Nguyen">Thử ngay</a>
    </div>

</div>

</body>
</html>