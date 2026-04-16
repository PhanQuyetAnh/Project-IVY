package dao.Impl;

import dao.DashboardDAO;
import util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DashboardDAOImpl implements DashboardDAO {

    // Hàm tự động sinh điều kiện thời gian cho các câu SQL
    private String getDateCondition(String timeFilter, String dateColumn) {
        if ("today".equals(timeFilter)) {
            return " AND DATE(" + dateColumn + ") = CURDATE() ";
        } else if ("month".equals(timeFilter)) {
            return " AND MONTH(" + dateColumn + ") = MONTH(CURDATE()) AND YEAR(" + dateColumn + ") = YEAR(CURDATE()) ";
        } else if ("year".equals(timeFilter)) {
            return " AND YEAR(" + dateColumn + ") = YEAR(CURDATE()) ";
        }
        return ""; // Nếu timeFilter là "all" hoặc null thì không lọc ngày
    }

    // 1. TỔNG ĐƠN HÀNG (DOANH SỐ)
    @Override
    public int getTotalOrders(String timeFilter) {
        String sql = "SELECT COUNT(*) AS total FROM `Order` WHERE 1=1 "
                + getDateCondition(timeFilter, "order_date");
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // 2. TỔNG DOANH THU (Bao gồm Thành công & Đã xác nhận)
    @Override
    public double getTotalRevenue(String timeFilter) {
        // Dùng IN (?, ?) để gom chung 2 trạng thái
        String sql = "SELECT SUM(total_amount) AS revenue FROM `Order` WHERE order_status IN (?, ?) "
                + getDateCondition(timeFilter, "order_date");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Xử lý an toàn Tiếng Việt
            ps.setString(1, "Thành công");
            ps.setString(2, "Đã xác nhận");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("revenue");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 3. TỔNG KHÁCH HÀNG
    @Override
    public int getTotalCustomers(String timeFilter) {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role_id = 2 "
                + getDateCondition(timeFilter, "user_created_date");
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // 4. BIỂU ĐỒ THỐNG KÊ (Cũng gom Thành công & Đã xác nhận)
    @Override
    public Map<String, List<Object>> getLineChartData(String timeFilter) {
        Map<String, List<Object>> chartData = new HashMap<>();
        List<Object> labels = new ArrayList<>();
        List<Object> orders = new ArrayList<>();
        List<Object> revenue = new ArrayList<>();

        String sql = "";
        if ("today".equals(timeFilter)) {
            // Lấy theo giờ: 0h, 1h, 2h...
            sql = "SELECT HOUR(order_date) as label, COUNT(*) as total_order, SUM(total_amount) as total_revenue " +
                    "FROM `Order` WHERE DATE(order_date) = CURDATE() AND order_status IN (?, ?) " +
                    "GROUP BY HOUR(order_date) ORDER BY HOUR(order_date) ASC";
        } else if ("year".equals(timeFilter)) {
            // Lấy theo tháng: 1, 2, 3...
            sql = "SELECT MONTH(order_date) as label, COUNT(*) as total_order, SUM(total_amount) as total_revenue " +
                    "FROM `Order` WHERE YEAR(order_date) = YEAR(CURDATE()) AND order_status IN (?, ?) " +
                    "GROUP BY MONTH(order_date) ORDER BY MONTH(order_date) ASC";
        } else {
            // Mốc THÁNG: Lấy ngày trong tháng (1, 2, 3... 31)
            sql = "SELECT DAY(order_date) as label, COUNT(*) as total_order, SUM(total_amount) as total_revenue " +
                    "FROM `Order` WHERE MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE()) AND order_status IN (?, ?) " +
                    "GROUP BY DAY(order_date) ORDER BY DAY(order_date) ASC";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Thành công");
            ps.setString(2, "Đã xác nhận");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Chỉnh label cho đẹp: 'Giờ 17', 'Ngày 11', 'Tháng 4'
                    String prefix = "today".equals(timeFilter) ? "Giờ " : ("year".equals(timeFilter) ? "T" : "Ngày ");
                    labels.add("'" + prefix + rs.getString("label") + "'");
                    orders.add(rs.getInt("total_order"));
                    revenue.add(rs.getDouble("total_revenue"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chartData.put("labels", labels);
        chartData.put("orders", orders);
        chartData.put("revenue", revenue);
        return chartData;
    }

    @Override
    public Map<String, Double> getCategoryRadarData() {
        Map<String, Double> data = new HashMap<>();
        // Khởi tạo 6 nhóm mục tiêu
        String[] categories = {"Áo sơ mi", "Áo thun", "Quần dài", "Chân váy", "Đầm công sở", "Đầm dạ hội"};
        for (String cat : categories) data.put(cat, 0.0);

        // SQL thông minh: Gom nhóm các category_id tương ứng vào nhóm Radar
        String sql = "SELECT " +
                "  CASE " +
                "    WHEN c.category_id IN (10, 21) THEN 'Áo sơ mi' " +
                "    WHEN c.category_id IN (11, 22) THEN 'Áo thun' " +
                "    WHEN c.category_id IN (16, 24) THEN 'Quần dài' " +
                "    WHEN c.category_id IN (6, 17, 18) THEN 'Chân váy' " +
                "    WHEN c.category_id = 19 THEN 'Đầm công sở' " +
                "    WHEN c.category_id = 20 THEN 'Đầm dạ hội' " +
                "    ELSE 'Khác' " +
                "  END as radar_group, " +
                "  SUM(od.price * od.quantity_sold) as total " +
                "FROM Category c " +
                "JOIN Product p ON c.category_id = p.category_id " +
                "JOIN OrderDetail od ON p.id = od.product_id " +
                "JOIN `Order` o ON od.order_id = o.order_id " +
                "WHERE o.order_status IN (?, ?) " +
                "GROUP BY radar_group";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Thành công");
            ps.setString(2, "Đã xác nhận");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String group = rs.getString("radar_group");
                    if (data.containsKey(group)) {
                        data.put(group, rs.getDouble("total"));
                    }
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return data;
    }


    @Override
    public Map<String, Integer> getOrderStatusCounts(String timeFilter) {
        Map<String, Integer> counts = new HashMap<>();
        // Query gom nhóm theo trạng thái
        String sql = "SELECT order_status, COUNT(*) AS total_count FROM `Order` WHERE 1=1 "
                + getDateCondition(timeFilter, "order_date")
                + " GROUP BY order_status";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                counts.put(rs.getString("order_status"), rs.getInt("total_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }
}