<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>User Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css?v=${System.currentTimeMillis()}" />
         <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/homePage.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="profile-wrapper">
            <div class="profile-avatar-side">
                <img class="avatar" src="image/logo/${sessionScope.user1.avatar}" alt="Avatar"
                     onerror="this.src='image/logo/default_avatar.png'"/>
                <div class="profile-name">
                    ${sessionScope.user1.firstName} ${sessionScope.user1.lastName}
                </div>
                <div class="profile-email">
                    ${sessionScope.user1.email}
                </div>
                <a href="order" class="profile-order-btn">Đơn mua</a>
            </div>
            <div class="profile-form-side">
                <div class="header-title">Thông tin cá nhân</div>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="success-message">${successMessage}</div>
                </c:if>
                <form action="profile" method="post" enctype="multipart/form-data">
                    <div class="profile-form-grid">
                        <div>
                            <label class="labels">Họ</label>
                            <input name="firstName" type="text" class="form-control"
                                   value="${sessionScope.user1.firstName}" required>
                        </div>
                        <div>
                            <label class="labels">Tên</label>
                            <input name="lastName" type="text" class="form-control"
                                   value="${sessionScope.user1.lastName}" required>
                        </div>
                        <div>
                            <label class="labels">Giới tính</label>
                            <select name="gender" class="form-control" required>
                                <option value="0" <c:if test="${sessionScope.user1.gender == 0}">selected</c:if>>Nam</option>
                                <option value="1" <c:if test="${sessionScope.user1.gender == 1}">selected</c:if>>Nữ</option>
                                <option value="2" <c:if test="${sessionScope.user1.gender == 2}">selected</c:if>>Khác</option>
                                </select>
                            </div>
                            <div>
                                <label class="labels">Số điện thoại</label>
                                <input id="mobile" name="mobile" type="text" class="form-control"
                                       value="${sessionScope.user1.mobile}" required>
                        </div>
                        <div style="grid-column: span 2;">
                            <label class="labels">Tỉnh/Thành phố</label>
                            <input type="hidden" name="addressId" value="${sessionScope.address[0].addressId}">
                            <input name="province" type="text" class="form-control"
                                   value="${sessionScope.address[0].province}" required>
                        </div>

                        <div style="grid-column: span 2;">
                            <label class="labels">Quận/Huyện</label>
                            <input name="district" type="text" class="form-control"
                                   value="${sessionScope.address[0].district}" required>
                        </div>

                        <div style="grid-column: span 2;">
                            <label class="labels">Xã/Phường</label>
                            <input name="ward" type="text" class="form-control"
                                   value="${sessionScope.address[0].ward}" required>
                        </div>

                        <div style="grid-column: span 2;">
                            <label class="labels">Địa chỉ chi tiết</label>
                            <input name="addressDetail" type="text" class="form-control"
                                   value="${sessionScope.address[0].addressDetail}" required>
                        </div>
                        <!--                        <div>
                                                    <label class="labels">Vai trò</label>
                                                    <input name="role" type="text" class="form-control"
                                                           value="${sessionScope.role}" readonly>
                                                </div>-->
                        <!--                        <div>
                                                    <label class="labels">Email</label>
                                                    <input name="email" type="text" class="form-control"
                                                           value="${sessionScope.user1.email}" readonly>
                                                </div>-->
                        <div style="grid-column: span 2;">
                            <label class="labels">Thay đổi ảnh đại diện</label>
                            <input name="avatar" type="file" class="form-control" accept="image/*" onchange="previewAvatar(event)"><br/>
                            <small class="form-text text-muted mb-2">Chỉ chọn ảnh mới nếu muốn thay đổi.</small>
                            <img id="preview-img" style="display:none; width: 140px; height: 140px; margin-top: 10px; border-radius: 10px;">
                        </div>
                    </div>
                    <div class="profile-actions">
                        <button class="profile-button" type="submit">Lưu Thông Tin</button>
                        <!--<a href="changePassWord.jsp" class="profile-button profile-button-outline">Đổi mật khẩu</a>-->
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <script>
            function previewAvatar(event) {
                const output = document.getElementById('preview-img');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.style.display = 'block';
                output.onload = () => URL.revokeObjectURL(output.src);
            }
            // Validate số điện thoại trước submit
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector('.profile-form-side form').addEventListener('submit', function (e) {
                    const mobile = document.getElementById('mobile').value.trim();
                    const mobileRegex = /^[0-9]{10,11}$/;
                    if (!mobileRegex.test(mobile)) {
                        alert('Số điện thoại phải có 10-11 chữ số!');
                        e.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>
