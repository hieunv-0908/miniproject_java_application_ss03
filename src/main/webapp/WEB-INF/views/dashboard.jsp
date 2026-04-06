<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f7fa;
        }

        .container {
            width: 900px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #1a237e;
        }

        .box {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .card {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .top {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .status {
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        .bar {
            background: #ddd;
            height: 20px;
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .fill {
            height: 20px;
            color: white;
            text-align: center;
            line-height: 20px;
        }

        .green { background: green; }
        .orange { background: orange; }
        .blue { background: blue; }

        a {
            display: inline-block;
            margin-top: 20px;
            background: #1a237e;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Dashboard</h1>

    <!-- Tổng + GPA -->
    <div class="box">
        <div class="card">
            <h3>Tổng sinh viên</h3>
            <p>${totalStudents}</p>
        </div>

        <div class="card">
            <h3>GPA trung bình</h3>
            <p>${averageGpa}</p>
        </div>
    </div>

    <!-- Thủ khoa -->
    <div class="top">
        <h2>Thủ khoa</h2>

        <c:if test="${topStudent != null}">
            <p>Họ tên: ${topStudent.fullName}</p>
            <p>Mã SV: ${topStudent.studentCode}</p>
            <p>Khoa: ${topStudent.faculty}</p>
            <p>GPA: ${topStudent.gpa}</p>
            <p>Trạng thái: ${topStudent.status}</p>
        </c:if>
    </div>

    <!-- Tỷ lệ -->
    <div class="status">
        <h2>Tỷ lệ trạng thái</h2>

        Đang học
        <div class="bar">
            <div class="fill green" style="width:${studyingPercent}%">
                ${studyingPercent}%
            </div>
        </div>

        Bảo lưu
        <div class="bar">
            <div class="fill orange" style="width:${pausedPercent}%">
                ${pausedPercent}%
            </div>
        </div>

        Tốt nghiệp
        <div class="bar">
            <div class="fill blue" style="width:${graduatedPercent}%">
                ${graduatedPercent}%
            </div>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/students">Quay lại</a>

</div>

</body>
</html>