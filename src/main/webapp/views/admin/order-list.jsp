<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang quản lý đơn hàng | IVY moda</title>
</head>
<body>
<main id="main" class="main">
    <div class="pagetitle d-flex align-items-center justify-content-between">
      <h1>Quản lý đơn hàng</h1>
      <nav>
        <ol class="breadcrumb mb-0">
          <li class="breadcrumb-item">
            <a href="index.html"><i class="bi bi-bag"></i></a>
          </li>
          <li class="breadcrumb-item active">Quản lý đơn hàng</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">
        <div class="section-4">
          <form action="/jsp-servlet/admin/admin-order-list" method="get">
            <div class="inner-wrap">
              <div class="inner-item inner-label"><i class="fa-solid fa-filter"></i> Bộ lọc</div>
              <div class="inner-item">
                <select name="orderStatus">
                  <option value="">Trạng thái </option>
                  <option ${orderStatus == 'pending' ? 'selected="selected"' : ''} value="pending">Khởi tạo</option>
                  <option ${orderStatus == 'shipping' ? 'selected="selected"' : ''} value="shipping">Đang giao</option>
                  <option ${orderStatus == 'success' ? 'selected="selected"' : ''} value="success">Thành công</option>
                  <option ${orderStatus == 'canceled' ? 'selected="selected"' : ''} value="canceled">Đã hủy</option>
                </select>
              </div>
              <div class="inner-item">
                <select name="paymentMethod">
                  <option value="">Phương thức thanh toán</option>
                  <option ${paymentMethod == 'COD' ? 'selected="selected"' : ''} value="COD">Tiền mặt</option>
                  <option ${paymentMethod == 'BANK' ? 'selected="selected"' : ''} value="BANK">Chuyển khoản</option>
                  <option ${paymentMethod == 'credit_card' ? 'selected="selected"' : ''} value="credit_card">Thẻ tín dụng</option>
                </select>
              </div>
              <div class="inner-item">
                <select name="paymentStatus">
                  <option value="">Trạng thái thanh toán</option>
                  <option ${paymentStatus == 'unpaid' ? 'selected="selected"' : ''} value="unpaid">Chưa thanh toán</option>
                  <option ${paymentStatus == 'paid' ? 'selected="selected"' : ''} value="paid">Đã thanh toán</option>
                </select>
              </div>
              <button type="submit" class="inner-item inner-reset">Áp dụng</button>
            </div>
          </form>
        </div>
      </div>
      <div class="row">
        <div class="section-6">
          <div class="table-2">
            <table>
              <thead>
                <tr>
                  <th>Mã</th>
                  <th>Thông tin khách</th>
                  <th>Danh sách đơn hàng</th>
                  <th>Thanh toán</th>
                  <th>Trạng thái</th>
                  <th>Ngày đặt</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="order" items="${orders}">
                  <tr>
                    <td>
                      <div class="inner-code">DH#${order.orderId}</div>
                    </td>
                    <td>
                      <div>Họ tên: ${order.userObject.fullname}</div>
                      <div>SĐT: ${order.userObject.phoneNumber}</div>
                      <div>Địa chỉ: ${order.userObject.address}</div>
                    </td>
                    <td>
                      <div class="inner-list">
                        <c:forEach var="orderItem" items="${order.orderDetailList}">
                          <div class="inner-item">
                            <div class="inner-image"> <img src="<c:url value='${orderItem.productObject.productImage}'/>" /></div>
                            <div class="inner-content">
                              <div class="inner-name">${orderItem.productObject.productName}</div>
                              <div class="inner-quantity">
                                <div>Màu sắc: ${orderItem.productColor}</div>
                                <div>Size: ${orderItem.productSize}</div>
                                <div>Số lượng:
                                  <fmt:formatNumber value="${orderItem.quantitySold}"
                                                    type="number" groupingUsed="true" />
                                </div>
                                <div>Giá:
                                  <fmt:formatNumber value="${orderItem.price}"
                                                    type="number" groupingUsed="true" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </c:forEach>
                      </div>
                    </td>
                    <td>
                      <div>Tổng tiền:
                        <fmt:formatNumber value="${order.totalAmount}"
                                          type="number" groupingUsed="true" />đ
                      </div>
                      <div>PTTT:
                        <c:choose>
                          <c:when test="${order.paymentMethod == 'credit_card'}">Thẻ tín dụng</c:when>
                          <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng</c:when>
                          <c:when test="${order.paymentMethod == 'BANK'}">Chuyển khoản ngân hàng</c:when>
                        </c:choose>
                      </div>
                      <div>TTTT:
                        <c:choose>
                          <c:when test="${order.paymentStatus == 'unpaid'}">Chưa thanh toán</c:when>
                          <c:when test="${order.paymentStatus == 'paid'}">Đã thanh toán</c:when>
                        </c:choose>
                      </div>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${order.orderStatus == 'pending'}">
                          <div class="badge badge-orange">Khởi tạo</div>
                        </c:when>
                        <c:when test="${order.orderStatus == 'shipping'}">
                          <div class="badge badge-orange">Đang vận chuyển</div>
                        </c:when>
                        <c:when test="${order.orderStatus == 'success'}">
                          <div class="badge badge-green">Thành công</div>
                        </c:when>
                        <c:when test="${order.orderStatus == 'canceled'}">
                          <div class="badge badge-red">Đã hủy</div>
                        </c:when>
                      </c:choose>

                    </td>
                    <td>
                      <div>${order.orderDate}</div>
                    </td>
                    <td>
                      <div class="inner-buttons"><a class="inner-edit"
                          href="/jsp-servlet/admin/admin-order-edit?orderId=${order.orderId}">
                        <i class="fa-solid fa-pen-to-square"></i></a>
                        <a class="inner-remove"  href="#" data-order-id="${order.orderId}"><i class="fa-solid fa-trash-can"></i></a></div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="row">
        <nav aria-label="Page navigation example">
          <ul class="pagination justify-content-end">

            <!-- Nút Previous -->
            <c:if test="${pageNo gt 1}">
              <li class="page-item">
                <a class="page-link"
                   href="/jsp-servlet/admin/admin-order-list?pageNo=${pageNo - 1}&orderStatus=${orderStatus}&paymentStatus=${paymentStatus}&paymentMethod=${paymentMethod}"
                   aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
            </c:if>

            <!-- Trang đầu -->
            <c:if test="${pageNo ne 1}">
              <li class="page-item"><a class="page-link"
                 href="/jsp-servlet/admin/admin-order-list?pageNo=1&orderStatus=${orderStatus}&paymentStatus=${paymentStatus}&paymentMethod=${paymentMethod}">1</a></li>
            </c:if>

            <!-- Dấu ... nếu cách xa trang đầu -->
            <c:if test="${pageNo gt 2}">
              <li class="page-item disabled"><a class="page-link">...</a></li>
            </c:if>

            <!-- Trang hiện tại -->
            <li class="page-item active"><a class="page-link" href="#">${pageNo}</a></li>

            <!-- Dấu ... nếu cách xa trang cuối -->
            <c:if test="${pageNo lt pageNumber - 1}">
              <li class="page-item disabled"><a class="page-link">...</a></li>
            </c:if>

            <!-- Trang cuối -->
            <c:if test="${pageNo ne pageNumber}">
              <li class="page-item"><a class="page-link"
                 href="/jsp-servlet/admin/admin-order-list?pageNo=${pageNumber}&orderStatus=${orderStatus}&paymentStatus=${paymentStatus}&paymentMethod=${paymentMethod}">${pageNumber}</a></li>
            </c:if>

            <!-- Nút Next -->
            <c:if test="${pageNo lt pageNumber}">
              <li class="page-item">
                <a class="page-link"
                   href="/jsp-servlet/admin/admin-order-list?pageNo=${pageNo + 1}&orderStatus=${orderStatus}&paymentStatus=${paymentStatus}&paymentMethod=${paymentMethod}" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </c:if>

          </ul>
        </nav>

      </div>
    </section>
  </main>
<script src="<c:url value='/templates/admin/js/order.js'/>"></script>
</body>
</html>