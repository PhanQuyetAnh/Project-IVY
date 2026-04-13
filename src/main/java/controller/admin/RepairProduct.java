package controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
import dao.CategoryDAO;
import dao.Impl.CategoryDAOImpl;
import model.ProductObject;
import model.CategoryObject;

/**
 * Servlet implementation class RepairProduct
 */
@WebServlet("/admin/admin-repair-product")
public class RepairProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductDAO productDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        productDAO = new ProductImpl();
        categoryDAO = new CategoryDAOImpl();
    }

    // Hàm đệ quy làm phẳng cây Menu để đưa vào thẻ <select>
    private List<CategoryObject> getFlatCategoryList() {
        List<CategoryObject> tree = categoryDAO.getMenuTree();
        List<CategoryObject> flatList = new ArrayList<>();
        for (CategoryObject root : tree) {
            flatList.add(root);
            if (root.getChildren() != null) {
                for (CategoryObject child : root.getChildren()) {
                    flatList.add(child);
                    if (child.getChildren() != null) {
                        flatList.addAll(child.getChildren());
                    }
                }
            }
        }
        return flatList;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        ProductObject product = null;
        List<CategoryObject> categories = null;

        try {
            product = productDAO.getProductById(Integer.parseInt(id));
            categories = getFlatCategoryList(); // ĐÃ SỬA: Lấy danh mục từ CategoryDAO
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu sản phẩm.");
        }

        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/repair-product.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            ProductObject product = new ProductObject();
            String imagePath = null;
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString("UTF-8");
                        switch (fieldName) {
                            case "productId":
                                product.setProductId(Integer.parseInt(fieldValue));
                                break;
                            case "productName":
                                product.setProductName(fieldValue);
                                break;
                            case "productCode":
                                product.setProductCode(fieldValue);
                                break;
                            case "productPrice":
                                product.setProductPrice(Double.parseDouble(fieldValue));
                                break;
                            case "categoryId": // ĐÃ SỬA: Lấy ID danh mục (int) thay vì productCategory (String)
                                product.setCategoryId(Integer.parseInt(fieldValue));
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
                            case "productImagePath":
                                imagePath = fieldValue; // Đây là đường dẫn ảnh cũ
                                break;
                        }
                    } else if (item.getFieldName().equals("productImage") && item.getSize() > 0) {
                        String fileName = new File(item.getName()).getName();
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "templates" + File.separator + "admin" + File.separator + "img";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        String newImagePath = "/templates/admin/img/" + uniqueFileName;
                        File storeFile = new File(uploadPath + File.separator + uniqueFileName);
                        item.write(storeFile);

                        // ĐÃ SỬA: Đặt ảnh vào đúng thuộc tính Image1 (giống hàm Update trong DAO)
                        product.setProductImage1(newImagePath);
                    }
                }

                // Nếu người dùng không upload ảnh mới, sử dụng lại ảnh cũ
                if (product.getProductImage1() == null && imagePath != null && !imagePath.isEmpty()) {
                    product.setProductImage1(imagePath);
                }

                // Server-side validation
                StringBuilder errors = new StringBuilder();
                if (product.getProductName() == null || product.getProductName().trim().isEmpty()) {
                    errors.append("Tên sản phẩm không được để trống.\n");
                }
                if (product.getProductCode() == null || product.getProductCode().trim().isEmpty()) {
                    errors.append("Mã sản phẩm không được để trống.\n");
                }
                if (product.getProductPrice() <= 0) {
                    errors.append("Giá sản phẩm phải là số dương.\n");
                }
                if (product.getCategoryId() <= 0) { // ĐÃ SỬA: Validate ID danh mục
                    errors.append("Danh mục không được để trống.\n");
                }
                if (product.getProductColor() == null || product.getProductColor().trim().isEmpty()) {
                    errors.append("Màu sắc không được để trống.\n");
                }
                if (product.getProductSize() == null || product.getProductSize().trim().isEmpty()) {
                    errors.append("Kích cỡ không được để trống.\n");
                }
                if (product.getProductQuantity() < 0) {
                    errors.append("Số lượng phải là số không âm.\n");
                }
                if (product.getProductDescription() == null || product.getProductDescription().trim().isEmpty()) {
                    errors.append("Mô tả sản phẩm không được để trống.\n");
                }

                if (errors.length() > 0) {
                    System.out.println("Validation errors: " + errors.toString());
                    request.setAttribute("error", errors.toString());
                    request.setAttribute("product", product);
                    request.setAttribute("categories", getFlatCategoryList()); // Nạp lại danh mục khi có lỗi
                    RequestDispatcher rd = request.getRequestDispatcher("/views/admin/repair-product.jsp");
                    rd.forward(request, response);
                    return;
                }

                // Cập nhật sản phẩm trong database
                boolean success = productDAO.updateProduct(product);
                if (success) {
                    System.out.println("Product updated successfully");
                    // Nạp thông báo thành công vào Session để JSP hứng được
                    request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/admin-manage-product");
                    // ----------------------
                } else {
                    throw new Exception("Không thể cập nhật sản phẩm.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Error updating product: " + e.getMessage());
                request.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
                request.setAttribute("product", product);
                request.setAttribute("categories", getFlatCategoryList());
                RequestDispatcher rd = request.getRequestDispatcher("/views/admin/repair-product.jsp");
                rd.forward(request, response);
            }
        }
    }
}