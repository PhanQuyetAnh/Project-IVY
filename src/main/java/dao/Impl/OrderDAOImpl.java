package dao.Impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dao.OrderDAO;
import model.OrderInfo;
import util.DBUtil;


import dao.UserDAO;
import model.OrderDetailObject;
import model.OrderObject;
import model.ProductObject;
import model.UserObject;

import java.util.*;

public class OrderDAOImpl implements OrderDAO {
    @Override
    public List<OrderInfo> getRecentOrders(int limit) {
        List<OrderInfo> orderList = new ArrayList<>();
        String sql = "SELECT u.user_fullname, p.product_name, od.price, o.order_status, o.order_date " +
                     "FROM `Order` o " +
                     "JOIN `OrderDetail` od ON o.order_id = od.order_id " +
                     "JOIN `Product` p ON od.product_id = p.id " +
                     "JOIN `users` u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_date DESC LIMIT ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderInfo order = new OrderInfo();
                    order.setCustomerName(rs.getString("user_fullname"));
                    order.setProductName(rs.getString("product_name"));
                    order.setPrice(rs.getDouble("price"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setOrderDate(rs.getString("order_date"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
    
    // ha
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    public List<OrderObject> getAllOrders(int pageNo, int pageSize, String orderStatus,
                                    String paymentStatus, String paymentMethod) {
        Map<Integer, OrderObject> orderMap = new LinkedHashMap<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.order_id, o.total_amount, o.order_status, o.payment_status, o.payment_method, o.order_date, ");
        sql.append("u.user_id, u.user_fullname, u.user_phone_number, u.user_address, ");
        sql.append("od.quantity_sold, od.price, od.product_id, od.product_size, od.product_color, ");
        sql.append("p.product_name, p.product_image ");
        sql.append("FROM `Order` o ");
        sql.append("LEFT JOIN users u ON o.user_id = u.user_id ");
        sql.append("LEFT JOIN OrderDetail od ON od.order_id = o.order_id ");
        sql.append("LEFT JOIN Product p ON p.id = od.product_id ");

        // Xây dựng điều kiện WHERE động
        List<String> conditions = new ArrayList<>();
        if (orderStatus != null && !orderStatus.isEmpty()) conditions.add("o.order_status = ?");
        if (paymentStatus != null && !paymentStatus.isEmpty()) conditions.add("o.payment_status = ?");
        if (paymentMethod != null && !paymentMethod.isEmpty()) conditions.add("o.payment_method = ?");

        if (!conditions.isEmpty()) {
            sql.append("WHERE ");
            sql.append(String.join(" AND ", conditions));
            sql.append(" ");
        }
        sql.append("ORDER BY o.order_date DESC ");
        // Phân trang
        sql.append("LIMIT ? OFFSET ?");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            // Gán giá trị cho các điều kiện lọc
            if (orderStatus != null && !orderStatus.isEmpty()) ps.setString(index++, orderStatus);
            if (paymentStatus != null && !paymentStatus.isEmpty()) ps.setString(index++, paymentStatus);
            if (paymentMethod != null && !paymentMethod.isEmpty()) ps.setString(index++, paymentMethod);

            // Gán LIMIT và OFFSET
            int offset = (pageNo - 1) * pageSize;
            ps.setInt(index++, pageSize);
            ps.setInt(index, offset);

            // Thực thi truy vấn và lấy kết quả
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    int orderId = rs.getInt("order_id");
                    OrderObject order = orderMap.get(orderId);
                    if (order == null) {
                        order = new OrderObject();

                        order.setOrderId(rs.getInt("order_id"));
                        order.setOrderDate(rs.getTimestamp("order_date"));
                        order.setTotalAmount(rs.getFloat("total_amount"));
                        order.setOrderStatus(rs.getString("order_status"));
                        order.setPaymentStatus(rs.getString("payment_status"));
                        order.setPaymentMethod(rs.getString("payment_method"));

                        UserObject user = new UserObject();
                        user.setUserId(rs.getInt("user_id"));
                        user.setFullname(rs.getString("user_fullname"));
                        user.setPhoneNumber(rs.getString("user_phone_number"));
                        user.setAddress(rs.getString("user_address"));
                        order.setUserObject(user);

                        order.setOrderDetailList(new ArrayList<>());
                        orderMap.put(orderId, order);
                    }

                    ProductObject productObject = new ProductObject();
                    productObject.setProductId(rs.getInt("product_id"));
                    productObject.setProductName(rs.getString("product_name"));
                    productObject.setProductImage(rs.getString("product_image"));

                    OrderDetailObject orderDetailObject = new OrderDetailObject();
                    orderDetailObject.setPrice(rs.getFloat("price"));
                    orderDetailObject.setQuantitySold(rs.getInt("quantity_sold"));
                    orderDetailObject.setProductSize(rs.getString("product_size"));
                    orderDetailObject.setProductColor(rs.getString("product_color"));

                    orderDetailObject.setProductObject(productObject); //set sp vào chi tiêt đơn hàng

                    order.getOrderDetailList().add(orderDetailObject); //thêm chi tiết đơn hàng vào hóa đơn
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Có thể log lỗi hoặc ném lại exception tuỳ trường hợp
        }

        return new ArrayList<>(orderMap.values());
    }


    @Override
    public int countAllOrders(String orderStatus, String paymentStatus, String paymentMethod) {
        StringBuilder sql = new StringBuilder();
        sql.append("select count(*) from `Order`");
        List<String> conditions = new ArrayList<>();
        if (orderStatus != null && !orderStatus.isEmpty()) conditions.add("order_status = ?");
        if (paymentStatus != null && !paymentStatus.isEmpty()) conditions.add("payment_status = ?");
        if (paymentMethod != null && !paymentMethod.isEmpty()) conditions.add("payment_method = ?");

        if (!conditions.isEmpty()) {
            sql.append("WHERE ");
            sql.append(String.join(" AND ", conditions));
            sql.append(" ");
        }
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql.toString())
        ) {
            int index = 1;
            if (orderStatus != null && !orderStatus.isEmpty()) ps.setString(index++, orderStatus);
            if (paymentStatus != null && !paymentStatus.isEmpty()) ps.setString(index++, paymentStatus);
            if (paymentMethod != null && !paymentMethod.isEmpty()) ps.setString(index, paymentMethod);

            try(ResultSet rs = ps.executeQuery()){
                if(rs.next())
                    return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public OrderObject getOrderDetailByOrderId(int orderId) {
        OrderObject order = new OrderObject();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.order_id, o.total_amount, o.order_status, o.payment_status, o.payment_method, o.order_date, ");
        sql.append("u.user_id, u.user_fullname, u.user_phone_number, u.user_address, ");
        sql.append("od.quantity_sold, od.price, od.product_id, od.product_size, od.product_color, ");
        sql.append("p.product_name, p.product_image ");
        sql.append("FROM `Order` o ");
        sql.append("LEFT JOIN users u ON o.user_id = u.user_id ");
        sql.append("LEFT JOIN OrderDetail od ON od.order_id = o.order_id ");
        sql.append("LEFT JOIN Product p ON p.id = od.product_id ");
        sql.append("WHERE o.order_id = ?");

        try(Connection conn  = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString())){

            ps.setInt(1, orderId);

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()){
                    if (order.getOrderId() == 0){
                        order.setOrderId(rs.getInt("order_id"));
                        order.setOrderDate(rs.getTimestamp("order_date"));
                        order.setTotalAmount(rs.getFloat("total_amount"));
                        order.setOrderStatus(rs.getString("order_status"));
                        order.setPaymentStatus(rs.getString("payment_status"));
                        order.setPaymentMethod(rs.getString("payment_method"));

                        UserObject user = new UserObject();
                        user.setUserId(rs.getInt("user_id"));
                        user.setFullname(rs.getString("user_fullname"));
                        user.setPhoneNumber(rs.getString("user_phone_number"));
                        user.setAddress(rs.getString("user_address"));
                        order.setUserObject(user);

                        order.setOrderDetailList(new ArrayList<>());
                    }


                    ProductObject productObject = new ProductObject();
                    productObject.setProductId(rs.getInt("product_id"));
                    productObject.setProductName(rs.getString("product_name"));
                    productObject.setProductImage(rs.getString("product_image"));

                    OrderDetailObject orderDetailObject = new OrderDetailObject();
                    orderDetailObject.setPrice(rs.getFloat("price"));
                    orderDetailObject.setQuantitySold(rs.getInt("quantity_sold"));
                    orderDetailObject.setProductSize(rs.getString("product_size"));
                    orderDetailObject.setProductColor(rs.getString("product_color"));

                    orderDetailObject.setProductObject(productObject);

                    order.getOrderDetailList().add(orderDetailObject);
                }
            }

        }catch (SQLException e){
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public boolean deleteOrder(int orderId) {

        String deleteOrderItemsSql = "DELETE FROM `OrderDetail` WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM `Order` WHERE order_id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            try (
                    PreparedStatement psItems = conn.prepareStatement(deleteOrderItemsSql);
                    PreparedStatement psOrder = conn.prepareStatement(deleteOrderSql)
            ) {
                // Xóa các mục trong đơn hàng
                psItems.setInt(1, orderId);
                psItems.executeUpdate();

                // Xóa đơn hàng
                psOrder.setInt(1, orderId);
                int affectedRows = psOrder.executeUpdate();

                if (affectedRows > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                }
            } catch (SQLException e) {
                conn.rollback(); // rollback nếu có lỗi trong quá trình xóa
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true); // khôi phục trạng thái ban đầu
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateOrder(int orderId, int userId, String orderStatus, String paymentStatus) {
        String sql = "UPDATE `Order` SET order_status = ?, payment_status = ? WHERE order_id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderStatus);
            ps.setString(2, paymentStatus);
            ps.setInt(3, orderId);
            ps.setInt(4, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
