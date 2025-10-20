<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dam Studio</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/thanks.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="thanks-container">
                <div class="thanks-header">
                    Đặt hàng thành công
                </div>
                <div class="thanks-message">
                    🎉 Chúc mừng bạn đã hoàn tất đơn hàng.<br>
                    Chúng tôi sẽ kiểm tra và liên hệ giao hàng đến bạn trong thời gian sớm nhất.<br>
                    Để xem lại đơn hàng, vui lòng <a href="myorder">nhấn vào đây</a>.
                </div>
                <a href="homepage" class="thanks-btn">Quay lại trang chủ</a>
            </div>     

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
