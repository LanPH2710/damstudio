package controller.cart;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ChangeCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangeCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeCartServlet at " + request.getContextPath() + "</h1>");
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
        String colorIdStr = request.getParameter("colorId");
        String sizeIdStr = request.getParameter("sizeId");
        try (PrintWriter out = response.getWriter()) {
            if (cartIdStr != null && colorIdStr != null && sizeIdStr != null) {
                int cartId = Integer.parseInt(cartIdStr);
                int colorId = Integer.parseInt(colorIdStr);
                int sizeId = Integer.parseInt(sizeIdStr);
                CartDAO cartDAO = new CartDAO();
                try {
                    boolean updated = cartDAO.updateCartVariant(cartId, colorId, sizeId);
                    out.print(updated ? "OK" : "Không thể cập nhật phân loại!");
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("Không thể cập nhật phân loại!");
                }
            } else {
                out.print("Dữ liệu gửi lên thiếu!");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
