package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Color;

public class ColorDAO extends DBContext {

    public List<Color> getColorOfProduct(String productId) {
        List<Color> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT c.colorId, c.colorName, c.colorStatus\n"
                + "        FROM detail_product dp\n"
                + "        JOIN color c ON dp.colorId = c.colorId\n"
                + "        WHERE dp.productId = ? and c.colorStatus = 1";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int colorId = rs.getInt("colorId");
                String colorName = rs.getString("colorName");
                int colorStatus = rs.getInt("colorStatus");
                colors.add(new Color(colorId, colorName, colorStatus));
            }
        } catch (SQLException e) {
        }
        return colors;
    }
    
    public Color getColorById(int colorId) {
        Color color = null;
        String sql = "SELECT * FROM color WHERE colorId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, colorId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                color = new Color();
                color.setColorId(rs.getInt("colorId"));
                color.setColorName(rs.getString("colorName"));
                color.setColorStatus(rs.getInt("colorStatus"));
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        return color;
    }

    public static void main(String[] args) {
        ColorDAO colorDAO = new ColorDAO();
        String productId = "ST0001"; // Thay bằng productId bạn muốn test

        List<Color> colors = colorDAO.getColorOfProduct(productId);

        if (colors.isEmpty()) {
            System.out.println("Không tìm thấy màu nào cho sản phẩm có ID: " + productId);
        } else {
            System.out.println("Danh sách màu cho sản phẩm " + productId + ":");
            for (Color color : colors) {
                System.out.println("• ID: " + color.getColorId() + ", Tên màu: " + color.getColorName());
            }
        }
    }
}
