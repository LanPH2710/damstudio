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
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Inter:opsz,wght@14..32,100..900&family=Mulish:ital,wght@0,200..1000;1,200..1000&family=Playwrite+HU:wght@100..400&family=Roboto+Condensed:wght@100..900&family=Roboto+Slab:wght@100..900&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

    </head>
    <body>
        <header>
            <nav class="custom-navbar">
                <button class="menu-toggle-btn">
                    <i class="fas fa-bars"></i>
                </button>

                <div class="leftnavbar">
                    <a href="homepage"><img src="image/logo/logoLONGpng.PNG" alt="Logo" class="mobile-logo"></a>
                </div>

                <div class="centernavbar">
                    <c:choose>
                        <c:when test="${sessionScope.account.roleId == 1}">
                            <!--<a href="changeorder">ADMIN</a>-->
                            <a href="manageruser">ADMIN</a>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${sessionScope.account.roleId == 2}">
                            <a href="#">MARKETING</a>
                        </c:when>
                    </c:choose>
                    <!--<a href="#">MAKETING</a>-->
                    <a href="about.jsp">DÁM STUDIO</a>
                    <a href="productlist">SẢN PHẨM</a>
                    <li class="dropdown"><a href="story.jsp">CÂU CHUYỆN</a>
                        <ul class="submenu">
                            <li><a href="sutichhoguom.html">Sự tích hồ Gươm</a></li>
                            <li><a href="sontinhthuytinh.html">Sơn tinh thủy tinh</a></li>
                            <!--                            <li><a href="#">Con rồng cháu tiên</a></li>
                                                        <li><a href="#">Thánh Gióng</a></li>
                                                        <li><a href="#">Chử Đồng Tử</a></li>
                                                        <li><a href="#">Tấm Cám</a></li>
                                                        <li><a href="#">Cây tre trăm đốt</a></li>
                                                        <li><a href="#">Ăn khế trả vàng</a></li>
                                                        <li><a href="#">Mai An Tiêm</a></li>
                                                        <li><a href="#">Sọ Dừa</a></li>-->
                        </ul>
                    </li>
                    <a href="https://www.facebook.com/profile.php?id=61581282917311">LIÊN HỆ</a>
                    <!--<a href="#">ĐÁNH GIÁ</a>-->
                </div>

                <div class="rightnavbar">
                    <a href="profile"><i class="fas fa-user"></i></a>
                    <a href="cart" class="cart-icon-wrapper">
                        <i class="fas fa-shopping-cart"></i>
                        <c:if test="${sessionScope.sizeCart > 0}">
                            <span class="cart-amount">${sessionScope.sizeCart}</span>
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
                    <!--                    <button><i class="fab fa-facebook-f"></i></button>
                                        <button><i class="fab fa-facebook-f"></i></button>-->
                </div>
            </nav>
        </header>


        <div id="addToCartAlert" class="cart-alert" style="display:none;">Đã thêm sản phẩm vào giỏ hàng!</div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy đường dẫn của trang hiện tại, ví dụ: "/ProjectName/productlist"
                const currentPath = window.location.pathname;

                // Lấy tất cả các thẻ a trong navbar
                const navLinks = document.querySelectorAll('.centernavbar a');

                // Duyệt qua từng link
                navLinks.forEach(link => {
                    // Lấy thuộc tính href của link, ví dụ: "productlist"
                    const linkPath = link.getAttribute('href');

                    // Nếu đường dẫn hiện tại chứa đường dẫn của link
                    if (currentPath.includes(linkPath)) {
                        // Thêm class 'active' vào link đó
                        link.classList.add('active');
                    }
                });
            });

        </script>
        <script>  window.addEventListener('scroll', function () {
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }
            });



            window.addEventListener('scroll', function () {
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }

                // Animation for hello-frame text
                const helloContent = document.querySelector('.hello-animated-content');
                if (helloContent) {
                    const rect = helloContent.getBoundingClientRect();
                    if (rect.top < window.innerHeight - 100) {
                        helloContent.classList.add('visible');
                    }
                }
            });
            // Also trigger on page load
            window.dispatchEvent(new Event('scroll'));


            window.addEventListener('scroll', function () {
                // Sticky header logic
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }

                // Animate each section's text when in view
                document.querySelectorAll('.section-animated-content').forEach(function (content) {
                    const rect = content.getBoundingClientRect();
                    if (rect.top < window.innerHeight - 100) {
                        content.classList.add('visible');
                    }
                });
            });
// Trigger on page load
            window.dispatchEvent(new Event('scroll'));


// File: app.js hoặc trong thẻ <script>

// File: app.js (hoặc trong thẻ <script>)

            document.addEventListener('DOMContentLoaded', function () {

                const menuToggleBtn = document.querySelector('.menu-toggle-btn');
                const customNavbar = document.querySelector('.custom-navbar');

                if (menuToggleBtn && customNavbar) {
                    // Khi bấm nút hamburger, nó sẽ tự động BẬT hoặc TẮT menu
                    menuToggleBtn.onclick = function () {
                        customNavbar.classList.toggle('mobile-menu-open');
                    }
                }

            });
        </script>
    </body>
</html>
