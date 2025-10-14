package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DetailProduct;

public class ProductDetailDAO extends DBContext {

    public int getQuantityByProductColorSize(String productId, int colorId, int sizeId) {
        String sql = "SELECT quantity FROM detail_product WHERE productId = ? AND colorId = ? AND sizeId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productId);
            ps.setInt(2, colorId);
            ps.setInt(3, sizeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantity");
                }
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<DetailProduct> getListProductDetail(String productId) {
        List<DetailProduct> list = new ArrayList<>();
        String sql = "SELECT * FROM detail_product WHERE productId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DetailProduct detail = new DetailProduct();
                    detail.setProductId(rs.getString("productId"));
                    detail.setSizeId(rs.getInt("sizeId"));
                    detail.setColorId(rs.getInt("colorId"));
                    detail.setQuantity(rs.getInt("quantity"));
                    list.add(detail);
                }
            }
        } catch (SQLException exception) {
        }
        return list;
    }

    public DetailProduct getDetailProduct(String productId, int colorId, int sizeId) {
        DetailProduct detail = null;
        String sql = "SELECT * FROM detail_product WHERE productId = ? AND colorId = ? AND sizeId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            st.setInt(2, colorId);
            st.setInt(3, sizeId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    detail = new DetailProduct();
                    detail.setProductId(rs.getString("productId"));
                    detail.setColorId(rs.getInt("colorId"));
                    detail.setSizeId(rs.getInt("sizeId"));
                    detail.setQuantity(rs.getInt("quantity"));
                }
            }
        } catch (SQLException e) {
        }
        return detail;
    }

    public boolean updateStock(String productId, int sizeId, int colorId, int quantityToSubtract) {
        String sql = "UPDATE detail_product "
                + "SET quantity = quantity - ? "
                + "WHERE productId = ? AND sizeId = ? AND colorId = ? "
                + "AND quantity >= ?"; // Đảm bảo không bị âm

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quantityToSubtract);
            st.setString(2, productId);
            st.setInt(3, sizeId);
            st.setInt(4, colorId);
            st.setInt(5, quantityToSubtract);
            int affected = st.executeUpdate();
            return affected > 0; // true nếu update thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        ProductDetailDAO pddao = new ProductDetailDAO();
        int q = pddao.getQuantityByProductColorSize("ST0001", 1, 1);
        System.out.println(q);
        DetailProduct detail = pddao.getDetailProduct("ST0001", 1, 1);
        System.out.println(detail.getProductId());
    }
}
