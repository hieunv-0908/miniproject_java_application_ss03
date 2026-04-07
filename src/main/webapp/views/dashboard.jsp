<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - StudentHub</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #eef2ff, #f5f7fa);
        }

        .container {
            width: 1100px;
            margin: 30px auto;
        }

        h1 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 30px;
        }

        /* CARD */
        .cards {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .card {
            flex: 1;
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            color: #666;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 28px;
            font-weight: bold;
            color: #3949ab;
        }

        /* TOP STUDENT */
        .top {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .top h2 {
            color: #1a237e;
            margin-bottom: 15px;
        }

        .top p {
            margin: 6px 0;
            font-size: 15px;
        }

        /* STATUS */
        .status {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .status h2 {
            color: #1a237e;
            margin-bottom: 20px;
        }

        .bar {
            background: #e0e0e0;
            height: 22px;
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 15px;
        }

        .fill {
            height: 22px;
            color: white;
            text-align: center;
            line-height: 22px;
            font-size: 13px;
        }

        .green { background: #43a047; }
        .orange { background: #fb8c00; }
        .blue { background: #1e88e5; }

        /* BUTTON */
        .btn {
            display: inline-block;
            margin-top: 25px;
            background: #1a237e;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn:hover {
            background: #3949ab;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>📊 Dashboard StudentHub</h1>

    <!-- CARD -->
    <div class="cards">
        <div class="card">
            <h3>Tổng sinh viên</h3>
            <p>${totalStudents}</p>
        </div>

        <div class="card">
            <h3>GPA trung bình</h3>
            <p>${averageGpa}</p>
        </div>
    </div>

    <!-- TOP STUDENT -->
    <div class="top">
        <h2>🏆 Thủ khoa</h2>

        <c:if test="${topStudent != null}">
            <p><b>Họ tên:</b> ${topStudent.fullName}</p>
            <p><b>Mã SV:</b> ${topStudent.studentCode}</p>
            <p><b>Khoa:</b> ${topStudent.faculty}</p>
            <p><b>GPA:</b> ${topStudent.gpa}</p>
            <p><b>Trạng thái:</b> ${topStudent.status}</p>
        </c:if>
    </div>

    <!-- STATUS -->
    <div class="status">
        <h2>📈 Tỷ lệ trạng thái</h2>

        <p>Đang học</p>
        <div class="bar">
            <div class="fill green" style="width:${studyingPercent}%">
                ${studyingPercent}%
            </div>
        </div>

        <p>Bảo lưu</p>
        <div class="bar">
            <div class="fill orange" style="width:${pausedPercent}%">
                ${pausedPercent}%
            </div>
        </div>

        <p>Tốt nghiệp</p>
        <div class="bar">
            <div class="fill blue" style="width:${graduatedPercent}%">
                ${graduatedPercent}%
            </div>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/students" class="btn">⬅ Quay lại danh sách</a>

</div>

</body>
</html>