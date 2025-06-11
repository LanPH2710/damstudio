package controller.common;

import dal.AccountDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeUtility;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import model.Account;

public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang đăng ký
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đặt encoding để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");  // Sửa từ userName thành username
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String genderStr = request.getParameter("gender");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");

        // Kiểm tra các trường bắt buộc
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || firstName == null || firstName.trim().isEmpty()
                || lastName == null || lastName.trim().isEmpty()
                || genderStr == null || genderStr.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || mobile == null || mobile.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
            return;
        }

        int gender;
        try {
            gender = Integer.parseInt(genderStr.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Giới tính không hợp lệ.");
            forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
            return;
        }

        AccountDAO dao = new AccountDAO();

        try {
            Account existingUser = dao.checkUserNameExists(username);
            Account existingEmail = dao.checkEmailExists(email);
            Account existingMobile = dao.checkMobileExists(mobile);

            if (existingUser != null) {
                request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại.");
                forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
                return;
            } else if (existingEmail != null) {
                request.setAttribute("errorMessage", "Email đã đăng ký.");
                forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
                return;
            } else if (existingMobile != null) {
                request.setAttribute("errorMessage", "Số điện thoại đã đăng ký.");
                forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
                return;
            }
            // Tạo mã xác thực (có thể bỏ qua nếu không cần)
            String confirmationCode = java.util.UUID.randomUUID().toString();

            // Chèn thông tin vào database và thiết lập trạng thái là pending
            Account newAccount = new Account(username, password, firstName, lastName, gender, email, mobile, address, 1); // 2 = pending
            dao.insertAccount(newAccount);

            // Gửi email xác nhận
            sendConfirmationEmail(email, confirmationCode);

            // Chuyển hướng đến trang đăng nhập với thông báo thành công
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.");
            forwardToRegisterPage(request, response, username, password, firstName, lastName, genderStr, email, mobile, address);
        }
    }
    
    private void sendConfirmationEmail(String toEmail, String confirmationCode) {
        // Cấu hình thuộc tính máy chủ gửi mail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        // Tạo phiên gửi mail với xác thực
        Session session = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("carpipi1904@gmail.com", "fyvtiafvzyheblfw");
            }
        });

        // Soạn thảo email xác nhận
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("carpipi1904@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

//            message.setSubject("Xác nhận đăng ký tài khoản");
                message.setSubject(MimeUtility.encodeText("Xác nhận đăng ký tài khoản", "UTF-8", "B"));
            //String confirmationLink = "http://localhost:9999/Iter1_Test/confirm?email=" + toEmail; // Đảm bảo thay đổi 'yourapp' thành tên ứng dụng của bạn
//            message.setText("Vui lòng nhấp vào liên kết sau để xác nhận tài khoản của bạn: " + confirmationLink);
           // message.setContent("Vui lòng nhấp vào liên kết sau để xác nhận tài khoản của bạn: " + confirmationLink, "text/plain; charset=UTF-8");
            String confirmationLink = "http://localhost:9999/Iter1_Test/confirm?email=" + toEmail;
        String emailContent = "Vui lòng click vào link: " + confirmationLink;
        message.setContent(emailContent, "text/plain; charset=UTF-8");

            // Gửi email
            Transport.send(message);
            System.out.println("Email xác nhận đã được gửi thành công.");
        } catch (MessagingException| UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    private void forwardToRegisterPage(HttpServletRequest request, HttpServletResponse response,
            String username, String password, String firstName,
            String lastName, String gender, String email,
            String mobile, String address)
            throws ServletException, IOException {
        // Set attributes for each field
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("firstName", firstName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("gender", gender);
        request.setAttribute("email", email);
        request.setAttribute("mobile", mobile);
        request.setAttribute("address", address);

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
