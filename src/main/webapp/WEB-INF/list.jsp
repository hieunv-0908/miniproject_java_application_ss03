<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sinh viên</title>
    <style>
        body {
            font-family: Arial;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        .sort-links a {
            margin-right: 15px;
            text-decoration: none;
            color: blue;
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
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .pass {
            color: green;
            font-weight: bold;
        }

        .fail {
            color: red;
            font-weight: bold;
        }

        .detail-link {
            color: purple;
            text-decoration: none;
        }

        .detail-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>📋 Danh sách sinh viên</h2>

<!-- SORT -->
<div class="sort-links">
    <a href="${pageContext.request.contextPath}/student/list?sort=id">Sắp xếp theo ID</a>
    <a href="${pageContext.request.contextPath}/student/list?sort=name">Sắp xếp theo tên</a>
    <a href="${pageContext.request.contextPath}/student/list?sort=score">Sắp xếp theo điểm</a>
</div>

<!-- TABLE -->
<table>
    <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Lớp</th>
        <th>Điểm</th>
        <th>Trạng thái</th>
        <th>Chi tiết</th>
    </tr>

    <c:forEach var="s" items="${students}">
        <tr>
            <td>${s.id}</td>
            <td>${s.name}</td>
            <td>${s.className}</td>
            <td>${s.score}</td>

            <!-- STATUS -->
            <td>
                <c:choose>
                    <c:when test="${s.score >= 5}">
                        <span class="pass">Đạt</span>
                    </c:when>
                    <c:otherwise>
                        <span class="fail">Rớt</span>
                    </c:otherwise>
                </c:choose>
            </td>

            <!-- DETAIL LINK -->
            <td>
                <a class="detail-link"
                   href="${pageContext.request.contextPath}/student/detail?id=${s.id}">
                    Xem
                </a>
            </td>
        </tr>
    </c:forEach>

    <!-- Nếu không có dữ liệu -->
    <c:if test="${empty students}">
        <tr>
            <td colspan="6">Không có dữ liệu sinh viên</td>
        </tr>
    </c:if>

</table>

</body>
</html>