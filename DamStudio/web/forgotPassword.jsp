<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quên Mật Khẩu</title>
        <link rel="stylesheet" href="css/forgotpassword.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="forgot-container">
            <h2>Quên Mật Khẩu</h2>

            <ul>
                <li><span class="text-primary text-medium">1. </span>Nhập địa chỉ email bạn dùng để đăng ký.</li>
                <li><span class="text-primary text-medium">2. </span>Hệ thống của tôi sẽ gửi OTP đến bạn.</li>
                <li><span class="text-primary text-medium">3. </span>Nhập OTP vào trang tiếp theo.</li>
            </ul>
            <c:if test="${not empty errorMessage}">
                <div style="color:red;">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success">${message}</div>
            </c:if>
            <form action="forgotpassword" method="post">
                <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
                <button type="submit" class="submit-btn">Gửi OTP</button>
            </form>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

