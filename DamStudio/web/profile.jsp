<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>User Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/profile.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <form action="profile" method="post" enctype="multipart/form-data">
                <div class="profile-wrapper">
                    <div class="container rounded mt-5 mb-5 p-4">
                        <a href="homepage" class="btn btn-primary" style="margin-bottom: 10px;">
                            <span>X</span>
                        </a>

                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="success-message">${successMessage}</div>
                    </c:if>
                    <div class="row">
                        <!-- Avatar and User Info -->
                        <div class="col-md-4 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                <img class="avatar mt-5" width="200px" height="200px" src="image/logo/${user1.avatar}">
                                <h3 class="font-weight-bold mt-3">${user1.firstName} ${user1.lastName}</h3>
                                <span class="text-black-50">${user1.email}</span>
                            </div>
                        </div>

                        <!-- Profile Form -->
                        <div class="col-md-8 border-right">
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="header-title">Thông tin cá nhân</h4>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Họ</label>
                                        <input name="firstName" type="text" class="form-control" value="${user1.firstName}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Tên</label>
                                        <input name="lastName" type="text" class="form-control" value="${user1.lastName}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Giới tính</label>
                                        <select name="gender" class="form-control" required>
                                            <option value="0" <c:if test="${user1.gender == 0}">selected</c:if>>Nam</option>
                                            <option value="1" <c:if test="${user1.gender == 1}">selected</c:if>>Nữ</option>
                                            <option value="2" <c:if test="${user1.gender == 2}">selected</c:if>>Khác</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="labels">Số điện thoại</label>
                                            <input id="mobile" name="mobile" type="text" class="form-control" value="${user1.mobile}" required>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="labels">Địa chỉ</label>
                                        <input name="address" type="text" class="form-control" value="${user1.address}" required>
                                    </div>
                                    <!-- Role (Read-Only) -->
                                    <div class="col-md-6">
                                        <label class="labels">Vai trò</label>
                                        <input name="role" type="text" class="form-control" value="${role}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Số dư tài khoản</label>
                                        <input name="money" type="text" class="form-control" value="${user1.money} USD" readonly>
                                    </div>

                                    <!-- Email (Read-Only) -->
                                    <div class="col-md-12">
                                        <label class="labels">Email</label>
                                        <input name="email" type="text" class="form-control" value="${user1.email}" readonly>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="labels">Thay đổi ảnh đại diện</label>
                                        <input name="avatar" type="file" class="form-control" accept="image/*" onchange="previewAvatar(event)">
                                        <small class="form-text text-muted mb-2">Chỉ cần chọn ảnh mới nếu bạn muốn thay đổi ảnh đại diện.</small>
                                        <img id="preview-img" style="display:none; width: 140px; height: 140px; margin-top: 10px; border-radius: 10px;">
                                    </div>
                                </div>
                                <!-- Save Button -->
                                <span class="mt-5 text-center">
                                    <button class="btn btn-primary profile-button" type="submit">Lưu Thông Tin</button>
                                </span>
                                <span class="mt-5 text-center">
                                    <a href="changePassWord.jsp" class="btn btn-primary profile-button">Đổi mật khẩu</a>
                                </span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <form action="increaseBalance" method="post">
            <div class="container mt-3">
                <div class="col-md-12">
                    <label class="labels">Tăng số dư tài khoản</label>
                    <input name="increaseAmount" type="number" class="form-control" placeholder="Nhập số tiền muốn nạp" min="1" required>
                </div>
                <span class="mt-3 text-center">
                    <button class="btn btn-success profile-button" type="submit">Tăng Số Dư</button>
                </span>
            </div>
        </form>
        <jsp:include page="footer.jsp"></jsp:include>
        <script>
            function previewAvatar(event) {
                const output = document.getElementById('preview-img');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.style.display = 'block';
                output.onload = () => URL.revokeObjectURL(output.src);
            }
            // Kiểm tra số điện thoại trước khi gửi form
            document.querySelector('form[action="profile"]').addEventListener('submit', function (e) {
                const mobile = document.getElementById('mobile').value.trim();
                const mobileRegex = /^[0-9]{10,11}$/;
                if (!mobileRegex.test(mobile)) {
                    alert('Số điện thoại phải có 10-11 chữ số!');
                    e.preventDefault();
                }
            });
        </script>

    </body>
</html>
