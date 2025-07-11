package controller.common;

import dal.AccountDAO;
import dal.AddressUserDAO;
import dal.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.List;
import model.Account;
import model.AddressUser;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO adao = new AccountDAO();
        AddressUserDAO addressDAO = new AddressUserDAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        List<AddressUser> address = addressDAO.getAddressByUserId(acc.getUserId());
        Account user = adao.getAccountById(acc.getUserId());
        session.setAttribute("user1", user);
        session.setAttribute("address", address);
        RoleDAO rdao = new RoleDAO();
        String role = rdao.getRoleNameById(user.getRoleId());
        session.setAttribute("role", role);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO adao = new AccountDAO();
        AddressUserDAO addressDAO = new AddressUserDAO();
        Account user = (Account) session.getAttribute("user1");
        // Lấy thông tin cũ
        int userId = user.getUserId();
        String userName = user.getUserName();
        String password = user.getPassword();
        int roleId = user.getRoleId();
        String email = user.getEmail();
        String avatar = user.getAvatar();
        int status = user.getAccountStatus();
        // Lấy giá trị từ JSP
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        int gender = Integer.parseInt(request.getParameter("gender"));
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        // Xử lý upload avatar nếu có file mới
        Part file = request.getPart("avatar");
        if (file != null && file.getSize() > 0) {
            String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/image/logo") + File.separator + fileName;

            // Tạo thư mục nếu chưa tồn tại
            File uploadDir = new File(getServletContext().getRealPath("/image/logo"));
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tạo thư mục
            }

            // Lưu file
            try (InputStream is = file.getInputStream(); FileOutputStream fos = new FileOutputStream(uploadPath)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
                avatar = fileName; // Cập nhật đường dẫn avatar mới
            } catch (Exception e) {
                return;
            }
        }

        // Cập nhật account
        adao.editAccount(userName, password, firstName, lastName, gender, email, mobile, roleId, avatar, status, userId);
        addressDAO.editAddress(userId, addressId, address);
        response.sendRedirect("profile");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
