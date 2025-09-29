package controller.order;

import dal.AccountDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;

public class CancelOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CancelOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelOrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO od = new OrderDAO();
        AccountDAO adao = new AccountDAO();
        int userId = Integer.parseInt(request.getParameter("userId"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int payMethod = Integer.parseInt(request.getParameter("payMethod"));

        // Kiểm tra xem tham số totalPrice có tồn tại và hợp lệ không
        String totalPriceStr = request.getParameter("totalPrice");
        BigDecimal totalPrice = (totalPriceStr != null && !totalPriceStr.isEmpty())
                ? new BigDecimal(totalPriceStr)
                : BigDecimal.ZERO;  // Giá trị mặc định nếu không có giá trị hợp lệ

        // Hủy đơn hàng
        if (payMethod == 2) {
            // Thanh toán khi nhận hàng => hủy luôn
            od.cancelOrder(orderId);
        } else if (payMethod == 3) {
            // Thanh toán chuyển khoản => hiện thông báo
            request.getSession().setAttribute("cancelMessage", "Nếu bạn đã chuyển tiền, xin vui lòng nhắn tin với shop qua "
                    + "<a href='https://www.facebook.com/Bear27102004' target='_blank'>Facebook</a> để lấy lại tiền.");
        }
//        // Hoàn lại tiền cho người dùngì
//        if (payMethod == 1 || payMethod==3) {
//            adao.payback(userId, totalPrice);
//        }
        response.sendRedirect("order");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
