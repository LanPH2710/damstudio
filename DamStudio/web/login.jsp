<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Login Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;900&display=swap"
              rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <main>
            <div class="login-container">
                <h2>Đăng Nhập</h2>

                <% 
                    String errorMessage = (String) request.getAttribute("mess");
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                <p style="color: red; text-align: center; margin-bottom: 20px; font-weight: 500;"><%= errorMessage %></p>
                <%
                    }
                %>

                <form action="loginbyaccount" method="post" class="login-form">
                    <div class="social-login">
                        <a href="login-google" class="google-btn">
                            <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google icon">
                            Đăng nhập bằng Google
                        </a>
                    </div>
                    <div class="form-group">
                        <label for="username">Tên đăng nhập / Email</label>
                        <input type="text" id="username" name="username" required 
                               placeholder="Nhập tên đăng nhập hoặc email" 
                               value="${requestScope.userName != null ? requestScope.userName : (requestScope.user != null ? requestScope.user : '')}">
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                        <%-- KHÔNG NÊN điền lại mật khẩu vì lý do bảo mật --%>
                    </div>

                    <div class="form-group remember-forgot">
                        <label class="remember-me">
                            <input type="checkbox" id="remember" name="remember" 
                                   <%= (request.getAttribute("userCookie") != null && !((String)request.getAttribute("userCookie")).isEmpty()) ? "checked" : "" %>>
                            Ghi nhớ đăng nhập
                        </label>
                        <a href="forgotPassword.jsp" class="forgot-password">Quên mật khẩu?</a>
                    </div>

                    <button type="submit">Đăng Nhập</button>
                    <p class="register-link">Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
                </form>
            </div>
        </main>
        <jsp:include page="footer.jsp"/>
    </body>
</html>