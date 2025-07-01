<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang Chủ - Áo QR Việt Nam</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;900&display=swap"
              rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!-- Slider Section -->
        <section class="slider-section">
            <div class="slider-container">
                <div class="slider">
                    <div class="slides" style="--img: url('${pageContext.request.contextPath}/image/homeSlider/Son tinh thuy tinh.png')"></div>
                    <div class="slides" style="--img: url('${pageContext.request.contextPath}/image/homeSlider/Su tich ho guom.png')"></div>
                    <div class="slides" style="--img: url('${pageContext.request.contextPath}/image/homeSlider/con rong chau tien.png')"></div>
                    
                </div>
                <div class="buttons">
                    <span class="prev"></span>
                    <span class="next"></span>
                </div>
            </div>
        </section>

        <!-- Hello Section -->
        <section class="hello">
            <div class="mid">
                <div class="hello-img">
                    <img src="image/logo/logoIMG.png" alt="Dám Studio Image">
                </div>
                <div class="hello-text">
                    <h2>"Chúng tôi không chỉ bán áo – chúng tôi kể câu chuyện Việt Nam"</h2>
                    <p>Dám Studio truyền tải văn hóa Việt qua từng chiếc áo – sáng tạo, sâu sắc và hiện đại.</p>
                    <p>Chúng tôi dám làm khác biệt, biến áo phông thành cầu nối giữa con người và di sản.</p>
                    <p>Mỗi thiết kế là một bản đồ thu nhỏ – từ phố cổ Hà Nội đến ánh đèn Hội An.</p>
                    <div class="learnmore">
                        <a href="#more" class="learn-more-btn">TÌM HIỂU THÊM</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Product Section -->
        <section class="all-products">
            <h2>SẢN PHẨM NỔI BẬT</h2>
            <div class="products">
                <c:forEach var="product" items="${featuredProducts}">
                    <div class="product">
                        <c:choose>
                            <c:when test="${not empty product.images}">
                                <img src="${product.images[0].imageUrl}" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="image/homeSlider/homeSlider3.png" alt="${product.name}">
                            </c:otherwise>
                        </c:choose>
                        <p>${product.name}</p>
                        <p class="price">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VNĐ
                        </p>
                        <a class="learn-more-btn" href="productdetail?productId=${product.productId}">Xem chi tiết</a>
                    </div>
                </c:forEach>
            </div>
            <div class="learnmore">
                <a class="learn-more-btn" href="productlist">XEM TẤT CẢ</a>
            </div>
        </section>

        <!-- Highlighted Section -->
        <section class="highlighted-section">
            <div class="highlighted-wrapper">
                <div class="highlighted-showcase">
                    <div class="highlight-card">
                        <div class="highlight-img-wrapper">
                            <img src="image/homeSlider/Son tinh thuy tinh.png" alt="Sơn Tinh Thủy Tinh">
                        </div>
                        <div class="highlight-caption">Sơn Tinh - Thủy Tinh</div>
                    </div>

                    <div class="highlight-card">
                        <div class="highlight-img-wrapper">
                            <img src="image/homeSlider/Son tinh thuy tinh.png" alt="Hồn Việt">
                        </div>
                        <div class="highlight-caption">Hồn Việt</div>
                    </div>
                </div>

                <div class="highlight-btn-wrapper">
                    <a href="productlist" class="highlight-buy-btn">KHÁM PHÁ NGAY</a>
                </div>
            </div>
        </section>

        <jsp:include page="footer.jsp"/>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // --- Menu Toggle and Dropdown for Mobile ---
                const menuToggle = document.getElementById('menuToggle');
                const headerMenu = document.querySelector('.header-center .menu');
                const dropdown = document.querySelector('.menu .dropdown'); // The 'STORY' li element
                const header = document.querySelector('.header'); // Lấy phần tử header

                // Function to handle mobile dropdown click
                function dropdownClickHandler(event) {
                    // Only toggle if click is not on a link within the submenu
                    if (window.innerWidth <= 600) { // Ensure this only runs on mobile
                        if (event.target.tagName !== 'A') {
                            event.preventDefault(); // Prevent default li behavior
                            dropdown.classList.toggle('active');
                        }
                    }
                }

                // Setup/Remove mobile dropdown listener based on screen size
                function setupMobileDropdownListener() {
                    if (window.innerWidth <= 600) {
                        dropdown.addEventListener('click', dropdownClickHandler);
                    } else {
                        dropdown.removeEventListener('click', dropdownClickHandler);
                        dropdown.classList.remove('active');
                    }
                }

                // Toggle main menu on mobile
                menuToggle.addEventListener('click', function () {
                    const headerHeight = header.offsetHeight; // Lấy chiều cao hiện tại của header

                    if (!headerMenu.classList.contains('show')) {
                        // Nếu menu sắp mở
                        headerMenu.style.paddingTop = headerHeight + 'px'; // Đặt padding để đẩy nội dung xuống dưới header
                        headerMenu.style.display = 'flex'; // Hiển thị menu trước khi trượt
                        // Đợi một chút để CSS transform có thể áp dụng mượt mà
                        setTimeout(() => {
                            headerMenu.classList.add('show');
                        }, 10); // Khoảng thời gian nhỏ
                    } else {
                        // Nếu menu sắp đóng
                        headerMenu.classList.remove('show');
                        // Đợi transition hoàn tất rồi mới ẩn display
                        setTimeout(() => {
                            headerMenu.style.display = 'none';
                            headerMenu.style.paddingTop = '0'; // Reset padding
                        }, 500); // Phù hợp với thời gian transition (0.5s)
                    }

                    // Nếu menu chính đang đóng, đảm bảo submenu cũng đóng
                    if (!headerMenu.classList.contains('show')) {
                        dropdown.classList.remove('active');
                    }
                });

                // Close menu when clicking outside (only for mobile)
                document.addEventListener('click', function (event) {
                    if (window.innerWidth <= 600) {
                        const isClickInsideMenu = headerMenu.contains(event.target) || menuToggle.contains(event.target);
                        if (!isClickInsideMenu && headerMenu.classList.contains('show')) {
                            headerMenu.classList.remove('show');
                            setTimeout(() => {
                                headerMenu.style.display = 'none';
                                headerMenu.style.paddingTop = '0';
                            }, 500);
                            dropdown.classList.remove('active');
                        }
                    }
                });

                // Handle window resize events
                window.addEventListener('resize', function () {
                    if (window.innerWidth > 600) {
                        // On desktop, ensure mobile menu classes are removed and display is reset
                        headerMenu.classList.remove('show');
                        headerMenu.style.paddingTop = ''; // Xóa padding động
                        headerMenu.style.transform = ''; // Xóa transform
                        headerMenu.style.display = ''; // Reset display để header-center trở lại mặc định (flex)
                        dropdown.classList.remove('active'); // Đảm bảo submenu ẩn
                    } else {
                        // On mobile, if menu is shown, re-adjust padding (in case header height changed)
                        if (headerMenu.classList.contains('show')) {
                            const headerHeight = header.offsetHeight;
                            headerMenu.style.paddingTop = headerHeight + 'px';
                        }
                        // Luôn gọi lại để thiết lập/xóa listener mobile dropdown
                        setupMobileDropdownListener();
                    }
                });

                // Initial setup for mobile dropdown on page load
                setupMobileDropdownListener();

                // --- Image Slider Script ---
                let next = document.querySelector('.next');
                let prev = document.querySelector('.prev');
                let slider = document.querySelector('.slider');

                next.addEventListener('click', function () {
                    let slides = document.querySelectorAll('.slides');
                    slider.appendChild(slides[0]);
                });
                prev.addEventListener('click', function () {
                    let slides = document.querySelectorAll('.slides');
                    slider.prepend(slides[slides.length - 1]);
                });
                setInterval(function () {
                    let slides = document.querySelectorAll('.slides');
                    slider.appendChild(slides[0]);
                }, 15000);
            });
        </script>
    </body>
</html>
