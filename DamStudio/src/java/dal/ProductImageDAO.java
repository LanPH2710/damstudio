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
        String sql = "SELECT imageId, imageUrl, isMain FROM productimage WHERE productId = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductImage img = new ProductImage();
                img.setImageId(rs.getInt("imageId"));
                img.setProductId(productId);
                img.setImageUrl(rs.getString("imageUrl"));
                img.setIsMain(rs.getBoolean("isMain"));
                images.add(img);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public ProductImage getMainImageByProductId(String productId) {
        String sql = "SELECT imageId, productId, imageUrl, isMain "
                + "FROM productimage "
                + "WHERE productId = ? AND isMain = TRUE "
                + "LIMIT 1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new ProductImage(
                            rs.getInt("imageId"),
                            rs.getString("productId"),
                            rs.getString("imageUrl"),
                            rs.getBoolean("isMain")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
