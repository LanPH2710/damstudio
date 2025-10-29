<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-VJFMJBKESV"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-VJFMJBKESV');
</script>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productDetail.css?v=${System.currentTimeMillis()}"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="css/homePage.css">
<link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div id="toast-notify" class="toast-notify" style="display:none;">
            <i id="toast-icon" class="fa fa-check-circle"></i>
            <span id="toast-msg"></span>
        </div>
        <div class="main-product-layout mid">
            <!-- Khối 1: Thông tin sản phẩm -->
            <div class="product-main-info shadow">
                <div class="product-img-block">
                    <div class="product-slider">
                        <c:forEach var="img" items="${product.images}" varStatus="loop">
                            <img src="image/ao/${img.imageUrl}" 
                                 alt="${product.name}" 
                                 class="slide ${loop.first ? 'active' : ''}">
                        </c:forEach>
                        <div class="slider-dots">
                            <c:forEach var="img" items="${product.images}" varStatus="loop">
                                <span class="dot ${loop.first ? 'active' : ''}" data-index="${loop.index}"></span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="product-info-block">
                    <h1 class="product-title">${product.name}</h1>
                    <p class="product-desc">${product.description}</p>
                    <div class="product-rating-row">
                        <span class="product-stars">
                            <c:forEach var="i" begin="1" end="5">
                                <i class="${i <= requestScope.rateProduct ? 'fa fa-star' : 'far fa-star'}"></i>
                            </c:forEach>
                        </span>
                        <span class="product-rating-count">${fn:length(feedback)} đánh giá</span>
                    </div>
                    <div class="product-price">
                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VNĐ
                    </div>
                    <ul class="product-attrs">
                        <li><b>Bộ Sưu Tập:</b> ${brand}</li>
                        <li><b>Kiểu dáng:</b> ${style}</li>
                    </ul>
                    <div class="product-variants">
                        <div class="variant-block">
                            <span><b>Màu sắc:</b></span>
                            <div class="variant-list">
                                <c:forEach var="color" items="${colorList}">
                                    <span class="variant-item color-option" data-color-id="${color.colorId}">${color.colorName}</span>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="variant-block">
                            <span><b>Kích thước:</b></span>
                            <div class="variant-list">
                                <c:forEach var="size" items="${sizeList}">
                                    <span class="variant-item size-option" data-size-id="${size.sizeId}">${size.sizeName}</span>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="variant-block">
                            <span><b>Số lượng:</b></span>
                            <div class="quantity-box">
                                <button type="button" class="qty-btn" id="btnMinus">−</button>
                                <input type="text" id="inputQuantity" value="1" readonly>
                                <button type="button" class="qty-btn" id="btnPlus">+</button>
                                <span class="stock-info" id="stockInfo"></span>
                            </div>
                        </div>
                    </div>
                    <form class="product-action-form" action="addtocart" method="get" onsubmit="return validateForm();">
                        <input type="hidden" id="productId" name="productId" value="${product.productId}">
                        <input type="hidden" id="colorInput" name="colorId">
                        <input type="hidden" id="sizeInput" name="sizeId">
                        <input type="hidden" id="quantityInput" name="quantity" value="1">
                        <input type="hidden" id="buynowInput" name="buynow" value="0">
                        <div class="action-buttons">
                            <button type="submit" class="btn primary">
                                <i class="fas fa-shopping-basket"></i> Thêm vào giỏ hàng
                            </button>
                            <button type="button" class="btn buy-now" id="btnBuyNow">Mua ngay</button>
                        </div>
                    </form>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            document.getElementById('btnBuyNow').addEventListener('click', function () {
                                document.getElementById('buynowInput').value = 1;
                                document.querySelector('.product-action-form').submit();
                            });
                            document.querySelector('.product-action-form').addEventListener('submit', function () {
                                setTimeout(() => {
                                    document.getElementById('buynowInput').value = 0;
                                }, 200);
                            });
                        });
                    </script>
                </div>
            </div>

            <!-- Hướng dẫn chọn size -->
            <div class="size-guide-block">
                <h3 class="desc-title"><i class="fa-solid fa-shirt"></i> Mô tả sản phẩm</h3>

                <div class="brand-intro">
                    <p><b>Chào mừng bạn đến với DamStudio!</b></p>
                    <p>
                        Chúng tôi không chỉ bán áo – chúng tôi mang đến cho bạn một tấm vé để thể hiện chính mình.  
                        Mỗi thiết kế của <b>Dám</b> là một câu chuyện, một tuyên ngôn thời trang dành cho giới trẻ phá cách.  
                        Chất liệu siêu xịn, form chuẩn “sương sương”, cùng các họa tiết độc quyền chất ngầu giúp bạn tỏa sáng theo cách riêng.  
                        <b>Dám – lựa chọn của những người trẻ không ngừng cháy!</b>
                    </p>
                </div>
                <div class="desc-section">
                    <h4>🌿 Chất liệu & Thiết kế</h4>
                    <ul>
                        <li>Chất liệu: <b>100% Cotton 250gsm</b> – dày dặn, thoáng mát, bền màu.</li>
                        <li>Họa tiết: In kỹ thuật cao, sắc nét, bền màu theo thời gian.</li>
                        <li>Màu sắc: <b>Đen</b> / <b>Trắng</b> – basic nhưng tinh tế, dễ phối đồ.</li>
                        <li>Kiểu dáng: <b>Dáng rộng (Unisex)</b> – phù hợp cho cả nam và nữ.</li>
                    </ul>
                </div>
                <h3 class="size-guide-title"><i class="fa-solid fa-ruler"></i> Hướng dẫn chọn size</h3>
                <table class="size-guide-table">
                    <thead>
                        <tr>
                            <th>SIZE ÁO</th>
                            <th>S</th>
                            <th>M</th>
                            <th>L</th>
                            <th>XL</th>
                            <th>XXL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><b>DÀI ÁO</b></td>
                            <td>66</td>
                            <td>69</td>
                            <td>72</td>
                            <td>75</td>
                            <td>78</td>
                        </tr>
                        <tr>
                            <td><b>NGANG ÁO</b></td>
                            <td>49</td>
                            <td>52</td>
                            <td>55</td>
                            <td>58</td>
                            <td>61</td>
                        </tr>
                        <tr>
                            <td><b>DÀI TAY</b></td>
                            <td>22</td>
                            <td>23</td>
                            <td>24</td>
                            <td>25</td>
                            <td>26</td>
                        </tr>
                        <tr>
                            <td><b>CÂN NẶNG</b></td>
                            <td>~40–55kg</td>
                            <td>~55–65kg</td>
                            <td>~65–75kg</td>
                            <td>~75–85kg</td>
                            <td>>90kg</td>
                        </tr>
                        <tr>
                            <td><b>CHIỀU CAO</b></td>
                            <td><1m55</td>
                            <td><1m65</td>
                            <td><1m75</td>
                            <td><1m80</td>
                            <td><1m90</td>
                        </tr>
                    </tbody>
                </table>
                <p class="size-guide-note">* Số liệu mang tính chất tham khảo, có thể chênh lệch ±1–2cm tùy sản phẩm.</p>
                <div class="desc-section">
                    <h4>🧺 Hướng dẫn sử dụng & bảo quản</h4>
                    <ul>
                        <li>Giặt riêng áo trắng và áo màu.</li>
                        <li>Tránh dùng chất tẩy mạnh, không giặt nước nóng.</li>
                        <li>Không phơi trực tiếp dưới ánh nắng gắt.</li>
                        <li>Ủi ở nhiệt độ thấp, bảo quản nơi khô ráo, thoáng mát.</li>
                    </ul>
                </div>

                <div class="desc-section highlight">
                    <p>📞 Hỗ trợ 24/7 – <b>Chỉ cần nhắn tin cho shop</b> là có ngay tư vấn tận tâm!</p>
                </div>
            </div>

            <!-- Khối 2: Feedback -->
            <div class="product-feedback-section shadow">
                <h2 class="section-title">Đánh giá sản phẩm</h2>
                <div class="feedback-summary-bar">
                    <div class="star-bar">
                        <c:forEach var="i" begin="1" end="5">
                            <i class="${i <= rateProduct ? 'fa fa-star' : 'far fa-star'}"></i>
                        </c:forEach>
                    </div>
                    <div class="rating-count">${fn:length(feedback)} đánh giá</div>
                </div>
                <div class="feedback-filter-row">
                    <button class="filter-btn active">Tất cả</button>
                    <button class="filter-btn">5 Sao</button>
                    <button class="filter-btn">4 Sao</button>
                    <button class="filter-btn">3 Sao</button>
                    <button class="filter-btn">2 Sao</button>
                    <button class="filter-btn">1 Sao</button>
                </div>
                <div class="feedback-list">
                    <c:forEach items="${feedback}" var="all">
                        <c:set var="userDisplayed" value="false" />
                        <div class="review-item">
                            <c:forEach items="${acc}" var="acc">
                                <c:if test="${acc.userId == all.userId && !userDisplayed}">
                                    <div class="user-info">
                                        <img src="image/logo/${acc.avatar}" class="avatar" alt="Avatar">
                                        <div>
                                            <b>${acc.firstName} ${acc.lastName}</b>
                                            <div class="stars">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <i class="${i <= all.feedbackRate ? 'fa fa-star' : 'far fa-star'}"></i>
                                                </c:forEach>
                                            </div>
                                            <span class="feedback-time">${all.feedbackTime}</span>
                                        </div>
                                    </div>
                                    <c:set var="userDisplayed" value="true"/>
                                </c:if>
                            </c:forEach>
                            <div class="feedback-content">${all.feedbackInfo}</div>
                            <c:if test="${not empty all.feedbackImg}">
                                <div class="feedback-imgs">
                                    <img src="image/logo/${all.feedbackImg}" alt="Feedback Image"/>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Khối 3: Sản phẩm cùng tầm giá -->
            <div class="related-products-section shadow">
                <h2 class="section-title">Sản phẩm cùng tầm giá</h2>
                <div class="related-products-list">
                    <c:forEach items="${pro2}" var="pro2">
                        <div class="related-product-card">
                            <img src="image/ao/${pro2.images[0].imageUrl}"
                                 alt="Product Image" class="related-product-img"/>
                            <div class="related-product-info">
                                <a href="productdetail?productId=${pro2.productId}" class="related-product-name">${pro2.name}</a>
                                <div class="related-product-price">
                                    <fmt:formatNumber value="${pro2.price}" type="number" groupingUsed="true"/> VNĐ
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script>
            // Render map quantity
            const quantityMap = {
            <c:forEach var="d" items="${detailList}" varStatus="loop">
                "${d.colorId}-${d.sizeId}": ${d.quantity}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
                    };

                    let selectedColorId = null;
                    let selectedSizeId = null;
                    let maxStock = 0;

                    document.addEventListener('DOMContentLoaded', function () {
                        const colorOptions = document.querySelectorAll('.color-option');
                        const sizeOptions = document.querySelectorAll('.size-option');
                        const inputQuantity = document.getElementById('inputQuantity');
                        const stockInfo = document.getElementById('stockInfo');
                        const btnMinus = document.getElementById('btnMinus');
                        const btnPlus = document.getElementById('btnPlus');
                        const colorInput = document.getElementById('colorInput');
                        const sizeInput = document.getElementById('sizeInput');
                        const quantityInput = document.getElementById('quantityInput');
                        const urlParams = new URLSearchParams(window.location.search);
                        const msg = urlParams.get('msg');
                        if (msg) {
                            let text = '';
                            let type = '';
                            if (msg === 'success') {
                                text = 'Đã thêm vào giỏ hàng thành công!';
                                type = 'success';
                            } else if (msg === 'overstock') {
                                text = 'Số lượng vượt quá tồn kho!';
                                type = 'error';
                            } else if (msg === 'exist') {
                                text = 'Sản phẩm đã có trong giỏ!';
                                type = 'info';
                            } else if (msg === 'login') {
                                text = 'Bạn cần đăng nhập để sử dụng chức năng này!';
                                type = 'error';
                            } else if (msg === 'fail') {
                                text = 'Có lỗi xảy ra, vui lòng thử lại!';
                                type = 'error';
                            } else {
                                text = msg;
                                type = 'info';
                            }
                            showToast(text, type);
                        }

                        function updateQuantityControls() {
                            const qty = parseInt(inputQuantity.value);
                            btnMinus.disabled = qty <= 1;
                            btnPlus.disabled = qty >= maxStock;
                        }

                        function resetQuantityUI(message) {
                            inputQuantity.value = 0;
                            quantityInput.value = 0;
                            stockInfo.innerText = message || "Vui lòng chọn màu và kích thước";
                            updateQuantityControls();
                        }

                        function updateQuantityFromMap() {
                            if (!selectedColorId || !selectedSizeId) {
                                resetQuantityUI();
                                return;
                            }
                            const key = String(selectedColorId) + '-' + String(selectedSizeId);
                            maxStock = quantityMap[key] !== undefined ? quantityMap[key] : 0;
                            if (maxStock > 0) {
                                inputQuantity.value = 1;
                                quantityInput.value = 1;
                                stockInfo.innerText = `${maxStock} sản phẩm có sẵn`;
                            } else {
                                resetQuantityUI("Hết hàng cho tổ hợp này");
                            }
                            updateQuantityControls();
                        }

                        colorOptions.forEach(option => {
                            option.addEventListener('click', function () {
                                colorOptions.forEach(opt => opt.classList.remove('active'));
                                this.classList.add('active');
                                selectedColorId = String(this.dataset.colorId);
                                colorInput.value = selectedColorId;
                                updateQuantityFromMap();
                            });
                        });

                        sizeOptions.forEach(option => {
                            option.addEventListener('click', function () {
                                sizeOptions.forEach(opt => opt.classList.remove('active'));
                                this.classList.add('active');
                                selectedSizeId = String(this.dataset.sizeId);
                                sizeInput.value = selectedSizeId;
                                updateQuantityFromMap();
                            });
                        });

                        btnMinus.addEventListener('click', () => {
                            let qty = parseInt(inputQuantity.value);
                            if (qty > 1) {
                                inputQuantity.value = qty - 1;
                                quantityInput.value = inputQuantity.value;
                                updateQuantityControls();
                            }
                        });

                        btnPlus.addEventListener('click', () => {
                            let qty = parseInt(inputQuantity.value);
                            if (qty < maxStock) {
                                inputQuantity.value = qty + 1;
                                quantityInput.value = inputQuantity.value;
                                updateQuantityControls();
                            }
                        });
                    });

                    function validateForm() {
                        if (!selectedColorId || !selectedSizeId || maxStock === 0) {
                            alert("Vui lòng chọn đầy đủ màu sắc, kích thước và đảm bảo còn hàng.");
                            return false;
                        }
                        return true;
                    }
                    function showToast(msg, type) {
                        const toast = document.getElementById('toast-notify');
                        const icon = document.getElementById('toast-icon');
                        const msgSpan = document.getElementById('toast-msg');
                        msgSpan.textContent = msg;
                        toast.className = 'toast-notify ' + type;
                        if (type === 'success')
                            icon.className = 'fa fa-check-circle';
                        else if (type === 'error')
                            icon.className = 'fa fa-times-circle';
                        else
                            icon.className = 'fa fa-info-circle';
                        toast.style.display = 'flex';
                        setTimeout(() => {
                            toast.style.display = 'none';
                            // Xóa param msg khỏi url
                            const url = new URL(window.location);
                            url.searchParams.delete('msg');
                            window.history.replaceState({}, document.title, url);
                        }, 2500);
                    }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const slides = document.querySelectorAll('.product-slider .slide');
                const dots = document.querySelectorAll('.product-slider .dot');
                let currentIndex = 0;
                let slideInterval;

                function showSlide(index) {
                    slides.forEach((slide, i) => {
                        slide.classList.toggle('active', i === index);
                        dots[i].classList.toggle('active', i === index);
                    });
                    currentIndex = index;
                }

                function nextSlide() {
                    const nextIndex = (currentIndex + 1) % slides.length;
                    showSlide(nextIndex);
                }

                // Chuyển tự động sau 7 giây
                function startAutoSlide() {
                    slideInterval = setInterval(nextSlide, 7000);
                }

                function stopAutoSlide() {
                    clearInterval(slideInterval);
                }

                // Sự kiện click vào dot
                dots.forEach(dot => {
                    dot.addEventListener('click', () => {
                        stopAutoSlide();
                        const index = parseInt(dot.getAttribute('data-index'));
                        showSlide(index);
                        startAutoSlide();
                    });
                });

                // Khởi động
                if (slides.length > 1) {
                    startAutoSlide();
                }
            });
        </script>

    </body>
</html>