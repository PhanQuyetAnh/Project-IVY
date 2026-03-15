package dao.Impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import dao.CartDAO;
import model.CartObject;
import model.ProductObject;
import model.UserObject;
import util.DBUtil;



public class CartDAOImpl implements CartDAO {
	
	

	@Override
    public List<CartObject> getCartItems(int userId) {
        List<CartObject> cartItems = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.id, p.product_name, p.product_image, p.product_price, p.product_color, ");
        sql.append("c.quantity, c.product_size ");
        sql.append("FROM cart c JOIN Product p ON c.product_id = p.id WHERE c.user_id = ?");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                ProductObject p = new ProductObject();
                p.setProductId(rs.getInt("id"));
	            p.setProductName(rs.getString("product_name"));
	            p.setProductImage(rs.getString("product_image"));
	            p.setProductPrice(rs.getDouble("product_price"));
	            p.setProductColor(rs.getString("product_color"));

                CartObject c = new CartObject();
                c.setQuantity(rs.getInt("quantity"));
                c.setProductSize(rs.getString("product_size"));
                c.setProductObject(p);

                cartItems.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    @Override
    public CartObject getCartItem(int userId, int productId, String productSize) {
        CartObject cartItem = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT user_id, product_id, quantity, product_size ");
        sql.append("FROM cart WHERE user_id = ? AND product_id = ? AND product_size = ?");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setString(3, productSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                UserObject userObject = new UserObject();
                userObject.setUserId(rs.getInt("user_id"));

                ProductObject p = new ProductObject();
                p.setProductId(rs.getInt("product_id"));

                cartItem = new CartObject();

                cartItem.setQuantity(rs.getInt("quantity"));
                cartItem.setProductSize(rs.getString("product_size"));

                cartItem.setProductObject(p);
                cartItem.setUserObject(userObject);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItem;
    }

    @Override
    public void addToCart(int userId, int productId, int quantity, String productSize) {
        String sql = "INSERT INTO cart (user_id, product_id, quantity, product_size) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setString(4, productSize);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean updateCart(int userId, int productId, int quantity, String productSize) {
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ? AND product_size = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

        	stmt.setInt(1, quantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, productId);
            stmt.setString(4, productSize);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteCartItem(int userId, int productId, String size) {
        StringBuilder sql = new StringBuilder();
        sql.append("DELETE FROM cart WHERE user_id = ? AND product_id = ? AND product_size = ?");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setString(3, size);
            return stmt.executeUpdate() > 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
