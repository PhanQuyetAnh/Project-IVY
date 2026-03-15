package controller.web;

import dao.CartDAO;
import dao.Impl.CartDAOImpl;
import model.CartObject;
import model.UserObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customer/update-cart")
public class UpdateCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateCartController() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] productIds = request.getParameterValues("productId");
        String[] sizes = request.getParameterValues("size");
        String[] quantities = request.getParameterValues("quantity");

        HttpSession session = request.getSession();
        UserObject userObject = (UserObject) session.getAttribute("user");

        if(userObject == null) {
            response.sendRedirect("/jsp-servlet/login");
        }else{
            CartDAO cartDAO = new CartDAOImpl();

            for (int i = 0; i < productIds.length; i++) {
                int productId = Integer.parseInt(productIds[i]);
                String size = sizes[i];
                int quantity = Integer.parseInt(quantities[i]);

                if(quantity == 0){
                    cartDAO.deleteCartItem(userObject.getUserId(), productId, size);
                }

                cartDAO.updateCart(userObject.getUserId(), productId, quantity, size);
            }

            response.sendRedirect("/jsp-servlet/customer/cart");
        }


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}
