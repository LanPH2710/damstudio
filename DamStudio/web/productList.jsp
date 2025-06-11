<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách sản phẩm</title>
        <link rel="stylesheet" href="css/product.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="product-page">
            <h2 class="title">Danh sách sản phẩm</h2>
            <!-- Thanh tìm kiếm -->
            <div class="product-search">
                <form action="productlist" method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." />
                    <button type="submit">Tìm kiếm</button>

                    <select name="sort" onchange="this.form.submit()">
                        <option value="default" ${param.sort == 'default' ? 'selected' : ''}>Sắp xếp theo</option>
                        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Tăng dần</option>
                        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giảm dần</option>
                    </select>
                </form>
            </div>
            <div class="product-content">
                <!-- Sidebar mục lục -->
                <aside class="product-sidebar">
                    <h3>Danh mục</h3>
                    <ul>
                        <li><a href="#">Tất cả</a></li>
                        <li><a href="#">Điện thoại</a></li>
                        <li><a href="#">Laptop</a></li>
                        <li><a href="#">Phụ kiện</a></li>
                        <li><a href="#">Khuyến mãi</a></li>
                    </ul>
                </aside>
                <!-- Lưới sản phẩm -->
                <div class="product-grid">
                    <c:forEach var = "product" items="${productList}">
                        <div class="product-card">
                            <img src="image/logo/logoIMG.png" alt="Sản phẩm 1"/>
                            <h3>${productList.name}</h3>
                            <p class="description">${productList.description}</p>
                            <p class="price">${productList.price}</p>
                            <a href="#" class="btn">Xem chi tiết</a>
                        </div>
                    </c:forEach>
                    <div class="product-card">
                        <img src="image/logo/logoIMG.png" alt="Sản phẩm 2" class="product-image" />
                        <h3>Sản phẩm 2</h3>
                        <p class="description">Mô tả ngắn gọn về sản phẩm 2.</p>
                        <p class="price">Giá: 320,000 VND</p>
                        <a href="#" class="btn">Xem chi tiết</a>
                    </div>

                    <div class="product-card">
                        <img src="image/logo/logoIMG.png" alt="Sản phẩm 3" class="product-image" />
                        <h3>Sản phẩm 3</h3>
                        <p class="description">Mô tả ngắn gọn về sản phẩm 3.</p>
                        <p class="price">Giá: 150,000 VND</p>
                        <a href="#" class="btn">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>

