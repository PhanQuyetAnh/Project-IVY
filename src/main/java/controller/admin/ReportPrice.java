package controller.admin;

import dao.IProductDAO;
import dao.Impl.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/admin-report")
public class ReportPrice extends HttpServlet {
    private IProductDAO productDao;

    @Override
    public void init() {
        productDao = new ProductImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            double totalRevenue = productDao.getTotalRevenue();
            double totalInventoryValue = productDao.getTotalInventoryValue();

            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalValue", totalInventoryValue);

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