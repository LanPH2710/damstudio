package controller.admin;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;

public class ManagerUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AccountDAO accountDAO = new AccountDAO();

        // Lấy keyword tìm kiếm (nếu có)
        String keyword = request.getParameter("keyword");

        // Lấy danh sách account theo keyword hoặc toàn bộ
        List<Account> allAccounts;
        if (keyword != null && !keyword.trim().isEmpty()) {
            allAccounts = accountDAO.getAccountByKeyword(keyword.trim());
        } else {
            allAccounts = accountDAO.getAllAccount();
        }

        // Nếu không có dữ liệu
        if (allAccounts == null || allAccounts.isEmpty()) {
            request.setAttribute("message", "Không có tài khoản nào trong hệ thống.");
            request.getRequestDispatcher("controllUser.jsp").forward(request, response);
            return;
        }

        // ===== PHÂN TRANG =====
        int page, numberPage = 10; // số tài khoản mỗi trang
        int size = allAccounts.size();
        int numPage = (int) Math.ceil((double) size / numberPage); // tổng số trang
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
           page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * numberPage;
        int end = Math.min(page * numberPage, size);
        List<Account> currentPageList = accountDAO.getAccountListByPage(allAccounts, start, end);

        // Gửi dữ liệu sang JSP
        request.setAttribute("accountList", currentPageList);
        request.setAttribute("totalPage", numPage);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);

        // Chuyển đến trang hiển thị
        request.getRequestDispatcher("controllUser.jsp").forward(request, response);
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
