-- =====================================================
-- IMPLEMENTATION GUIDE
-- Hướng dẫn triển khai hệ thống 4 ảnh sản phẩm
-- =====================================================

-- BƯỚC 1: Cập nhật cấu trúc bảng Product
-- =======================================================

-- Thêm 4 column ảnh mới vào bảng Product
ALTER TABLE Product
ADD COLUMN product_image1 VARCHAR(255) NULL,
ADD COLUMN product_image2 VARCHAR(255) NULL,
ADD COLUMN product_image3 VARCHAR(255) NULL,
ADD COLUMN product_image4 VARCHAR(255) NULL;

-- BƯỚC 2: Migrate dữ liệu từ column cũ sang column mới
-- =======================================================

-- Nếu bạn đã có dữ liệu trong product_image, copy sang product_image1
UPDATE Product
SET product_image1 = product_image
WHERE product_image IS NOT NULL AND product_image1 IS NULL;

-- BƯỚC 3: Insert dữ liệu sample (Quần baggy phối đai)
-- =======================================================

INSERT INTO Product (
    product_code,
    product_name,
    product_image1,
    product_image2,
    product_image3,
    product_image4,
    product_price,
    product_quantity,
    product_color,
    product_size,
    product_description,
    product_category,
    isDeleted,
    created_at
) VALUES (
    'SKU: 22M7779',
    'Quần baggy phối đai',
    '/templates/admin/img/quanbaggyphoidaikhoi.webp',
    '/templates/admin/img/quanbaggyphoidaikhoi.webp',
    '/templates/admin/img/quanbaggyphoidaikhoi.webp',
    '/templates/admin/img/quanbaggyphoidaikhoi.webp',
    1290000,
    1000,
    'Kẻ Ghi khói',
    'S, M, L, XL, XXL',
    'Quần baggy lửng, cạp cao. Ống quần có đường xếp ly từ cạp xuống. Ống quần rộng. Quần kèm đai, cài bằng dây khóa kéo bên hông. Mang kiểu dáng đơn giản, rộng vừa phải, dễ mặc và dễ phối cùng những kiểu áo khác, giúp người mặc thể hiện được sự chỉnh chu nhưng vẫn thanh lịch và thời trang.',
    'Quần dài',
    FALSE,
    NOW()
);

-- BƯỚC 4: Verify dữ liệu
-- =======================================================

-- Kiểm tra dữ liệu đã được thêm
SELECT id, product_code, product_name, product_image1, product_image2,
       product_image3, product_image4, product_price, product_quantity
FROM Product
WHERE product_code = 'SKU: 22M7779'
LIMIT 1;

-- Kiểm tra tất cả sản phẩm có ảnh
SELECT COUNT(*) as total_products,
       COUNT(product_image1) as with_image1,
       COUNT(product_image2) as with_image2,
       COUNT(product_image3) as with_image3,
       COUNT(product_image4) as with_image4
FROM Product
WHERE isDeleted = FALSE;

-- =====================================================
-- TESTING STEPS
-- =====================================================

/*
1. DATABASE TESTING:
   ✓ Kiểm tra 4 column mới đã được thêm
   ✓ Kiểm tra dữ liệu sample đã được insert
   ✓ Kiểm tra migration từ product_image sang product_image1

2. JAVA TESTING:
   ✓ Compile ProductImpl.java không lỗi
   ✓ Compile ProductObject.java không lỗi
   ✓ Test getAllProducts() - lấy tất cả sản phẩm
   ✓ Test getProductById(id) - lấy chi tiết 1 sản phẩm
   ✓ Test insertProduct() - thêm sản phẩm mới với 4 ảnh
   ✓ Test updateProduct() - cập nhật sản phẩm

3. JSP TESTING:
   ✓ Mở trang chi tiết sản phẩm
   ✓ Kiểm tra ảnh chính hiển thị đúng
   ✓ Kiểm tra 4 ảnh nhỏ hiển thị đúng
   ✓ Click thumbnail để chuyển ảnh chính
   ✓ Swipe/drag ảnh để xem ảnh tiếp theo
   ✓ Kiểm tra responsive trên mobile

4. FEATURE TESTING:
   ✓ Thêm sản phẩm vào giỏ hàng
   ✓ Lưu sản phẩm yêu thích
   ✓ Xem đánh giá sản phẩm
   ✓ Chọn màu sắc, kích cỡ, số lượng
   ✓ Xem mô tả sản phẩm chi tiết
*/

-- =====================================================
-- ROLLBACK PLAN (nếu cần quay lại)
-- =====================================================

/*
-- Nếu muốn xóa 4 column mới (không recommend)
ALTER TABLE Product
DROP COLUMN product_image1,
DROP COLUMN product_image2,
DROP COLUMN product_image3,
DROP COLUMN product_image4;

-- Nếu muốn xóa bảng ProductImage (chỉ sau khi chắc chắn)
DROP TABLE ProductImage;
*/

-- =====================================================
-- NOTES
-- =====================================================

/*
✓ ProductImage table có thể giữ nguyên để backward compatibility
✓ Hoặc xóa sau khi hoàn toàn chuyển sang hệ thống mới
✓ ProductImpl.java không còn sử dụng bảng ProductImage
✓ product-detail.jsp sử dụng 4 column mới
✓ productImages list vẫn được populate từ 4 column
*/

