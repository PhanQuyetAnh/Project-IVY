<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chỉnh sửa đơn hàng | IVY moda</title>
</head>

<body>
<main id="main" class="main">
    <section class="section dashboard">
      <div class="row">
        <div class="col-12">
          <h1 class="box-title">Đơn hàng: DH#${order.orderId}</h1>
          <c:if test="${param.status == 'success'}">
            <div class="alert alert-success">Cập nhật đơn hàng thành công!</div>
          </c:if>
        </div>
        <div class="col-12">
          <div class="section-8">
          <form action="/jsp-servlet/admin/admin-update-order" method="post" class="form-order-edit">
            <input type="text" name="userId" value="${order.userObject.userId}" hidden class="inner-name"/>
            <input type="text" name="orderId" value="${order.orderId}" hidden class="inner-name"/>

            <div class="inner-group">
              <label class="inner-label" for="name">Tên khách hàng</label>
              <input type="text" id="name" name="name" value="${order.userObject.fullname}" class="inner-name"/>
              <div class="message message-name"></div>
            </div>
            <div class="inner-group">
              <label class="inner-label" for="phone">Số điện thoại</label>
              <input type="text" id="phone" name="phone" value="${order.userObject.phoneNumber}" class="inner-phone"/>
              <div class="message message-phone"></div>
            </div>
            <div class="inner-group inner-two-col">
              <label class="inner-label" for="note">Địa chỉ</label>
              <input type="text" id="address" name="address" value="${order.userObject.address}" class="inner-address"/>
            </div>
            <div class="inner-group">
              <label class="inner-label" for="paymentMethod">Phương thức thanh toán</label>
              <c:choose>
                <c:when test="${order.paymentMethod == 'COD'}">
                  <input type="text" id="paymentMethod" name="paymentMethod" value="Tiền mặt" readonly/>
                </c:when>
                <c:when test="${order.paymentMethod == 'credit_card'}">
                  <input type="text" id="paymentMethod" name="paymentMethod" value="Thẻ tín dụng" readonly/>
                </c:when>
                <c:when test="${order.paymentMethod == 'BANK'}">
                  <input type="text" id="paymentMethod" name="paymentMethod" value="Chuyển khoản" readonly/>
                </c:when>
              </c:choose>

            </div>
            <div class="inner-group">
              <label class="inner-label" for="statusPay">Trạng thái thanh toán</label>
              <select name="paymentStatus" id="statusPay">
                <option ${order.paymentStatus == 'paid' ? 'selected="selected"' : ''} value="paid">Đã thanh toán</option>
                <option ${order.paymentStatus == 'unpaid' ? 'selected="selected"' : ''} value="unpaid">Chưa thanh toán</option>
              </select>
            </div>
            <div class="inner-group">
              <label class="inner-label" for="createAt">Ngày đặt</label>
              <input type="datetime-local" id="createAt" name="createAt" value="${order.orderDate}" readonly="readonly" />
            </div>
            <div class="inner-group">
              <label class="inner-label" for="status">Trạng thái</label>
              <select name="orderStatus" id="status">
                <option ${order.orderStatus == 'pending' ? 'selected="selected"' : ''} value="pending">Khởi tạo</option>
                <option ${order.orderStatus == 'shipping' ? 'selected="selected"' : ''} value="shipping">Đang giao</option>
                <option ${order.orderStatus == 'success' ? 'selected="selected"' : ''} value="success">Thành công</option>
                <option ${order.orderStatus == 'canceled' ? 'selected="selected"' : ''} value="canceled">Đã hủy</option>
              </select>
            </div>
            <div class="inner-group">
              <label class="inner-label">Danh sách đơn hàng</label>
              <div class="inner-order-list">
                <c:forEach var="orderItem" items="${order.orderDetailList}">
                  <div class="inner-order-item">
                    <div class="inner-order-image"> <img src="/jsp-servlet/${orderItem.productObject.productImage}" /></div>
                    <div class="inner-order-content">
                      <div class="inner-order-name">${orderItem.productObject.productName}</div>
                      <div class="inner-order-text">Màu sắc: ${orderItem.productColor}</div>
                      <div class="inner-order-text">Size: ${orderItem.productSize}</div>
                      <div class="inner-order-text">Số lượng:
                        <fmt:formatNumber value="${orderItem.quantitySold}"
                                          type="number" groupingUsed="true" />
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>
            <div class="inner-group">
              <label class="inner-label">Thanh toán</label>
              <div class="inner-order-total">
                <div>Tổng tiền:  <fmt:formatNumber value="${order.totalAmount}"
                                                   type="number" groupingUsed="true" />đ
                </div>
              </div>
            </div>
            <div class="inner-button inner-two-col">
              <button type="submit" class="btn-update">Cập nhật</button>
            </div>
          </form>
          <div class="inner-back"> <a href="admin-order-list">Quay lại danh sách</a></div>
        </div>
        </div>
      </div>
    </section>
  </main>

</body>
</html>