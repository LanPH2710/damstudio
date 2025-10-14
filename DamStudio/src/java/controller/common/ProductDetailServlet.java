package controller.common;

import dal.*;
import model.*;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String rateParam = request.getParameter("rate");
        if (productId == null || productId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu productId");
            return;
        }

        try {
            ColorDAO cdao = new ColorDAO();
            ProductDAO pdao = new ProductDAO();
            BrandDAO bdao = new BrandDAO();
            StyleDAO sdao = new StyleDAO();
            SizeDAO sizedao = new SizeDAO();
            FeedbackDAO fdao = new FeedbackDAO();
            AccountDAO adao = new AccountDAO();
            ProductDetailDAO pddao = new ProductDetailDAO();
            ProductImageDAO image = new ProductImageDAO();

            Product pro = pdao.getProductById(productId);
            if (pro == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
                return;
            }

            List<Color> color = cdao.getColorOfProduct(productId);
            List<Size> sizeList = sizedao.getAllSizeOfProduct(productId);

            // Lấy feedback theo rate nếu có, còn không thì lấy tất cả
            List<Feedback> feedback;
            Integer filterRate = null;
            try {
                if (rateParam != null && !rateParam.isEmpty()) {
                    filterRate = Integer.parseInt(rateParam);
                    feedback = fdao.getFeedbackByRate(productId, filterRate);
                } else {
                    feedback = fdao.getFeedbackByProductId(productId);
                }
            } catch (NumberFormatException e) {
                feedback = fdao.getFeedbackByProductId(productId);
            }

            // Đếm số feedback theo từng rate (1-5 sao)
            Map<Integer, Integer> feedbackCountByRate = new LinkedHashMap<>();
            for (int i = 5; i >= 1; i--) {
                feedbackCountByRate.put(i, fdao.countFeedbackByProductIdAndRate(productId, i));
            }
            int totalFeedbackCount = fdao.countFeedbackByProductId(productId);

            String brand = bdao.getBrandById(pro.getBrandId());
            String style = sdao.getStyleNameByStyleId(pro.getStyleId());
            Size size1 = sizedao.getSizeOfProduct(productId);
            List<Account> listAcc = adao.getUserNameByProductId(productId);
            List<Product> pro2 = pdao.getProductByPrice(pro.getPrice());
            int rateProduct = fdao.getRateProduct(productId);
            List<DetailProduct> detailList = pddao.getListProductDetail(productId);
            String selectedColorId = request.getParameter("colorId");
            String selectedSizeId = request.getParameter("sizeId");
            request.setAttribute("selectedColorId", selectedColorId);
            request.setAttribute("selectedSizeId", selectedSizeId);

            request.setAttribute("product", pro);
            request.setAttribute("detailList", detailList);
            request.setAttribute("colorList", color);
            request.setAttribute("brand", brand);
            request.setAttribute("style", style);
            request.setAttribute("sizeOfProduct1", size1);
            request.setAttribute("sizeList", sizeList);
            request.setAttribute("feedback", feedback);
            request.setAttribute("acc", listAcc);
            request.setAttribute("rateProduct", rateProduct);
            request.setAttribute("pro2", pro2);
            request.setAttribute("feedbackCountByRate", feedbackCountByRate);
            request.setAttribute("totalFeedbackCount", totalFeedbackCount);
            request.setAttribute("feedbackCountByRate", feedbackCountByRate);
            request.setAttribute("filterRate", filterRate);
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Lỗi khi xử lý sản phẩm: " + ex.getMessage(), ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Product Detail with Feedback Filtering";
    }
}
