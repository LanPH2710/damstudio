<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderDetail.css?v=${System.currentTimeMillis()}"/>
        <link href="assets1/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="order-detail-container">
            <div class="container mt-4">
                <!-- Quay lại -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <a href="javascript:history.back()" class="back-btn">← Trở lại</a>
                </div>

                <!-- Tiến trình đơn -->
                <c:set var="currentStatus" value="${order.orderStatus}"   />
                <div class="order-status">
                    <div class="order-status-step ${currentStatus >= 1 ? 'active' : ''}">Đã đặt</div>
                    <div class="order-status-step ${currentStatus >= 2 ? 'active' : ''}">Đã thanh toán</div>
                    <div class="order-status-step ${currentStatus == 3 ? 'active' : ''}">Đang giao</div>
                    <div class="order-status-step ${currentStatus == 4 ? 'active' : ''}">Hoàn thành</div>
                    <div class="order-status-step ${currentStatus == 5 ? 'active' : ''}">Đã hủy</div>

                </div>

                <!-- Danh sách sản phẩm -->
                <div class="mb-4">
                    <h5>Sản phẩm</h5>
                    <c:forEach var="item" items="${orderInfor}">
                        <div class="product-card">
                            <img src="image/logo/logoIMG.png" alt="${item.productName}">
                            <div>
                                <h6>${item.productName}</h6>
                                <p>Màu sắc: ${item.colorName}</p>
                                <p>Size: ${item.sizeName}</p>
                                <p>Số lượng: ${item.quantity}</p>
                                <p>
                                    Thanh toán:
                                    <c:choose>
                                        <c:when test="${order.payMethod == 1}">Đã thanh toán</c:when>
                                        <c:when test="${order.payMethod == 2}">Khi nhận hàng</c:when>
                                        <c:when test="${order.payMethod == 3}">Số dư tài khoản</c:when>
                                        <c:otherwise>Khác</c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="text-danger fw-bold">
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Địa chỉ và vận chuyển -->
                <div class="order-info">
                    <div>
                        <h5>Địa chỉ nhận hàng</h5>
                        <p>${order.orderName}</p>
                        <p>${order.orderPhone}</p>
                        <p>${order.orderEmail}</p>
                        <p>${order.shippingAddress}</p>
                    </div>
                    <div>
                        <h5>Vận chuyển</h5>
                        <p>Ngày tạo: ${order.createDate}</p>
                        <p>Mã vận chuyển: ${order.orderDeliverCode}</p>
                    </div>
                </div>

                <!-- Tổng tiền + Nút hành động -->
                <div class="order-total">
                    <h5>
                        Tổng tiền: 
                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="VND" maxFractionDigits="0"/>
                    </h5>
                    <div>
<!--                        <a href="addtocart?productId=${orderInfor[0].productId}&colorId=${orderInfor[0].colorId}&quantity=1" class="btn-red">Mua lại</a>-->
                        <c:if test="${order.orderStatus == 1}">
                            <a href="cancelorder?orderId=${order.orderId}&totalPrice=${order.totalPrice}&userId=${order.userId}&payMethod=${order.payMethod}"
                               onclick="return confirm('Bạn có chắc muốn hủy đơn này?');"
                               class="btn-red">Hủy đơn</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <script src="assets1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
