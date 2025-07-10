package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Size;

public class SizeDAO extends DBContext {

    public List<Size> getAllSize() {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM size where sizeStatus = 1";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Size size = new Size();
                size.setSizeId(rs.getInt("sizeId"));
                size.setSizeName(rs.getString("sizeName"));
                size.setHeightMin(rs.getInt("heightMin"));
                size.setHeightMax(rs.getInt("heightMax"));
                size.setWeightMin(rs.getInt("weightMin"));
                size.setWeightMax(rs.getInt("weightMax"));
                list.add(size);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllSize: " + e.getMessage());
        }
        return list;
    }

    public List<Size> getAllSizeOfProduct(String productId) {
        List<Size> sizes = new ArrayList<>();
        String sql = "SELECT DISTINCT s.* FROM detail_product dp "
                + "JOIN size s ON dp.sizeId = s.sizeId "
                + "WHERE dp.productId = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Size s = new Size(
                        rs.getInt("sizeId"),
                        rs.getString("sizeName"),
                        rs.getInt("heightMin"),
                        rs.getInt("heightMax"),
                        rs.getInt("weightMin"),
                        rs.getInt("weightMax"),
                        rs.getInt("sizeStatus")
                );
                sizes.add(s);
            }
        } catch (SQLException e) {
        }
        return sizes;
    }

    public Size getSizeOfProduct(String productId) {
        String sql = "SELECT s.* FROM detail_product dp "
                + "JOIN size s ON dp.sizeId = s.sizeId "
                + "WHERE dp.productId = ? AND s.sizeStatus = 1 LIMIT 1";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Size(
                        rs.getInt("sizeId"),
                        rs.getString("sizeName"),
                        rs.getInt("heightMin"),
                        rs.getInt("heightMax"),
                        rs.getInt("weightMin"),
                        rs.getInt("weightMax"),
                        rs.getInt("sizeStatus")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Nên log lỗi để dễ debug
        }
        return null; // Trả về null nếu không có kết quả
    }

    public Size getSizeOfProduct2(int sizeId) {
        String sql = "SELECT * FROM size WHERE sizeId = ? AND sizeStatus = 1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, sizeId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Size(
                        rs.getInt("sizeId"),
                        rs.getString("sizeName"),
                        rs.getInt("heightMin"),
                        rs.getInt("heightMax"),
                        rs.getInt("weightMin"),
                        rs.getInt("weightMax"),
                        rs.getInt("sizeStatus")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        SizeDAO dao = new SizeDAO();
        Size size = dao.getSizeOfProduct("ST0001");
        System.out.println(size.getHeightMax());
    }
}
