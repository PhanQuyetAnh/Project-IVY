package controller.admin;

import dao.Impl.OrderDAOImpl;
import dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/admin-update-order")
public class OrderUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        String userIdParam = request.getParameter("userId");
        String paymentStatus = request.getParameter("paymentStatus");
        String orderStatus = request.getParameter("orderStatus");

        if(orderIdParam != null || userIdParam != null || paymentStatus != null || orderStatus != null) {
            int orderId = Integer.parseInt(orderIdParam);
            int userId = Integer.parseInt(userIdParam);

            OrderDAO orderDAO = new OrderDAOImpl();
            boolean check = orderDAO.updateOrder(orderId, userId, orderStatus, paymentStatus);

            response.sendRedirect(request.getContextPath() + "/admin/admin-order-edit?orderId=" + orderId + "&status=success");
        }

    }
}