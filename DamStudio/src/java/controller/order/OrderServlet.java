package controller.order;

import dal.ColorDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Color;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Size;

public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        ColorDAO colorDAO = new ColorDAO();
        SizeDAO sizeDAO = new SizeDAO();
        ProductDAO prodao = new ProductDAO();

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = account.getUserId();
        int statusId = 0;
        String statusIdParam = request.getParameter("statusId");

        if (statusIdParam != null && !statusIdParam.isEmpty()) {
            try {
                statusId = Integer.parseInt(statusIdParam);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Status ID không hợp lệ.");
            }
        }

        List<Product> pro = new ArrayList<>();
        // Lấy danh sách đơn hàng theo người dùng và trạng thái
        List<Order> myOrder = (statusId > 0)
                ? odao.getOrderByStatus(userId, statusId)
                : odao.getOrderByUserId(userId);

        // Map lưu thông tin chi tiết mỗi đơn
        Map<Integer, List<OrderDetail>> orderDetailsMap = new HashMap<>();

        // Vòng lặp từng đơn hàng
        for (Order order : myOrder) {
            List<OrderDetail> orderDetails = oddao.getOrderInforById(order.getOrderId());

            for (OrderDetail detail : orderDetails) {
                int colorId = detail.getColorId();
                int sizeId = detail.getSizeId();
                Product p = prodao.getProductInOrder(detail.getProductId());
                if (p != null) {
                    pro.add(p);
                }
                // Lấy đối tượng Color và Size tương ứng
                Color color = colorDAO.getColorById(colorId);
                Size size = sizeDAO.getSize(sizeId);

                // Gắn thêm vào detail nếu bạn có field để hiển thị tên
                detail.setColorName(color.getColorName());
                detail.setSizeName(size.getSizeName());
            }

            // Sau khi hoàn thiện danh sách chi tiết, thêm vào map
            orderDetailsMap.put(order.getOrderId(), orderDetails);
        }

        // --- PHÂN TRANG ---
        int page, numPerPage = 5;
        int size = myOrder.size();
        int num = (int) Math.ceil((double) size / numPerPage);

        String xpage = request.getParameter("page");
        page = (xpage == null) ? 1 : Integer.parseInt(xpage);

        int start = (page - 1) * numPerPage;
        int end = Math.min(page * numPerPage, size);

        myOrder = odao.getMyOrderListByPage(myOrder, start, end);

        // --- GỬI DỮ LIỆU QUA JSP ---
        request.setAttribute("myOrder", myOrder);
        request.setAttribute("pro", pro);
        request.setAttribute("orderDetailsMap", orderDetailsMap);
        request.setAttribute("page", page);
        request.setAttribute("statusId", statusId);
        request.setAttribute("num", num);

        request.getRequestDispatcher("myOrder.jsp").forward(request, response);
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
