<%-- 
    Document   : About.jsp
    Created on : Oct 13, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về Chúng Tôi - Dám Studio</title>
    
    <%-- Các link font và icon --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
    <%-- Link tới các file CSS của bạn --%>
    <link rel="stylesheet" href="css/header.css"><link rel="stylesheet" href="css/about.css">
    <link rel="stylesheet" href="css/homePage.css">
    
</head>
<body class="about-page">

    <jsp:include page="header.jsp"/>

    <main>
        <section class="hero-about">
            <div class="hero-content">
                <h1>Về Dám Studio</h1>
                <p>Dám Studio là một doanh nghiệp sáng tạo có quy mô nhỏ và vừa, hoạt động trong lĩnh vực thiết kế thời trang kết hợp với truyền thông văn hóa Việt Nam và ứng dụng công nghệ hiện đại. Dự án hướng đến việc sáng tạo các sản phẩm thời trang có chiều sâu văn hóa, góp phần lưu giữ, lan tỏa giá trị truyền thống qua hình thức tiếp cận mới mẻ, gần gũi và mang tính cá nhân hóa cao.</p>
            </div>
        </section>

        <section class="content-section">
            <div class="container">
                <div class="section-grid">
                    <div class="section-image">
                        <img src="image/STTTBlackBack.png" alt="Tầm nhìn Dám Studio">
                    </div>
                    <div class="section-text">
                        <h2 class="section-title">Tầm nhìn</h2>
                        <h3 class="section-subtitle">Dám Studio: Nơi Văn Hóa Giao Thoa Cùng Công Nghệ</h3>
                        <p>Dám Studio luôn mong muốn tạo ra một thế hệ sản phẩm thời trang thông minh, nơi mỗi họa tiết đều là một cánh cửa mở ra tri thức và niềm tự hào dân tộc, giúp người trẻ tiếp cận, yêu thích và lan tỏa giá trị văn hóa Việt Nam theo cách sáng tạo nhất.</p>
                        <p>Tại Dám Studio, chúng tôi không đơn thuần tạo ra những chiếc áo – chúng tôi kiến tạo những câu chuyện.</p>
                        <p>Dám Studio mong muốn là trở thành thương hiệu thời trang tiên phong, là cầu nối thế hệ, biến những di sản văn hóa và kho tàng truyền thuyết Việt Nam thành ngôn ngữ thời trang hiện đại.</p>
                        <p>Chúng tôi tin rằng, mỗi câu chuyện dân gian, từ sự tích Sơn Tinh – Thủy Tinh hùng vĩ đến huyền thoại Con Rồng cháu Tiên cao đẹp,... đều xứng đáng được kể lại và khám phá một cách đầy hứng thú.</p>
                        <p>Bên cạnh đó, chúng tôi cũng sẽ không chỉ dừng lại ở Việt Nam, mà còn hướng tới việc đưa văn hóa Việt Nam vươn ra thế giới thông qua những chiếc áo có câu chuyện, với mức giá phải chăng, dễ dàng tiếp cận mọi đối tượng, từ học sinh, sinh viên đến bạn bè quốc tế.</p>
                        <p>Dám Studio – Dám mơ, dám nghĩ và dám làm.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="content-section sumenh">
            <div class="container">
                <div class="section-grid reverse">
                    <div class="section-image">
                        <img src="image/homeSlider/Dragon-Bridge2_lg.jpg" alt="">
                    </div>
                    <div class="section-text sumenh">
                        <h2 class="section-title sumenhh2">Sứ mệnh</h2>
                        <p><strong>Gìn giữ và Lan tỏa Văn hóa:</strong> Chúng tôi cam kết sử dụng nghệ thuật minh họa hiện đại để làm sống lại các câu chuyện dân gian, truyền thuyết và biểu tượng lịch sử đã bị lãng quên, đưa chúng trở lại đời sống hàng ngày của giới trẻ.</p>
                        <p><strong>Đổi mới trong Giáo dục:</strong> Biến chiếc áo thun trở thành một công cụ học tập tương tác độc đáo. Thông qua việc tích hợp mã QR, chúng tôi cung cấp nội dung hấp dẫn, chính xác về văn hóa, biến việc mặc đồ trở thành một trải nghiệm khám phá không ngừng.</p>
                        <p><strong>Hỗ trợ Cộng đồng:</strong> Cung cấp các sản phẩm chất lượng cao với mức giá dễ tiếp cận, đặc biệt cho đối tượng học sinh, sinh viên và các tổ chức giáo dục, nhằm đảm bảo mọi người đều có thể tham gia vào hành trình văn hóa này.</p>
                        <p>Tại Dám Studio, chúng tôi tin rằng thời trang là một ngôn ngữ. Sứ mệnh của chúng tôi là kể lại những câu chuyện văn hóa Việt Nam đầy tự hào qua từng thiết kế áo thun. Chúng tôi không chỉ bán một sản phẩm, chúng tôi lan tỏa giá trị, kết nối quá khứ với hiện tại và truyền cảm hứng cho thế hệ trẻ "dám" thể hiện bản sắc của mình.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="content-section team-section">
            <div class="container">
                <h2 class="section-title">Đội Ngũ Sáng Tạo</h2>
                <p class="section-intro">Những con người đứng sau mỗi thiết kế, mang nhiệt huyết và đam mê vào từng sản phẩm.</p>
                <div class="team-grid">
                    <div class="team-member">
                        <img src="image/logo/logoIMG.png" alt="Thành viên 1">
                        <h3>Phan Hoàng Lan</h3>
                        <p>Founder & Creative Director</p>
                    </div>
                    <div class="team-member">
                        <img src="image/logo/logoIMG.png" alt="Thành viên 2">
                        <h3>Quanh</h3>
                        <p>Lead Designer</p>
                    </div>
                    <div class="team-member">
                        <img src="image/logo/logoIMG.png" alt="Thành viên 3">
                        <h3>Hùng</h3>
                        <p>Marketing Manager</p>
                    </div>
                    <br><div class="team-member">
                        <img src="image/logo/logoIMG.png" alt="Thành viên 2">
                        <h3>Tuấn</h3>
                        <p>Lead Dev</p>
                    </div>
                    <div class="team-member">
                        <img src="image/logo/logoIMG.png" alt="Thành viên 3">
                        <h3>Ngân</h3>
                        <p>design</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="footer.jsp"/>

</body>
</html>