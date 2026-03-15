<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Bán chạy nhất | IVY moda</title>
    
    
</head>
<body>
    <main id="main" class="main">
        <section class="section">
            <div class="row">
                <!-- Top Selling -->
                <div class="col-12">
                    <div class="card top-selling overflow-auto">
                        <div class="card-body pb-0" id="banchay">
                            <div class="row align-items-center">
                                <div class="col-7">
                                    <h5 class="card-title" style="margin-left: 10px;">Bán chạy nhất</h5>
                                </div>
                                <div class="col-5 d-flex justify-content-end">
                                    <form action="<c:url value='/admin-top-selling'/>" method="get" class="d-flex">
                                        <input type="text" id="searchInput" name="search" class="form-control"
                                               placeholder="🔍 Tìm sản phẩm..." style="width: 270px; margin: 15px;"
                                               value="${param.search}">
                                        <button type="submit" class="btn btn-primary" style="margin: 15px;">Tìm</button>
                                    </form>
                                </div>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col">Hình ảnh</th>
                                        <th scope="col">Sản phẩm</th>
                                        <th scope="col">Giá</th>
                                        <th scope="col">Đã bán</th>
                                        <th scope="col">Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${productList}">
                                        <tr>
                                            <th>
                                                <img src="<c:url value='${empty product.productImage ? "/templates/admin/img/default-product.jpg" : product.productImage}'/>"
                                                     alt="${product.productName}" style="width: 150px;" />
                                            </th>
                                            <td>${product.productName}</td>
                                            <td><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0.00"/> VNĐ</td>
                                            <td>${product.totalSold}</td>
                                            <td><fmt:formatNumber value="${product.revenue}" type="number" pattern="#,##0.00"/> VNĐ</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty productList}">
                                        <tr>
                                            <td colspan="5" class="text-center">Không có sản phẩm nào.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <!-- Trang đầu -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="<c:url value='/admin-top-selling'><c:param name='page' value='1'/><c:if test='${not empty param.search}'><c:param name='search' value='${param.search}'/></c:if></c:url>" aria-label="First">
                                                <span aria-hidden="true">««</span>
                                            </a>
                                        </li>
                                        <!-- Trang trước -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="<c:url value='/admin-top-selling'><c:param name='page' value='${currentPage - 1}'/><c:if test='${not empty param.search}'><c:param name='search' value='${param.search}'/></c:if></c:url>" aria-label="Previous">
                                                <span aria-hidden="true">«</span>
                                            </a>
                                        </li>
                                        <!-- Các trang -->
                                        <c:forEach begin="${currentPage - 2 > 0 ? currentPage - 2 : 1}"
                                                   end="${currentPage + 2 <= totalPages ? currentPage + 2 : totalPages}"
                                                   var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="<c:url value='/admin-top-selling'><c:param name='page' value='${i}'/><c:if test='${not empty param.search}'><c:param name='search' value='${param.search}'/></c:if></c:url>">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <!-- Trang sau -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="<c:url value='/admin-top-selling'><c:param name='page' value='${currentPage + 1}'/><c:if test='${not empty param.search}'><c:param name='search' value='${param.search}'/></c:if></c:url>" aria-label="Next">
                                                <span aria-hidden="true">»</span>
                                            </a>
                                        </li>
                                        <!-- Trang cuối -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="<c:url value='/admin-top-selling'><c:param name='page' value='${totalPages}'/><c:if test='${not empty param.search}'><c:param name='search' value='${param.search}'/></c:if></c:url>" aria-label="Last">
                                                <span aria-hidden="true">»»</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
                <!-- End Top Selling -->
            </div>
        </section>
    </main>
    
</body>
</html>