package dao;

import java.util.List;

import model.ProductObject;
import model.ProductImageObject;

public interface IProductDAO {
	List<ProductObject> getAllProducts();
	ProductObject getProductById(int id);
	boolean insertProduct(ProductObject product);
	boolean updateProduct(ProductObject product);
	boolean deleteProduct(int id);
    double getTotalRevenue();
    double getTotalInventoryValue();
    
    List<ProductObject> getDeletedProducts(); // Thêm phương thức lấy sản phẩm trong thùng rác
    boolean restoreProduct(int id); // Thêm phương thức khôi phục
    boolean permanentlyDeleteProduct(int id); // Thêm phương thức xóa vĩnh viễn


}
