package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;

public class CartDAO extends DBContext {

    // Lấy danh sách giỏ hàng của user
    public List<Cart> getCartsByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.* "
                + "FROM cart c "
                + "JOIN detail_product dp ON c.productId = dp.productId AND c.sizeId = dp.sizeId AND c.colorId = dp.colorId "
                + "JOIN color col ON c.colorId = col.colorId "
                + "JOIN size s ON c.sizeId = s.sizeId "
                + "WHERE c.userId = ? "
                + "AND col.colorStatus = 1 "
                + "AND s.sizeStatus = 1 "
                + "AND dp.quantity > 0";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cartId = rs.getInt("cartId");
                String productId = rs.getString("productId");
                int sizeId = rs.getInt("sizeId");
                int colorId = rs.getInt("colorId");
                int cartQuantity = rs.getInt("cartQuantity");
                Cart cart = new Cart(cartId, userId, productId, sizeId, colorId, cartQuantity);
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public List<Cart> getInactiveCartsByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.* "
                + "FROM cart c "
                + "JOIN detail_product dp ON c.productId = dp.productId AND c.sizeId = dp.sizeId AND c.colorId = dp.colorId "
                + "JOIN color col ON c.colorId = col.colorId "
                + "JOIN size s ON c.sizeId = s.sizeId "
                + "WHERE c.userId = ? "
                + "AND (col.colorStatus = 0 OR s.sizeStatus = 0 OR dp.quantity < 1)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cartId = rs.getInt("cartId");
                String productId = rs.getString("productId");
                int sizeId = rs.getInt("sizeId");
                int colorId = rs.getInt("colorId");
                int cartQuantity = rs.getInt("cartQuantity");
                Cart cart = new Cart(cartId, userId, productId, sizeId, colorId, cartQuantity);
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    // Lấy cartId đầu tiên theo userId (nếu có)
    public Integer getCartIdByUserId(int userId) {
        String sql = "SELECT cartId FROM cart WHERE userId = ? LIMIT 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Đếm số lượng cart (item) của user
    public int countCartsByUserId(int userId) {
        int totalCarts = 0;
        String sql = "SELECT COUNT(*) AS totalCarts FROM cart WHERE userId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalCarts = rs.getInt("totalCarts");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCarts;
    }

    // Lấy số lượng sản phẩm trong giỏ theo userId và productId
    public int getQuantityByUserIdAndProductId(int userId, String productId) {
        String sql = "SELECT cartQuantity FROM cart WHERE userId = ? AND productId = ?";
        int quantity = -1;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("cartQuantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    // Lấy cartId theo userId và productId
    public int getCartIdByUserIdAndProductId(int userId, String productId) throws SQLException {
        String sql = "SELECT cartId FROM cart WHERE userId = ? AND productId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
            return -1;
        }
    }

    public int getCartId(int userId, String productId, int sizeId, int colorId) throws SQLException {
        String sql = "SELECT cartId FROM cart WHERE userId = ? AND productId = ? and sizeId = ? and colorId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, productId);
            ps.setInt(3, sizeId);
            ps.setInt(4, colorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
            return -1;
        }
    }

    // Thêm sản phẩm vào giỏ hàng
    public boolean addToCart(int userId, String productId, int sizeId, int colorId, int quantity) throws SQLException {
        String sql = "INSERT INTO cart (userId, productId, sizeId, colorId, cartQuantity) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, productId);
            ps.setInt(3, sizeId);
            ps.setInt(4, colorId);
            ps.setInt(5, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    public void updateQuantityByCartId(int cartId, int quantity, boolean isSet) {
        String sql;
        if (isSet) {
            sql = "UPDATE Cart SET cartQuantity = ? WHERE cartId = ?";
        } else {
            sql = "UPDATE Cart SET cartQuantity = cartQuantity + ? WHERE cartId = ?";
        }
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quantity);
            st.setInt(2, cartId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteCartItem(int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE cartId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateCartQuantity(int cartId, int newQuantity) throws SQLException {
        String sql = "UPDATE cart SET cartQuantity = ? WHERE cartId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateCartVariant(int cartId, int colorId, int sizeId) throws SQLException {
        String sql = "UPDATE cart SET colorId = ?, sizeId = ? WHERE cartId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, colorId);
            ps.setInt(2, sizeId);
            ps.setInt(3, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Cart> getCartsByCartIds(List<Integer> cartIds) {
        if (cartIds == null || cartIds.isEmpty()) {
            return new ArrayList<>();
        }
        String inSql = cartIds.stream().map(id -> "?").collect(java.util.stream.Collectors.joining(","));
        String sql = "SELECT * FROM cart WHERE cartId IN (" + inSql + ")";
        List<Cart> carts = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < cartIds.size(); i++) {
                ps.setInt(i + 1, cartIds.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getInt("cartId"),
                        rs.getInt("userId"),
                        rs.getString("productId"),
                        rs.getInt("sizeId"),
                        rs.getInt("colorId"),
                        rs.getInt("cartQuantity") // Sửa lại tên field đúng với DB nếu khác!
                );
                carts.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carts;
    }

    public void updateQuantityToExact(int cartId, int quantity) throws SQLException {
        String sql = "UPDATE Cart SET cartQuantity = ? WHERE cartId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quantity);
            st.setInt(2, cartId);
            st.executeUpdate();
        }
    }

    public int getQuantityByCartId(int cartId) {
        int quantity = 0;
        String sql = "SELECT cartQuantity FROM Cart WHERE cartId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cartId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("cartQuantity");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    // Demo test các hàm DAO
    public static void main(String[] args) {
        CartDAO dao = new CartDAO();
        int testUserId = 1;

        List<Cart> carts = dao.getCartsByUserId(testUserId);
        System.out.println("Danh sách giỏ hàng của userId = " + testUserId + ":");
        for (Cart cart : carts) {
            System.out.println("Cart ID: " + cart.getCartId()
                    + ", Product ID: " + cart.getProductId()
                    + ", Size ID: " + cart.getSizeId()
                    + ", Color ID: " + cart.getColorId()
                    + ", Quantity: " + cart.getCartQuantity());
        }

        Integer cartId = dao.getCartIdByUserId(testUserId);
        if (cartId != null) {
            System.out.println("Cart ID đầu tiên của userId " + testUserId + ": " + cartId);
        } else {
            System.out.println("Không tìm thấy giỏ hàng cho userId " + testUserId);
        }
    }
}
