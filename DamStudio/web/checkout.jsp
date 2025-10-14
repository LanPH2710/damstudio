<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Checkout - DÁM STUDIO</title>
        <meta charset="utf-8"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css?v=${System.currentTimeMillis()}"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700;600;400&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link rel="stylesheet" href="css/homePage.css">

    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="checkout-main-wrapper">
            <h2 class="checkout-title">Checkout</h2>
            <c:if test="${not empty error}">
                <div class="checkout-alert">${error}</div>
            </c:if>
            <form action="checkout" method="post" class="checkout-form">
                <input type="hidden" name="cartIds" value="${cartIds}"/>
                <div class="checkout-grid">
                    <!-- LEFT -->
                    <div class="checkout-left">
                        <div class="checkout-step">
                            <div class="checkout-step-header"><i class="fa fa-map-marker-alt"></i> Địa chỉ giao hàng</div>
                            <div class="checkout-address-list">
                                <c:forEach var="address" items="${addressUsers}" varStatus="loop">
                                    <label class="checkout-address-card <c:if test='${loop.first}'>active</c:if>">
                                        <input type="radio" name="addressId" value="${address.addressId}" <c:if test="${loop.first}">checked</c:if> required/>
                                            <div class="address-info">
                                                <div class="address-name-row">
                                                    <div class="address-name"><b>${address.name}</b></div>
                                                <a href="editcartaddress?addressId=${address.addressId}&cartIds=${cartIds}" class="edit-address-btn" title="Sửa địa chỉ">
                                                    <i class="fa fa-pen"></i>
                                                </a>
                                            </div>
                                            <div class="address-detail">
                                                ${address.addressDetail}, ${address.ward}, ${address.district}, ${address.province}
                                            </div>
                                            <div class="address-contact">
                                                <span class="email"><i class="fa fa-envelope"></i> ${address.email}</span>
                                                <span class="phone"><i class="fa fa-phone"></i> ${address.phone}</span>
                                            </div>
                                        </div>
                                    </label>
                                </c:forEach>
                                <a href="adddaddressuser?cartIds=${cartIds}" class="btn-link add-address-btn"><i class="fa fa-plus"></i> Thêm địa chỉ mới</a>
                            </div>
                        </div>

                        <div class="checkout-step">
                            <div class="checkout-step-header"><i class="fa fa-ticket"></i> Voucher khuyến mãi</div>
                            <div class="voucher-row">
                                <c:choose>
                                    <c:when test="${empty voucherList}">
                                        <div class="voucher-empty-msg">
                                            <i class="fa fa-ticket"></i> Hiện tại bạn chưa có voucher nào khả dụng.  
                                            <br>
                                            <span class="voucher-note">(Voucher hết hạn, đã sử dụng hoặc không đáp ứng điều kiện giá trị đơn hàng)</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <select id="voucherSelect" name="voucherId" class="voucher-select">
                                            <option value="0" data-type="none" data-value="0">Không áp dụng voucher</option>
                                            <c:forEach var="v" items="${voucherList}">
                                                <option
                                                    value="${v.voucherId}"
                                                    data-type="${v.discountType}"
                                                    data-value="${v.discountValue}"
                                                    data-maxdiscount="${v.maxDiscountValue}"
                                                    data-minorder="${v.minOrderValue}"
                                                    >
                                                    ${v.code} - ${v.description}
                                                    <c:choose>
                                                        <c:when test="${v.discountType eq 'percent'}">
                                                            (-${v.discountValue}% tối đa <fmt:formatNumber value="${v.maxDiscountValue}" type="number"/> đ)
                                                        </c:when>
                                                        <c:otherwise>
                                                            (-<fmt:formatNumber value="${v.discountValue}" type="number"/> đ)
                                                        </c:otherwise>
                                                    </c:choose>
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <span id="voucher-desc" class="voucher-desc"></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="checkout-step">
                            <div class="checkout-step-header"><i class="fa fa-credit-card"></i> Phương thức thanh toán</div>
                            <div class="checkout-payment-list">
                                <label class="checkout-payment-card">
                                    <input type="radio" name="payMethod" value="online" checked>
                                    <div class="payment-info">
                                        <i class="fa fa-university"></i> Thanh toán online
                                    </div>
                                </label>
                                <!--                                <label class="checkout-payment-card">-->
<!--                                    <input type="radio" name="payMethod" value="balance">-->
                                    <!--                                    <div class="payment-info">
                                                                            <i class="fa fa-wallet"></i> Ví Carpipi<br>
                                                                            <span class="payment-balance">Số dư: <fmt:formatNumber value="${balance}" type="number"/> đ</span>
                                                                        </div>-->
