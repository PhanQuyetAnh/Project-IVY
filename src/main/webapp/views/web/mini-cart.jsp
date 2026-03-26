<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="miniCartSidebar" class="mini-cart-sidebar">
  <div class="mini-cart-header">
    <h2>Giỏ hàng</h2>
    <button id="miniCartClose" class="mini-cart-close" title="Đóng giỏ hàng">
      <i class="fa-solid fa-xmark"></i>
    </button>
  </div>

  <div class="mini-cart-content">
    <%-- SỬA: Đưa ID miniCartItems ra ngoài vòng c:choose để AJAX luôn tìm thấy vùng này để update --%>
    <div id="miniCartItems">
      <c:choose>
        <c:when test="${empty sessionScope.cart}">
          <ul class="mini-cart-list">
            <li class="mini-cart-empty">Giỏ hàng trống</li>
          </ul>
        </c:when>
        <c:otherwise>
          <ul class="mini-cart-list">
            <c:forEach var="item" items="${sessionScope.cart}">
              <c:if test="${not empty item.productObject}">
                <c:set var="p" value="${item.productObject}" />
                <li class="cart-item">
                  <div class="item-image-wrapper">
                    <img src="<c:url value='${p.productImage}'/>" alt="${p.productName}" class="item-image" />
                  </div>
                  <div class="item-info">
                    <p class="item-name">${p.productName}</p>
                    <p class="item-detail">
                      <span>Màu: ${p.productColor}</span> | <span>Size: ${item.productSize}</span>
                    </p>
                    <div class="item-quantity-control">
                      <button class="btn-qty-down" data-product-id="${p.productId}" data-product-size="${item.productSize}">−</button>
                      <span class="qty-display">${item.quantity}</span>
                      <button class="btn-qty-up" data-product-id="${p.productId}" data-product-size="${item.productSize}">+</button>
                    </div>
                    <p class="item-price">
                      <span class="total-price">
                        <fmt:formatNumber value="${p.productPrice * item.quantity}" pattern="###,###"/>đ
                      </span>
                    </p>
                  </div>
                  <button class="btn-remove-item" data-product-id="${p.productId}" data-product-size="${item.productSize}">
                    <i class="fa-solid fa-trash"></i>
                  </button>
                </li>
              </c:if>
            </c:forEach>
          </ul>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="mini-cart-footer">
    <%-- SỬA: Thêm ID miniCartTotalWrapper bao quanh để khi load lại không bị mất định dạng hoặc mất số tiền --%>
    <div class="mini-cart-total" id="miniCartTotalWrapper">
      <span>Tổng cộng:</span>
      <b id="miniCartTotal">
        <c:set var="sum" value="0" />
        <c:forEach var="item" items="${sessionScope.cart}">
          <c:if test="${not empty item.productObject}">
            <c:set var="sum" value="${sum + (item.productObject.productPrice * item.quantity)}" />
          </c:if>
        </c:forEach>
        <fmt:formatNumber value="${sum}" pattern="###,###"/>đ
      </b>
    </div>
    <a href="${pageContext.request.contextPath}/customer/cart" class="mini-cart-button">Xem giỏ hàng</a>
  </div>
</div>
<div id="miniCartOverlay" class="mini-cart-overlay"></div>