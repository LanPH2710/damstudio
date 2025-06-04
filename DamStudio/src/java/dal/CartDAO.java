package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;

public class CartDAO extends DBContext {

    public List<Cart> getCartsByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE userId = ? AND isDeleted = 0 ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Assuming your Cart class has a constructor that takes these parameters
                int cartId = rs.getInt("cartId");
                String productId = rs.getString("productId");
                int sizeId = rs.getInt("sizeId");
                int colorId = rs.getInt("colorId");
                int cartQuantity = rs.getInt("cartQuantity");
                int isSelect = rs.getInt("isSelect");

                Cart cart = new Cart(cartId, userId, productId, sizeId, colorId, cartQuantity, isSelect, 0);
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
        return cartList;
    }

    public Integer getCartIdByUserId(int userId) {
        String sql = "SELECT cartId FROM cart WHERE userId = ? LIMIT 1"; // Adjust based on your SQL dialect

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // or throw an exception if no cart is found
    }

    public int countCartsByUserId(int userId) {
        int totalCarts = 0;  // Variable to hold the count
        String sql = "SELECT COUNT(*) AS totalCarts "
                + "FROM damstudio.cart "
                + "WHERE userId = ? AND isDeleted = 0";  // Ensure only active carts are counted

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);  // Set the userId parameter
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalCarts = rs.getInt("totalCarts");  // Retrieve the count
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Print the stack trace to help debug any SQL errors
        }
        return totalCarts;  // Return the total count
    }

    public static void main(String[] args) {
        CartDAO dao = new CartDAO();
        int testUserId = 1; // Giả sử userId = 1 tồn tại trong bảng cart

        // Test phương thức getCartsByUserId
        List<Cart> carts = dao.getCartsByUserId(testUserId);
        System.out.println("Danh sách giỏ hàng của userId = " + testUserId + ":");
        for (Cart cart : carts) {
            System.out.println("Cart ID: " + cart.getCartId()
                    + ", Product ID: " + cart.getProductId()
                    + ", Size ID: " + cart.getSizeId()
                    + ", Color ID: " + cart.getColorId()
                    + ", Quantity: " + cart.getCartQuantity()
                    + ", Is Selected: " + cart.getIsSelect());
        }

        // Test phương thức getCartIdByUserId
        Integer cartId = dao.getCartIdByUserId(testUserId);
        if (cartId != null) {
            System.out.println("Cart ID đầu tiên của userId " + testUserId + ": " + cartId);
        } else {
            System.out.println("Không tìm thấy giỏ hàng cho userId " + testUserId);
        }
    }
}
