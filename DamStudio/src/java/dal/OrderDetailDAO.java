package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;

public class OrderDetailDAO extends DBContext {

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM orderdetail WHERE orderId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(
                        rs.getInt("orderDetailId"),
                        rs.getInt("orderId"),
                        rs.getString("productId"),
                        rs.getInt("sizeId"),
                        rs.getInt("colorId"),
                        rs.getInt("quantity"),
                        rs.getInt("isFeedback")
                );
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

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

    public List<OrderDetail> getOrderDetail(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT \n"
                + "    od.orderDetailId,\n"
                + "    od.orderId,\n"
                + "    od.productId,\n"
                + "    od.sizeId,\n"
                + "    od.colorId,\n"
                + "    od.quantity,\n"
                + "    od.isFeedback,\n"
                + "    p.name AS productName,\n"
                + "    p.description,\n"
                + "    p.price,\n"
                + "    p.VAT,\n"
                + "    b.name AS brandName,\n"
                + "    c.colorName,\n"
                + "    s.sizeName,\n"
                + "    pi.imageUrl,\n"
                + "    o.createDate,\n"
                + "    os.description AS statusDescription\n"
                + "FROM orderdetail od\n"
                + "JOIN product p ON od.productId = p.productId\n"
                + "JOIN brand b ON p.brandId = b.brandId\n"
                + "JOIN color c ON od.colorId = c.colorId\n"
                + "JOIN size s ON od.sizeId = s.sizeId\n"
                + "JOIN `order` o ON od.orderId = o.orderId\n"
                + "JOIN orderstatus os ON o.orderStatus = os.statusId\n"
                + "LEFT JOIN detail_product dp \n"
                + "       ON dp.productId = od.productId \n"
                + "      AND dp.sizeId = od.sizeId \n"
                + "      AND dp.colorId = od.colorId\n"
                + "LEFT JOIN productimage pi \n"
                + "       ON dp.imageId = pi.imageId\n"
                + "WHERE od.orderId = ?\n"
                + "ORDER BY o.createDate DESC;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    OrderDetail orderDetail = new OrderDetail(
                            rs.getInt("orderId"),
                            rs.getTimestamp("createDate"),
                            rs.getString("productId"),
                            rs.getString("productName"),
                            rs.getInt("quantity"),
                            rs.getString("colorName"),
                            rs.getString("imageUrl"),
                            rs.getInt("isfeedback"),
                            rs.getInt("orderDetailId"),
                            rs.getDouble("price"),
                            rs.getString("description")
                    );
                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<OrderDetail> getOrderInforById(Integer orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.orderDetailId, od.orderId, od.productId, od.sizeId, od.colorId, "
                + "od.quantity, od.isFeedback "
                + "FROM orderdetail od "
                + "WHERE od.orderId = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                OrderDetail o = new OrderDetail(
                        rs.getInt("orderDetailId"),
                        rs.getInt("orderId"),
                        rs.getString("productId"),
                        rs.getInt("sizeId"),
                        rs.getInt("colorId"),
                        rs.getInt("quantity"),
                        rs.getInt("isFeedback"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi
        }
        return list;
    }

    public static void main(String[] args) {
        OrderDetailDAO dao = new OrderDetailDAO();
        List<OrderDetail> list = dao.getOrderInforById(1); // giả sử orderId = 1

        if (list.isEmpty()) {
            System.out.println("Không tìm thấy chi tiết đơn hàng!");
        } else {
            for (OrderDetail od : list) {
                System.out.println("OrderDetailId: " + od.getOrderDetailId()
                        + ", OrderId: " + od.getOrderId()
                        + ", ProductId: " + od.getProductId()
                        + ", Size: " + od.getSizeId()
                        + ", Color: " + od.getColorId()
                        + ", Qty: " + od.getQuantity());
            }
        }
    }
}
