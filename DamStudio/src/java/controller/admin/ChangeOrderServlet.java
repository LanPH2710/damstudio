package controller.admin;

import dal.AccountDAO;
import dal.ColorDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import dal.ProductDetailDAO;
import dal.SizeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Order;
import model.OrderDetail;

public class ChangeOrderServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangeOrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeOrderServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDAO odao = new OrderDAO();
        AccountDAO adao = new AccountDAO();
        ProductDAO productDAO = new ProductDAO();
        ProductDetailDAO pddao = new ProductDetailDAO();
        ColorDAO colorDAO = new ColorDAO();
        SizeDAO sizeDAO = new SizeDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        List<Order> allOrder = new ArrayList<>();
        Map<Integer, List<OrderDetail>> orderDetailsMap = new HashMap<>();
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int totalQuantitySTTT = 0;
        int totalQuantitySTHG = 0;
        
        totalQuantitySTTT = odao.getTotalQuantitySale("TT0001");
        totalQuantitySTHG = odao.getTotalQuantitySale("ST0001");
        
        int userId = account.getUserId();
        int statusId = 0;
        String statusIdParam = request.getParameter("statusId");
        if (statusIdParam != null && !statusIdParam.isEmpty()) {
            try {
                statusId = Integer.parseInt(statusIdParam);
            } catch (NumberFormatException e) {
                // Xử lý ngoại lệ khi chuyển đổi statusId
                e.printStackTrace(); // Log lỗi
                request.setAttribute("error", "Status ID không hợp lệ.");
            }
        }
        if (statusId > 0) {
            allOrder = odao.getAllOrderByStatus(statusId);
        } else {
            allOrder = odao.getAllOrder();
        }
        for (Order order : allOrder) {
            List<OrderDetail> orderDetails = oddao.getOrderDetail(order.getOrderId());
            orderDetailsMap.put(order.getOrderId(), orderDetails);
        }
        // Phân trang
        int page, numperpage = 15;
        int size = allOrder.size();
        int num = (int) Math.ceil((double) size / numperpage); // Số trang, làm tròn lên
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * numperpage;
        int end = Math.min(page * numperpage, size);
        allOrder = odao.getMyOrderListByPage(allOrder, start, end);

        request.setAttribute("allOrder", allOrder);
        request.setAttribute("totalQuantitySTHG", totalQuantitySTHG);
        request.setAttribute("totalQuantitySTTT", totalQuantitySTTT);
        request.setAttribute("orderDetailsMap", orderDetailsMap);
        request.setAttribute("page", page);
        request.setAttribute("statusId", statusId);
        request.setAttribute("num", num);
        request.getRequestDispatcher("adminOrder.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDAO odao = new OrderDAO();
        int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        odao.updateOrderStatus(orderId, orderStatus);
        response.sendRedirect("changeorder");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
