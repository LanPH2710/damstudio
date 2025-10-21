<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm - Dam Studio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/managerProduct.css?v=${System.currentTimeMillis()}">
    </head>

    <body class="control-user-page">

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand"><a href="homepage">Dam Studio</a></div>
            <ul class="menu">
                <!--<li><a href="dashboard"><i class="fas fa-home"></i> Dashboard</a></li>-->
                <li><a href="manageruser"><i class="fas fa-users"></i> User List</a></li>
                <li class="active"><a href="managerproduct"><i class="fas fa-box"></i> Product List</a></li>
                <li><a href="changeorder"><i class="fas fa-users"></i> Manager Orders</a></li>
            </ul>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <div class="header d-flex justify-content-between align-items-center">
                <form action="managerproduct" method="get" class="search-box">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Search product...">
                    <select name="brandId" class="form-select" style="width:150px;">
                        <option value="">Brand</option>
                        <c:forEach var="b" items="${brandList}">
                            <option value="${b.brandId}" ${b.brandId == selectedBrandId ? 'selected' : ''}>${b.name}</option>
                        </c:forEach>
                    </select>

                    <select name="styleId" class="form-select" style="width:150px;">
                        <option value="">Style</option>
                        <c:forEach var="s" items="${styleList}">
                            <option value="${s.styleId}" ${s.styleId == selectedStyleId ? 'selected' : ''}>${s.styleName}</option>
                        </c:forEach>
                    </select>

                    <select name="sort" class="form-select" style="width:150px;">
                        <option value="">Sort Price</option>
                        <option value="asc" ${sort == 'asc' ? 'selected' : ''}>Low → High</option>
                        <option value="desc" ${sort == 'desc' ? 'selected' : ''}>High → Low</option>
                    </select>

                    <button type="submit" class="btn btn-primary">Filter</button>
                    <a href="managerproduct" class="btn btn-secondary">Reset</a>
                </form>
                <span class="admin-info">ADMIN ▸ Product List</span>
            </div>

            <div class="container mt-3">
                <h2 class="page-title mb-3">Product List</h2>

                <div class="table-container">
                    <table class="table table-hover table-bordered text-center align-middle user-table">
                        <thead>
                            <tr>
                                <th>Main Image</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>VAT</th>
                                <th>Status</th>
                                <th>Activity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${productList}">
                                <tr>
                                    <td>
                                        <c:if test="${not empty p.images}">
                                            <img src="image/ao/${p.images[0].imageUrl}" alt="${p.name}" class="avatar"/>
                                        </c:if></td>
                                    <td>${p.name}</td>
                                    <td>${p.price}₫</td>
                                    <td>${p.VAT}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.productStatus == 1}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><a href="editproduct?productId=${p.productId}">
                                            <span class="badge bg-warning">Edit</span>
                                        </a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <ul class="pagination justify-content-center mt-4">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="managerproduct?page=${currentPage - 1}&keyword=${keyword}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&sort=${sort}">&laquo;</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="${currentPage - 2 <= 0 ? 1 : currentPage - 2}" 
                               end="${currentPage + 2 >= totalPages ? totalPages : currentPage + 2}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="managerproduct?page=${i}&keyword=${keyword}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&sort=${sort}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="managerproduct?page=${currentPage + 1}&keyword=${keyword}&brandId=${selectedBrandId}&styleId=${selectedStyleId}&sort=${sort}">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </body>
</html>
