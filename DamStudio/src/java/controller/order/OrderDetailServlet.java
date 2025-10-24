package controller.order;

import dal.ColorDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderStatusDAO;
import dal.ProductDAO;
import dal.SizeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Brand;
import model.Color;
import model.Order;
import model.OrderDetail;
import model.OrderStatus;
import model.Product;
import model.Size;

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
        String userIdParam = request.getParameter("userId");
        int orIdParam = Integer.parseInt(orderId);
        int userId = Integer.parseInt(userIdParam);
        OrderDetailDAO oddao = new OrderDetailDAO();
        OrderDAO odao = new OrderDAO();
        OrderStatusDAO osdao = new OrderStatusDAO();
        ProductDAO prodao = new ProductDAO();
        SizeDAO sdao = new SizeDAO();
        ColorDAO cdao = new ColorDAO();

        Order order = odao.getOrderById(userId, orIdParam);
        OrderStatus orderstatus = osdao.getOrderStatusById(order.getOrderStatus());
        List<OrderDetail> orderInfor = oddao.getOrderInforById(orIdParam);
        List<Color> color = new ArrayList<>();
        List<Size> size = new ArrayList<>();
        List<Product> pro = new ArrayList<>();
        for (OrderDetail od : orderInfor) {
            Product p = prodao.getProductById(od.getProductId());
            if (p != null) {
                pro.add(p);
            }
            Size s = sdao.getSize(od.getSizeId());
            if (s != null) {
                size.add(s);
            }
            Color c = cdao.getColorByProductId(od.getColorId());
            if (c != null) {
                color.add(c);
            }
        }
        request.setAttribute("orderInfor", orderInfor);
        request.setAttribute("pro", pro);
        request.setAttribute("size", size);
        request.setAttribute("color", color);
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
