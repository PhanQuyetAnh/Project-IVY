<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-cart-page" style="padding: 40px 0;">
    <div class="container">
        <h2 style="font-size: 24px; font-weight: 600; margin-bottom: 30px;">
            Giỏ hàng của bạn <span style="color: #dc3545;">${fn:length(sessionScope.cart)} Sản Phẩm</span>
        </h2>

        <div class="row">
            <div class="col-lg-8">
                <div class="cart-large-list" style="background: #fff; padding: 20px; border-radius: 8px;">

                    <c:forEach var="item" items="${sessionScope.cart}">
                        <div class="cart-item" style="display: flex; align-items: center; border-bottom: 1px solid #eee; padding: 20px 0; gap: 20px;">

                            <img src="<c:url value='${item.product.productImage}'/>" class="item-image" style="width: 120px; height: 160px;">

                            <div class="item-info" style="flex: 2;">
                                <h3 class="item-name" style="font-size: 16px;">${item.product.productName}</h3>
                                <p class="item-detail" style="margin-top: 10px;">Màu sắc: ${item.color} | Size: ${item.size}</p>
                            </div>

                            <div class="item-quantity-control" style="flex: 1; justify-content: center;">
                                <button class="btn-qty-down" data-product-id="${item.product.id}" data-product-size="${item.size}">-</button>
                                <div class="qty-display">${item.quantity}</div>
                                <button class="btn-qty-up" data-product-id="${item.product.id}" data-product-size="${item.size}">+</button>
                            </div>

                            <div style="flex: 1; text-align: right;">
                                <b class="item-price" style="font-size: 16px; color: #333;">${item.product.productPrice}đ</b>
                                <button class="btn-remove-item" data-product-id="${item.product.id}" data-product-size="${item.size}" style="margin-top: 15px; display: block; width: 100%; text-align: right;">
                                    <i class="fa-regular fa-trash-can" style="font-size: 18px;"></i>
                                </button>
                            </div>

                        </div>
                    </c:forEach>

                </div>
            </div>

            <div class="col-lg-4">
                <div class="cart-summary-box" style="background: #f9f9f9; padding: 25px; border-radius: 8px;">
                    <h3 style="font-size: 18px; font-weight: 700; margin-bottom: 20px;">Tổng tiền giỏ hàng</h3>

                    <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                        <span>Tổng sản phẩm</span>
                        <span>${fn:length(sessionScope.cart)}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                        <span>Tổng tiền hàng</span>
                        <span>${totalMoney}đ</span>
                    </div>

                    <hr style="border-top: 1px dashed #ccc; margin: 20px 0;">

                    <div style="display: flex; justify-content: space-between; margin-bottom: 20px; font-size: 18px;">
                        <b>Tạm tính</b>
                        <b style="color: #dc3545;">${totalMoney}đ</b>
                    </div>

                    <p style="font-size: 13px; color: #dc3545; margin-bottom: 20px;">
                        <i class="fa-solid fa-circle-info"></i> Giao hàng miễn phí cho đơn từ 500k!
                    </p>

                    <a href="${pageContext.request.contextPath}/customer/checkout" class="btn btn-dark w-100" style="padding: 15px; font-weight: bold; border-radius: 0;">
                        TIẾN HÀNH ĐẶT HÀNG
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>