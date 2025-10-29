<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu | Dám Studio</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newPassword.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="css/homePage.css">
</head>

<body>
    <jsp:include page="header.jsp"></jsp:include>

    <section class="reset-container">
        <div class="reset-box shadow">
            <h2 class="text-center mb-4">🔒 Đặt Lại Mật Khẩu</h2>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger text-center">${errorMessage}</div>
            </c:if>

            <form action="newpassword" method="POST">
                <div class="mb-3">
                    <label for="password" class="form-label fw-semibold">Mật khẩu mới *</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu mới" required>
                </div>

                <div class="mb-3">
                    <label for="confPassword" class="form-label fw-semibold">Xác nhận mật khẩu *</label>
                    <input type="password" class="form-control" id="confPassword" name="confPassword" placeholder="Nhập lại mật khẩu" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-semibold">Đặt Lại Mật Khẩu</button>
            </form>

            <div class="text-center mt-3">
                <a href="login.jsp" class="text-decoration-none text-secondary">← Quay lại đăng nhập</a>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
