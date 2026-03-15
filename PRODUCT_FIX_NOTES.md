# Sửa lỗi Trang Chi Tiết Sản Phẩm - Design 4 Ảnh Riêng Biệt

## 📋 Tóm tắt thay đổi

Đã cập nhật hệ thống để hỗ trợ **4 ảnh sản phẩm riêng biệt** thay vì sử dụng bảng `ProductImage` phức tạp.

---

## ✅ Những file đã được sửa

### 1. **ProductObject.java** - Model
- Thêm 4 field ảnh mới:
  - `productImage1` - Ảnh chính (slide 1)
  - `productImage2` - Ảnh thứ 2
  - `productImage3` - Ảnh thứ 3
  - `productImage4` - Ảnh thứ 4
- Giữ lại `productImage` để backward compatibility

### 2. **ProductImpl.java** - DAO Implementation
#### Các thay đổi chính:
- **Xóa method**: `getProductImages()` - không cần sử dụng bảng ProductImage nữa
- **Cập nhật method**:
  - `getAllProducts()` - lấy 4 ảnh từ các column mới
  - `getProductById()` - lấy chi tiết sản phẩm + tạo danh sách ảnh từ 4 column
  - `insertProduct()` - thêm 4 tham số ảnh vào INSERT
  - `updateProduct()` - cập nhật 4 ảnh trong UPDATE
  - `getDeletedProducts()` - lấy 4 ảnh cho sản phẩm đã xóa

#### SQL Query updates:
```sql
-- INSERT thêm 4 column ảnh
INSERT INTO Product (product_code, product_name, product_image1, product_image2, 
                     product_image3, product_image4, ...)

-- UPDATE hỗ trợ 4 ảnh
UPDATE Product SET product_image1=?, product_image2=?, product_image3=?, product_image4=?, ...

-- SELECT tất cả đã sử dụng 4 column mới
SELECT * FROM Product WHERE ...
```

### 3. **product-detail.jsp** - View (Giao diện)
#### Gallery Main (Ảnh chính):
```jsp
<c:if test="${not empty product.productImage1}">
    <div class="swiper-slide">
        <img src="<c:url value='${product.productImage1}'/>" alt="${product.productName}">
    </div>
</c:if>
<!-- Tương tự cho image2, image3, image4 -->
```

#### Gallery Thumbnails (Ảnh nhỏ):
```jsp
<c:if test="${not empty product.productImage1}">
    <img src="<c:url value='${product.productImage1}'/>"
         class="thumbnail-image active"
         onclick="goToSlide(0)">
</c:if>
<!-- Tương tự cho 3 ảnh còn lại -->
```

---

## 🗄️ Cập nhật Database

### Chạy SQL script để cập nhật bảng:
```bash
File: UPDATE_PRODUCT_TABLE.sql

Nội dung:
1. Thêm 4 column mới vào bảng Product
2. Copy dữ liệu từ product_image cũ sang product_image1
3. Insert sample data Quần baggy phối đai
```

### Chạy lệnh:
```sql
-- Chạy file UPDATE_PRODUCT_TABLE.sql trên database
-- Hoặc chạy từng câu SQL:

ALTER TABLE Product 
ADD COLUMN product_image1 VARCHAR(255) NULL,
ADD COLUMN product_image2 VARCHAR(255) NULL,
ADD COLUMN product_image3 VARCHAR(255) NULL,
ADD COLUMN product_image4 VARCHAR(255) NULL;

UPDATE Product 
SET product_image1 = product_image 
WHERE product_image IS NOT NULL AND product_image1 IS NULL;
```

---

## 🎨 Design Layout Trang Chi Tiết

```
┌────────────────────────────────────────────────┐
│         Trang Chi Tiết Sản Phẩm               │
└────────────────────────────────────────────────┘

┌─────────────────────────┬──────────────────────┐
│   NỬA TRÁI (ẢNH)       │  NỬA PHẢI (THÔNG TIN)│
│                         │                      │
│  ┌─────────────────┐   │  Tên sản phẩm        │
│  │                 │   │  SKU: 4BM9333       │
│  │  Ảnh chính      │   │  ⭐⭐⭐⭐⭐ (0 đánh giá)│
│  │  (swiper)       │   │                      │
│  │                 │   │  2.290.000đ          │
│  ├─────────────────┤   │                      │
│  │ [1] [2] [3] [4]│   │  Màu sắc: Trắng ngà  │
│  │  Thumbnails    │   │  Size: S M L XL XXL  │
│  │  (4 ảnh nhỏ)   │   │                      │
│  └─────────────────┘   │  Số lượng: [- 1 +]  │
│                         │                      │
│                         │  [THÊM VÀO GIỎ]     │
│                         │  [❤ LƯU]            │
│                         │                      │
│                         │  ─────────────────── │
│                         │  Giới thiệu sản phẩm │
│                         │  Chi tiết sản phẩm   │
│                         │  Bảo quản            │
└─────────────────────────┴──────────────────────┘
```

---

## ✨ Tính năng

### Gallery Swiper:
- ✅ Click ảnh nhỏ để chuyển ảnh chính
- ✅ Swipe/Slide để xem ảnh tiếp theo
- ✅ Tối đa 4 ảnh sản phẩm
- ✅ Ảnh thứ nhất là primary (ảnh chính)

### Product Info:
- ✅ Hiển thị tên sản phẩm
- ✅ Hiển thị SKU từ product_code
- ✅ Hiển thị đánh giá sao
- ✅ Hiển thị giá
- ✅ Chọn màu sắc
- ✅ Chọn kích cỡ
- ✅ Chọn số lượng
- ✅ Nút "Thêm vào giỏ"
- ✅ Nút "Lưu sản phẩm" (yêu thích)

---

## 🔧 Thử nghiệm

### Kiểm tra:
1. **Database**: Verify 4 column mới đã được thêm
2. **Product List**: Kiểm tra tất cả sản phẩm hiển thị đúng
3. **Product Detail**: 
   - Ảnh chính hiển thị đúng
   - 4 ảnh nhỏ hiển thị đúng
   - Click thumbnail chuyển ảnh chính
   - Swiper có thể drag/swipe
4. **Add to Cart**: Kiểm tra functionality vẫn hoạt động

---

## 📝 Ghi chú

- Bảng `ProductImage` có thể được xóa nếu không cần backward compatibility
- Hoặc giữ nguyên để tránh ảnh hưởng đến code cũ
- File: `ProductImpl.java` không sử dụng bảng ProductImage nữa
- `productImages` field trong ProductObject vẫn được populate từ 4 column mới

---

## 📦 File thay đổi

1. ✅ `src/main/java/model/ProductObject.java` - Thêm 4 field ảnh
2. ✅ `src/main/java/dao/Impl/ProductImpl.java` - Cập nhật DAO queries
3. ✅ `src/main/webapp/views/web/product-detail.jsp` - Cập nhật gallery view
4. ✅ `UPDATE_PRODUCT_TABLE.sql` - Script cập nhật database
5. ✅ `PRODUCT_FIX_NOTES.md` - File này

---

**Status**: ✅ Hoàn thành - Sẵn sàng triển khai

