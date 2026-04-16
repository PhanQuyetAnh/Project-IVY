package controller.admin;

import dao.DashboardDAO;
import dao.Impl.DashboardDAOImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/admin-report")
public class ReportPrice extends HttpServlet {

    // Chỉ cần dùng DashboardDAO là đủ để lấy mọi dữ liệu thực tế
    private DashboardDAO dashboardDAO;

    @Override
    public void init() {
        dashboardDAO = new DashboardDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. LẤY DOANH THU THỰC TẾ (Hàm này mặc định chỉ cộng đơn Thành công/Đã xác nhận)
            double totalRevenue = dashboardDAO.getTotalRevenue("all");
            request.setAttribute("totalRevenue", totalRevenue);

            // 2. LẤY SỐ LIỆU ĐƠN HÀNG (Cho biểu đồ Donut và Thẻ Tổng đơn)
            Map<String, Integer> statusCounts = dashboardDAO.getOrderStatusCounts("all");

            int successCount   = statusCounts.getOrDefault("Thành công", 0);
            int confirmedCount = statusCounts.getOrDefault("Đã xác nhận", 0);
            int pendingCount   = statusCounts.getOrDefault("Chờ xử lý", 0) + statusCounts.getOrDefault("pending", 0);
            int cancelCount    = statusCounts.getOrDefault("cancelled", 0) + statusCounts.getOrDefault("Đã hủy", 0);

            // Tính tổng số lượng đơn hàng
            int totalOrdersReport = successCount + confirmedCount + pendingCount + cancelCount;

            request.setAttribute("successCount", successCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("cancelCount", cancelCount);

            // Truyền Tổng số đơn sang JSP cho thẻ bên phải
            request.setAttribute("totalOrdersReport", totalOrdersReport);

            RequestDispatcher rd = request.getRequestDispatcher("/views/admin/report.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            System.out.println("Error fetching statistics: " + e.getMessage());
            request.setAttribute("error", "Lỗi khi tải dữ liệu thống kê: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/admin/report.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}