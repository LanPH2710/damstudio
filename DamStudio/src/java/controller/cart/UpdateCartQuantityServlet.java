package controller.cart;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateCartQuantityServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateCartQuantityServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCartQuantityServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String cartIdStr = request.getParameter("cartId");
        String quantityStr = request.getParameter("cartQuantity");
        try (PrintWriter out = response.getWriter()) {
            if (cartIdStr != null && quantityStr != null) {
                int cartId = Integer.parseInt(cartIdStr);
                int cartQuantity = Integer.parseInt(quantityStr);
                CartDAO cartDAO = new CartDAO();
                boolean updated = false;
                try {
                    updated = cartDAO.updateCartQuantity(cartId, cartQuantity);
                } catch (Exception ex) {
                    ex.printStackTrace(); // Có thể log ra file hoặc console tùy mục tiêu
                }
                out.print(updated ? "OK" : "ERROR");
            } else {
                out.print("ERROR");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
