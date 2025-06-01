<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang Chủ - Áo QR Việt Nam</title>
<!--        <link rel="stylesheet" href="css/home1.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <style>
            /* Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                background-color: #fff8f8;
                color: #333;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            /* Header */
            .header {
                padding: 0 30px;
                position: sticky;
                top: 0;
                background: #fff;
                color: #000;
                border-bottom: 3px solid #c62828;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 83px;
                transition: background-color 0.3s ease;
            }

            .header:hover {
                background-color: #fff0f0;
            }

            .header-top {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header-left {
                display: flex;
                align-items: center;
                flex-shrink: 0;
            }

            .menu-toggle {
                display: none;
                /* Mặc định ẩn trên desktop */
                background: none;
                border: none;
                font-size: 28px;
                color: #c62828;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .menu-toggle:hover {
                color: #8b0000;
            }

            .header-left a .logo,
            .footer-logo {
                height: 84px;
                width: auto;
                transition: transform 0.3s ease;
            }

            .header-left a .logo:hover,
            .footer-logo:hover {
                transform: scale(1.05);
            }

            .header-center {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
                position: relative;
            }

            .header-center .menu {
                list-style: none;
                display: flex;
                /* Hiển thị ngang trên desktop */
                gap: 36px;
                font-weight: 700;
                font-size: 18px;
                letter-spacing: 0.05em;
                color: #222;
                text-transform: uppercase;
                user-select: none;
                flex-wrap: wrap;
                transition: all 0.3s ease;
                position: relative;
            }

            .menu li {
                position: relative;
                cursor: pointer;
                padding: 8px 15px;
                border-radius: 12px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .menu li:hover {
                background: #c62828;
                color: white;
                box-shadow: 0 3px 5px rgba(198, 40, 40, 0.5);
            }

            .dropdown {
                position: relative;
                list-style: none;
            }

            /* Mega Menu Styles (Desktop) */
            .submenu {
                position: absolute;
                top: 100%;
                /* Ngay dưới mục menu cha */
                left: 50%;
                /* Căn giữa theo chiều ngang của dropdown li */
                transform: translateX(-50%);
                /* Dịch chuyển sang trái 50% chiều rộng của nó để căn giữa */
                width: 900px;
                /* Chiều rộng của mega menu */
                max-width: calc(100vw - 60px);
                /* Đảm bảo menu không tràn màn hình */
                background-color: #fff;
                border: 1px solid #ddd;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
                /* Tăng shadow để nổi bật hơn */
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
                z-index: 1000;
                pointer-events: none;
                list-style: none;
                display: grid;
                /* Sử dụng Grid để tạo các cột bên trong mega menu */
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                /* Tự động tạo cột */
                gap: 20px;
                /* Khoảng cách giữa các cột và hàng */
                padding: 25px;
                /* Padding bên trong mega menu */
                box-sizing: border-box;
                /* Đảm bảo padding không làm tăng chiều rộng */
                border-radius: 12px;
                /* Bo góc cho mega menu */
            }

            .submenu li {
                padding: 0;
                /* Bỏ padding mặc định của li trong submenu */
                white-space: normal;
                /* Cho phép chữ xuống dòng */
            }

            .submenu li a {
                text-decoration: none;
                color: #333;
                display: block;
                padding: 8px 10px;
                /* Padding cho từng link trong submenu */
                transition: background-color 0.3s ease;
                border-radius: 8px;
                /* Bo góc cho từng link */
                font-weight: 500;
                /* Điều chỉnh độ đậm chữ */
            }

            .submenu li a:hover {
                background-color: #f5f5f5;
                color: #b71c1c;
                /* Thay đổi màu chữ khi hover */
            }

            .dropdown:hover .submenu {
                opacity: 1;
                visibility: visible;
                transform: translateX(-50%) translateY(0);
                /* Đảm bảo transform đúng khi hover */
                pointer-events: auto;
            }

            /* Arrow down icon for dropdown */
            .menu li.dropdown::after {
                content: "▼";
                font-size: 10px;
                margin-left: 6px;
                color: #c62828;
                transition: transform 0.3s ease;
            }

            .menu li.dropdown:hover::after {
                transform: rotate(-180deg);
                color: #fff;
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 30px;
            }

            .header-right a {
                text-decoration: none;
                font-size: 20px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: #fff;
                color: #c62828;
                border-radius: 50%;
                width: 38px;
                height: 38px;
                box-shadow: 0 2px 8px rgba(198, 40, 40, 0.25);
                transition: background 0.3s ease, transform 0.3s ease, color 0.3s ease;
            }

            .header-right a:hover {
                background: #c62828;
                color: #fff;
                transform: scale(1.15);
                box-shadow: 0 4px 14px rgba(198, 40, 40, 0.6);
            }

            /* Slide Section */
            .slide {
                max-height: 610px;
                width: auto;
                aspect-ratio: 16 / 9;
                margin: 30px auto;
                border-radius: 16px;
                overflow: hidden;
                position: relative;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            .slide-container {
                display: flex;
                height: 100%;
                transition: transform 0.6s ease;
            }

            .slide-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                flex-shrink: 0;
            }

            .slide-container img:hover {
                filter: brightness(100%);
            }

            .dots {
                position: absolute;
                bottom: 12px;
                left: 50%;
                transform: translateX(-50%);
                display: flex;
                gap: 8px;
            }

            .dots span {
                width: 12px;
                height: 12px;
                background: #c62828;
                opacity: 0.4;
                border-radius: 50%;
                cursor: pointer;
            }

            .dots span.active {
                opacity: 1;
            }

            /* Hello Section */
            .hello {
                padding: 60px 20px;
                background-color: #fdf6f6;
                border-bottom: 3px solid #222;
                box-shadow: inset 0 -3px 8px rgba(0, 0, 0, 0.05);
            }

            .mid {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-wrap: wrap;
                max-width: 1200px;
                margin: auto;
                gap: 36px;
            }

            .hello-img {
                flex: 0 0 55%;
                box-shadow: 0 8px 24px rgba(198, 40, 40, 0.15);
                border-radius: 16px;
                overflow: hidden;
            }

            .hello-img img {
                width: 100%;
                height: auto;
                object-fit: cover;
                border-radius: 16px;
                transition: transform 0.5s ease;
            }

            .hello-img img:hover {
                transform: scale(1.05);
            }

            .hello-text {
                flex: 1;
                font-size: 18px;
                line-height: 1.8;
                color: #333;
                padding: 12px 24px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 8px 20px rgba(198, 40, 40, 0.12);
            }

            .hello-text h2 {
                font-size: 28px;
                margin-bottom: 28px;
                color: #b71c1c;
                text-align: center;
                font-weight: 900;
                letter-spacing: 0.1em;
                text-transform: uppercase;
            }

            .hello-text p {
                font-family: 'Playfair Display', serif;
                font-size: 18px;
                color: #4a4a4a;
                line-height: 1.8;
                letter-spacing: 0.03em;
            }

            /* Learn More Button */
            .learnmore {
                text-align: center;
                margin-top: 32px;
                width: 100%;
            }

            .learn-more-btn {
                display: inline-block;
                padding: 14px 36px;
                background-color: #fff;
                color: #b71c1c;
                border: 2.5px solid #b71c1c;
                text-decoration: none;
                font-weight: 700;
                font-size: 18px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(183, 28, 28, 0.25);
                transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
            }

            .learn-more-btn:hover {
                background-color: #b71c1c;
                color: #fff;
                box-shadow: 0 6px 20px rgba(183, 28, 28, 0.45);
            }

            /* Products */
            .all-products {
                min-height: 100vh;
                padding: 0 20px 60px 20px;
                text-align: center;
                background: #fff5f5;
                border-radius: 20px;
                margin: 50px 20px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                box-shadow: 0 10px 30px rgba(198, 40, 40, 0.08);
            }

            .all-products h2 {
                font-size: 38px;
                color: #8b0000;
                margin-bottom: 50px;
                font-weight: 900;
                letter-spacing: 0.1em;
                text-transform: uppercase;
                text-shadow: 1px 1px 3px rgba(198, 40, 40, 0.3);
            }

            .products {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 36px;
                justify-items: center;
                padding: 0 60px;
            }

            .product {
                background: #fff;
                padding: 24px 20px;
                border-radius: 20px;
                border: 3px solid #b71c1c;
                box-shadow: 0 8px 22px rgba(183, 28, 28, 0.18);
                width: 100%;
                max-width: 300px;
                transition: transform 0.4s ease, box-shadow 0.4s ease, border-color 0.3s ease;
                text-align: center;
                cursor: pointer;
            }

            .product:hover {
                transform: translateY(-12px);
                border-color: #8b0000;
                box-shadow: 0 18px 30px rgba(183, 28, 28, 0.45);
            }

            .product img {
                width: 100%;
                height: 230px;
                object-fit: contain;
                border-radius: 20px;
                margin-bottom: 16px;
                transition: transform 0.3s ease;
            }

            .product img:hover {
                transform: scale(1.1);
            }

            .product p {
                font-weight: 600;
                font-size: 22px;
                color: #b71c1c;
                margin-bottom: 18px;
                letter-spacing: 0.03em;
                text-transform: capitalize;
                font-family: 'Montserrat', sans-serif;
            }

            .product .price {
                font-size: 20px;
                font-weight: 900;
                color: #d32f2f;
                letter-spacing: 0.05em;
                margin-bottom: 16px;
                font-family: 'Montserrat', sans-serif;
            }

            /* Buttons */
            .button {
                padding: 12px 26px;
                font-weight: 600;
                border-radius: 18px;
                font-size: 18px;
                background: transparent;
                border: 3px solid #b71c1c;
                color: #b71c1c;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
                letter-spacing: 0.07em;
            }

            .button:hover {
                background-color: #b71c1c;
                color: #fff;
                box-shadow: 0 6px 20px rgba(183, 28, 28, 0.45);
            }

            /* Footer */
            .footer {
                background-color: #fff;
                color: #c62828;
                font-weight: 700;
                font-size: 14px;
                padding: 30px 40px;
                border-top: 3px solid #c62828;
                box-shadow: 0 -4px 12px rgba(198, 40, 40, 0.12);
            }

            .footer-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                flex-wrap: wrap;
                gap: 40px;
                justify-content: space-between;
                align-items: flex-start;
            }

            .footer-logo-box {
                flex: 1 1 150px;
            }

            .footer-logo {
                width: 120px;
                height: auto;
                filter: drop-shadow(0 0 3px #b71c1c);
                cursor: pointer;
                transition: transform 0.3s ease;
            }

            .footer-logo:hover {
                transform: scale(1.07);
            }

            .footer-section {
                flex: 1 1 250px;
            }

            .footer-section h2 {
                margin-bottom: 16px;
                font-size: 18px;
                color: #8b0000;
                font-weight: 800;
            }

            .footer-section p {
                letter-spacing: 0.07em;
                color: #8b0000;
                user-select: none;
                margin-bottom: 8px;
                line-height: 1.5;
            }

            .email-box {
                display: flex;
                margin-top: 10px;
                max-width: 320px;
            }

            .email-box input[type="email"] {
                flex-grow: 1;
                padding: 10px 16px;
                border: 2px solid #b71c1c;
                border-radius: 25px 0 0 25px;
                outline: none;
                font-size: 14px;
                color: #8b0000;
                transition: border-color 0.3s ease;
            }

            .email-box input[type="email"]:focus {
                border-color: #d32f2f;
            }

            .email-box button {
                padding: 10px 20px;
                border: 2px solid #b71c1c;
                background-color: #b71c1c;
                color: white;
                font-weight: 700;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-size: 14px;
            }

            .email-box button:hover {
                background-color: #d32f2f;
            }

            /* Responsive */
            @media (max-width: 900px) {
                .header-center .menu {
                    gap: 20px;
                    font-size: 16px;
                }

                .header-right a {
                    width: 34px;
                    height: 34px;
                    font-size: 18px;
                }

                .hello-text h2 {
                    font-size: 24px;
                }

                .all-products h2 {
                    font-size: 32px;
                }

                .footer-container {
                    justify-content: center;
                }

                .footer-section,
                .footer-logo-box {
                    flex: 1 1 100%;
                    text-align: center;
                }

                .email-box {
                    justify-content: center;
                }
            }

            @media (max-width: 600px) {
                .header {
                    flex-wrap: wrap;
                    height: auto;
                    padding: 10px 20px;
                }

                .header-top {
                    width: 100%;
                    /* Đảm bảo header-top chiếm toàn bộ chiều rộng */
                    justify-content: space-between;
                    /* Giữ logo và toggle menu ở hai bên */
                }

                .header-left {
                    order: 1;
                    /* Đảm bảo logo ở vị trí đầu */
                    /* width: 100%; */
                    /* Loại bỏ width: 100% để logo không chiếm hết hàng */
                    justify-content: flex-start;
                }

                .header-right {
                    order: 2;
                    width: 100%;
                    /* Vẫn cần width 100% để icon nằm đúng hàng */
                    justify-content: flex-end;
                    margin-bottom: 8px;
                    margin-top: 10px;
                    /* Thêm margin trên để tách biệt khỏi header-top */
                }

                .menu-toggle {
                    display: block;
                    /* Hiển thị nút toggle menu */
                }

                .header-center {
                    /* order: 3;
                    width: 100%;
                    justify-content: center;
                    margin-top: 0;
                    Đặt lại margin-top vì nó sẽ trượt xuống */
                    display: none;
                }

                .header-center .menu {
                    display: flex; /* Bật lại display: flex khi menu được show */
                    flex-direction: column;
                    width: 100%;
                    height: 100vh; /* Menu sẽ chiếm toàn bộ chiều cao viewport */
                    background-color: #fff;
                    position: fixed; /* Rất quan trọng: Để menu là một lớp phủ cố định */
                    top: 0; /* Ban đầu đặt ở top 0, JS sẽ điều chỉnh padding-top */
                    left: 0;
                    right: 0;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
                    padding-top: 0; /* Sẽ được JS thiết lập để đẩy nội dung xuống dưới header */
                    align-items: center;
                    transform: translateY(-100%); /* Ban đầu ẩn hoàn toàn ở trên màn hình */
                    transition: transform 0.5s ease-in-out; /* Hiệu ứng trượt */
                    z-index: 999; /* Đảm bảo nó nằm dưới header cố định (z-index 1000) */
                    overflow-y: auto; /* Cho phép cuộn nếu nội dung menu quá dài */
                }

                .header-center .menu.show {
                    transform: translateY(0); /* Trượt xuống hiển thị */
                    /* padding-top sẽ được thiết lập bởi JS */
                }

                .menu li {
                    width: 100%;
                    text-align: center;
                    padding: 12px 0;
                    border-bottom: 1px solid #eee;
                    border-radius: 0;
                }

                .menu li:last-child {
                    border-bottom: none;
                    /* Bỏ đường phân cách ở mục cuối cùng */
                }

                .menu li:hover {
                    background: #f0f0f0;
                    /* Thay đổi màu nền hover cho mobile */
                    color: #c62828;
                    /* Giữ màu chữ đỏ */
                    box-shadow: none;
                    /* Bỏ box-shadow trên mobile */
                }

                /* Mobile Dropdown (STORY) */
                .submenu {
                    position: static;
                    width: 100%;
                    min-width: unset;
                    border: none;
                    box-shadow: none;
                    opacity: 1;
                    visibility: visible;
                    transform: none;
                    pointer-events: auto;
                    background-color: #f8f8f8;
                    padding: 0;
                    max-height: 0;
                    overflow: hidden;
                    display: block;
                    transition: max-height 0.4s ease-out;
                }

                .dropdown.active .submenu {
                    /* Thêm class 'active' bằng JS */
                    max-height: 400px;
                    /* Hoặc một giá trị đủ lớn để hiển thị tất cả các mục */
                    padding: 10px 0;
                    /* Padding khi submenu mở */
                }

                .submenu li {
                    padding: 8px 0;
                    /* Padding cho các mục con */
                    text-align: center;
                    border-bottom: 1px solid #eee;
                    /* Thêm đường phân cách cho mỗi item trong submenu */
                }

                .submenu li:last-child {
                    border-bottom: none;
                    /* Bỏ đường phân cách ở cuối submenu */
                }


                .submenu li a {
                    padding: 8px 20px;
                    /* Padding cho link trong submenu */
                    color: #555;
                    /* Màu chữ cho link trong submenu */
                }

                .submenu li a:hover {
                    background-color: #e0e0e0;
                    /* Màu nền hover cho link submenu */
                }

                /* Đảm bảo dropdown arrow không hiển thị khi menu đang ở dạng mobile (dạng cột) */
                .menu li.dropdown::after {
                    display: none;
                }

                /* Slide Section on mobile */
                .slide {
                    height: auto;
                    /* Điều chỉnh chiều cao tự động dựa trên tỷ lệ khung hình */
                    aspect-ratio: 16 / 9;
                    /* Giữ nguyên tỷ lệ khung hình gốc */
                    margin: 20px auto;
                    /* Giảm margin để phù hợp với màn hình nhỏ hơn */
                    border-radius: 8px;
                    /* Giảm bo góc */
                }

                .dots {
                    bottom: 8px;
                    /* Điều chỉnh vị trí các chấm cho phù hợp */
                    gap: 6px;
                    /* Giảm khoảng cách giữa các chấm */
                }

                .dots span {
                    width: 10px;
                    /* Giảm kích thước các chấm */
                    height: 10px;
                }

                .hello {
                    padding: 40px 16px;
                }

                .hello-text {
                    padding: 16px 20px;
                }

                .hello-img {
                    flex: 1 1 100%;
                }

                .hello-text {
                    flex: 1 1 100%;
                }

                .products {
                    padding: 0 20px;
                    grid-template-columns: 1fr 1fr;
                }

                .all-products {
                    margin: 30px 10px;
                }
            }

            @media (max-width: 400px) {
                .products {
                    grid-template-columns: 1fr;
                    padding: 0 12px;
                }

                .header-center .menu {
                    font-size: 14px;
                }

                .header-right a {
                    width: 30px;
                    height: 30px;
                }

                /* Điều chỉnh lại footer cho màn hình nhỏ hơn */
                .footer-container {
                    justify-content: center;
                    text-align: center;
                    gap: 20px;
                    /* Giảm khoảng cách giữa các phần footer */
                }

                .footer-section,
                .footer-logo-box {
                    flex: 1 1 100%;
                    /* Mỗi phần footer chiếm toàn bộ chiều rộng */
                }

                .email-box {
                    justify-content: center;
                    /* Căn giữa input email */
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="header-top">
                <div class="header-left">
                    <a href="home"><img src="image/logo/logoIMG.png" alt="Logo" class="logo" /></a>
                </div>
                <button class="menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
            <nav class="header-center">
                <ul class="menu">
                    <li>ABOUT</li>
                    <li>PRODUCT</li>
                    <li class="dropdown">STORY
                        <ul class="submenu">
                            <li><a href="hanoiInfo.html">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                            <li><a href="#">Sự tích hồ Gươm</a></li>
                        </ul>
                    </li>
                    <li>CONTACT</li>
                    <li>FEEDBACK</li>
                </ul>
            </nav>
            <div class="header-right">
                <a href="#"><i class="fas fa-search"></i></a>
                <a href="#"><i class="fas fa-shopping-cart"></i></a>
                <a href="#"><i class="fas fa-globe"></i></a>
            </div>
        </header>

        <section class="slide">
            <div class="slide-container" id="slideContainer">
                <img src="image/homeSlider/su tich ho guom gemini.png" alt="Slide 1">
                <img src="image/homeSlider/Son tinh thuy tinh.png" alt="Slide 2">
                <img src="image/homeSlider/con rong chau tien.png" alt="Slide 3">
                <img src="image/homeSlider/Su tich ho guom.png" alt="Slide 4">
            </div>
            <div class="dots" id="dots"></div>
        </section>
        <section class="hello">
            <div class="mid">
                <div class="hello-img">
                    <img src="image/logo/logoIMG.png" alt="Dám Studio Image">
                </div>
                <div class="hello-text">
                    <h2>"Chúng tôi không chỉ bán áo. Chúng tôi mang đến một mảnh đất Việt Nam mà bạn có thể mặc lên"</h2>
                    <p>
                        Dám Studio ra đời với sứ mệnh kể lại câu chuyện của quê hương Việt Nam theo cách trẻ trung, sáng tạo
                        và có chiều sâu.</p>
                    <p> Chúng tôi "dám" làm khác - từ một chiếc áo phông đơn giản, biến thành cây cầu kết nối giữa con người
                        và văn hóa, giữa quá khứ và hiện tại.</p>
                    <p> Mỗi thiết kế là một lát cắt văn hóa - từ phố cổ Hà Nội đến phố đèn lồng Hội An, từ Huế cổ kính đến
                        Sài Gòn sôi động - gói gọn trong chiếc áo bạn mặc và trang web bạn quét mã.</p>
                    <p> Chúng tôi không chỉ in hình, chúng tôi thổi hồn vào từng chi tiết.
                    </p>
                    <br>
                    <div class="learnmore">
                        <a href="#more" class="learn-more-btn">LEARN MORE</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="all-products">
            <h2>ALL PRODUCTS</h2>
            <div class="products">
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Đà Nẵng">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Sài Gòn">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Huế">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Hội An">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Miền Tây">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Buôn Mê">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Tây Bắc">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
                <div class="product">
                    <img src="image/homeSlider/homeSlider3.png" alt="Áo Biển">
                    <p>Áo 1</p>
                    <p>150.000</p>
                </div>
            </div>
            <div class="learnmore">
                <button class="learn-more-btn">View More</button>
            </div>
        </section>

        <footer class="footer">
            <div class="footer-container">
                <div class="footer-logo-box">
                    <img src="image/logo/logoIMG.png" alt="Logo" class="footer-logo" />
                </div>
                <div class="footer-section">
                    <h2>Contact Info</h2>
                    <p>Email: example@email.com</p>
                    <p>Địa chỉ: trường Đại học FPT, Hòa Lạc, Hà Nội</p>
                    <p>SĐT: 0123 456 789</p>
                </div>
                <div class="footer-section">
                    <h2>Subscribe</h2>
                    <p>Stay informed with our latest news and updates.</p>
                    <div class="email-box">
                        <input type="email" placeholder="Nhập email của bạn" />
                        <button>Subscribe</button>
                    </div>
                </div>
            </div>
        </footer>

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
                    if (event.target.tagName !== 'A') {
                        event.preventDefault(); // Prevent default li behavior
                        dropdown.classList.toggle('active');
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
                const slideContainer = document.getElementById("slideContainer");
                const slides = slideContainer.querySelectorAll("img");
                const dotsContainer = document.getElementById("dots");
                let currentIndex = 0;
                let autoSlide;

                // Tạo chấm
                slides.forEach((_, i) => {
                    const dot = document.createElement("span");
                    dot.dataset.index = i;
                    dot.classList.add("dot");
                    if (i === 0)
                        dot.classList.add("active");
                    dotsContainer.appendChild(dot);
                });

                const dots = document.querySelectorAll(".dot");

                function goToSlide(index) {
                    currentIndex = index;
                    slideContainer.style.transform = `translateX(-${index * 100}%)`;
                    dots.forEach(dot => dot.classList.remove("active"));
                    dots[index].classList.add("active");
                }

                function nextSlide() {
                    currentIndex = (currentIndex + 1) % slides.length;
                    goToSlide(currentIndex);
                }

                function startAutoSlide() {
                    autoSlide = setInterval(nextSlide, 10000); // 10s
                }

                function stopAutoSlide() {
                    clearInterval(autoSlide);
                }

                // Dấu chấm click
                dots.forEach(dot => {
                    dot.addEventListener("click", () => {
                        stopAutoSlide();
                        goToSlide(Number(dot.dataset.index));
                        startAutoSlide();
                    });
                });

                // Kéo (touch)
                let startX = 0;
                slideContainer.addEventListener("touchstart", e => {
                    startX = e.touches[0].clientX;
                    stopAutoSlide();
                });

                slideContainer.addEventListener("touchend", e => {
                    const diff = e.changedTouches[0].clientX - startX;
                    if (diff > 50) {
                        currentIndex = currentIndex > 0 ? currentIndex - 1 : slides.length - 1;
                    } else if (diff < -50) {
                        currentIndex = (currentIndex + 1) % slides.length;
                    }
                    goToSlide(currentIndex);
                    startAutoSlide();
                });

                // Khởi động
                startAutoSlide();
            });
        </script>
</html>
