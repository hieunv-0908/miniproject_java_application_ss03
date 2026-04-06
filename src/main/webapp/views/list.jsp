<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sinh viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .controls {
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .search-box, .filter-box {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        input[type="text"], select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background-color: #0056b3;
        }

        .sort-links {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .sort-links a {
            margin-right: 15px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .sort-links a:hover {
            text-decoration: underline;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f0f0f0;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-inactive {
            color: red;
            font-weight: bold;
        }

        .status-reserve {
            color: orange;
            font-weight: bold;
        }

        .status-graduated {
            color: blue;
            font-weight: bold;
        }

        .action-links {
            text-align: center;
        }

        .detail-link {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            padding: 5px 10px;
            border: 1px solid #007bff;
            border-radius: 3px;
            display: inline-block;
        }

        .detail-link:hover {
            background-color: #007bff;
            color: white;
        }

        .message {
            padding: 10px 15px;
            margin-bottom: 15px;
            border-radius: 4px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .no-data {
            text-align: center;
            padding: 30px;
            color: #666;
        }

        .gpa-high {
            color: green;
        }

        .gpa-medium {
            color: orange;
        }

        .gpa-low {
            color: red;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📋 Danh sách sinh viên</h2>

    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>

    <!-- CONTROLS -->
    <div class="controls">
        <!-- Search -->
        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/students" style="display: flex; gap: 10px;">
                <input type="text" name="search" placeholder="Tìm theo tên hoặc mã SV" value="${param.search}">
                <button type="submit">🔍 Tìm</button>
            </form>
        </div>

        <!-- Filter by Faculty -->
        <div class="filter-box">
            <form method="get" action="${pageContext.request.contextPath}/students" style="display: flex; gap: 10px;">
                <select name="faculty">
                    <option value="">-- Tất cả khoa --</option>
                    <option value="CNTT" <c:if test="${param.faculty == 'CNTT'}">selected</c:if>>CNTT</option>
                    <option value="Kế toán" <c:if test="${param.faculty == 'Kế toán'}">selected</c:if>>Kế toán</option>
                    <option value="Marketing" <c:if test="${param.faculty == 'Marketing'}">selected</c:if>>Marketing</option>
                </select>
                <button type="submit">🔎 Lọc</button>
            </form>
        </div>
    </div>

    <!-- SORT -->
    <div class="sort-links">
        <strong>Sắp xếp:</strong>
        <a href="${pageContext.request.contextPath}/students?sortBy=name">↑ Theo tên A-Z</a>
        <a href="${pageContext.request.contextPath}/students?sortBy=gpa">↓ Theo GPA cao nhất</a>
    </div>

    <!-- TABLE -->
    <c:if test="${not empty students}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mã sinh viên</th>
                    <th>Họ tên</th>
                    <th>Khoa</th>
                    <th>Năm nhập học</th>
                    <th>GPA</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.studentCode}</td>
                        <td>${student.fullName}</td>
                        <td>${student.faculty}</td>
                        <td>${student.enrollmentYear}</td>
                        <td class="<c:choose>
                                <c:when test="${student.gpa >= 3.5}">gpa-high</c:when>
                                <c:when test="${student.gpa >= 3.0}">gpa-medium</c:when>
                                <c:otherwise>gpa-low</c:otherwise>
                            </c:choose>">
                            ${String.format("%.2f", student.gpa)}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${student.status == 'Đang học'}">
                                    <span class="status-active">🟢 ${student.status}</span>
                                </c:when>
                                <c:when test="${student.status == 'Bảo lưu'}">
                                    <span class="status-reserve">🟠 ${student.status}</span>
                                </c:when>
                                <c:when test="${student.status == 'Tốt nghiệp'}">
                                    <span class="status-graduated">🔵 ${student.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span>${student.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="action-links">
                            <a class="detail-link" href="${pageContext.request.contextPath}/students/detail?id=${student.id}">
                                📄 Xem chi tiết
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Không có dữ liệu -->
    <c:if test="${empty students}">
        <div class="no-data">
            <h3>❌ Không tìm thấy dữ liệu sinh viên</h3>
            <p>Hãy thử lại với các tiêu chí khác</p>
        </div>
    </c:if>

</div>

</body>
</html>