<!--                                </label>-->
                                <label class="checkout-payment-card">
                                    <input type="radio" name="payMethod" value="cod">
                                    <div class="payment-info">
                                        <i class="fa fa-money-bill-wave"></i> Thanh toán COD
                                    </div>
                                </label>
                            </div>
                            <c:if test="${not empty sessionScope.messCheckOut}">
                                <div class="checkout-alert warn">
                                    ${sessionScope.messCheckOut}
                                    <c:remove var="messCheckOut" scope="session"/>
                                </div>
                            </c:if>
                        </div>
                        <button type="submit" class="checkout-btn">Đặt hàng & Thanh toán</button>
                    </div>
                    <!-- RIGHT -->
                    <div class="checkout-right">
                        <div class="checkout-step">
                            <div class="checkout-step-header"><i class="fa fa-receipt"></i> Đơn hàng của bạn</div>
                            <div class="order-summary-box">
                                <table class="order-summary-table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>SL</th>
                                            <th class="text-end">Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cart" items="${cartList}">
                                            <tr>
                                                <td>
                                                    <b>${productMap[cart.productId].name}</b>
                                                    <div class="order-variant">
                                                        <span>Màu: ${colorMap[cart.colorId].colorName}</span> | 
                                                        <span>Size: ${sizeMap[cart.sizeId].sizeName}</span>
                                                    </div>
                                                </td>
                                                <td>${cart.cartQuantity}</td>
                                                <td class="text-end">
                                                    <fmt:formatNumber value="${productMap[cart.productId].price * cart.cartQuantity}" type="number"/> đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr id="voucher-row" style="display:none;">
                                            <td colspan="2" class="text-end"><b>Voucher giảm giá</b></td>
                                            <td class="text-end" id="voucherDiscount">-0 đ</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="text-end"><b>Tổng cộng</b></td>
                                            <td class="text-end total-money">
                                                <span id="finalTotal"><fmt:formatNumber value="${totalMoney}" type="number"/> đ</span>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>

                        <!-- Khối QR Thanh toán Online (ẩn mặc định) -->
                        <div id="qrPaymentBox" class="checkout-step" style="display:none; margin-top:15px; text-align:center;">
                            <div class="checkout-step-header"><i class="fa fa-qrcode"></i> Quét mã để thanh toán</div>
                            <div>
                                <img src="${pageContext.request.contextPath}/image/logo/payment.png" alt="QR thanh toán" style="max-width:250px;">
                                <p><b>Ngân hàng:</b> TP Bank</p>
                                <p><b>Số tài khoản:</b> 5682446888</p>
                                <p><b>Chủ tài khoản:</b> Trinh Van Tuan</p>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy các element liên quan
                const voucherSelect = document.getElementById('voucherSelect');
                const finalTotalSpan = document.getElementById('finalTotal');
                const voucherDiscount = document.getElementById('voucherDiscount');
                const voucherRow = document.getElementById('voucher-row');
                const voucherDesc = document.getElementById('voucher-desc');

                // Nhận totalMoney từ server qua data attribute (an toàn hơn EL trực tiếp)
                // <span id="finalTotal" data-totalmoney="..."></span> (nếu muốn dùng)
                // Nhưng bạn vẫn có thể lấy từ JSP như sau (nên cast về number):
                const totalMoney = Number('${totalMoney}');

                // Hàm định dạng tiền VNĐ
                function formatCurrency(amount) {
                    if (isNaN(amount))
                        return "0 đ";
                    return amount.toLocaleString('vi-VN') + ' đ';
                }

                // Xử lý khi người dùng chọn voucher
                function updateVoucherInfo() {
                    if (!voucherSelect)
                        return; // Không có voucher, bỏ qua
                    let option = voucherSelect.selectedOptions[0];
                    if (!option)
                        return;

                    let type = option.dataset.type;
                    let value = Number(option.dataset.value) || 0;
                    let max = Number(option.dataset.maxdiscount) || 0;
                    let discount = 0;

                    // Tính toán giảm giá
                    if (type === 'percent') {
                        discount = Math.round(totalMoney * value / 100);
                        if (max > 0 && discount > max)
                            discount = max;
                        voucherDesc.textContent = "Giảm " + value + "% (tối đa " + formatCurrency(max) + ")";
                    } else if (type === 'amount') {
                        discount = value;
                        voucherDesc.textContent = "Giảm trực tiếp" + formatCurrency(discount);
                    } else {
                        voucherDesc.textContent = '';
                    }

                    if (discount > totalMoney)
                        discount = totalMoney;

                    let final = totalMoney - discount;

                    // Cập nhật UI bảng tổng kết đơn hàng
                    if (discount > 0) {
                        voucherRow.style.display = '';
                        voucherDiscount.textContent = '-' + formatCurrency(discount);
                    } else {
                        voucherRow.style.display = 'none';
                        voucherDiscount.textContent = '';
                    }
                    finalTotalSpan.textContent = formatCurrency(final);
                }

                // Nếu có voucherSelect thì lắng nghe sự kiện thay đổi
                if (voucherSelect) {
                    voucherSelect.addEventListener('change', updateVoucherInfo);
                    // Tự động tính toán khi load trang
                    voucherSelect.dispatchEvent(new Event('change'));
                }
            });

            document.addEventListener("DOMContentLoaded", function () {
                const payMethodRadios = document.querySelectorAll('input[name="payMethod"]');
                const qrBox = document.getElementById("qrPaymentBox");

                function toggleQR() {
                    let selected = document.querySelector('input[name="payMethod"]:checked');
                    if (selected && selected.value === "online") {
                        qrBox.style.display = "block";
                    } else {
                        qrBox.style.display = "none";
                    }
                }

                payMethodRadios.forEach(r => r.addEventListener("change", toggleQR));

                // chạy lần đầu để đồng bộ khi load trang
                toggleQR();
            });
        </script>
    </body>
</html>
