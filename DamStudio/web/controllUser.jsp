<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/controllUser.css?v=${System.currentTimeMillis()}">
        <link rel="stylesheet" href="css/homePage.css">
    </head>
    <body class="control-user-page">

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand"><a href="homepage">Dam Studio</a></div>
            <ul class="menu">
                <!--<li><a href="dashboard"><i class="fas fa-home"></i> Dashboard</a></li>-->
                <li class="active"><a href="manageruser"><i class="fas fa-users"></i> User List</a></li>
                <li><a href="managerproduct"><i class="fas fa-box"></i> Product List</a></li>
                <li><a href="changeorder"><i class="fas fa-users"></i> Manager Orders</a></li>
            </ul>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <div class="header d-flex justify-content-between align-items-center">
                <form action="manageruser" method="get" class="search-box">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Search keyword...">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <a href="manageruser" class="btn btn-secondary">Reset</a>
                </form>
                <span class="admin-info">ADMIN ▸ USER LIST</span>
            </div>

            <div class="container mt-4">
                <h2 class="page-title mb-3">User List</h2>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered text-center align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Mobile</th>
                                <th>Gender</th>
                                <th>Role</th>
                                <th>Avatar</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${accountList}">
                                <tr>
                                    <td>${u.firstName} ${u.lastName}</td>
                                    <td>${u.email}</td>
                                    <td>${u.mobile}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.gender == 0}">Male</c:when>
                                            <c:when test="${u.gender == 1}">Female</c:when>
                                            <c:otherwise>Other</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.roleId == 1}">Admin</c:when>
                                            <c:when test="${u.roleId == 2}">Marketing</c:when>
                                            <c:when test="${u.roleId == 3}">Sale</c:when>
                                            <c:when test="${u.roleId == 4}">Customer</c:when>
                                            <c:when test="${u.roleId == 5}">Shipper</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><img src="${u.avatar}" alt="avatar" class="avatar rounded-circle" width="50"></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.accountStatus == 1}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:when test="${u.accountStatus == 0}">
                                                <span class="badge bg-warning">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>   
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <ul class="pagination justify-content-center mt-4">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="manageruser?page=${currentPage - 1}&keyword=${keyword}">&laquo;</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="${currentPage - 2 <= 0 ? 1 : currentPage - 2}" 
                               end="${currentPage + 2 >= totalPages ? totalPages : currentPage + 2}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="manageruser?page=${i}&keyword=${keyword}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="manageruser?page=${currentPage + 1}&keyword=${keyword}">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </body>
</html>
