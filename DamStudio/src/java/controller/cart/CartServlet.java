package controller.cart;

import dal.CartDAO;
import dal.ColorDAO;
import dal.ProductDAO;
import dal.ProductDetailDAO;
import dal.SizeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Cart;
import model.Color;
import model.Product;
import model.Size;

public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = account.getUserId();

        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Cart> activeCarts = cartDAO.getCartsByUserId(userId);
        List<Cart> inactiveCarts = cartDAO.getInactiveCartsByUserId(userId);
        ProductDetailDAO pddao = new ProductDetailDAO();
        ColorDAO colorDAO = new ColorDAO();
        SizeDAO sizeDAO = new SizeDAO();

        double totalMoney = 0;
        double inactiveTotalMoney = 0;
        Map<String, List<Color>> colorMap = new HashMap<>();
        Map<String, List<Size>> sizeMap = new HashMap<>();
        Map<String, Product> productMap = new HashMap<>();
        Map<String, Integer> quantityMap = new HashMap<>();

        for (Cart cartItem : activeCarts) {
            String productId = cartItem.getProductId();
            int colorId = cartItem.getColorId();
            int sizeId = cartItem.getSizeId();

            Product product = productMap.get(productId);
            if (product == null) {
                product = productDAO.getProductByProductId(productId);
                productMap.put(productId, product);
            }
            if (!colorMap.containsKey(productId)) {
                List<Color> colors = colorDAO.getColorOfProduct(productId);
                colorMap.put(productId, colors);
            }
            if (!sizeMap.containsKey(productId)) {
                List<Size> sizes = sizeDAO.getAllSizeOfProduct(productId);
                sizeMap.put(productId, sizes);
            }
            int quantity = pddao.getQuantityByProductColorSize(productId, colorId, sizeId);
            String key = productId + "_" + colorId + "_" + sizeId;
            quantityMap.put(key, quantity);

            totalMoney += cartItem.getCartQuantity() * product.getPrice();
        }

        Map<String, List<Color>> inaciveColorMap = new HashMap<>();
        Map<String, List<Size>> inaciveSizeMap = new HashMap<>();
        Map<String, Product> inaciveProductMap = new HashMap<>();

        for (Cart cartItem : inactiveCarts) {
            String productId = cartItem.getProductId();
            Product product = inaciveProductMap.get(productId);
            if (product == null) {
                product = productDAO.getProductByProductId(productId);
                inaciveProductMap.put(productId, product);
            }
            if (!inaciveColorMap.containsKey(productId)) {
                List<Color> colors = colorDAO.getColorOfProduct(productId);
                inaciveColorMap.put(productId, colors);
            }
            if (!inaciveSizeMap.containsKey(productId)) {
                List<Size> sizes = sizeDAO.getAllSizeOfProduct(productId);
                inaciveSizeMap.put(productId, sizes);
            }
        }
        int vol = activeCarts.size();

        session.setAttribute("totalMoney", totalMoney);
        session.setAttribute("inactiveTotalMoney", inactiveTotalMoney);
        session.setAttribute("activeCarts", activeCarts);
        session.setAttribute("inactiveCarts", inactiveCarts);
        request.setAttribute("colorMap", colorMap);
        request.setAttribute("sizeMap", sizeMap);
        request.setAttribute("quantityMap", quantityMap);
        request.setAttribute("vol", vol);
        request.setAttribute("productMap", productMap);
        request.setAttribute("inaciveProductMap", inaciveProductMap);
        request.setAttribute("inaciveColorMap", inaciveColorMap);
        request.setAttribute("inaciveSizeMap", inaciveSizeMap);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
