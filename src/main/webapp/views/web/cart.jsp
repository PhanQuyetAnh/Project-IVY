<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>
</head>
<body>
<div class="cart-detail">
    <div class="container">
        <div class="row">
            <div class="col-xl-8">
                <div class="checkout-process-bar">
                    <div class="inner-line"></div>
                    <ul>
                        <li>
                            <div class="inner-dot active"></div> <span>Giỏ hàng</span>
                        </li>
                        <li>
                            <div class="inner-dot"></div> <span>Đặt hàng</span>
                        </li>
                        <li>
                            <div class="inner-dot"></div> <span>Thanh toán</span>
                        </li>
                        <li>
                            <div class="inner-dot"></div> <span>Hoàn thành đơn</span>
                        </li>
                    </ul>
                </div>
                <div class="box-list-product">
                    <form action="/jsp-servlet/customer/update-cart" method="post">
                        <h3 class="inner-title">
                            Giỏ hàng của bạn <span>${totalQuantity} Sản Phẩm</span>
                        </h3>
                        <div class="cart-table mt-4">
                            <table class="table table-striper">
                                <thead>
                                <tr>
                                    <th>Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Tổng tiền</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach var="item" items="${cartItems}" varStatus="status">
                                    <tr>
                                        <input type="hidden" name="productId" value="${item.productObject.productId}">
                                        <input type="hidden" name="size" value="${item.productSize}">
                                        <td><img src="${pageContext.request.contextPath}${item.productObject.productImage}"></td>
                                        <td>
                                            <div class="width-table">
                                                <div>${item.productObject.productName}</div>
                                                <div class="fontsize-14">
                                                    Màu sắc: ${item.productObject.productColor}
                                                    <div>Size: ${item.productSize}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="quantity">
                                                <button class="section-5-down">-</button>
                                                <input type="number" min="0" name="quantity" value="${item.quantity}">
                                                <button class="section-5-up">+</button>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${item.productObject.productPrice * item.quantity}"
                                                              type="number" groupingUsed="true" />đ
                                        </td>
                                        <td><a href="/jsp-servlet/customer/cart-delete-item?productId=${item.productObject.productId}&size=${item.productSize}">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
<%--                        <div class="inner-button" style="text-align: right">--%>
<%--                            <button type="submit" class="button-outline button-main" style="width: 150px">Cập nhật</button>--%>
<%--                        </div>--%>
                    </form>


                </div>
            </div>
            <div class="col-xl-4">
                <div class="inner-position">
                    <div class="cart-summary">
                        <h3 class="cart-summary-title">Tổng tiền giỏ hàng</h3>
                        <div class="cart-summary-item">
                            <p>Tổng sản phẩm</p>
                            <div>${totalQuantity}</div>
                        </div>
                        <div class="cart-summary-item">
                            <p>Tổng tiền hàng</p>
                            <div>
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />đ
                            </div>
                        </div>
                        <div class="cart-summary-item">
                            <p>Thành tiền</p>
                            <span>
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />đ
                            </span>
                        </div>
                        <div class="cart-summary-item">
                            <p>Tạm tính</p>
                            <span>
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />đ
                            </span>
                        </div>
                        <div class="cart-summary-note">
                            <div class="inner-icon">
                                <i class="bi bi-info-circle"></i>
                            </div>
                            <p>Sản phẩm nằm trong chương trình đồng giá, giảm giá trên
                                50% không hỗ trợ đổi trả</p>
                        </div>
                    </div>
                    <div class="inner-button">
                        <a href="#" class="button-outline button-main">ĐẶT HÀNG</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="inner-button">
                <a href="http://localhost:8080/jsp-servlet/public/trang-chu" class="button-outline"> <i class="bi bi-arrow-left"></i>
                    Tiếp tục mua hàng
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>