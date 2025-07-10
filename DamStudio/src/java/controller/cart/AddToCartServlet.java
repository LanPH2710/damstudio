package controller.cart;

import dal.CartDAO;
import dal.ProductDAO;
import dal.ProductDetailDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import model.Account;
import model.DetailProduct;
import model.Product;

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        ProductDetailDAO pddao = new ProductDetailDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        // 1. Check login
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Get & validate params
        String productId = request.getParameter("productId");
        String colorIdParam = request.getParameter("colorId");
        String sizeIdParam = request.getParameter("sizeId");
        String quantityStr = request.getParameter("quantity");
        String buyNowParam = request.getParameter("buynow");

        if (productId == null || colorIdParam == null || sizeIdParam == null || quantityStr == null
                || productId.isEmpty() || colorIdParam.isEmpty() || sizeIdParam.isEmpty() || quantityStr.isEmpty()) {
            response.sendRedirect("productdetail?productId=" + productId + "&msg=fail");
            return;
        }

        int colorId, sizeId, quantity;
        try {
            colorId = Integer.parseInt(colorIdParam);
            sizeId = Integer.parseInt(sizeIdParam);
            quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                response.sendRedirect("productdetail?productId=" + productId + "&msg=fail");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("productdetail?productId=" + productId + "&msg=fail");
            return;
        }

        try {
            int userId = account.getUserId();
            // 3. Check sản phẩm, biến thể tồn tại
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect("productdetail?productId=" + productId + "&msg=fail");
                return;
            }
            DetailProduct detail = pddao.getDetailProduct(productId, colorId, sizeId);
            if (detail == null) {
                response.sendRedirect("productdetail?productId=" + productId + "&msg=fail");
                return;
            }

            // 4. Lấy đúng cartId theo biến thể
            int cartId = cartDAO.getCartId(userId, productId, sizeId, colorId);

            // 5. Lấy số lượng hiện tại (nếu đã có trong giỏ)
            int quantityCurrent = 0;
            if (cartId != -1) {
                quantityCurrent = cartDAO.getQuantityByCartId(cartId);
            }

            // 6. Check tồn kho
            if (quantity + (("1".equals(buyNowParam)) ? 0 : quantityCurrent) > detail.getQuantity()) {
                response.sendRedirect("productdetail?productId=" + productId + "&msg=overstock");
                return;
            }

            // 7. Phân nhánh: Mua ngay vs Thêm vào giỏ
            if ("1".equals(buyNowParam)) {
                // ======== MUA NGAY =========
                if (cartId == -1) {
                    cartDAO.addToCart(userId, productId, sizeId, colorId, quantity);
                    // Sau khi thêm mới, lấy lại cartId thật để truyền cho checkout
                    cartId = cartDAO.getCartId(userId, productId, sizeId, colorId);
                } else {
                    cartDAO.updateQuantityByCartId(cartId, quantity, true); // true: set lại số lượng, không cộng dồn
                }
                int sizeCart = cartDAO.countCartsByUserId(userId);
                session.setAttribute("sizeCart", sizeCart);
                response.sendRedirect("checkout?cartIds=" + cartId);
                return;
            } else {
                // ======= THÊM VÀO GIỎ (cộng dồn số lượng) =========
                if (cartId == -1) {
                    cartDAO.addToCart(userId, productId, sizeId, colorId, quantity);
                } else {
                    int newQuantity = quantityCurrent + quantity;
                    cartDAO.updateQuantityByCartId(cartId, newQuantity, true); // true: set quantity mới
                }
                int sizeCart = cartDAO.countCartsByUserId(userId);
                session.setAttribute("sizeCart", sizeCart);
                response.sendRedirect("productdetail?productId=" + productId + "&msg=success");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("productdetail?productId=" + request.getParameter("productId") + "&msg=fail");
        }
    }

    @Override
    public String getServletInfo() {
        return "AddToCartServlet for Gen Z! - Siêu chuẩn nghiệp vụ, không bao giờ truyền cartId -1.";
    }
}
