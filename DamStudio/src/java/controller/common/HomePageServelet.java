package controller.common;

import dal.CartDAO;
import dal.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Product;

public class HomePageServelet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomePageServelet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageServelet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        
        Account account = (Account) session.getAttribute("account");
        if (account !=null) {
             int sizeCart = cartDAO.countCartsByUserId(account.getUserId());
             session.setAttribute("sizeCart", sizeCart);
        }

        List<Product> featuredProducts = productDAO.getProductsByProductIdPrefix("TT", 4);
        featuredProducts.addAll(productDAO.getProductsByProductIdPrefix("ST", 4));
        request.setAttribute("featuredProducts", featuredProducts); // Sử dụng tên đúng cho JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("homePage.jsp");
        dispatcher.forward(request, response);
    } 

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
