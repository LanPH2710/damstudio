package controller.cart;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.Account;
import model.Cart;

public class DeleteCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteCartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String cartIdsParam = request.getParameter("cartIds");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = account.getUserId();

        boolean anyDeleted = false; // Dùng để xác định có sản phẩm nào bị xóa không
        CartDAO cartDAO = new CartDAO();

        try (PrintWriter out = response.getWriter()) {
            if (cartIdsParam != null && !cartIdsParam.isEmpty()) {
                String[] cartIdArray = cartIdsParam.split(",");
                boolean allDeleted = true;
                for (String idStr : cartIdArray) {
                    try {
                        int cartId = Integer.parseInt(idStr.trim());
                        boolean deleted = false;
                        try {
                            deleted = cartDAO.deleteCartItem(cartId);
                        } catch (SQLException exception) {
                            exception.printStackTrace();
                            allDeleted = false;
                            continue; // bỏ qua cartId lỗi này, xử lý tiếp các cái khác
                        }
                        if (deleted) {
                            anyDeleted = true; // Nếu có ít nhất một sản phẩm bị xóa
                        } else {
                            allDeleted = false;
                        }
                    } catch (NumberFormatException e) {
                        allDeleted = false;
                    }
                }
                // Cập nhật badge cart sau khi xóa (nếu có xóa)
                if (anyDeleted) {
                    List<Cart> cartList = cartDAO.getCartsByUserId(userId);
                    int cartCount = cartList != null ? cartList.size() : 0;
                    session.setAttribute("cartCount", cartCount);
                }
                out.print(allDeleted ? "OK" : "ERROR");
            } else {
                // Support old single delete for backward compatibility
                String cartIdStr = request.getParameter("cartId");
                boolean deleted = false;
                if (cartIdStr != null) {
                    try {
                        int cartId = Integer.parseInt(cartIdStr.trim());
                        deleted = cartDAO.deleteCartItem(cartId);
                        // Cập nhật badge cart nếu xóa thành công
                        if (deleted) {
                            List<Cart> cartList = cartDAO.getCartsByUserId(userId);
                            int cartCount = cartList != null ? cartList.size() : 0;
                            session.setAttribute("sizeCart", cartCount);
                        }
                        out.print(deleted ? "OK" : "ERROR");
                    } catch (Exception e) {
                        out.print("ERROR");
                    }
                } else {
                    out.print("ERROR");
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
