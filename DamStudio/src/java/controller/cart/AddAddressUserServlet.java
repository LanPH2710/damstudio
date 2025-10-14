package controller.cart;

import dal.AddressUserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.AddressUser;

public class AddAddressUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAddressUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAddressUserServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String cartIdsStr = request.getParameter("cartIds");
        int cartIds = -1;
        if (cartIdsStr != null) {
            try {
                cartIds = Integer.parseInt(cartIdsStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid address ID.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Address ID not provided.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

//        AddressUserDAO addressDAO = new AddressUserDAO();
//        AddressUser addressUser = addressDAO.getAddressById(addressId);

//        request.setAttribute("addressUser", addressUser);
        request.setAttribute("cartIds", cartIds);
        request.getRequestDispatcher("editAddress.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AddressUserDAO addressDAO = new AddressUserDAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        String cartIds = request.getParameter("cartIds");
        
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String detail = request.getParameter("addressDetail");

        addressDAO.insertCartAddress(acc.getUserId(), province, district, ward, detail, name, email, phone);

        response.sendRedirect("checkout?cartIds=" + cartIds);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
