package dal;

import context.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OrderDAO extends DBContext {

    // 1. Hàm ngắn gọn: gọi trong controller khi tạo đơn hàng thông thường
    public int addOrder(int userId, String orderName, String orderEmail, String orderPhone,
            BigDecimal totalPrice, String shippingAddress,
            int orderStatus, int payMethod) {
        // Truyền các trường còn lại là null (hoặc default) cho hàm đầy đủ
        return addOrder(userId, orderName, orderEmail, orderPhone, totalPrice,
                null, orderStatus, payMethod, null, null, shippingAddress);
    }

    // 2. Hàm đầy đủ: dùng khi cần truyền hết các field (mặc định các trường null sẽ được setNull)
    public int addOrder(Integer userId, String orderName, String orderEmail, String orderPhone,
            BigDecimal totalPrice, String note, Integer orderStatus, Integer payMethod,
            Integer voucherId, Integer shipId, String shippingAddress) {
        int orderId = -1;
        String sql = "INSERT INTO `order` "
                + "(orderDeliverCode, userId, orderName, orderEmail, orderPhone, totalPrice, note, orderStatus, payMethod, voucherId, shipId, createDate, shippingAddress) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String deliverCode = "DEL" + (System.currentTimeMillis() % 1000000);
        java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());

        try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, deliverCode);
            if (userId != null) {
                st.setInt(2, userId);
            } else {
                st.setNull(2, java.sql.Types.INTEGER);
            }
            st.setString(3, orderName);
            st.setString(4, orderEmail);
            st.setString(5, orderPhone);
            st.setBigDecimal(6, totalPrice);
            st.setString(7, note); // Có thể null

            if (orderStatus != null) {
                st.setInt(8, orderStatus);
            } else {
                st.setNull(8, java.sql.Types.INTEGER);
            }
            if (payMethod != null) {
                st.setInt(9, payMethod);
            } else {
                st.setNull(9, java.sql.Types.INTEGER);
            }
            if (voucherId != null) {
                st.setInt(10, voucherId);
            } else {
                st.setNull(10, java.sql.Types.INTEGER);
            }
            if (shipId != null) {
                st.setInt(11, shipId);
            } else {
                st.setNull(11, java.sql.Types.INTEGER);
            }
            st.setTimestamp(12, now);
            st.setString(13, shippingAddress);

            st.executeUpdate();

            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }
}
