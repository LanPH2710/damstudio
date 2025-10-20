package controller.admin;

import dal.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;

public class ManagerUserServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 10;

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

        // Lấy số trang hiện tại (mặc định là 1)
        int page = 1;
        String keyword = request.getParameter("keyword");
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Account> allAccounts;
        if(keyword != null && !keyword.isEmpty()){
            allAccounts = accountDAO.getAccountByKeyword(keyword);
        }else{
            allAccounts = accountDAO.getAllAccount();
        }
        
        int totalUsers = allAccounts.size();

        // Tính chỉ số bắt đầu và kết thúc
        int start = (page - 1) * RECORDS_PER_PAGE;
        int end = Math.min(start + RECORDS_PER_PAGE, totalUsers);

        // Lấy danh sách user cho trang hiện tại
        List<Account> currentPageList = allAccounts.subList(start, end);

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalUsers / RECORDS_PER_PAGE);

        // Gửi dữ liệu sang JSP
        request.setAttribute("accountList", currentPageList);
        request.setAttribute("totalPage", totalPages);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);

        // Nếu không có dữ liệu
        if (allAccounts == null || allAccounts.isEmpty()) {
            request.setAttribute("message", "Không có tài khoản nào trong hệ thống.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("controllUser.jsp");
        dispatcher.forward(request, response);
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
