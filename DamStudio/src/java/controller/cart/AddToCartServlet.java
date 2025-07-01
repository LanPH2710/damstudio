package controller.cart;

import dal.CartDAO;
import dal.ProductDAO;
import dal.ProductDetailDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
    String urlHistory = (String) session.getAttribute("urlHistory");
    urlHistory = (urlHistory == null) ? "home" : urlHistory;

    // Check login
    if (account == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String productId = request.getParameter("productId");
    String colorIdParam = request.getParameter("colorId");
    String sizeIdParam = request.getParameter("sizeId");
    String quantityStr = request.getParameter("quantity");

    // Input validation
    if (productId == null || colorIdParam == null || sizeIdParam == null || quantityStr == null
            || productId.isEmpty() || colorIdParam.isEmpty() || sizeIdParam.isEmpty() || quantityStr.isEmpty()) {
        response.getWriter().write("Thông tin sản phẩm không hợp lệ.");
        return;
    }

    int colorId, sizeId, quantity;
    try {
        colorId = Integer.parseInt(colorIdParam);
        sizeId = Integer.parseInt(sizeIdParam);
        quantity = Integer.parseInt(quantityStr);
        if (quantity <= 0) {
            response.getWriter().write("Số lượng phải lớn hơn 0.");
            return;
        }
    } catch (NumberFormatException e) {
        response.getWriter().write("Dữ liệu nhập không hợp lệ.");
        return;
    }

    try {
        int userId = account.getUserId();
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            response.getWriter().write("Sản phẩm không tồn tại.");
            return;
        }
        DetailProduct detail = pddao.getDetailProduct(productId, colorId, sizeId);
        if (detail == null) {
            response.getWriter().write("Không tìm thấy chi tiết sản phẩm.");
            return;
        }
        int quantityCurrent = cartDAO.getQuantityByUserIdAndProductId(userId, productId);

        if ((quantity + quantityCurrent) > detail.getQuantity()) {
            request.setAttribute("mesOfCart", "Số lượng vượt quá tồn kho.");
            response.sendRedirect("productdetail?productId="+ productId);
            return;
        }

        int cartId = cartDAO.getCartId(userId, productId, sizeId, colorId);

        if (cartId == -1) {
            cartDAO.addToCart(userId, productId, sizeId, colorId, quantity);
        } else {
            cartDAO.updateQuantityByCartId(cartId, quantity);
        }

        int sizeCart = cartDAO.countCartsByUserId(userId);
        session.setAttribute("sizeCart", sizeCart);
        request.setAttribute("mesOfCart", "Thêm vào giỏ thành công!");
        response.sendRedirect("productdetail?productId="+ productId);

    } catch (SQLException ex) {
        ex.printStackTrace();
        request.setAttribute("mesOfCart", "Lỗi hệ thống, vui lòng thử lại sau!");
        request.getRequestDispatcher(urlHistory).forward(request, response);
    }
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}