<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="css/productDetail.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="product-detail-container">
            <div class="product-detail-card">
                <div class="product-detail-image">
                    <img src="image/logo/logoIMG.png" alt="${product.name}"/>
                </div>
                <div class="product-detail-info">
                    <h2 class="product-name">${product.name}</h2>
                    <p class="product-description">${product.description}</p>
                    <p class="product-price">
                        Giá: <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VNĐ
                    </p>

                    <ul class="product-attributes">
                        <li><strong>Thương hiệu:</strong> ${product.brand.name}</li>
                        <li><strong>Kiểu dáng:</strong> ${product.style.name}</li>
                        <li><strong>Kích thước:</strong> ${product.size.sizeName}</li>
                        <li><strong>Chiều cao:</strong> ${product.size.heightMin}cm - ${product.size.heightMax}cm</li>
                        <li><strong>Cân nặng:</strong> ${product.size.weightMin}kg - ${product.size.weightMax}kg</li>
                    </ul>

                    <div class="product-colors">
                        <p><strong>Màu sắc:</strong></p>
                        <c:forEach var="color" items="${colorList}">
                            <span class="color-dot" style="background-color: ${color.hex};" title="${color.name}"></span>
                        </c:forEach>
                    </div>

                    <a href="productlist" class="btn">Quay lại danh sách</a>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
