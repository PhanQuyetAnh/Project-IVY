package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.IProductDAO;
import dao.Impl.ProductImpl;
import model.ProductObject;

@WebServlet("/admin/admin-manage-product")
public class ManageProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ProductObject> products = productDAO.getAllProducts();
        List<ProductObject> deletedProducts = productDAO.getDeletedProducts();
        request.setAttribute("products", products);
        request.setAttribute("deletedProducts", deletedProducts);
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/manage-product.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}