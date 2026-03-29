<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ | IVY moda</title>
</head>
<body>

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
<div class="section-4">
    <div class="container">
        <div class="inner-wrap">
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
                        <%-- Cập nhật đúng đường dẫn xem chi tiết sản phẩm --%>
                        <c:url value="/public/product-detail" var="detailUrl">
                            <c:param name="id" value="${product.productId}" />
                        </c:url>
                        <c:url value="${product.productImage}" var="imgUrl" />

                        <div class="product-item">
                            <div class="inner-tag tag-uppercase">New</div>
                            <div class="inner-image">
                                <a href="${detailUrl}">
                                    <img src="${imgUrl}" alt="${product.productName}">
                                    <img src="${imgUrl}" alt="${product.productName}" class="hover-img">
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
                                    <a href="${detailUrl}">${product.productName}</a>
                                </h3>
                                <div class="price-product">
                                    <div class="inner-price">
                                        <div class="inner-price-new">
                                            <fmt:formatNumber value="${product.productPrice * 0.5}" pattern="###,###"/>đ
                                        </div>
                                        <div class="inner-price-old">
                                            <fmt:formatNumber value="${product.productPrice}" pattern="###,###"/>đ
                                        </div>
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
                        <li>
                            <c:url value="/public/all-product" var="prevUrl">
                                <c:param name="page" value="${currentPage > 1 ? currentPage - 1 : 1}" />
                            </c:url>
                            <a href="${prevUrl}">
                                <i class="fa-solid fa-angles-left"></i>
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <li>
                                <c:url value="/public/all-product" var="pageUrl">
                                    <c:param name="page" value="${pageNum}" />
                                </c:url>
                                <a href="${pageUrl}" class="${pageNum == currentPage ? 'active' : ''}">
                                        ${pageNum}
                                </a>
                            </li>
                        </c:forEach>

                        <li>
                            <c:url value="/public/all-product" var="nextUrl">
                                <c:param name="page" value="${currentPage < totalPages ? currentPage + 1 : totalPages}" />
                            </c:url>
                            <a href="${nextUrl}">
                                <i class="fa-solid fa-angles-right"></i>
                            </a>
                        </li>

                        <li>
                            <c:url value="/public/all-product" var="lastUrl">
                                <c:param name="page" value="${totalPages}" />
                            </c:url>
                            <a href="${lastUrl}">Trang cuối</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
</body>
</html>