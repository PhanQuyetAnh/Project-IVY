package dao.Impl;

import java.sql.*;
import java.util.List;
import dao.IProductDAO;
import model.ProductObject;
import util.DBUtil;

/**
 * Test cases cho ProductImpl
 * Chạy các test này để verify hệ thống 4 ảnh sản phẩm
 */
public class ProductImplTest {

    public static void main(String[] args) {
        ProductImpl productDao = new ProductImpl();

        System.out.println("=== PRODUCT DAO TEST ===\n");

        // TEST 1: Get All Products
        System.out.println("TEST 1: getAllProducts()");
        testGetAllProducts(productDao);

        // TEST 2: Get Product By ID
        System.out.println("\nTEST 2: getProductById()");
        testGetProductById(productDao);

        // TEST 3: Get Deleted Products
        System.out.println("\nTEST 3: getDeletedProducts()");
        testGetDeletedProducts(productDao);

        // TEST 4: Create New Product
        System.out.println("\nTEST 4: insertProduct()");
        testInsertProduct(productDao);

        System.out.println("\n=== END OF TESTS ===");
    }

    private static void testGetAllProducts(ProductImpl productDao) {
        try {
            List<ProductObject> products = productDao.getAllProducts();
            System.out.println("✓ Total products: " + products.size());

            if (!products.isEmpty()) {
                ProductObject p = products.get(0);
                System.out.println("  First product:");
                System.out.println("    - Name: " + p.getProductName());
                System.out.println("    - Image1: " + p.getProductImage1());
                System.out.println("    - Image2: " + p.getProductImage2());
                System.out.println("    - Image3: " + p.getProductImage3());
                System.out.println("    - Image4: " + p.getProductImage4());
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void testGetProductById(ProductImpl productDao) {
        try {
            // Thay đổi ID theo dữ liệu của bạn
            int testId = 1;
            ProductObject product = productDao.getProductById(testId);

            if (product != null) {
                System.out.println("✓ Found product: " + product.getProductName());
                System.out.println("  - ID: " + product.getProductId());
                System.out.println("  - Code: " + product.getProductCode());
                System.out.println("  - Price: " + product.getProductPrice());
                System.out.println("  - Quantity: " + product.getProductQuantity());
                System.out.println("  - Images count: " + (product.getProductImages() != null ?
                                   product.getProductImages().size() : 0));

                // Check if 4 images are properly populated
                if (product.getProductImages() != null) {
                    for (int i = 0; i < product.getProductImages().size(); i++) {
                        System.out.println("    Image " + (i+1) + ": " +
                                         product.getProductImages().get(i).getImageUrl());
                    }
                }
            } else {
                System.out.println("✗ Product not found with ID: " + testId);
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void testGetDeletedProducts(ProductImpl productDao) {
        try {
            List<ProductObject> deletedProducts = productDao.getDeletedProducts();
            System.out.println("✓ Total deleted products: " + deletedProducts.size());

            if (!deletedProducts.isEmpty()) {
                ProductObject p = deletedProducts.get(0);
                System.out.println("  First deleted product:");
                System.out.println("    - Name: " + p.getProductName());
                System.out.println("    - Deleted: " + p.isDeleted());
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void testInsertProduct(ProductImpl productDao) {
        try {
            // Tạo sản phẩm test
            ProductObject testProduct = new ProductObject();
            testProduct.setProductCode("TEST-SKU-001");
            testProduct.setProductName("Test Product");
            testProduct.setProductImage1("/templates/test/img1.jpg");
            testProduct.setProductImage2("/templates/test/img2.jpg");
            testProduct.setProductImage3("/templates/test/img3.jpg");
            testProduct.setProductImage4("/templates/test/img4.jpg");
            testProduct.setProductPrice(99999);
            testProduct.setProductQuantity(100);
            testProduct.setProductColor("Red");
            testProduct.setProductSize("S,M,L");
            testProduct.setProductDescription("Test Description");
            testProduct.setProductCategory("Test Category");

            boolean result = productDao.insertProduct(testProduct);

            if (result) {
                System.out.println("✓ Product inserted successfully");
            } else {
                System.out.println("✗ Failed to insert product");
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

