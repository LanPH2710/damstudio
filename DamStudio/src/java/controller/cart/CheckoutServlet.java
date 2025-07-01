package controller.cart;

import dal.AccountDAO;
import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.AddressUser;
import model.Cart;

public class CheckoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO adao = new AccountDAO();
        CheckOutDAO checkout = new CheckOutDAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc != null) {
            List<AddressUser> addressUsers = checkout.getAddressByUserId(acc.getUserId());
            if (addressUsers != null && !addressUsers.isEmpty()) {
                System.out.println("Address list size: " + addressUsers.size());
                session.setAttribute("userAddress", addressUsers);
            } else {
                System.out.println("No addresses found.");
            }

        } else {
            // Handle the case where the account is null (e.g., redirect to login)
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        List<Cart> carts = cartDAO.getSelectedCarts(acc.getUserId());
        if (carts == null || carts.isEmpty()) {
            session.setAttribute("messUpdateCart", "Bạn chưa chọn sản phẩm");
            response.sendRedirect("carts");
            return;
        }

        // For testing, forward to the test JSP
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        CartDAO cartDAO = new CartDAO();
        List<Cart> cartList = cartDAO.getCartsSelectByUserId(acc.getUserId());
        // Retrieve selected address ID from the form
        String selectedAddressIdStr = request.getParameter("address");
        int selectedAddressId = -1;
        if (selectedAddressIdStr != null) {
            try {
                selectedAddressId = Integer.parseInt(selectedAddressIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid address selected.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
        } else {
            // No address selected
            request.setAttribute("error", "Please select a shipping address.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Retrieve selected payment method from the form
        String payMethod = request.getParameter("pay-method");
        if (payMethod == null) {
            // No payment method selected
            request.setAttribute("error", "Please select a payment method.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Fetch the selected address details
        CheckOutDAO checkoutDAO = new CheckOutDAO();
        AddressUser selectedAddress = checkoutDAO.getAddressById(selectedAddressId);
        if (selectedAddress == null) {
            request.setAttribute("error", "Selected address not found.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        String name = selectedAddress.getName();
        String phone = selectedAddress.getPhone();
        String email = selectedAddress.getEmail();
        String address = selectedAddress.getAddress();
        // Store selected address and payment method in session or process accordingly
        session.setAttribute("selectedAddress", selectedAddress);
        session.setAttribute("payMethod", payMethod);

        // Proceed based on the selected payment method
        if (payMethod.equals("online")) {
            session.setAttribute("name", name);
            session.setAttribute("phone", phone);
            session.setAttribute("email", email);
            session.setAttribute("address", address);
            session.setAttribute("ThanhHieu", "2");
            // Redirect to online payment page
            response.sendRedirect("vnpay_pay.jsp");
        } else if (payMethod.equals("cod")) {
            // Process COD order
            double totalmoney = (double) session.getAttribute("totalFinal");// Ensure to implement a method to calculate total money if needed
            int orderId = cartDAO.addOrder(acc.getUserId(), name, email, phone, totalmoney, address, 1,2);

            for (Cart cart : cartList) {
                // Add each cart's details to the order
                cartDAO.addOrderDetail(orderId, cart.getProduct().getProductId(), cart.getQuantity(),  cart.getColorId(), 0);

                // Update stock for the product associated with the cart item
                cartDAO.updateStockByCartId(cart.getCartId());

                // Remove the cart after processing
                cartDAO.deleteCar(cart.getCartId());
            }

            // Redirect to order confirmation page after processing
            response.sendRedirect("thanks.jsp");
        } else if (payMethod.equals("balance")) {
            // Process COD order
            double totalmoney = (double) session.getAttribute("totalFinal");// Ensure to implement a method to calculate total money if needed

            double balance = checkoutDAO.getMoneyByUserId(acc.getUserId());
            if (totalmoney > balance) {
                session.setAttribute("messCheckOut", "Số dư không đủ");
                response.sendRedirect("checkout");
                return;
            }else{
            checkoutDAO.updateMoneyAfterPurchase(acc.getUserId(), totalmoney);
            int orderId = cartDAO.addOrder(acc.getUserId(), name, email, phone, totalmoney, address, 1,3);
            
            for (Cart cart : cartList) {
                // Add each cart's details to the order
                             cartDAO.addOrderDetail(orderId, cart.getProduct().getProductId(), cart.getQuantity(),  cart.getColorId(), 0);


                // Update stock for the product associated with the cart item
                cartDAO.updateStockByCartId(cart.getCartId());

                // Remove the cart after processing
                cartDAO.deleteCar(cart.getCartId());
            }

            // Redirect to order confirmation page after processing
            response.sendRedirect("thanks.jsp");}
        } else {
            // Handle other payment methods if any
            request.setAttribute("error", "Invalid payment method selected.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
