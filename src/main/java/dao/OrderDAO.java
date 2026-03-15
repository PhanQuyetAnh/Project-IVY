package dao;

import java.util.List;
import model.OrderInfo;
import model.OrderObject;




public interface OrderDAO {
	
    List<OrderInfo> getRecentOrders(int limit);
    
    // lấy tất cả đơn hàng theo phân trang
    List<OrderObject> getAllOrders(int pageNo, int pageSize,String orderStatus,
                             String paymentStatus, String paymentMethod);

    //Đếm số lượng đơn hàng
    public int countAllOrders(String orderStatus, String paymentStatus, String paymentMethod);

    //lấy chi tiết đơn hàng theo orderId
    OrderObject getOrderDetailByOrderId(int orderId);

   // Xóa đơn hàng
    boolean deleteOrder(int orderId);

    //Cập nhật trạng thái đơn hàng
    boolean updateOrder(int orderId, int userId, String orderStatus, String paymentStatus);
}