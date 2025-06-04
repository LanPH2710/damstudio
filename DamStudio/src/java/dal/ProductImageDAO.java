package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ProductImage;

public class ProductImageDAO extends DBContext {

    public List<ProductImage> getImagesByProductId(String productId) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT DISTINCT pi.imageId, pi.imageUrl "
                + // Lấy cả imageId nếu bạn cần
                "FROM detail_product dp "
                + "JOIN productimage pi ON dp.imageId = pi.imageId "
                + "WHERE dp.productId = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ProductImage image = new ProductImage();
                    image.setImageId(rs.getInt("imageId"));   // Set imageId nếu cần
                    image.setImageUrl(rs.getString("imageUrl"));
                    images.add(image);
                }
            }
        } catch (SQLException exception) {
        }
        return images;
    }
    
    
}
