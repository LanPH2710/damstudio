package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderDetailDAO extends DBContext {

    public boolean addOrderDetail(int orderId, String productId, int sizeId, int colorId, int quantity, int isFeedback) {
        String sql = "INSERT INTO orderdetail (orderId, productId, sizeId, colorId, quantity, isFeedback) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            st.setString(2, productId);
            st.setInt(3, sizeId);
            st.setInt(4, colorId);
            st.setInt(5, quantity);
            st.setInt(6, isFeedback);
            int affected = st.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
