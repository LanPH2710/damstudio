<%-- 
    Document   : story
    Created on : Oct 13, 2025, 1:11:18 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Câu Chuyện - Dám Studio</title>

    <%-- Các link font và icon (giữ lại từ các trang khác) --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <%-- Link tới các file CSS của bạn --%>
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/homePage.css">
    <link rel="stylesheet" href="css/story.css"> <%-- File CSS mới cho trang này --%>
</head>
<body>

    <%-- Include Header --%>
    <jsp:include page="header.jsp"/>

    <main>
        <section class="story-page-section">
            <div class="container">
                <div class="section-header">
                    <h1>Khám Phá Các Câu Chuyện</h1>
                    <p>Mỗi thiết kế là một di sản văn hóa được kể lại.</p>
                </div>

                <div class="story-grid">
                    <a href="sutichhoguom.html" class="story-card">
                        <img src="image/homeSlider/STHG.png" alt="Sự Tích Hồ Gươm" class="card-background">
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <h3 class="card-title">Sự Tích Hồ Gươm</h3>
                            <p class="card-description">
                                Câu chuyện huyền thoại về vua Lê Lợi trả gươm báu cho Rùa Vàng, biểu tượng cho khát vọng hòa bình của dân tộc.
                            </p>
                        </div>
                    </a>

                    <a href="sontinhthuytinh.html" class="story-card">
                        <img src="image/homeSlider/STTT.png" alt="Sơn Tinh - Thủy Tinh" class="card-background">
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <h3 class="card-title">Sơn Tinh - Thủy Tinh</h3>
                            <p class="card-description">
                                Cuộc chiến long trời lở đất giữa hai vị thần để giành lấy công chúa Mị Nương, giải thích cho hiện tượng lũ lụt hàng năm.
                            </p>
                        </div>
                    </a>
                    
                    </div>
            </div>
        </section>
    </main>

    <%-- Include Footer --%>
    <jsp:include page="footer.jsp"/>

</body>
</html>