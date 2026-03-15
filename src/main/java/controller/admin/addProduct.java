package controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.IProductDAO;
import dao.Impl.ProductImpl;
import model.ProductObject;

/**
 * Servlet implementation class addProduct
 */
@WebServlet("/admin/admin-add-product")
public class addProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductDAO productDAO;

    public void init() {
        productDAO = new ProductImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> categories = productDAO.getAllProducts().stream()
                .map(ProductObject::getProductCategory)
                .distinct()
                .collect(Collectors.toList());
        request.setAttribute("categories", categories);
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/add-product.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            ProductObject product = new ProductObject();
            String imagePath = null;
            StringBuilder errors = new StringBuilder();

            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString("UTF-8");
                        switch (fieldName) {
                            case "productName":
                                product.setProductName(fieldValue);
                                break;
                            case "productCode":
                                product.setProductCode(fieldValue);
                                break;
                            case "productPrice":
                                product.setProductPrice(Double.parseDouble(fieldValue));
                                break;
                            case "productCategory":
                                product.setProductCategory(fieldValue);
                                break;
                            case "productColor":
                                product.setProductColor(fieldValue);
                                break;
                            case "productSize":
                                product.setProductSize(fieldValue);
                                break;
                            case "productQuantity":
                                product.setProductQuantity(Integer.parseInt(fieldValue));
                                break;
                            case "productDescription":
                                product.setProductDescription(fieldValue);
                                break;
                        }
                    } else {
                        if (item.getFieldName().equals("productImage") && item.getSize() > 0) {
                            String fileName = new File(item.getName()).getName();
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "templates" + File.separator + "admin" + File.separator + "img";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs();
                            }
                            imagePath = "/templates/admin/img/" + fileName;
                            File storeFile = new File(uploadPath + File.separator + fileName);
                            item.write(storeFile);
                            product.setProductImage(imagePath);
                        }
                    }
                }

                // Server-side validation
                if (product.getProductName() == null || product.getProductName().trim().isEmpty()) {
                    errors.append("Tên sản phẩm không được để trống.\n");
                    request.setAttribute("errorProductName", "Tên sản phẩm không được để trống");
                }
                if (product.getProductCode() == null || product.getProductCode().trim().isEmpty()) {
                    errors.append("Mã sản phẩm không được để trống.\n");
                    request.setAttribute("errorProductCode", "Mã sản phẩm không được để trống");
                }
                if (product.getProductPrice() <= 0) {
                    errors.append("Giá sản phẩm phải là số dương.\n");
                    request.setAttribute("errorProductPrice", "Giá sản phẩm phải là số dương");
                }
                if (product.getProductCategory() == null || product.getProductCategory().trim().isEmpty()) {
                    errors.append("Danh mục không được để trống.\n");
                    request.setAttribute("errorProductCategory", "Danh mục không được để trống");
                }
                if (product.getProductColor() == null || product.getProductColor().trim().isEmpty()) {
                    errors.append("Màu sắc không được để trống.\n");
                    request.setAttribute("errorProductColor", "Màu sắc không được để trống");
                }
                if (product.getProductSize() == null || product.getProductSize().trim().isEmpty()) {
                    errors.append("Kích cỡ không được để trống.\n");
                    request.setAttribute("errorProductSize", "Kích cỡ không được để trống");
                }
                if (product.getProductQuantity() < 0) {
                    errors.append("Số lượng phải là số không âm.\n");
                    request.setAttribute("errorProductQuantity", "Số lượng phải là số không âm");
                }
                if (product.getProductDescription() == null || product.getProductDescription().trim().isEmpty()) {
                    errors.append("Mô tả sản phẩm không được để trống.\n");
                    request.setAttribute("errorProductDescription", "Mô tả sản phẩm không được để trống");
                }
                if (imagePath == null) {
                    errors.append("Ảnh sản phẩm không được để trống.\n");
                    request.setAttribute("errorProductImage", "Ảnh sản phẩm không được để trống");
                }

                if (errors.length() > 0) {
                    request.setAttribute("errorMessage", errors.toString());
                    request.setAttribute("productName", product.getProductName());
                    request.setAttribute("productCode", product.getProductCode());
                    request.setAttribute("productPrice", product.getProductPrice());
                    request.setAttribute("productCategory", product.getProductCategory());
                    request.setAttribute("productSize", product.getProductSize());
                    request.setAttribute("productColor", product.getProductColor());
                    request.setAttribute("productQuantity", product.getProductQuantity());
                    request.setAttribute("productDescription", product.getProductDescription());
                    request.setAttribute("categories", productDAO.getAllProducts().stream()
                            .map(ProductObject::getProductCategory)
                            .distinct()
                            .collect(Collectors.toList()));
                    RequestDispatcher rd = request.getRequestDispatcher("/views/admin/add-product.jsp");
                    rd.forward(request, response);
                    return;
                }

                // Lưu sản phẩm vào database
                boolean success = productDAO.insertProduct(product);
                if (success) {
                    response.sendRedirect("admin-manage-product?success=add");
                } else {
                    throw new Exception("Không thể thêm sản phẩm.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi khi thêm sản phẩm: " + e.getMessage());
                request.setAttribute("productName", product.getProductName());
                request.setAttribute("productCode", product.getProductCode());
                request.setAttribute("productPrice", product.getProductPrice());
                request.setAttribute("productCategory", product.getProductCategory());
                request.setAttribute("productSize", product.getProductSize());
                request.setAttribute("productColor", product.getProductColor());
                request.setAttribute("productQuantity", product.getProductQuantity());
                request.setAttribute("productDescription", product.getProductDescription());
                request.setAttribute("categories", productDAO.getAllProducts().stream()
                        .map(ProductObject::getProductCategory)
                        .distinct()
                        .collect(Collectors.toList()));
                RequestDispatcher rd = request.getRequestDispatcher("/views/admin/add-product.jsp");
                rd.forward(request, response);
            }
        }
    }
}