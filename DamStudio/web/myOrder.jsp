<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myOrder.css?v=${System.currentTimeMillis()}"/>
        <title>Đơn hàng của tôi</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="page-wrapper doctris-theme toggled">
            <!-- Page Content -->
            <main class="page-content bg-light">
                <div class="container-fluid">
                    <div class="layout-specing">
                        <!-- Hiển thị thông báo hủy đơn -->
                        <c:if test="${not empty sessionScope.cancelMessage}">
                            <div style="color: red; font-weight: bold; margin: 10px 0; text-align: center;">
                                ${sessionScope.cancelMessage}
                            </div>
                            <c:remove var="cancelMessage" scope="session"/>
                        </c:if>

                        <!-- Tabs trạng thái -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="table-responsive bg-white shadow rounded">
                                    <!-- Danh sách đơn -->
                                    <div class="order-list">
                                        <div class="header1">
                                            <c:set var="currentStatusId" value="${statusId != null ? statusId : 0}" />
                                            <ul class="tabs">
                                                <li class="${currentStatusId == 0 ? 'active' : ''}"><a href="order">Tất cả</a></li>
                                                <li class="${currentStatusId == 1 ? 'active' : ''}"><a href="order?statusId=1">Chờ xử lý</a></li>
                                                <li class="${currentStatusId == 2 ? 'active' : ''}"><a href="order?statusId=2">Đã xác nhận</a></li>
                                                <li class="${currentStatusId == 3 ? 'active' : ''}"><a href="order?statusId=3">Chờ giao hàng</a></li>
                                                <li class="${currentStatusId == 4 ? 'active' : ''}"><a href="order?statusId=4">Hoàn thành</a></li>
                                                <li class="${currentStatusId == 5 ? 'active' : ''}"><a href="order?statusId=5">Đã hủy</a></li>
                                            </ul>
                                        </div>
                                        <c:choose>
                                            <c:when test="${empty myOrder}">
                                                <p class="no-order-message">Chưa có đơn nào, xin hãy quay lại mua sắm.</p>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${myOrder}" var="order">
                                                    <article class="order-item">
                                                        <div class="order-details">
                                                            <!-- Trạng thái thanh toán -->
                                                            <p class="delivery-status">
                                                                <c:choose>
                                                                    <c:when test="${order.payMethod == 1}">Đã thanh toán trước.</c:when>
                                                                    <c:when test="${order.payMethod == 3}">Đã thanh toán trước.</c:when>
                                                                    <c:when test="${order.payMethod == 2}">Thanh toán khi nhận hàng.</c:when>
                                                                    <c:otherwise>Đã thanh toán.</c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <!-- Trạng thái đơn hàng -->
                                                            <p class="delivery-status">
                                                                <c:choose>
                                                                    <c:when test="${order.orderStatus == 1}">Đang chờ xử lý</c:when>
                                                                    <c:when test="${order.orderStatus == 2}">Đã xác nhận</c:when>
                                                                    <c:when test="${order.orderStatus == 3}">Đang giao hàng</c:when>
                                                                    <c:when test="${order.orderStatus == 4}">Hoàn thành</c:when>
                                                                    <c:when test="${order.orderStatus == 5}">Đã hủy</c:when>
                                                                </c:choose>
                                                            </p>

                                                            <!-- Chi tiết sản phẩm -->
                                                            <c:forEach items="${orderDetailsMap[order.orderId]}" var="detail">
                                                                <div class="order-detail-item">
                                                                    <div class="product-info">
                                                                        <img src="image/logo/logoIMG.png" class="product-img" alt="">
                                                                        <div class="product-description">
                                                                            <h4>
                                                                                <a href="productdetail?productId=${detail.productId}" class="product-name">${detail.productName}</a>
                                                                            </h4>
                                                                            <p class="quantity">Số lượng: ${detail.quantity}</p>
                                                                            <p class="color">Màu sắc: ${detail.colorName}</p>
                                                                            <p class="color">Kiểu dáng: ${detail.sizeName}</p>


                                                                        </div>
                                                                        <!-- Đánh giá -->
                                                                        <c:if test="${order.orderStatus == 4 && detail.isFeedback == 0}">
                                                                            <a class="buy-again-btn"
                                                                               href="customerfeedback?productId=${detail.productId}&orderDetailId=${detail.orderDetailId}">Đánh giá</a>
                                                                        </c:if>
                                                                    </div>
                                                                    <c:choose>
                                                                        <c:when test="${detail.isFeedback == 0}">
                                                                            <small class="feedback-message">Xin hãy đánh giá sau khi nhận hàng!</small>
                                                                        </c:when>
                                                                        <c:when test="${detail.isFeedback == 1}">
                                                                            <small class="feedback-message">Cảm ơn bạn đã đánh giá!</small>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </div>
                                                            </c:forEach>

                                                            <!-- Tổng tiền -->
                                                            <div class="order-actions">
                                                                <p class="price">
                                                                    <span>Thành tiền:</span>&nbsp;
                                                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="USD" maxFractionDigits="0"/>
                                                                </p>
                                                            </div>

                                                            <!-- Nút hành động -->
                                                            <div class="button-container">
                                                                <a href="orderdetail?orderId=${order.orderId}">
                                                                    <button class="return-btn">Thông tin đơn hàng</button>
                                                                </a>
                                                                <c:if test="${order.orderStatus == 4}">
                                                                    <a href="addtocart?productId=${orderDetailsMap[order.orderId][0].productId}&colorId=${orderDetailsMap[order.orderId][0].colorId}&sizeId=${orderDetailsMap[order.orderId][0].sizeId}&quantity=1">
                                                                        <button class="buy-again-btn">Mua lại</button>
                                                                    </a>
                                                                </c:if>
                                                                <c:if test="${order.orderStatus == 1}">
                                                                    <a href="cancelorder?orderId=${order.orderId}&totalPrice=${order.totalPrice}&userId=${order.userId}&payMethod=${order.payMethod}"
                                                                       onclick="return confirm('Bạn chắc chắn muốn hủy đơn này?');">
                                                                        <button class="buy-again-btn">Hủy đơn</button>
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </article>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Trang <b>${page}</b> / <b>${num}</b>
                                    </span>
                                    <ul class="pagination justify-content-center mb-0">
                                        <c:if test="${page > 1}">
                                            <li class="page-item"><a class="page-link" href="order?page=${page-1}&statusId=${statusId}">Prev</a></li>
                                            </c:if>
                                            <c:forEach begin="${page-1 <= 1 ? 1 : page-1}" end="${page+1 > num ? num : page+1}" var="i">
                                            <li class="page-item ${i==page?'active':''}">
                                                <a class="page-link" href="order?page=${i}&statusId=${statusId}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${page < num}">
                                            <li class="page-item"><a class="page-link" href="order?page=${page+1}&statusId=${statusId}">Next</a></li>
                                            </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </main>
        </div>

        <!-- JS -->
        <script src="assets1/js/bootstrap.bundle.min.js"></script>
        <script src="assets1/js/simplebar.min.js"></script>
        <script src="assets1/js/feather.min.js"></script>
        <script src="assets1/js/app.js"></script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
