<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang thêm sản phẩm | IVY moda</title>
</head>
<body>
<main id="main" class="main">
    <div class="pagetitle">
      <h1>Thêm sản phẩm mới</h1>
    </div>
    <div class="card">
      <div class="card-body">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        <form id="addProductForm" action="${pageContext.request.contextPath}/admin/admin-add-product" method="post" enctype="multipart/form-data">
          <div class="row mt-4 mb-4">
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productName" class="form-label" style="width: 150px;">Tên sản phẩm</label>
              <input type="text" class="form-control" id="productName" name="productName" value="${productName}" placeholder="Golden Hour Skirt - Chân váy maxi vàng hoa" style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productName">${errorProductName}</div>
            </div>
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productCode" class="form-label" style="width: 150px;">Mã sản phẩm</label>
              <input type="text" class="form-control" id="productCode" name="productCode" value="${productCode}" placeholder="31B0156"style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productCode">${errorProductCode}</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productPrice" class="form-label" style="width: 150px;">Giá</label>
              <input type="number" step="0.01" class="form-control" id="productPrice" name="productPrice" value="${productPrice}" style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productPrice">${errorProductPrice}</div>
            </div>
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productCategory" class="form-label" style="width: 150px;">Danh mục</label>
              <select class="form-select" id="productCategory" name="productCategory" style="margin-left: 40px;">
                <option value="">Chọn danh mục</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category}" <c:if test="${category == productCategory}">selected</c:if>>${category}</option>
                </c:forEach>
              </select>
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productCategory">${errorProductCategory}</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productSize" class="form-label" style="width: 150px;">Kích cỡ</label>
              <input type="text" class="form-control" id="productSize" name="productSize" value="${productSize}" placeholder="S,M,L" style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productSize">${errorProductSize}</div>
            </div>
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productColor" class="form-label" style="width: 150px;">Màu sắc</label>
              <input type="text" class="form-control" id="productColor" name="productColor" value="${productColor}" placeholder="Vàng, Trắng" style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productColor">${errorProductColor}</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productQuantity" class="form-label" style="width: 150px;">Số lượng</label>
              <input type="number" class="form-control" id="productQuantity" name="productQuantity" value="${productQuantity}" style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productQuantity">${errorProductQuantity}</div>
            </div>
            <div class="col-md-6 d-flex align-items-center position-relative mb-3">
              <label for="productImage" class="form-label" style="width: 150px;">Ảnh sản phẩm</label>
              <input class="form-control" type="file" id="productImage" name="productImage" multiple style="margin-left: 40px;">
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productImage">${errorProductImage}</div>
            </div>
          </div>
          
          <div class="row mb-3 position-relative">
            <label for="productDescription" class="col-md-4 col-lg-3 col-form-label" style="width: 150px;">Mô tả sản phẩm</label>
            <div class="col-md-8 col-lg-9" style="width: 1059px;">
              <textarea class="tinymce-editor" id="productDescription" name="productDescription">${productDescription}</textarea>
              <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productDescription">${errorProductDescription}</div>
            </div>
          </div>
          <div class="d-flex justify-content-between mt-4">
            <a href="admin-manage-product" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách
            </a>
            <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
          </div>
        </form>
      </div>
    </div>
  </main>
</body>
</html>