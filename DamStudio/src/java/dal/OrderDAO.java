package dal;

import context.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Order;

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

    public List<Order> getOrderByStatus(int userId, int status) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM `order` "
                + "WHERE userId = ? AND orderStatus = ? "
                + "ORDER BY createDate DESC";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, status);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order(
                            resultSet.getInt("orderId"),
                            resultSet.getString("orderDeliverCode"),
                            resultSet.getInt("userId"),
                            resultSet.getString("orderName"),
                            resultSet.getString("orderEmail"),
                            resultSet.getString("orderPhone"),
                            resultSet.getBigDecimal("totalPrice"),
                            resultSet.getString("note"),
                            resultSet.getInt("orderStatus"),
                            resultSet.getInt("payMethod"),
                            resultSet.getInt("voucherId"),
                            resultSet.getInt("shipId"),
                            resultSet.getTimestamp("createDate"), // giữ nguyên cả ngày và giờ
                            resultSet.getString("shippingAddress")
                    );
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalQuantitySale(String productId) {
        String query = "SELECT IFNULL(SUM(od.quantity), 0) AS totalSold "
                + "FROM orderdetail od "
                + "JOIN `order` o ON od.orderId = o.orderId "
                + "WHERE od.productId = ? "
                + "AND o.orderStatus IN (2, 3, 4)"; // chỉ tính đơn đã xác nhận, đang giao, đã giao xong

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, productId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalSold");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> getAllOrderByStatus(int status) {
        List<Order> orders = new ArrayList<>();
        String query = "String query = \"\"\"\n"
                + "    SELECT o.*, a.firstName, a.lastName, a.email\n"
                + "    FROM `order` o\n"
                + "    JOIN account a ON o.userId = a.userId\n"
                + "    WHERE o.orderStatus = ?\n"
                + "    ORDER BY o.createDate DESC\n"
                + "\"\"\";";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, status);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                            rs.getInt("orderId"),
                            rs.getString("orderDeliverCode"),
                            rs.getInt("userId"),
                            rs.getString("orderName"),
                            rs.getString("orderEmail"),
                            rs.getString("orderPhone"),
                            rs.getBigDecimal("totalPrice"),
                            rs.getString("note"),
                            rs.getInt("orderStatus"),
                            rs.getInt("payMethod"),
                            rs.getInt("voucherId"),
                            rs.getInt("shipId"),
                            rs.getTimestamp("createDate"),
                            rs.getString("shippingAddress")
                    );

                    // Gán thông tin account cho Order
                    Account acc = new Account();
                    acc.setUserId(rs.getInt("userId"));
                    acc.setFirstName(rs.getString("firstName"));
                    acc.setLastName(rs.getString("lastName"));
                    acc.setEmail(rs.getString("email"));
                    order.setAccount(acc);

                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int userId, int orderId) {
        String query = "SELECT * FROM `order` "
                + "WHERE userId = ? AND orderId = ? "
                + "ORDER BY createDate DESC";

        Order order = null; // khai báo trước vòng lặp

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) { // vì chỉ có 1 orderId duy nhất
                    order = new Order(
                            resultSet.getInt("orderId"),
                            resultSet.getString("orderDeliverCode"),
                            resultSet.getInt("userId"),
                            resultSet.getString("orderName"),
                            resultSet.getString("orderEmail"),
                            resultSet.getString("orderPhone"),
                            resultSet.getBigDecimal("totalPrice"),
                            resultSet.getString("note"),
                            resultSet.getInt("orderStatus"),
                            resultSet.getInt("payMethod"),
                            resultSet.getInt("voucherId"),
                            resultSet.getInt("shipId"),
                            resultSet.getTimestamp("createDate"),
                            resultSet.getString("shippingAddress")
                    );
                }
            }
        } catch (SQLException e) {
        }
        return order;
    }

    public List<Order> getOrderByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * "
                + "FROM `order` "
                + "WHERE userId = ? "
                + "ORDER BY createDate desc, orderStatus ASC ";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order(
                            resultSet.getInt("orderId"),
                            resultSet.getString("orderDeliverCode"),
                            resultSet.getInt("userId"),
                            resultSet.getString("orderName"),
                            resultSet.getString("orderEmail"),
                            resultSet.getString("orderPhone"),
                            resultSet.getBigDecimal("totalPrice"),
                            resultSet.getString("note"),
                            resultSet.getInt("orderStatus"),
                            resultSet.getInt("payMethod"),
                            resultSet.getInt("voucherId"),
                            resultSet.getInt("shipId"),
                            resultSet.getTimestamp("createDate"), // giữ nguyên cả ngày và giờ
                            resultSet.getString("shippingAddress")
                    );
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrder() {
        List<Order> orders = new ArrayList<>();
        String query = """
        SELECT o.*, a.firstName, a.lastName, a.email
        FROM `order` o
        JOIN account a ON o.userId = a.userId
        ORDER BY o.createDate DESC, o.orderStatus ASC
    """;

        try (PreparedStatement statement = connection.prepareStatement(query); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderId"),
                        rs.getString("orderDeliverCode"),
                        rs.getInt("userId"),
                        rs.getString("orderName"),
                        rs.getString("orderEmail"),
                        rs.getString("orderPhone"),
                        rs.getBigDecimal("totalPrice"),
                        rs.getString("note"),
                        rs.getInt("orderStatus"),
                        rs.getInt("payMethod"),
                        rs.getInt("voucherId"),
                        rs.getInt("shipId"),
                        rs.getTimestamp("createDate"),
                        rs.getString("shippingAddress")
                );

                // Gán thông tin account cho Order
                Account acc = new Account();
                acc.setUserId(rs.getInt("userId"));
                acc.setFirstName(rs.getString("firstName"));
                acc.setLastName(rs.getString("lastName"));
                acc.setEmail(rs.getString("email"));
                order.setAccount(acc);

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getMyOrderListByPage(List<Order> order, int start, int end) {
        ArrayList<Order> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(order.get(i));
        }
        return arr;
    }

    public void cancelOrder(int orderId) {
        String sql = "UPDATE `order` SET orderStatus = 5 WHERE orderId = ?;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderStatus(int orderId, int orderStatus) {
        String query = "UPDATE `order` SET orderStatus = ? WHERE orderId = ?;";
        try (PreparedStatement st = connection.prepareStatement(query)) {
            st.setInt(1, orderStatus);
            st.setInt(2, orderId);
            st.executeUpdate(); // Gọi phương thức này để thực hiện cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        int quantity = 0;
        int userId = 1;   // thay bằng userId thực tế có trong DB
        int statusId = 1; // ví dụ: 1 = chờ xác nhận, 2 = đã giao... tùy DB của bạn
        quantity = dao.getTotalQuantitySale("TT0001");
        System.out.println(quantity);
        System.out.println("===== Test getOrderByUserId =====");
        List<Order> ordersByUser = dao.getOrderByUserId(userId);
        for (Order o : ordersByUser) {
            System.out.println(o);
        }

        System.out.println("\n===== Test getOrderByStatus =====");
        List<Order> ordersByStatus = dao.getOrderByStatus(userId, statusId);
        for (Order o : ordersByStatus) {
            System.out.println(o);
        }

        System.out.println("\n===== Test getMyOrderListByPage =====");
        if (!ordersByUser.isEmpty()) {
            int page = 1;
            int numPerPage = 3; // test hiển thị 3 đơn/1 trang
            int start = (page - 1) * numPerPage;
            int end = Math.min(page * numPerPage, ordersByUser.size());

            List<Order> paginatedOrders = dao.getMyOrderListByPage(ordersByUser, start, end);
            for (Order o : paginatedOrders) {
                System.out.println(o);
            }
        } else {
            System.out.println("Không có đơn hàng để test phân trang!");
        }

    }
}
