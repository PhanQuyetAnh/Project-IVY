package dao.Impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import dao.IProductDAO;
import model.ProductObject;
import model.ProductImageObject;
import util.DBUtil;

public class ProductImpl implements IProductDAO {

    private boolean exe(Connection conn, PreparedStatement pre) {
        if (pre != null) {
            try {
                int results = pre.executeUpdate();
                if (results == 0) {
                    conn.rollback();
                    return false;
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
                e.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public List<ProductObject> getAllProducts() {
        List<ProductObject> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE isDeleted = FALSE";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductObject p = new ProductObject();
                p.setProductId(rs.getInt("id"));
                p.setProductCode(rs.getString("product_code"));
                p.setProductName(rs.getString("product_name"));
                p.setProductImage(rs.getString("product_image1")); // Ảnh chính
                p.setProductImage1(rs.getString("product_image1"));
                p.setProductImage2(rs.getString("product_image2"));
                p.setProductImage3(rs.getString("product_image3"));
                p.setProductImage4(rs.getString("product_image4"));
                p.setProductPrice(rs.getDouble("product_price"));
                p.setProductQuantity(rs.getInt("product_quantity"));
                p.setProductColor(rs.getString("product_color"));
                p.setProductSize(rs.getString("product_size"));
                p.setProductDescription(rs.getString("product_description"));
                p.setProductCategory(rs.getString("product_category"));
                p.setCreatedAt(rs.getDate("created_at"));
                p.setUpdateAt(rs.getDate("updated_at"));
                p.setDeleted(rs.getBoolean("isDeleted"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public ProductObject getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE id = ? AND isDeleted = FALSE";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductObject p = new ProductObject();
                p.setProductId(rs.getInt("id"));
                p.setProductCode(rs.getString("product_code"));
                p.setProductName(rs.getString("product_name"));
                p.setProductImage(rs.getString("product_image1")); // Ảnh chính
                p.setProductImage1(rs.getString("product_image1"));
                p.setProductImage2(rs.getString("product_image2"));
                p.setProductImage3(rs.getString("product_image3"));
                p.setProductImage4(rs.getString("product_image4"));
                p.setProductPrice(rs.getDouble("product_price"));
                p.setProductQuantity(rs.getInt("product_quantity"));
                p.setProductColor(rs.getString("product_color"));
                p.setProductSize(rs.getString("product_size"));
                p.setProductDescription(rs.getString("product_description"));
                p.setProductCategory(rs.getString("product_category"));
                p.setCreatedAt(rs.getDate("created_at"));
                p.setUpdateAt(rs.getDate("updated_at"));
                p.setDeleted(rs.getBoolean("isDeleted"));

                // Tạo danh sách ảnh từ 4 ảnh riêng biệt
                List<ProductImageObject> images = new ArrayList<>();
                if (p.getProductImage1() != null) {
                    ProductImageObject img1 = new ProductImageObject();
                    img1.setImageUrl(p.getProductImage1());
                    img1.setDisplayOrder(0);
                    img1.setPrimary(true);
                    images.add(img1);
                }
                if (p.getProductImage2() != null) {
                    ProductImageObject img2 = new ProductImageObject();
                    img2.setImageUrl(p.getProductImage2());
                    img2.setDisplayOrder(1);
                    img2.setPrimary(false);
                    images.add(img2);
                }
                if (p.getProductImage3() != null) {
                    ProductImageObject img3 = new ProductImageObject();
                    img3.setImageUrl(p.getProductImage3());
                    img3.setDisplayOrder(2);
                    img3.setPrimary(false);
                    images.add(img3);
                }
                if (p.getProductImage4() != null) {
                    ProductImageObject img4 = new ProductImageObject();
                    img4.setImageUrl(p.getProductImage4());
                    img4.setDisplayOrder(3);
                    img4.setPrimary(false);
                    images.add(img4);
                }
                p.setProductImages(images);

                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public boolean insertProduct(ProductObject product) {
        StringBuilder sql = new StringBuilder("INSERT INTO Product(");
        sql.append("product_code,product_name,product_image1,product_image2,product_image3,product_image4,");
        sql.append("product_price,product_quantity,product_color,product_size,");
        sql.append("product_description,product_category,isDeleted,created_at,updated_at");
        sql.append(") VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pre = conn.prepareStatement(sql.toString())) {
            conn.setAutoCommit(false);
            pre.setString(1, product.getProductCode());
            pre.setString(2, product.getProductName());
            pre.setString(3, product.getProductImage1());
            pre.setString(4, product.getProductImage2());
            pre.setString(5, product.getProductImage3());
            pre.setString(6, product.getProductImage4());
            pre.setDouble(7, product.getProductPrice());
            pre.setInt(8, product.getProductQuantity());
            pre.setString(9, product.getProductColor());
            pre.setString(10, product.getProductSize());
            pre.setString(11, product.getProductDescription());
            pre.setString(12, product.getProductCategory());
            pre.setBoolean(13, false); // Mặc định isDeleted = false
            pre.setTimestamp(14, new Timestamp(System.currentTimeMillis())); // created_at
            pre.setTimestamp(15, null); // updated_at
            return this.exe(conn, pre);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateProduct(ProductObject product) {
        StringBuilder sql = new StringBuilder("UPDATE Product SET ");
        sql.append("product_code=?, product_name=?, product_image1=?, product_image2=?, ");
        sql.append("product_image3=?, product_image4=?, product_price=?, product_quantity=?, ");
        sql.append("product_color=?, product_size=?, product_description=?, product_category=?, ");
        sql.append("isDeleted=?, updated_at=? WHERE id=?");
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pre = conn.prepareStatement(sql.toString())) {
            conn.setAutoCommit(false);
            pre.setString(1, product.getProductCode());
            pre.setString(2, product.getProductName());
            pre.setString(3, product.getProductImage1());
            pre.setString(4, product.getProductImage2());
            pre.setString(5, product.getProductImage3());
            pre.setString(6, product.getProductImage4());
            pre.setDouble(7, product.getProductPrice());
            pre.setInt(8, product.getProductQuantity());
            pre.setString(9, product.getProductColor());
            pre.setString(10, product.getProductSize());
            pre.setString(11, product.getProductDescription());
            pre.setString(12, product.getProductCategory());
            pre.setBoolean(13, product.isDeleted());
            pre.setTimestamp(14, new Timestamp(System.currentTimeMillis())); // updated_at
            pre.setInt(15, product.getProductId());
            return exe(conn, pre);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteProduct(int id) {
        String sql = "UPDATE Product SET isDeleted = TRUE, updated_at = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pre = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false);
            pre.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // updated_at
            pre.setInt(2, id);
            return exe(conn, pre);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ProductObject> getDeletedProducts() {
        List<ProductObject> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE isDeleted = TRUE";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductObject p = new ProductObject();
                p.setProductId(rs.getInt("id"));
                p.setProductCode(rs.getString("product_code"));
                p.setProductName(rs.getString("product_name"));
                p.setProductImage(rs.getString("product_image1"));
                p.setProductImage1(rs.getString("product_image1"));
                p.setProductImage2(rs.getString("product_image2"));
                p.setProductImage3(rs.getString("product_image3"));
                p.setProductImage4(rs.getString("product_image4"));
                p.setProductPrice(rs.getDouble("product_price"));
                p.setProductQuantity(rs.getInt("product_quantity"));
                p.setProductColor(rs.getString("product_color"));
                p.setProductSize(rs.getString("product_size"));
                p.setProductDescription(rs.getString("product_description"));
                p.setProductCategory(rs.getString("product_category"));
                p.setCreatedAt(rs.getDate("created_at"));
                p.setUpdateAt(rs.getDate("updated_at"));
                p.setDeleted(rs.getBoolean("isDeleted"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean restoreProduct(int id) {
        String sql = "UPDATE Product SET isDeleted = FALSE, updated_at = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pre = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false);
            pre.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // updated_at
            pre.setInt(2, id);
            return exe(conn, pre);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean permanentlyDeleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE id = ? AND isDeleted = TRUE";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pre = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false);
            pre.setInt(1, id);
            return exe(conn, pre);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public double getTotalRevenue() {
        String sql = "SELECT SUM(COALESCE(quantity_sold, 0) * COALESCE(price, 0)) FROM OrderDetail";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public double getTotalInventoryValue() {
        String sql = "SELECT SUM(total_value) FROM ("
                   + "SELECT COALESCE(p.product_price, 0) * (p.product_quantity - COALESCE(SUM(od.quantity_sold), 0)) AS total_value "
                   + "FROM Product p "
                   + "LEFT JOIN OrderDetail od ON p.id = od.product_id "
                   + "WHERE p.isDeleted = FALSE "
                   + "GROUP BY p.id, p.product_quantity, p.product_price"
                   + ") subquery";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}