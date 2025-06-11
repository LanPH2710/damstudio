<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/register.css" />
        <title>Đăng Ký Tài Khoản</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <!-- Hiển thị thông báo lỗi nếu có -->
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="error-message" style="color: red; text-align: center; margin: 10px 0;">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <form class="register-form" action="register" method="post">
                <h2 class="form-title">Đăng Ký</h2>
                <p class="form-subtitle">Tạo tài khoản mới để bắt đầu</p>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập <span class="required">*</span></label>
                        <input type="text" id="username" name="username" required 
                               placeholder="Nhập tên đăng nhập"
                               value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Nhập mật khẩu"
                               value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : "" %>">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">Tên <span class="required">*</span></label>
                        <input type="text" id="firstName" name="firstName" required 
                               placeholder="Nhập tên của bạn"
                               value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="lastName">Họ <span class="required">*</span></label>
                        <input type="text" id="lastName" name="lastName" required 
                               placeholder="Nhập họ của bạn"
                               value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Giới tính <span class="required">*</span></label>
                    <div class="gender-options">
                        <div class="gender-option">
                            <input type="radio" id="male" name="gender" value="1" required
                                   <%= (request.getAttribute("gender") != null && request.getAttribute("gender").toString().equals("1")) ? "checked" : "" %>>
                            <label for="male">Nam</label>
                        </div>
                        <div class="gender-option">
                            <input type="radio" id="female" name="gender" value="0" required
                                   <%= (request.getAttribute("gender") != null && request.getAttribute("gender").toString().equals("0")) ? "checked" : "" %>>
                            <label for="female">Nữ</label>
                        </div>
                        <div class="gender-option">
                            <input type="radio" id="other" name="gender" value="2" required
                                   <%= (request.getAttribute("gender") != null && request.getAttribute("gender").toString().equals("2")) ? "checked" : "" %>>
                            <label for="other">Khác</label>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required 
                               placeholder="example@email.com"
                               value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="mobile">Số điện thoại <span class="required">*</span></label>
                        <input type="tel" id="mobile" name="mobile" required 
                               placeholder="0123456789"
                               value="<%= request.getAttribute("mobile") != null ? request.getAttribute("mobile") : "" %>">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <textarea id="address" name="address" 
                              placeholder="Nhập địa chỉ của bạn (tùy chọn)"><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                </div>
                
                <button type="submit" class="btn-register">Đăng Ký</button>
                
                <div class="login-link">
                    Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a>
                </div>
            </form>
        </div>
        
        <jsp:include page="footer.jsp"/>
        
        <script>
            // Validate form trước khi submit
            document.querySelector('.register-form').addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                const email = document.getElementById('email').value;
                const mobile = document.getElementById('mobile').value;
                
                // Kiểm tra độ dài mật khẩu
                if (password.length < 6) {
                    alert('Mật khẩu phải có ít nhất 6 ký tự!');
                    e.preventDefault();
                    return;
                }
                
                // Kiểm tra format email
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Vui lòng nhập email hợp lệ!');
                    e.preventDefault();
                    return;
                }
                
                // Kiểm tra số điện thoại (10-11 số)
                const mobileRegex = /^[0-9]{10,11}$/;
                if (!mobileRegex.test(mobile)) {
                    alert('Số điện thoại phải có 10-11 chữ số!');
                    e.preventDefault();
                    return;
                }
            });
            
            // Thêm hiệu ứng focus cho các input
            const inputs = document.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });
        </script>
    </body>
</html>