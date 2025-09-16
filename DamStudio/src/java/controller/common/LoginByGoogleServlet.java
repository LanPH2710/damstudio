package controller.common;

import dal.LoginDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.GoogleAccount;
import model.Inconstant;

public class LoginByGoogleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        LoginDAO gg = new LoginDAO();

        try {
            String accessToken = gg.getToken(code);
            GoogleAccount ggAccount = gg.getUserInfo(accessToken);
            String firstName = ggAccount.getGiven_name();
            String lastName = ggAccount.getFamily_name();
            String gender = "2";
            String email = ggAccount.getEmail();
            String picture = ggAccount.getPicture();
            String password = Inconstant.generateRandomPassword(8);
//            String cpass = HashPassword.toSHA1(password);

            HttpSession session = request.getSession();
            LoginDAO login = new LoginDAO();

            Account account = login.getByEmail(email);

            if (account == null) {
                login.inserUserByEmail(email, password, firstName, lastName, gender, email, "", picture);
                account = login.getByEmail(email);
            }

            session.setAttribute("account", account);
            session.setMaxInactiveInterval(60 * 600);
            request.getRequestDispatcher("homepage").forward(request, response);
        } catch (Exception e) {
            // Ghi lại lỗi để dễ dàng debug
            e.printStackTrace();
            // Chuyển hướng đến trang lỗi tùy chỉnh
            response.sendRedirect("error.jsp");
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
