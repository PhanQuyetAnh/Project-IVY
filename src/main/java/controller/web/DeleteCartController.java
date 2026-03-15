package controller.web;

import dao.CartDAO;
import dao.Impl.CartDAOImpl;
import model.UserObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customer/cart-delete-item")
public class DeleteCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteCartController() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String size = request.getParameter("size");

        HttpSession session = request.getSession();
        UserObject userObject = (UserObject) session.getAttribute("user");

        if(userObject == null) {
            response.sendRedirect("/jsp-servlet/login");
        }else{
            CartDAO cartDAO = new CartDAOImpl();
            boolean checkDelete = cartDAO.deleteCartItem(userObject.getUserId(), productId, size);

            response.sendRedirect("/jsp-servlet/customer/cart");
        }


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}
