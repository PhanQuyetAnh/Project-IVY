-- =====================================================
-- UPDATE PRODUCT TABLE STRUCTURE
-- Thay đổi cấu trúc bảng Product để hỗ trợ 4 ảnh riêng biệt
-- =====================================================

-- 1. Kiểm tra xem các column mới có tồn tại không
-- Nếu chưa có, thêm các column mới
ALTER TABLE Product
ADD COLUMN product_image1 VARCHAR(255) NULL,
ADD COLUMN product_image2 VARCHAR(255) NULL,
ADD COLUMN product_image3 VARCHAR(255) NULL,
ADD COLUMN product_image4 VARCHAR(255) NULL;

-- 2. Nếu column product_image cũ tồn tại và chưa có dữ liệu trong product_image1,
-- hãy copy dữ liệu từ product_image sang product_image1
UPDATE Product
SET product_image1 = product_image
WHERE product_image IS NOT NULL AND product_image1 IS NULL;

-- 3. Thêm sample data (thay đổi theo nhu cầu)
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
    product_category
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
    'Quần dài'
);

-- =====================================================
-- NOTE:
-- - Nếu bảng ProductImage còn sử dụng, có thể DROP sau khi migrate hết dữ liệu
-- - Hoặc giữ nguyên để backward compatibility
-- DROP TABLE ProductImage;
-- =====================================================

