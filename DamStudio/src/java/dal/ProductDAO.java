package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductImage;

public class ProductDAO extends DBContext {

    public List<Product> getProductsByProductIdPrefix(String prefix, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, MIN(pi.imageUrl) as imageUrl "
                + "FROM product p "
                + "LEFT JOIN detail_product dp ON p.productId = dp.productId "
                + "LEFT JOIN productimage pi ON dp.imageId = pi.imageId "
                + "WHERE p.productId LIKE ? "
                + "GROUP BY p.productId, p.name, p.price, p.description, p.VAT, p.brandId, p.styleId "
                + "ORDER BY p.productId DESC "
                + "LIMIT ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, prefix + "%");
            st.setInt(2, limit);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getString("productId"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDescription(rs.getString("description"));
                    product.setVAT(rs.getDouble("VAT"));
                    product.setBrandId(rs.getInt("brandId"));
                    product.setStyleId(rs.getInt("styleId"));

                    // Lấy ảnh đầu tiên
                    List<ProductImage> images = new ArrayList<>();
                    String imageUrl = rs.getString("imageUrl");
                    if (imageUrl != null) {
                        ProductImage image = new ProductImage();
                        image.setImageUrl(imageUrl);  // Cần có setter trong class ProductImage
                        images.add(image);
                    }
                    product.setImages(images);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductByProductId(String productId) {
        String productSql = "SELECT * FROM product WHERE productId = ?";
        String imageSql = "SELECT pi.imageUrl FROM detail_product dp "
                + "JOIN productimage pi ON dp.imageId = pi.imageId "
                + "WHERE dp.productId = ?";
        Product product = null;
        try (PreparedStatement psProduct = connection.prepareStatement(productSql)) {
            psProduct.setString(1, productId);
            try (ResultSet rs = psProduct.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductId(rs.getString("productId"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDescription(rs.getString("description"));
                    product.setVAT(rs.getDouble("VAT"));
                    product.setBrandId(rs.getInt("brandId"));
                    product.setStyleId(rs.getInt("styleId"));
                    product.setStatus(rs.getInt("status"));

                    // Lấy danh sách hình ảnh
                    List<ProductImage> images = new ArrayList<>();
                    try (PreparedStatement psImage = connection.prepareStatement(imageSql)) {
                        psImage.setString(1, productId);
                        try (ResultSet rsImg = psImage.executeQuery()) {
                            while (rsImg.next()) {
                                ProductImage img = new ProductImage();
                                img.setImageUrl(rsImg.getString("imageUrl"));
                                images.add(img);
                            }
                        }
                    }
                    product.setImages(images);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        System.out.println("--- Lấy 5 sản phẩm có tiền tố 'TT' ---");
        List<Product> ttProducts = dao.getProductsByProductIdPrefix("TT", 5);
        if (ttProducts.isEmpty()) {
            System.out.println("Không tìm thấy sản phẩm nào với tiền tố 'TT'.");
        } else {
            for (Product p : ttProducts) {
                System.out.println("Mã SP: " + p.getProductId() + ", Tên: " + p.getName() + ", Giá: " + p.getPrice());
                if (p.getImages() != null && !p.getImages().isEmpty()) {
                    System.out.println("  Ảnh: " + p.getImages().get(0).getImageUrl());
                } else {
                    System.out.println("  Không có ảnh.");
                }
                System.out.println("--------------------");
            }
        }
    }
}
