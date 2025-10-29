<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Nhập OTP</title>
        <link rel="stylesheet" href="css/enterOTP.css">
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="otp-container">
            <h2>Xác Thực OTP</h2>

            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>

            <form action="otp" method="post">
                <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP đã nhận" required>
                <button type="submit" class="submit-btn">Xác nhận</button>
            </form>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

