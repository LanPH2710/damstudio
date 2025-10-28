package controller.order;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order;
import model.OrderDetail;

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
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        ProductDetailDAO dpdao = new ProductDetailDAO();

        int userId = Integer.parseInt(request.getParameter("userId"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int payMethod = Integer.parseInt(request.getParameter("payMethod"));

        Order order = odao.getOrderById(userId, orderId);
        if (order == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không tìm thấy đơn hàng hoặc không thuộc về bạn.");
            return;
        }

        if (order.getOrderStatus() != 1) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Đơn hàng đã được xử lý, không thể hủy.");
            return;
        }

        // Cập nhật trạng thái
        odao.cancelOrder(orderId);

        // ✅ Cộng lại tồn kho
        List<OrderDetail> orderDetails = oddao.getOrderDetailsByOrderId(orderId);
        for (OrderDetail od : orderDetails) {
            dpdao.updateQuantity2(od.getProductId(), od.getSizeId(), od.getColorId(), od.getQuantity());
        }

        // ✅ Xử lý riêng nếu có phương thức thanh toán
        if (payMethod == 3) {
            request.getSession().setAttribute("cancelMessage",
                    "Nếu bạn đã chuyển tiền, vui lòng liên hệ với shop qua "
                    + "<a href='https://www.facebook.com/profile.php?id=61581282917311' target='_blank'>Facebook</a> để hoàn tiền.");
        }

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
