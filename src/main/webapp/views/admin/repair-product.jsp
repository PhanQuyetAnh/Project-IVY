<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm | IVY moda</title>
</head>
<body>
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Chỉnh sửa sản phẩm</h1>
        </div>
        <div class="card">
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <form id="editProductForm" action="${pageContext.request.contextPath}/admin/admin-repair-product" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <input type="hidden" name="productImagePath" value="${product.productImage}">
                    <!-- Hàng 1 -->
                    <div class="row mt-4 mb-4">
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productName" class="form-label" style="width: 150px;">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productName"></div>
                        </div>
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productCode" class="form-label" style="width: 150px;">Mã sản phẩm</label>
                            <input type="text" class="form-control" id="productCode" name="productCode" value="${product.productCode}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 130px;" id="error-productCode"></div>
                        </div>
                    </div>
                    <!-- Hàng 2 -->
                    <div class="row mb-3">
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productPrice" class="form-label" style="width: 150px;">Giá</label>
                            <input type="number" step="0.01" class="form-control" id="productPrice" name="productPrice" value="${product.productPrice}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productPrice"></div>
                        </div>
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productCategory" class="form-label" style="width: 150px;">Danh mục</label>
                            <select class="form-select" id="productCategory" name="productCategory" style="margin-left: 40px;">
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category}" <c:if test="${category == product.productCategory}">selected</c:if>>${category}</option>
                                </c:forEach>
                            </select>
                            <div class="text-danger small position-absolute" style="top: 100%; left: 130px;" id="error-productCategory"></div>
                        </div>
                    </div>
                    <!-- Hàng 3 -->
                    <div class="row mb-3">
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productSize" class="form-label" style="width: 150px;">Kích cỡ</label>
                            <input type="text" class="form-control" id="productSize" name="productSize" value="${product.productSize}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productSize"></div>
                        </div>
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productColor" class="form-label" style="width: 150px;">Màu sắc</label>
                            <input type="text" class="form-control" id="productColor" name="productColor" value="${product.productColor}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 130px;" id="error-productColor"></div>
                        </div>
                    </div>
                    <!-- Hàng 4 -->
                    <div class="row mb-3">
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productQuantity" class="form-label" style="width: 150px;">Số lượng</label>
                            <input type="number" class="form-control" id="productQuantity" name="productQuantity" value="${product.productQuantity}" style="margin-left: 40px;">
                            <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productQuantity"></div>
                        </div>
                    </div>
                    <!-- Hàng 5 -->
                    <div class="row mb-3">
                        <div class="col-md-6 d-flex align-items-center position-relative mb-3">
                            <label for="productImage" class="form-label" style="width: 220px;">Ảnh sản phẩm</label>
                            <input class="form-control" type="file" id="productImage" name="productImage" accept="image/*" style="margin-left: 40px;">
                            <c:if test="${not empty product.productImage}">
                                <img src="${pageContext.request.contextPath}${product.productImage}" alt="Product Image" style="max-width: 100px; margin-top: 10px; margin-left: 20px;">
                            </c:if>
                            <div class="text-danger small position-absolute" style="top: 100%; left: 162px;" id="error-productImage"></div>
                        </div>
                    </div>
                    <!-- Hàng mô tả -->
                    <div class="row mb-3">
                        <label for="productDescription" class="col-md-4 col-lg-3 col-form-label" style="width: 150px;">Mô tả sản phẩm</label>
                        <div class="col-md-8 col-lg-9 position-relative mb-3" style="width: 1059px;">
                            <textarea class="tinymce-editor" id="productDescription" name="productDescription">${product.productDescription}</textarea>
                            <div class="text-danger small position-absolute" style="top: 100%; left: 130px;" id="error-productDescription"></div>
                        </div>
                    </div>
                    <!-- Nút cập nhật -->
                    <div class="d-flex justify-content-between">
                        <a href="admin-manage-product" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách
                        </a>
                        <button type="submit" class="btn btn-success btn-update-product">Cập nhật sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>