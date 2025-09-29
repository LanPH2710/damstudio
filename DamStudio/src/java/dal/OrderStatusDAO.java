package dal;

import context.DBContext;
import model.OrderStatus;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderStatusDAO extends DBContext{
    public OrderStatus getOrderStatusById(int satusId) {
        OrderStatus orderStatus= null;
        String sql = "SELECT * FROM orderstatus WHERE satusId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, satusId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                orderStatus = new OrderStatus();
                orderStatus.setStatusId(rs.getInt("statusId"));
                orderStatus.setStatusName(rs.getString("statusName"));
                orderStatus.setDescription(rs.getString("description"));
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        return orderStatus;
    }
}
