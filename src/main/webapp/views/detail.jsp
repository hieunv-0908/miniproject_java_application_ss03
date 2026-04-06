<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Chi tiết Sinh viên</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }
        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #555;
            width: 30%;
        }
        td {
            color: #333;
        }
        .status-hoc {
            color: #2e8b57;
            font-weight: bold;
        }
        .status-bao {
            color: #ff8c00;
            font-weight: bold;
        }
        .status-tot {
            color: #1e90ff;
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            padding: 10px 18px;
            background: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .back-link:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Thông tin Chi tiết Sinh viên</h2>

    <c:if test="${not empty student}">
        <table>
            <tr><th>Mã SV</th><td>${student.studentCode}</td></tr>
            <tr><th>Họ tên</th><td>${student.fullName}</td></tr>
            <tr><th>Khoa</th><td>${student.faculty}</td></tr>
            <tr><th>Năm nhập học</th><td>${student.enrollmentYear}</td></tr>
            <tr><th>GPA</th><td>${student.gpa}</td></tr>
            <tr>
                <th>Trạng thái</th>
                <td>
                    <c:choose>
                        <c:when test="${student.status eq 'Đang học'}">
                            <span class="status-hoc">${student.status}</span>
                        </c:when>
                        <c:when test="${student.status eq 'Bảo lưu'}">
                            <span class="status-bao">${student.status}</span>
                        </c:when>
                        <c:when test="${student.status eq 'Tốt nghiệp'}">
                            <span class="status-tot">${student.status}</span>
                        </c:when>
                        <c:otherwise>
                            ${student.status}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </c:if>

    <a href="${pageContext.request.contextPath}/students" class="back-link">← Quay lại danh sách</a>
</div>
</body>
</html>
