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

    public List<Product> searchProductsByKeyword(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE REPLACE(name, ' ', '') LIKE CONCAT('%', REPLACE(?, ' ', ''), '%') AND status = 1";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId())); // Thêm hình ảnh vào sản phẩm
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<ProductImage> getImagesByProductId(String productId) {
        List<ProductImage> images = new ArrayList<>();
        String query = "SELECT pi.imageId, pi.imageUrl "
                + "FROM damstudio.detail_product dp "
                + "JOIN damstudio.productimage pi ON dp.imageId = pi.imageId "
                + "WHERE dp.productId = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, productId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ProductImage image = new ProductImage();
                    image.setImageId(resultSet.getInt("imageId"));
                    image.setImageUrl(resultSet.getString("imageUrl"));
                    images.add(image);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return images;
    }

    public List<Product> getAllProductByBrandId(String braId) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "select * from damstudio.product where brandId = ? AND status = 1";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, braId);

            ResultSet resultSet = st.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId())); // Thêm hình ảnh vào sản phẩm
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return products;
    }
    
    public List<Product> getAllProductByStyleId(String styleId) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "select * from product where styleId = ? AND status = 1";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, styleId);

            ResultSet resultSet = st.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId())); // Thêm hình ảnh vào sản phẩm
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return products;
    }
    
    public List<Product> getAllProductBySizeId(String sizeId) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "select * from damstudio.product where sizeId = ? AND status = 1";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, sizeId);

            ResultSet resultSet = st.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId())); // Thêm hình ảnh vào sản phẩm
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return products;
    }
    
    public List<Product> getAllProductsCommon() {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM product where status = 1"; // Thay đổi tên bảng cho đúng
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet resultSet = st.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId())); // Thêm hình ảnh vào sản phẩm
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return products;
    }
    
    public Product getProductById(String productId) { // Thay đổi kiểu tham số về String
        Product product = null;
        try {
            // Câu truy vấn lấy thông tin sản phẩm dựa trên productId
            String sql = "SELECT * FROM product WHERE productId = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, productId); // Sửa đổi để phù hợp với kiểu dữ liệu
            ResultSet resultSet = st.executeQuery();

            if (resultSet.next()) {
                // Tạo đối tượng Product với các thông tin lấy từ ResultSet
                product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId()));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy sản phẩm theo ID: " + e.getMessage());
        }
        return product;
    }
    
    public List<Product> getProductByPrice(double price) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE price BETWEEN ? AND ? LIMIT 8;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, price - 20000);
            st.setDouble(2, price + 20000);
            ResultSet resultSet = st.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getString("productId"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setVAT(resultSet.getDouble("VAT"));
                product.setBrandId(resultSet.getInt("brandId"));
                product.setStyleId(resultSet.getInt("styleId"));
                product.setImages(getImagesByProductId(product.getProductId()));
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        Product pro = dao.getProductById("ST0001");
        List<Product> price = dao.getProductByPrice(200000);
        System.out.println(price.get(2).getName() + price.get(1).getName());
        System.out.println(pro.getName());
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
