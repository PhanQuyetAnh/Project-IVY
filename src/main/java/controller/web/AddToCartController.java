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

@WebServlet("/customer/add-to-cart")
public class AddToCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public AddToCartController() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String size = request.getParameter("size");

        HttpSession session = request.getSession();
        UserObject userObject = (UserObject) session.getAttribute("user");

        if(userObject == null) {
            response.sendRedirect("/jsp-servlet/login");
        }else{
            CartDAO cartDAO = new CartDAOImpl();

            CartObject cartObject = cartDAO.getCartItem(userObject.getUserId(), productId, size);
            if(cartObject != null) {
                //nếu sp đã tồn tại thì chỉ cập nhật lại số lượng
                cartDAO.updateCart(userObject.getUserId(), productId, cartObject.getQuantity() + quantity, size);
            }else {
                cartDAO.addToCart(userObject.getUserId(), productId, quantity, size);
            }

            response.sendRedirect("/jsp-servlet/customer/cart");
        }


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}
