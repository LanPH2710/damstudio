package controller.order;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderStatusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Order;
import model.OrderDetail;
import model.OrderStatus;

public class OrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String orderId = request.getParameter("orderId");
        int orIdParam = Integer.parseInt(orderId);
        OrderDetailDAO oddao = new OrderDetailDAO();
        OrderDAO odao = new OrderDAO();
        OrderStatusDAO osdao = new OrderStatusDAO();
        
        Order order = odao.getOrderById(acc.getUserId(), orIdParam);
        OrderStatus orderstatus = osdao.getOrderStatusById(order.getOrderStatus());
        List<OrderDetail> orderInfor = oddao.getOrderInforById(orIdParam);
        request.setAttribute("orderInfor", orderInfor);
        request.setAttribute("order", order);
        request.setAttribute("orderstatus", orderstatus);
        request.getRequestDispatcher("orderDetail.jsp").forward(request, response);
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
