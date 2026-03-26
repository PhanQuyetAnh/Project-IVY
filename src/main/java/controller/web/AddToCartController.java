package controller.web;

import dao.CartDAO;
import dao.Impl.CartDAOImpl;
import dao.UserDAO;
import model.CartObject;
import model.UserObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/customer/add-to-cart")
public class AddToCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Phải đặt Content-Type là application/json để khớp với dataType: 'json' ở Client
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        UserObject user = (UserObject) session.getAttribute("user");

        // 2. Kiểm tra đăng nhập
        if (user == null) {
            response.setStatus(401);
            out.print("{\"status\":\"error\", \"message\":\"Vui lòng đăng nhập!\"}");
            out.flush();
            out.close();
            return;
        }

        try {
            String pIdStr = request.getParameter("product_id");
            String qtyStr = request.getParameter("quantity");
            String size = request.getParameter("size");

            // 3. Kiểm tra tham số đầu vào
            if (pIdStr == null || qtyStr == null || size == null || pIdStr.isEmpty()) {
                out.print("{\"status\":\"error\", \"message\":\"Thiếu thông tin sản phẩm!\"}");
                return;
            }

            int productId = Integer.parseInt(pIdStr);
            int quantity = Integer.parseInt(qtyStr);

            CartDAO cartDAO = new CartDAOImpl();

            // 4. Thực hiện thêm vào giỏ hàng (Logic cộng dồn nằm trong DAO)
            cartDAO.addToCart(user.getUserId(), productId, quantity, size);

            // 5. ĐỒNG BỘ SESSION: Lấy lại list mới nhất từ DB để Sidebar hiển thị đúng
            List<CartObject> updatedCart = cartDAO.getCartItems(user.getUserId());
            session.setAttribute("cart", updatedCart);

            // 6. Trả về JSON THÀNH CÔNG
            out.print("{\"status\":\"success\", \"message\":\"Thêm vào giỏ hàng thành công!\"}");

        } catch (NumberFormatException e) {
            out.print("{\"status\":\"error\", \"message\":\"Dữ liệu số lượng hoặc ID không hợp lệ!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            // Không setStatus(500) ở đây để AJAX vẫn nhận được JSON message lỗi
            out.print("{\"status\":\"error\", \"message\":\"Lỗi hệ thống: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}