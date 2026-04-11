package controller.web;

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

@WebServlet(urlPatterns = {"/category"})
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryIdStr = req.getParameter("id");

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);

                // BẠN CẦN VIẾT THÊM HÀM NÀY TRONG ProductDAO: Lấy sản phẩm theo ID danh mục
                // List<ProductObject> listProduct = productDAO.getProductsByCategoryId(categoryId);

                // Tạm thời nếu chưa viết hàm trên, cứ lấy GetAll để test giao diện trước
                List<ProductObject> listProduct = productDAO.getAllProducts();

                // Chú ý: Đổi "products" thành đúng tên biến mà file all_product.jsp của bạn đang dùng để lặp <c:forEach>
                req.setAttribute("allProducts", listProduct);

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // ĐIỂM ĂN TIỀN Ở ĐÂY: Forward thẳng về cái trang all_product.jsp có sẵn của bạn!
        RequestDispatcher rd = req.getRequestDispatcher("/views/web/all_product.jsp");
        rd.forward(req, resp);
    }
}