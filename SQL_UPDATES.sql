-- ========================================
-- SQL MIGRATION: PRODUCT IMAGES & REVIEWS
-- ========================================

-- 1. TẠO BẢNG PRODUCT_IMAGES (để lưu 4 ảnh cho 1 sản phẩm)
CREATE TABLE IF NOT EXISTS ProductImage (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    display_order INT DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(id) ON DELETE CASCADE,
    INDEX idx_product_id (product_id)
);

-- 2. TẠO BẢNG REVIEWS (để lưu đánh giá & bình luận sản phẩm)
CREATE TABLE IF NOT EXISTS Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_product_id (product_id),
    INDEX idx_user_id (user_id)
);

-- 3. TẠO BẢNG WISHLIST (để lưu sản phẩm yêu thích của khách hàng)
CREATE TABLE IF NOT EXISTS Wishlist (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_product (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_product_id (product_id)
);

-- 4. CẬP NHẬT BẢNG PRODUCT (thêm cột average_rating và total_reviews)
ALTER TABLE Product ADD COLUMN IF NOT EXISTS average_rating DECIMAL(3,2) DEFAULT 0;
ALTER TABLE Product ADD COLUMN IF NOT EXISTS total_reviews INT DEFAULT 0;

-- 5. CHÈN DỮ LIỆU MẪU (nếu cần - UNCOMMENT nếu muốn test)
-- INSERT INTO ProductImage (product_id, image_url, display_order, is_primary) VALUES
-- (1, '/templates/web/images/product-1-1.jpg', 0, TRUE),
-- (1, '/templates/web/images/product-1-2.jpg', 1, FALSE),
-- (1, '/templates/web/images/product-1-3.jpg', 2, FALSE),
-- (1, '/templates/web/images/product-1-4.jpg', 3, FALSE);

-- ========================================
-- GHI CHÚ:
-- - 1 sản phẩm = 4 ảnh (trong ProductImage table)
-- - Ảnh đầu tiên (display_order=0) là ảnh chính
-- - Click thumbnail → Swiper.js sẽ slide ảnh
-- - Không cần CRUD ảnh (chỉ SELECT)
-- ========================================


