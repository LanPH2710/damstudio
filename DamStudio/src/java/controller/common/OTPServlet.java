package controller.common;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OTPServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OTPServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String otpInput = request.getParameter("otp").trim();
        String otpSaved = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");
        long otpTime = (long) session.getAttribute("otpTime");
        long currentTime = System.currentTimeMillis();

// kiểm tra quá 3 phút (180000 ms)
        if (currentTime - otpTime > 180000) {
            request.setAttribute("errorMessage", "Mã OTP đã hết hạn. Vui lòng yêu cầu lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (otpSaved == null) {
            request.setAttribute("errorMessage", "OTP đã hết hạn hoặc chưa được gửi lại.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        System.out.println("OTP nhập: " + otpInput);
        System.out.println("OTP lưu trong session: " + otpSaved);

        if (otpInput.equals(otpSaved)) {
            request.setAttribute("email", email);
            request.setAttribute("status", "success");
            request.getRequestDispatcher("newPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "OTP không hợp lệ");
            request.getRequestDispatcher("enterOTP.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
