<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Giỏ hàng</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="css/homePage.css">

    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="main-cart">
                <div class="cart-title">Giỏ Hàng</div>
                <div class="cart-table-header">
                    <div class="cart-col-checkbox"><input type="checkbox" class="cart-checkall"/></div>
                    <div class="cart-col-product">Sản phẩm</div>
                    <div class="cart-col-price">Đơn giá</div>
                    <div class="cart-col-qty">Số lượng</div>
                    <div class="cart-col-total">Thành tiền</div>
                    <div class="cart-col-action">Thao tác</div>
                </div>
                <!-- Sản phẩm 1 -->
            <c:forEach items="${sessionScope.activeCarts}" var="activeCart">
                <div class="cart-item-row">
                    <div class="cart-col-checkbox"><input type="checkbox" class="cart-checkbox-item" value="${activeCart.cartId}"/></div>
                    <div class="cart-col-product">
                        <div class="product-info">
                            <img class="cart-img" src="image/logo/logoIMG.png" alt="${activeCart.productId}">
                            <div class="prod-details">
                                <div class="prod-name" onclick="window.location.href = 'productdetail?productId=${activeCart.productId}';">
                                    ${productMap[activeCart.productId].name}
                                </div>

                                <div class="prod-type">
                                    <span class="prod-variant-label">Phân Loại Hàng:</span>
                                    <span class="prod-variant-value variantSelect" tabindex="0">
                                        <c:forEach var="color" items="${colorMap[activeCart.productId]}">
                                            <c:if test="${color.colorId == activeCart.colorId}">
                                                ${color.colorName}
                                            </c:if>
                                        </c:forEach>, 
                                        <c:forEach var="size" items="${sizeMap[activeCart.productId]}">
                                            <c:if test="${size.sizeId == activeCart.sizeId}">
                                                ${size.sizeName}
                                            </c:if>
                                        </c:forEach> <span class="arrow-down">▲</span>
                                    </span>
                                    <!-- Popup Phân Loại Hàng -->
                                    <div class="variant-popup" style="display:none;">
                                        <div class="popup-arrow"></div>
                                        <div class="popup-content">
                                            <div class="popup-row">
                                                <span class="popup-label">Màu Sắc:</span>
                                                <c:forEach var="color" items="${colorMap[activeCart.productId]}">
                                                    <c:choose>
                                                        <c:when test="${color.colorId == activeCart.colorId}">
                                                            <button class="popup-option selected" data-color-id="${color.colorId}">
                                                                ${color.colorName}
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="popup-option" data-color-id="${color.colorId}">
                                                                ${color.colorName}
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            <div class="popup-row">
                                                <span class="popup-label">Size:</span>
                                                <c:forEach var="size" items="${sizeMap[activeCart.productId]}">
                                                    <c:choose>
                                                        <c:when test="${size.sizeId == activeCart.sizeId}">
                                                            <button class="popup-option selected" data-size-id="${size.sizeId}">
                                                                ${size.sizeName}
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="popup-option" data-size-id="${size.sizeId}">
                                                                ${size.sizeName}
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            <div class="popup-actions">
                                                <button class="popup-back">TRỞ LẠI</button>
                                                <button class="popup-confirm">XÁC NHẬN</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cart-col-price">
                        <span class="cart-price" data-price="${productMap[activeCart.productId].price}">₫${productMap[activeCart.productId].price}</span>
                    </div>
                    <div class="cart-col-qty">
                        <div class="cart-qty-box">
                            <button class="cart-qty-btn cart-qty-minus">-</button>
                            <input type="text" class="cart-qty-input" 
                                   value="${activeCart.cartQuantity}"
                                   data-max-qty="${quantityMap[activeCart.productId.concat('_').concat(activeCart.colorId).concat('_').concat(activeCart.sizeId)]}"
                                   readonly>
                            <button class="cart-qty-btn cart-qty-plus">+</button>
                        </div>
                    </div>
                    <div class="cart-col-total">
                        <span class="cart-total">₫${totalMoney}</span>
                    </div>
                    <div class="cart-col-action">
                        <button class="cart-del-btn" 
                                data-cart-id="${activeCart.cartId}" 
                                title="Xóa sản phẩm">Xóa</button>
                    </div>
                </div>
            </c:forEach>
            <!-- DANH SÁCH SẢN PHẨM KHÔNG HOẠT ĐỘNG -->
            <c:if test="${not empty inactiveCarts}">
                <div id="inactiveSection">
                    <div class="inactive-title-bar">Danh Sách Sản Phẩm Không Hoạt Động</div>
                    <c:forEach items="${inactiveCarts}" var="inactive">
                        <div class="cart-item-row cart-item-inactive">
                            <div class="cart-col-checkbox"></div>
                            <div class="cart-col-product">
                                <div class="product-info">
                                    <img class="cart-img" src="image/logo/logoIMG.png" alt="${inactive.productId}">
                                    <div class="prod-details">
                                        <div class="prod-name">${inaciveProductMap[inactive.productId].name}</div>
                                        <div class="prod-type">
                                            <span class="prod-variant-label">Phân Loại Hàng:</span>
                                            <span class="prod-variant-value">
                                                <c:forEach var="colorIn" items="${inaciveColorMap[inactive.productId]}">
                                                    <c:if test="${colorIn.colorId == inactive.colorId}">
                                                        ${colorIn.colorName}
                                                    </c:if>
                                                </c:forEach>, 
                                                <c:forEach var="sizeIn" items="${inaciveSizeMap[inactive.productId]}">
                                                    <c:if test="${sizeIn.sizeId == inactive.sizeId}">
                                                        ${sizeIn.sizeName}
                                                    </c:if>
                                                </c:forEach></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="cart-col-price">
                                <span class="cart-old-price"><s>
                                        <fmt:formatNumber value="${inaciveProductMap[inactive.productId].price}" type="currency" currencySymbol="₫"/>
                                    </s></span> 
                                <span class="cart-price">
                                    <fmt:formatNumber value="${inaciveProductMap[inactive.productId].price}" type="currency" currencySymbol="₫"/> VNĐ
                                </span>
                            </div>
                            <div class="cart-col-qty">${inactive.cartQuantity}</div>
                            <div class="cart-col-total">
                                <span class="cart-total"><fmt:formatNumber value="${inactiveTotalMoney}" type="number" groupingUsed="true"/> VNĐ</span>
                            </div>
                            <div class="cart-item-row cart-item-inactive" data-cart-id="${inactive.cartId}">
                                <button class="cart-del-btn-inactive">XÓA</button>
                            </div>
                        </div>
                        <div class="inactive-footer-bar">
                            Bỏ sản phẩm không hoạt động
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="cart-summary-bar">
                <div class="cart-summary-left">
                    <div class="cart-col-checkbox"><input type="checkbox" class="cart-checkall"/></div>
                    <span class="cart-action-all" id="checkAllLabel">Chọn Tất Cả (${vol})</span>
                    <span class="cart-action-link cart-action-delete">Xóa</span>
                    <c:if test="${not empty inactiveCarts}"><span class="cart-action-link cart-action-disable" id="btnRemoveInactive">Bỏ sản phẩm không hoạt động</span></c:if>
                    </div>
                    <div class="cart-summary-right">
                        <span class="cart-total-label">Tổng cộng (<span class="cart-count">0 Sản phẩm</span>):</span>
                        <span class="cart-total-value">₫0</span>
                        <button class="cart-checkout-btn" type="button">Mua Hàng</button>
                    </div>
                </div>
            </div>
        <jsp:include page="footer.jsp"></jsp:include>

            <!-- Modal xác nhận xóa -->
            <div id="deleteConfirmModal" class="modal" style="display:none;">
                <div class="modal-content">
                    <p style="margin-bottom:18px;">Bạn muốn xóa đơn hàng này khỏi giỏ hàng?</p>
                    <button id="deleteConfirmYes" class="btn-danger">Đồng ý</button>
                    <button id="deleteConfirmNo" class="btn-neutral">Không đồng ý</button>
                </div>
            </div>
            <!-- Toast thông báo -->
            <div id="toastNotify" class="toast" style="display:none;">Vui lòng chọn sản phẩm</div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // ==== PHÂN LOẠI HÀNG: MỞ/ĐÓNG POPUP TỪNG DÒNG ====
                    document.querySelectorAll('.variantSelect').forEach(function (variantBtn) {
                        variantBtn.addEventListener('click', function (e) {
                            e.stopPropagation();
                            document.querySelectorAll('.variant-popup').forEach(function (popup) {
                                popup.style.display = 'none';
                            });
                            var variantPopup = variantBtn.closest('.cart-item-row').querySelector('.variant-popup');
                            if (variantPopup)
                                variantPopup.style.display = 'block';
                        });
                        variantBtn.addEventListener('keydown', function (e) {
                            if (e.key === "Enter" || e.key === " ") {
                                e.preventDefault();
                                variantBtn.click();
                            }
                        });
                    });
                    document.addEventListener('click', function () {
                        document.querySelectorAll('.variant-popup').forEach(function (popup) {
                            popup.style.display = 'none';
                        });
                    });
                    document.querySelectorAll('.variant-popup').forEach(function (popup) {
                        popup.addEventListener('click', function (e) {
                            e.stopPropagation();
                        });
                        popup.querySelectorAll('.popup-back, .popup-confirm').forEach(function (btn) {
                            btn.addEventListener('click', function () {
                                popup.style.display = 'none';
                            });
                        });
                    });

                    // ==== CHỌN TẤT CẢ / TỪNG DÒNG ====
                    const checkAlls = document.querySelectorAll('.cart-checkall');
                    const checkAllLabels = document.querySelectorAll('.cart-action-all');
                    const itemCheckboxes = document.querySelectorAll('.cart-checkbox-item');
                    checkAllLabels.forEach((lbl, i) => {
                        lbl.style.cursor = 'pointer';
                        lbl.onclick = function () {
                            checkAlls[i].click();
                        };
                    });
                    checkAlls.forEach(checkAll => {
                        checkAll.addEventListener('change', function () {
                            itemCheckboxes.forEach(cb => cb.checked = checkAll.checked);
                            checkAlls.forEach(cb2 => {
                                if (cb2 !== checkAll)
                                    cb2.checked = checkAll.checked;
                            });
                            updateAllTotals();
                        });
                    });
                    itemCheckboxes.forEach(cb => {
                        cb.addEventListener('change', function () {
                            const allChecked = Array.from(itemCheckboxes).every(x => x.checked);
                            checkAlls.forEach(ca => ca.checked = allChecked);
                            updateAllTotals();
                        });
                    });

                    document.querySelectorAll('.popup-row').forEach(function (row) {
                        row.querySelectorAll('.popup-option').forEach(function (btn) {
                            btn.addEventListener('click', function () {
                                // Bỏ selected ở tất cả button cùng hàng (màu hoặc size)
                                row.querySelectorAll('.popup-option').forEach(b => b.classList.remove('selected'));
                                // Thêm selected cho button vừa chọn
                                btn.classList.add('selected');
                            });
                        });
                    });

                    // ==== Khi bấm "Mua Hàng" -> Sang trang /checkout?cartIds=... ==== //
                    document.querySelector('.cart-checkout-btn').addEventListener('click', function () {
                        let checkedCheckboxes = document.querySelectorAll('.cart-checkbox-item:checked');
                        if (checkedCheckboxes.length === 0) {
                            alert("Vui lòng chọn sản phẩm để thanh toán!");
                            return;
                        }

                        let cartIds = Array.from(checkedCheckboxes).map(cb => cb.value);
                        // Lấy contextPath từ server (vd: /DamStudio khi local, còn online sẽ là rỗng)
                        var contextPath = '${pageContext.request.contextPath}';
                        window.location.href = contextPath + '/checkout?cartIds=' + encodeURIComponent(cartIds.join(','));
                    });

                    // ==== CHỌN THAY DOI COLOR,SIZE ====
                    document.querySelectorAll('.popup-confirm').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            // Tìm dòng cart liên quan
                            var popup = btn.closest('.variant-popup');
                            var row = popup.closest('.cart-item-row');
                            var cartId = row.querySelector('.cart-del-btn').getAttribute('data-cart-id');

                            // Lấy id màu và id size đang chọn
                            var colorId = popup.querySelector('.popup-option.selected[data-color-id]')?.getAttribute('data-color-id');
                            var sizeId = popup.querySelector('.popup-option.selected[data-size-id]')?.getAttribute('data-size-id');

                            if (!colorId || !sizeId) {
                                alert("Bạn cần chọn đủ màu và size!");
                                return;
                            }

                            var contextPath = '${pageContext.request.contextPath}';
                            fetch(contextPath + '/changecart', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'cartId=' + encodeURIComponent(cartId)
                                        + '&colorId=' + encodeURIComponent(colorId)
                                        + '&sizeId=' + encodeURIComponent(sizeId)
                            })
                                    .then(resp => resp.text())
                                    .then(data => {
                                        if (data.trim() === "OK") {
                                            // Update lại text phân loại ngay trên giao diện (không cần reload)
                                            // (Giả sử phần hiển thị có class prod-variant-value)
                                            let prodType = row.querySelector('.prod-variant-value');
                                            prodType.innerHTML = popup.querySelector('.popup-option.selected[data-color-id]').innerText
                                                    + ', '
                                                    + popup.querySelector('.popup-option.selected[data-size-id]').innerText
                                                    + ' <span class="arrow-down">▲</span>';
                                            popup.style.display = 'none';
                                        } else {
                                            alert(data || 'Không thể thay đổi phân loại!');
                                        }
                                    })
                                    .catch(() => alert('Lỗi kết nối server!'));
                        });
                    });

                    // ==== XÓA AJAX TỪNG SẢN PHẨM (DELETE /deletecart) ====
                    document.querySelectorAll('.cart-del-btn').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const row = btn.closest('.cart-item-row');
                            const cartId = btn.getAttribute('data-cart-id');
                            if (!cartId)
                                return;
                            if (!confirm('Bạn chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?'))
                                return;
                            var contextPath = window.location.pathname.split('/')[1] ? '/' + window.location.pathname.split('/')[1] : '';
                            fetch(contextPath + '/deletecart', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'cartId=' + encodeURIComponent(cartId)
                            })
                                    .then(resp => resp.text())
                                    .then(data => {
                                        if (data.trim() === 'OK') {
                                            row.remove();
                                            updateAllTotals();
                                            checkCartSummaryDisplay();
                                            checkEmptyCartDisplay();
                                            window.location.reload();
                                        } else {
                                            alert('Có lỗi khi xóa sản phẩm!');
                                        }
                                    })
                                    .catch(() => alert('Lỗi kết nối server!'));
                        });
                    });

                    // ==== XÓA NHIỀU SP QUA CHECKBOX + MODAL + AJAX ====
                    const btnDelete = document.querySelectorAll('.cart-action-delete');
                    const deleteModal = document.getElementById('deleteConfirmModal');
                    const btnYes = document.getElementById('deleteConfirmYes');
                    const btnNo = document.getElementById('deleteConfirmNo');
                    const toast = document.getElementById('toastNotify');
                    let singleDeleteRow = null;
                    let selectedCartIds = [];
                    btnDelete.forEach(btn => {
                        btn.onclick = function () {
                            let checkedRows = Array.from(itemCheckboxes).filter(x => x.checked);
                            singleDeleteRow = null;
                            if (checkedRows.length === 0) {
                                toast.innerText = 'Vui lòng chọn sản phẩm';
                                toast.style.display = 'block';
                                setTimeout(() => {
                                    toast.style.display = 'none';
                                }, 1800);
                            } else {
                                // Lưu lại các cartId đã chọn để xóa batch
                                selectedCartIds = checkedRows
                                        .map(cb => cb.closest('.cart-item-row').querySelector('.cart-del-btn').getAttribute('data-cart-id'))
                                        .filter(id => !!id);
                                deleteModal.style.display = 'flex';
                            }
                        }
                    });
                    btnYes.onclick = function () {
                        if (singleDeleteRow) {
                            singleDeleteRow.remove();
                            singleDeleteRow = null;
                        } else if (selectedCartIds.length > 0) {
                            // Gọi AJAX để xóa nhiều cartId cùng lúc
                            var contextPath = window.location.pathname.split('/')[1] ? '/' + window.location.pathname.split('/')[1] : '';
                            fetch(contextPath + '/deletecart', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'cartIds=' + encodeURIComponent(selectedCartIds.join(','))
                            })
                                    .then(resp => resp.text())
                                    .then(data => {
                                        if (data.trim() === 'OK') {
                                            // Xóa khỏi DOM (nếu muốn hiệu ứng nhanh)
                                            selectedCartIds.forEach(id => {
                                                document.querySelectorAll('.cart-item-row').forEach(row => {
                                                    let btn = row.querySelector('.cart-del-btn');
                                                    if (btn && btn.getAttribute('data-cart-id') == id) {
                                                        row.remove();
                                                    }
                                                });
                                            });
                                            updateAllTotals();
                                            checkCartSummaryDisplay();
                                            checkEmptyCartDisplay();
                                            // Reload lại trang để đồng bộ với database
                                            window.location.reload();
                                        } else {
                                            alert('Có lỗi khi xóa sản phẩm!');
                                        }
                                    })
                                    .catch(() => alert('Lỗi kết nối server!'));
                            selectedCartIds = [];
                        }
                        deleteModal.style.display = 'none';
                        singleDeleteRow = null;
                    };
                    btnNo.onclick = function () {
                        deleteModal.style.display = 'none';
                        singleDeleteRow = null;
                        selectedCartIds = [];
                    };
                    deleteModal.onclick = function (e) {
                        if (e.target === deleteModal) {
                            deleteModal.style.display = 'none';
                            singleDeleteRow = null;
                            selectedCartIds = [];
                        }
                    };

                    // ==== TĂNG GIẢM SỐ LƯỢNG ====
                    document.querySelectorAll('.cart-item-row:not(.cart-item-inactive)').forEach(function (row) {
                        const btnMinus = row.querySelector('.cart-qty-minus');
                        const btnPlus = row.querySelector('.cart-qty-plus');
                        const qtyInput = row.querySelector('.cart-qty-input');
                        if (!btnMinus || !btnPlus || !qtyInput)
                            return;
                        btnMinus.addEventListener('click', function () {
                            let qty = parseInt(qtyInput.value, 10) || 1;
                            if (qty > 1) {
                                qty--;
                                qtyInput.value = qty;
                                updateCartQuantityAjax(row, qty);
                                updateAllTotals();
                            }
                        });
                        btnPlus.addEventListener('click', function () {
                            let qty = parseInt(qtyInput.value, 10) || 1;
                            let maxQty = parseInt(qtyInput.getAttribute('data-max-qty'), 10) || 1;
                            if (qty < maxQty) {
                                qty++;
                                qtyInput.value = qty;
                                updateCartQuantityAjax(row, qty);
                                updateAllTotals();
                            } else {
                                qtyInput.value = maxQty;
                                alert("Bạn đã chọn số lượng tối đa còn lại cho sản phẩm này!");
                            }
                        });
                    });
                    function updateCartQuantityAjax(row, newQty) {
                        var cartId = row.querySelector('.cart-del-btn').getAttribute('data-cart-id');
                        var contextPath = window.location.pathname.split('/')[1] ? '/' + window.location.pathname.split('/')[1] : '';
                        fetch(contextPath + '/updatecartquantity', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'cartId=' + encodeURIComponent(cartId) + '&cartQuantity=' + encodeURIComponent(newQty)
                        })
                                .then(resp => resp.text())
                                .then(data => {
                                    // Có thể hiển thị thông báo hoặc cập nhật tổng tiền, badge, v.v nếu muốn
                                    if (data.trim() !== 'OK') {
                                        alert("Lỗi cập nhật số lượng!");
                                    }
                                })
                                .catch(() => alert('Lỗi kết nối server!'));
                    }

                    // ==== XÓA TỪNG SẢN PHẨM KHÔNG HOẠT ĐỘNG ====
                    document.querySelectorAll('.cart-del-btn-inactive').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const row = btn.closest('.cart-item-inactive');
                            const cartId = row && row.getAttribute('data-cart-id');
                            if (!cartId)
                                return;
                            if (!confirm('Bạn muốn xóa sản phẩm không hoạt động này khỏi giỏ hàng?'))
                                return;
                            var contextPath = window.location.pathname.split('/')[1] ? '/' + window.location.pathname.split('/')[1] : '';
                            fetch(contextPath + '/deletecart', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'cartId=' + encodeURIComponent(cartId)
                            })
                                    .then(resp => resp.text())
                                    .then(data => {
                                        if (data.trim() === 'OK') {
                                            row.remove();
                                            checkInactiveDisplay();
                                            updateAllTotals();
                                        } else {
                                            alert('Có lỗi khi xóa sản phẩm!');
                                        }
                                    })
                                    .catch(() => alert('Lỗi kết nối server!'));
                        });
                    });

                    // ==== XÓA TOÀN BỘ INACTIVE PRODUCTS ====
                    document.querySelectorAll('.cart-action-disable, .inactive-footer-bar').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            // Thu thập tất cả cartId của sản phẩm inactive
                            const inactiveRows = document.querySelectorAll('.cart-item-inactive');
                            if (inactiveRows.length === 0)
                                return;
                            if (!confirm('Bạn chắc chắn muốn xóa toàn bộ sản phẩm không hoạt động khỏi giỏ hàng?'))
                                return;

                            var contextPath = window.location.pathname.split('/')[1] ? '/' + window.location.pathname.split('/')[1] : '';
                            let cartIds = Array.from(inactiveRows).map(row => row.getAttribute('data-cart-id')).filter(id => !!id);
                            if (cartIds.length === 0)
                                return;

                            fetch(contextPath + '/deletecart', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'cartIds=' + encodeURIComponent(cartIds.join(','))
                            })
                                    .then(resp => resp.text())
                                    .then(data => {
                                        if (data.trim() === 'OK') {
                                            inactiveRows.forEach(row => row.remove());
                                            checkInactiveDisplay();
                                            updateAllTotals();
                                        } else {
                                            alert('Có lỗi khi xóa sản phẩm không hoạt động!');
                                        }
                                    })
                                    .catch(() => alert('Lỗi kết nối server!'));
                        });
                    });

                    // ===== CẬP NHẬT SỐ LƯỢNG, TIỀN TỔNG =====
                    function updateAllTotals() {
                        let total = 0, count = 0;
                        document.querySelectorAll('.cart-item-row:not(.cart-item-inactive)').forEach(function (row) {
                            const priceEl = row.querySelector('.cart-price');
                            const qtyInput = row.querySelector('.cart-qty-input');
                            const totalEl = row.querySelector('.cart-total');
                            const checkbox = row.querySelector('.cart-checkbox-item');
                            if (!priceEl || !qtyInput || !totalEl || !checkbox)
                                return;
                            const price = parseInt(priceEl.dataset.price, 10) || 0;
                            const qty = parseInt(qtyInput.value, 10) || 1;
                            const lineTotal = price * qty;
                            totalEl.textContent = '₫' + lineTotal.toLocaleString('vi-VN');
                            if (checkbox.checked) {
                                total += lineTotal;
                                count += qty;
                            }
                        });
                        document.querySelectorAll('.cart-total-value').forEach(function (el) {
                            el.textContent = '₫' + total.toLocaleString('vi-VN');
                        });
                        document.querySelectorAll('.cart-count').forEach(function (el) {
                            el.textContent = count + ' Sản phẩm';
                        });
                        checkCartSummaryDisplay();
                        checkEmptyCartDisplay();
                    }

                    // ==== ẨN/HIỆN inactiveSection, nút bỏ sản phẩm không hoạt động ====
                    function checkInactiveDisplay() {
                        const inactiveRows = document.querySelectorAll('.cart-item-inactive');
                        const section = document.getElementById('inactiveSection');
                        const btnRemove = document.getElementById('btnRemoveInactive');
                        if (inactiveRows.length === 0) {
                            if (section)
                                section.style.display = 'none';
                            if (btnRemove)
                                btnRemove.style.display = 'none';
                        } else {
                            if (section)
                                section.style.display = '';
                            if (btnRemove)
                                btnRemove.style.display = '';
                        }
                    }

                    // ==== ẨN/HIỆN thanh tổng kết ====
                    function checkCartSummaryDisplay() {
                        const itemRows = document.querySelectorAll('.cart-item-row:not(.cart-item-inactive)');
                        const summaryBar = document.querySelector('.cart-summary-bar');
                        if (summaryBar) {
                            if (itemRows.length === 0) {
                                summaryBar.style.display = 'none';
                            } else {
                                summaryBar.style.display = '';
                            }
                        }
                    }

                    // ==== Show "giỏ hàng trống" khi hết sản phẩm ====
                    function checkEmptyCartDisplay() {
                        const itemRows = document.querySelectorAll('.cart-item-row:not(.cart-item-inactive)');
                        const mainCart = document.querySelector('.main-cart');
                        let emptyCart = document.getElementById('emptyCartNotify');
                        if (itemRows.length === 0) {
                            if (!emptyCart) {
                                emptyCart = document.createElement('div');
                                emptyCart.id = 'emptyCartNotify';
                                emptyCart.style.textAlign = 'center';
                                emptyCart.style.fontSize = '1.2rem';
                                emptyCart.style.color = '#f46a1c';
                                emptyCart.style.margin = '50px auto';
                                emptyCart.innerHTML = '<b>Giỏ hàng của bạn đang trống!</b>';
                                if (mainCart)
                                    mainCart.appendChild(emptyCart);
                            } else {
                                emptyCart.style.display = '';
                            }
                        } else {
                            if (emptyCart)
                                emptyCart.style.display = 'none';
                        }
                    }
                    fetch(contextPath + '/cart/count', {method: 'GET'})
                            .then(resp => resp.json())
                            .then(data => {
                                document.querySelector('.cart-badge').textContent = data.count;
                            });

                    // ==== KHỞI TẠO KHI LOAD TRANG ====
                    updateAllTotals();
                    checkCartSummaryDisplay();
                    checkEmptyCartDisplay();
                });
        </script>
    </body>
</html>