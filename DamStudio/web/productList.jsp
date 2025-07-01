<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách sản phẩm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
                        <li class="${empty param.brandId ? 'active' : ''}">
                            <a href="productlist?sizeId=${param.sizeId}&page=1&sort=${param.sort}">Tất cả</a>
                        </li>
                        <c:forEach var="brand" items="${brandList}">
                            <li class="${param.brandId == brand.brandId ? 'active' : ''}">
                                <a href="productlist?brandId=${brand.brandId}&page=1&sort=${param.sort}">${brand.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </aside>
                <!-- Lưới sản phẩm -->
                <div class="product-grid">
                    <c:forEach var = "product" items="${productList}">
                        <div class="product-card">
                            <img src="image/logo/logoIMG.png" alt="Sản phẩm 1"/>
                            <h3>${product.name}</h3>
                            <p class="price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VNĐ</p>
                            <a href="productdetail?productId=${product.productId}" class="btn">Xem chi tiết</a>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="clearfix">
                <ul class="paginationProList justify-content-center">
                    <!-- Nút về trang đầu -->
                    <c:if test="${currentPage > 2}">
                        <li class="page-item">
                            <a class="page-link" href="productlist?page=1&brandId=${selectedBrandId}&styleId=${selectedStyleId}&keyword=${keyword}&sort=${sort}">
                                <i class="fa fa-angle-double-left"></i>
                            </a>
                        </li>
                    </c:if>

                    <!-- Nút về trang trước -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="productlist?page=${currentPage - 1}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&keyword=${keyword}&sort=${sort}">
                                <i class="fa fa-angle-left"></i>
                            </a>
                        </li>
                    </c:if>

                    <!-- Vòng lặp trang -->
                    <c:forEach var="i" begin="${currentPage - 2 <= 0 ? 1 : currentPage - 2}"
                               end="${currentPage + 2 >= totalPages ? totalPages : currentPage + 2}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <li class="page-item active">
                                    <a class="page-link">${i}</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="productlist?page=${i}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&keyword=${keyword}&sort=${sort}">
                                        ${i}
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- Nút trang kế tiếp -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="productlist?page=${currentPage + 1}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&keyword=${keyword}&sort=${sort}">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </c:if>

                    <!-- Nút trang cuối -->
                    <c:if test="${currentPage + 2 < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="productlist?page=${totalPages}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&keyword=${keyword}&sort=${sort}">
                                <i class="fa fa-angle-double-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>

