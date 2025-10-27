<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback</title>
        <%-- Đảm bảo đường dẫn CSS của bạn đúng --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/feedback.css?v=${System.currentTimeMillis()}"/>
        <%-- Có vẻ bạn đang sử dụng Font Awesome cho các ngôi sao --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> 
        <link rel="stylesheet" href="css/homePage.css">
        <script>
            function previewImage(event) {
                const file = event.target.files[0];
                const reader = new FileReader();
                reader.onload = function () {
                    const output = document.getElementById('imagePreview');
                    output.src = reader.result;
                    output.style.display = 'block';
                };
                if (file)
                    reader.readAsDataURL(file);
            }
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp"/>

        <section class="feedback-container">
            <form action="customerfeedback" method="post" class="feedback-form" enctype="multipart/form-data">

                <h2 class="form-title">Đánh giá sản phẩm</h2>

                <%-- Thông tin khách hàng --%>
                <div class="info-group">
                    <h5 class="group-title">Thông tin khách hàng</h5>

                    <div class="form-row">
                        <div class="form-field">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="input-disabled" value="${acc.firstName} ${acc.lastName}" disabled>
                        </div>
                        <div class="form-field">
                            <label class="form-label">Giới tính</label>
                            <input type="text" class="input-disabled" value="${acc.gender == 0 ? 'Nam' : acc.gender == 1 ? 'Nữ' : 'Khác'}" disabled>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label class="form-label">Email</label>
                            <input type="text" class="input-disabled" value="${acc.email}" disabled>
                        </div>
                        <div class="form-field">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="input-disabled" value="${acc.mobile}" disabled>
                        </div>
                    </div>
                </div>

                <%-- Phản hồi từ khách hàng --%>
                <div class="feedback-content">
                    <h5 class="group-title">Phản hồi của bạn</h5>

                    <div class="form-field">
                        <label class="form-label">Nội dung phản hồi <span class="required">*</span></label>
                        <textarea class="form-input" name="feedbackInfor" rows="4" required placeholder="Chia sẻ cảm nhận của bạn về sản phẩm..."></textarea>
                    </div>

                    <div class="form-field rating-field">
                        <label class="form-label">Đánh giá <span class="required">*</span></label>
                        <div class="star-rating">
                            <%-- Star rating (sử dụng fa-star từ Font Awesome) --%>
                            <input type="radio" id="star5" name="feedbackRate" value="5" required/>
                            <label for="star5" class="fa fa-star" title="5 sao"></label>

                            <input type="radio" id="star4" name="feedbackRate" value="4" required/>
                            <label for="star4" class="fa fa-star" title="4 sao"></label>

                            <input type="radio" id="star3" name="feedbackRate" value="3" required/>
                            <label for="star3" class="fa fa-star" title="3 sao"></label>

                            <input type="radio" id="star2" name="feedbackRate" value="2" required/>
                            <label for="star2" class="fa fa-star" title="2 sao"></label>

                            <input type="radio" id="star1" name="feedbackRate" value="1" required/>
                            <label for="star1" class="fa fa-star" title="1 sao"></label>
                        </div>
                    </div>

                    <div class="form-field">
                        <label class="form-label">Hình ảnh phản hồi (Tùy chọn)</label>
                        <input name="feedbackImg" type="file" class="form-input-file" accept="image/*" onchange="previewImage(event)">
                        <img id="imagePreview" src="" alt="Hình ảnh xem trước">
                    </div>
                </div>

                <%-- Hidden Inputs --%>
                <input type="hidden" name="productId" value="${pro.productId}">
                <input type="hidden" name="userId" value="${acc.userId}">
                <input type="hidden" name="orderDetailId" value="${orderDetailId}">

                <div class="form-actions">
                    <button type="submit" class="submit-btn" name="submit" value="submit">Gửi Đánh Giá</button>
                </div>
            </form>
        </section>

        <jsp:include page="footer.jsp"/>
    </body>
</html>