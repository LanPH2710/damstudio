<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Manager Orders - Dam Studio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminOrder.css?v=${System.currentTimeMillis()}">
    </head>

    <body class="control-user-page">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand"><a href="homepage">Dam Studio</a></div>
            <ul class="menu">
                <!--<li><a href="dashboard"><i class="fas fa-home"></i> Dashboard</a></li>-->
                <li><a href="manageruser"><i class="fas fa-users"></i> User List</a></li>
                <li><a href="managerproduct"><i class="fas fa-box"></i> Product List</a></li>
                <li class="active"><a href="adminorder"><i class="fas fa-shopping-cart"></i> Manager Orders</a></li>
            </ul>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <div class="header d-flex justify-content-between align-items-center">
                <form action="adminorder" method="get" class="search-box">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Search order...">
                    <select name="statusId" class="form-select" style="width:150px;">
                        <option value="">All Status</option>
                        <option value="1" ${statusId == 1 ? 'selected' : ''}>Pending</option>
                        <option value="2" ${statusId == 2 ? 'selected' : ''}>Confirmed</option>
                        <option value="3" ${statusId == 3 ? 'selected' : ''}>Delivering</option>
                        <option value="4" ${statusId == 4 ? 'selected' : ''}>Completed</option>
                        <option value="5" ${statusId == 5 ? 'selected' : ''}>Canceled</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Filter</button>
                    <a href="adminorder" class="btn btn-secondary">Reset</a>
                </form>
                <span class="admin-info">ADMIN ▸ Manager Orders</span>
            </div>

            <!-- Order List -->
            <div class="container mt-4">
                <h2 class="page-title mb-3">Orders List</h2>

                <div class="table-responsive bg-white shadow rounded">
                    <c:choose>
                        <c:when test="${empty allOrder}">
                            <p class="text-center mt-4">No orders found.</p>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-hover table-bordered text-center align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Total Price</th>
                                        <th>Payment</th>
                                        <th>Status</th>
                                        <th>Change Status</th>
                                        <th>Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${allOrder}" var="order">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td>${order.account.firstName} ${order.account.lastName}</td>
                                            <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.payMethod == 1}">Paid (Online)</c:when>
                                                    <c:when test="${order.payMethod == 2}">COD</c:when>
                                                    <c:otherwise>Paid</c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 1}"><span class="badge bg-warning">Pending</span></c:when>
                                                    <c:when test="${order.orderStatus == 2}"><span class="badge bg-info">Confirmed</span></c:when>
                                                    <c:when test="${order.orderStatus == 3}"><span class="badge bg-primary">Delivering</span></c:when>
                                                    <c:when test="${order.orderStatus == 4}"><span class="badge bg-success">Completed</span></c:when>
                                                    <c:when test="${order.orderStatus == 5}"><span class="badge bg-danger">Canceled</span></c:when>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <form action="changeorder" method="post">
                                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                                    <select name="orderStatus" onchange="this.form.submit()" class="form-select form-select-sm">
                                                        <option value="1" ${order.orderStatus == 1 ? 'selected' : ''}>Pending</option>
                                                        <option value="2" ${order.orderStatus == 2 ? 'selected' : ''}>Confirmed</option>
                                                        <option value="3" ${order.orderStatus == 3 ? 'selected' : ''}>Delivering</option>
                                                        <option value="4" ${order.orderStatus == 4 ? 'selected' : ''}>Completed</option>
                                                        <option value="5" ${order.orderStatus == 5 ? 'selected' : ''}>Canceled</option>
                                                    </select>
                                                </form>
                                            </td>

                                            <td>
                                                <a href="orderdetail?orderId=${order.orderId}" class="btn btn-outline-primary btn-sm">View</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pagination -->
                <ul class="pagination justify-content-center mt-4">
                    <c:if test="${page > 1}">
                        <li class="page-item"><a class="page-link" href="adminorder?page=${page-1}&statusId=${statusId}">&laquo;</a></li>
                        </c:if>

                    <c:forEach var="i" begin="${page-1 <= 1 ? 1 : page-1}" end="${page+1 > num ? num : page+1}">
                        <li class="page-item ${i==page?'active':''}">
                            <a class="page-link" href="adminorder?page=${i}&statusId=${statusId}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${page < num}">
                        <li class="page-item"><a class="page-link" href="adminorder?page=${page+1}&statusId=${statusId}">&raquo;</a></li>
                        </c:if>
                </ul>
            </div>
        </div>
    </body>
</html>
