<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ | IVY moda</title>
</head>
<body>

    <!-- Breadcumb -->
    <div class="breadcumb">
        <div class="container">
            <nav class="inner-links">
                <ul>
                    <li><a href="#">Trang chủ <i class="fa-solid fa-minus"></i></a></li>
                    <li><a href="#">NEW ARRIVAL</a></li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- End Breadcumb -->

    <!-- Section 4 -->
    <div class="section-4">
        <div class="container">
            <div class="inner-wrap">
                <!-- Box filter -->
                <div class="box-filter">
                    <ul>
                        <li><a href="#collapseSize" data-bs-toggle="collapse"
                            role="button" aria-expanded="false" aria-controls="collapseSize">
                                Size <i class="fa-solid fa-plus"></i>
                        </a>
                            <div class="collapse" id="collapseSize">
                                <div class="inner-wrap-item">
                                    <div class="inner-item">S</div>
                                    <div class="inner-item">M</div>
                                    <div class="inner-item">L</div>
                                    <div class="inner-item">XL</div>
                                    <div class="inner-item">XXL</div>
                                </div>
                            </div></li>
                        <li><a href="#collapseColor" data-bs-toggle="collapse"
                            role="button" aria-expanded="false" aria-controls="collapseColor">
                                Màu sắc <i class="fa-solid fa-plus"></i>
                        </a>
                            <div class="collapse" id="collapseColor">
                                <div class="inner-wrap-item">
                                    <div class="inner-item-color"></div>
                                    <div class="inner-item-color"></div>
                                    <div class="inner-item-color"></div>
                                    <div class="inner-item-color"></div>
                                    <div class="inner-item-color"></div>
                                </div>
                            </div></li>
                        <li><a href="#">Mức giá</a></li>
                        <li><a href="#collapsePercent" data-bs-toggle="collapse"
                            role="button" aria-expanded="false"
                            aria-controls="collapsePercent"> Mức chiết khấu <i
                                class="fa-solid fa-plus"></i>
                        </a>
                            <div class="collapse" id="collapsePercent">
                                <div class="inner-wrap-percent">
                                    <div class="inner-item-percent">
                                        <input type="radio" name="percent" id="percent1"> <label
                                            for="percent1">Dưới 30%</label>
                                    </div>
                                    <div class="inner-item-percent">
                                        <input type="radio" name="percent" id="percent2"> <label
                                            for="percent2">Từ 30% - 50%</label>
                                    </div>
                                    <div class="inner-item-percent">
                                        <input type="radio" name="percent" id="percent3"> <label
                                            for="percent3">Từ 50% - 70%</label>
                                    </div>
                                    <div class="inner-item-percent">
                                        <input type="radio" name="percent" id="percent4"> <label
                                            for="percent4">Từ 70%</label>
                                    </div>
                                    <div class="inner-item-percent">
                                        <input type="radio" name="percent" id="percent5"> <label
                                            for="percent5">Giá đặc biệt</label>
                                    </div>
                                </div>
                            </div></li>
                        <li><a href="#">Nâng cao</a></li>
                    </ul>
                    <div class="inner-actions">
                        <div class="inner-button">
                            <a href="#" class="button-outline">Bỏ lọc</a>
                        </div>
                        <div class="inner-button">
                            <a href="#" class="button-main">Lọc</a>
                        </div>
                    </div>
                </div>
                <div class="overlay-filter"></div>
                <!-- End Box filter -->

                <div class="list-product">
                    <div class="inner-head">
                        <div class="inner-title">NEW ARRIVAL</div>
                        <div class="accordion-filter" id="accordionFilter">
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#collapseOne"
                                        aria-expanded="true" aria-controls="collapseOne">Sắp
                                        xếp theo</button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse"
                                    aria-labelledby="headingOne" data-bs-parent="#accordionFilter">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">Mặc định</a></li>
                                            <li><a href="#">Mới nhất</a></li>
                                            <li><a href="#">Được mua nhiều nhất</a></li>
                                            <li><a href="#">Được yêu thích nhất</a></li>
                                            <li><a href="#">Giá: cao đến thấp</a></li>
                                            <li><a href="#">Giá: thấp đến cao</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="inner-button-filter">
                            <i class="fa-solid fa-filter"></i>
                        </div>
                    </div>
                    <div class="wrap-item">
                        <c:forEach var="product" items="${products}">
                            <div class="product-item">
                                <div class="inner-tag tag-uppercase">New</div>
                                <div class="inner-image">
                                    <a href="/detail.html?id=${product.productId}">
                                        <img src="<c:url value='${product.productImage}'/>" alt="${product.productName}">
                                        <!-- Giả sử có ảnh hover, nếu không thì dùng cùng ảnh -->
                                        <img src="<c:url value='${product.productImage}'/>" alt="${product.productName}" class="hover-img">
                                    </a>
                                </div>
                                <div class="inner-content">
                                    <div class="inner-meta">
                                        <div class="inner-color">
                                            <div class="inner-box" style="background-color: ${product.productColor};"></div>
                                            <div class="inner-box">
                                                <i class="bi bi-check2"></i>
                                            </div>
                                        </div>
                                        <div class="inner-favorite">
                                            <i class="bi bi-heart"></i>
                                        </div>
                                    </div>
                                    <h3 class="inner-title">
                                        <a href="/detail.html?id=${product.productId}">${product.productName}</a>
                                    </h3>
                                    <div class="price-product">
                                        <div class="inner-price">
                                            <div class="inner-price-new">${product.productPrice * 0.5}đ</div>
                                            <div class="inner-price-old">${product.productPrice}đ</div>
                                        </div>
                                        <div class="inner-bag dropdown">
                                            <a href="#" role="button" data-bs-toggle="dropdown"
                                               aria-expanded="false" data-bs-offset="0, 20">
                                                <i class="bi bi-bag"></i>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <c:forTokens items="${product.productSize}" delims="," var="size">
                                                    <li><a class="dropdown-item" href="#">${size}</a></li>
                                                </c:forTokens>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <nav class="pagination">
                        <ul>
                            <!-- Trang trước -->
                            <li>
                                <a href="<c:url value='/all-product?page=${currentPage > 1 ? currentPage - 1 : 1}'/>">
                                    <i class="fa-solid fa-angles-left"></i>
                                </a>
                            </li>
                            <!-- Các số trang -->
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <li>
                                    <a href="<c:url value='/all-product?page=${pageNum}'/>"
                                       class="${pageNum == currentPage ? 'active' : ''}">
                                        ${pageNum}
                                    </a>
                                </li>
                            </c:forEach>
                            <!-- Trang sau -->
                            <li>
                                <a href="<c:url value='/all-product?page=${currentPage < totalPages ? currentPage + 1 : totalPages}'/>">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </li>
                            <!-- Trang cuối -->
                            <li>
                                <a href="<c:url value='/all-product?page=${totalPages}'/>">Trang cuối</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- End Section 4 -->
</body>
</html>