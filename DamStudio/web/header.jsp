<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="css/header.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;900&display=swap"
              rel="stylesheet">   
    </head>
    <body>
        <header class="header">
            <div class="header-top">
                <div class="header-left">
                    <a href="homepage"><img src="image/logo/logoIMG.png" alt="Logo" class="logo" /></a>
                </div>
                <button class="menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
            <nav class="header-center">
                <ul class="menu">
                    <c:choose>
                        <c:when test="${sessionScope.account.roleId == 1}">
                            <li><a href="#">ADMIN</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${sessionScope.account.roleId == 2}">
                            <li><a href="#">MARKETING</a></li>
                            </c:when>
                        </c:choose>
                    <li><a href="#">ABOUT</a></li>
                    <li><a href="productlist">PRODUCT</a></li>
                    <li class="dropdown">STORY
                        <ul class="submenu">
                            <li><a href="hanoiInfo.html">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sơn tinh thủy tinh</a></li>
                            <li><a href="#">Con rồng cháu tiên</a></li>
                            <li><a href="#">Thánh Gióng</a></li>
                            <li><a href="#">Chử Đồng Tử</a></li>
                            <li><a href="#">Tấm Cám</a></li>
                            <li><a href="#">Cây tre trăm đốt</a></li>
                            <li><a href="#">Ăn khế trả vàng</a></li>
                            <li><a href="#">Mai An Tiêm</a></li>
                            <li><a href="#">Sọ Dừa</a></li>
                        </ul>
                    </li>
                    <li><a href="#">CONTACT</a></li>
                    <li><a href="#">FEEDBACK</a></li>
                </ul>
            </nav>
            <div class="header-right">
                <a href="profile"><i class="fas fa-user"></i></a>
                <a href="cart" class="cart-icon-wrapper">
                    <i class="fas fa-shopping-cart"></i>
                    <c:if test="${sizeCart > 0}">
                        <span class="cart-amount">${sizeCart}</span>
                    </c:if>
                </a>
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <a href="login.jsp"><i class="fas fa-sign-in-alt"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i></a>
                        </c:otherwise>
                    </c:choose>
            </div>
        </header>
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
        </script>
    </body>
</html>
