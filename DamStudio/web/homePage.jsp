<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang Chủ - Áo QR Việt Nam</title>
        <!--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css?v=${System.currentTimeMillis()}" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;900&display=swap"
              rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Inter:opsz,wght@14..32,100..900&family=Mulish:ital,wght@0,200..1000;1,200..1000&family=Playwrite+HU:wght@100..400&family=Roboto+Condensed:wght@100..900&family=Roboto+Slab:wght@100..900&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    </head>

    <body class="homepage">
        <jsp:include page="header.jsp"/>
        <!-- carousel -->
        <div class="carousel">
            <!-- list item -->
            <div class="list">
                <div class="item">
                    <img src="image/homeSlider/CRCT.png">
                    <div class="content">

                        <div class="title">DÁM</div>
                        <div class="topic">STUDIO</div>
                        <!--                    <div class="author">Trân Trọng Giới Thiệu</div>
                                            <div class="des">
                                                 lorem 50 
                                                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut sequi, rem magnam nesciunt minima
                                                placeat, itaque eum neque officiis unde, eaque optio ratione aliquid assumenda facere ab et
                                                quasi ducimus aut doloribus non numquam. Explicabo, laboriosam nisi reprehenderit tempora at
                                                laborum natus unde. Ut, exercitationem eum aperiam illo illum laudantium?
                                            </div>
                                            <div class="buttons">
                                                <button>SEE MORE</button>
                                                 <button>SUBSCRIBE</button> 
                                            </div>-->
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STHG.png">
                    <div class="content">
                        <div class="title">DÁM</div>
                        <div class="topic">STUDIO</div>
                        <!--                    <div class="author">Trân Trọng Giới Thiệu</div>
                                            <div class="des">
                                                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut sequi, rem magnam nesciunt minima
                                                placeat, itaque eum neque officiis unde, eaque optio ratione aliquid assumenda facere ab et
                                                quasi ducimus aut doloribus non numquam. Explicabo, laboriosam nisi reprehenderit tempora at
                                                laborum natus unde. Ut, exercitationem eum aperiam illo illum laudantium?
                                            </div>
                                            <div class="buttons">
                                                <button>SEE MORE</button>
                                                 <button>SUBSCRIBE</button> 
                                            </div>-->
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STTT.png">
                    <div class="content">
                        <div class="title">DÁM</div>
                        <div class="topic">STUDIO</div>
                        <!--                    <div class="author">Trân Trọng Giới Thiệu</div>
                                            <div class="des">
                                                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut sequi, rem magnam nesciunt minima
                                                placeat, itaque eum neque officiis unde, eaque optio ratione aliquid assumenda facere ab et
                                                quasi ducimus aut doloribus non numquam. Explicabo, laboriosam nisi reprehenderit tempora at
                                                laborum natus unde. Ut, exercitationem eum aperiam illo illum laudantium?
                                            </div>
                                            <div class="buttons">
                                                <button>SEE MORE</button>
                                                 <button>SUBSCRIBE</button> 
                                            </div>-->
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STHG2.png">
                    <div class="content">
                        <div class="title">DÁM</div>
                        <div class="topic">STUDIO</div>
                        <!--                    <div class="author">Trân Trọng Giới Thiệu</div>
                                            <div class="des">
                                                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut sequi, rem magnam nesciunt minima
                                                placeat, itaque eum neque officiis unde, eaque optio ratione aliquid assumenda facere ab et
                                                quasi ducimus aut doloribus non numquam. Explicabo, laboriosam nisi reprehenderit tempora at
                                                laborum natus unde. Ut, exercitationem eum aperiam illo illum laudantium?
                                            </div>
                                            <div class="buttons">
                                                <button>SEE MORE</button>
                                                 <button>SUBSCRIBE</button> 
                                            </div>-->
                    </div>
                </div>
            </div>
            <!-- list thumnail -->
            <div class="thumbnail">
                <div class="item">
                    <img src="image/homeSlider/CRCT.png">
                    <div class="content">
                        <div class="title">
                            Name Slider
                        </div>
                        <div class="description">
                            Description
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STHG.png">
                    <div class="content">
                        <div class="title">
                            Name Slider
                        </div>
                        <div class="description">
                            Description
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STTT.png">
                    <div class="content">
                        <div class="title">
                            Name Slider
                        </div>
                        <div class="description">
                            Description
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img src="image/homeSlider/STHG2.png">
                    <div class="content">
                        <div class="title">
                            Name Slider
                        </div>
                        <div class="description">
                            Description
                        </div>
                    </div>
                </div>
            </div>
            <!-- next prev -->

            <div class="arrows">
                <button id="prev">
                    < </button>
                <button id="next">></button>
            </div>
            <!-- time running -->
            <div class="time"></div>
        </div>


        <!-- Frame 2: Hello Section -->
        <section class="frame hello-frame">
            <div class="frame-content">
                <div class="hello-row">
                    <div class="hello-img">
                        <img src="image/logo/logoBIGpng.PNG" alt="Dám Studio Image">
                    </div>
                    <div class="hello-text hello-animated-content">
                        <h2>"Chúng tôi không chỉ bán áo – chúng tôi kể câu chuyện Việt Nam"</h2>
                        <p>Dám Studio truyền tải văn hóa Việt qua từng chiếc áo – sáng tạo, sâu sắc và hiện đại.</p>
                        <p>Chúng tôi dám làm khác biệt, biến áo phông thành cầu nối giữa con người và di sản.</p>
                        <p>Mỗi thiết kế không chỉ là chiếc áo, đó là một câu chuyện, một di sản, một niềm tự hào.</p>
                        <div class="learnmore">
                            <a href="https://damstudio.store/about.jsp" class="learn-more-btn">TÌM HIỂU THÊM</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>






        <!-- ...frame3... -->
        <section class="frame">
            <div class="frame-content">
                <h2>SẢN PHẨM NỔI BẬT</h2>
                <div class="products section-animated-content">
                    <!-- Example product items, repeat as needed -->

                    <div class="product">
                        <img src="image/STTTBlackBack.png" alt="Áo Sơn Tinh Thủy Tinh">
                        <p>Áo Sơn Tinh Thủy Tinh</p>
                        <p class="price">169,000 VNĐ</p>
                        <a class="learn-more-btn" href="https://damstudio.store/productdetail?productId=TT0001">Xem chi tiết</a>
                    </div>
                    <div class="product">
                        <img src="image/STHGWhiteBack.png" alt="Áo Sự Tích Hồ Gươm">
                        <p>Áo Sự Tích Hồ Gươm</p>
                        <p class="price">169,000 VNĐ</p>
                        <a class="learn-more-btn" href="https://damstudio.store/productdetail?productId=ST0001">Xem chi tiết</a>
                    </div>

                    <!-- Add more products as needed -->
                </div>
                <div class="learnmore">
                    <a class="learn-more-btn" href="https://damstudio.store/productlist">XEM TẤT CẢ</a>
                </div>
            </div>
        </section>
        <!-- ...existing code... -->


        <section class="frame frame-fourth">
            <div class="frame-content">
                <div class="frame-fourth-row">
                    <div class="frame-fourth-text section-animated-content">
                        <h2>Tiêu đề nổi bật</h2>
                        <p>Mô tả hoặc nội dung chi tiết ở đây. Bạn có thể thêm nhiều đoạn văn hoặc nút tùy ý.</p>
                        <a href="#" class="learn-more-btn">Xem thêm</a>
                    </div>
                    <div class="frame-fourth-slider">
                        <!-- Image slider example (replace with your slider code if needed) -->
                        <div class="slider-images">
                            <img src="image/homeSlider/buu-dien-trung-tam-sai-gon-1.jpg" alt="Slider 1">
                            <img src="image/homeSlider/mceu_67032867531716201705287.jpg" alt="Slider 2" style="display:none;">
                            <!-- Add JS to switch images if you want -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--<footer class="main-footer">
            <div class="footer-top">
                <div class="footer-logo">
                    <img src="image/logo/logoLONG.png" alt="Dám Studio Logo">
                </div>
                <div class="footer-contact">
                    <h3>Contact info</h3>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> 3541 Fort Meade Road, Laurel, MD 20724</li>
                        <li><i class="fas fa-phone"></i> (301) 490-5050</li>
                        <li><i class="fas fa-clock"></i> Open 24 hours, 7 days a week</li>
                    </ul>
                </div>
                <div class="footer-subscribe">
                    <h3>Subscribe</h3>
                    <p>Stay informed with our latest news and updates.</p>
                    <form>
                        <input type="email" placeholder="Enter your email" required>
                        <button type="submit">Subscribe</button>
                    </form>
                    <small>By subscribing, you agree to our Privacy Policy and consent to receive updates from our
                        company.</small>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-links">
                    <a href="#">Bản Quyền © 2025</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Accessibility Statement</a>
                    <a href="#">Privacy Request Form</a>
                    <a href="#">Delivery Policy</a>
                </div>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </footer>-->

        <jsp:include page="footer.jsp"/>

        <script src="javascript/homePage.js"></script>
        <!-- ...existing code... -->




        <script src="https://sf-cdn.coze.com/obj/unpkg-va/flow-platform/chat-app-sdk/1.2.0-beta.6/libs/oversea/index.js"></script>
        <script>
            new CozeWebSDK.WebChatClient({
                config: {
                    bot_id: '7527700457444409362',
                },
                componentProps: {
                    title: 'Coze',
                },
                auth: {
                    type: 'token',
                    token: 'pat_mEeypgmlIiDCzxueWrgoF92lkVZq4bByUAXYR9y6498rqbfGz3pIHCLi8gPngZb1',
                    onRefreshToken: function () {
                        return 'pat_mEeypgmlIiDCzxueWrgoF92lkVZq4bByUAXYR9y6498rqbfGz3pIHCLi8gPngZb1'
                    }
                }
            });
        </script>
    </body>
</html>

