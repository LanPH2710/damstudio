package controller.common;

import context.DBContext;
import dal.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NewPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewPasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewPasswordServlet at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        AccountDAO dao = new AccountDAO();
                boolean isPasswordValid = dao.isValidPassword(newPassword);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("newPassword.jsp");

        if (!isPasswordValid) {
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 1 chữ cái viết hoa và 1 số.");
            dispatcher.forward(request, response);
            return;}
        if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
            DBContext dbContext = new DBContext();
            Connection con = null;
            try {
                con = dbContext.getConnection();
                if (con != null) {
                    // Mã hóa mật khẩu trước khi lưu
//                    String hashedPassword = HashPassword.toSHA1(newPassword);
                    PreparedStatement pst = con.prepareStatement("UPDATE account SET password = ? WHERE email = ?");
                    pst.setString(1, newPassword);
                    pst.setString(2, (String) session.getAttribute("email"));

                    int rowCount = pst.executeUpdate();
                    if (rowCount > 0) {
                        request.setAttribute("status", "resetSuccess");
                                    request.setAttribute("message", "doi mat khau thanh cong.");

                    } else {
                        request.setAttribute("status", "resetFailed");
                    }
                    dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // Xử lý khi không thể lấy kết nối
                    request.setAttribute("status", "dbConnectionError");
                    dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("status", "resetFailed");
                dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            } finally {
                if (con != null) {
                    try {
                        con.close(); // Đảm bảo kết nối được đóng
                    } catch (SQLException e) {
                        Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, "Failed to close the connection", e);
                    }
                }
            }
        } else {
            request.setAttribute("status", "passwordMismatch");
            request.setAttribute("errorMessage", "Mật khẩu xac nhan khong dung.");
            dispatcher = request.getRequestDispatcher("newPassword.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
