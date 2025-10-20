package controller.admin;

import dal.BrandDAO;
import dal.ProductDAO;
import dal.SizeDAO;
import dal.StyleDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.List;
import model.Brand;
import model.Product;
import model.Size;
import model.Style;

public class ManagerProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerProductServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerProductServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        BrandDAO brandDao = new BrandDAO();
        ProductDAO productDao = new ProductDAO();
        StyleDAO styleDao = new StyleDAO();
        SizeDAO sizeDao = new SizeDAO();
        HttpSession session = request.getSession();
        int page = 1;
        String pageParam = request.getParameter("page");
        String brandId = request.getParameter("brandId");
        String styleId = request.getParameter("styleId");
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        List<Product> allPro;

        if (keyword != null && !keyword.isEmpty()) {
            allPro = productDao.searchProducts(keyword);
        } else if (brandId != null && !brandId.isEmpty()) {
            allPro = productDao.getAllProductByBrandIdAdmin(brandId);
        } else if (styleId != null && !styleId.isEmpty()) {
            allPro = productDao.getAllProductByStyleIdAdmin(styleId);
        }else {
            // Nếu không có brandId, lấy tất cả sản phẩm
            allPro = productDao.getAllProducts();
        }
        if ("asc".equals(sort)) {
            allPro.sort(Comparator.comparing(Product::getPrice));  // Sắp xếp tăng dần theo giá
        } else if ("desc".equals(sort)) {
            allPro.sort(Comparator.comparing(Product::getPrice).reversed());  // Sắp xếp giảm dần theo giá
        }

        int totalPro = allPro.size();
        // Tính toán chỉ số sản phẩm bắt đầu và kết thúc cho trang hiện tại
        int start = (page - 1) * 2;
        int end = Math.min(start + 2, totalPro);
        // Lấy danh sách sản phẩm cho trang hiện tại
        List<Product> productsForCurrentPage = allPro.subList(start, end);
        int totalPages = (int) Math.ceil((double) totalPro / 2);

        List<Style> styList = styleDao.getAllStyle();
        List<Brand> brandList = brandDao.getAllBrand();
        List<Size> sizeList = sizeDao.getAllSize();

        request.setAttribute("productList", productsForCurrentPage);
        request.setAttribute("brandList", brandList);
        request.setAttribute("sizeList", sizeList);
        request.setAttribute("styleList", styList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("selectedBrandId", brandId);
        request.setAttribute("selectedStyleId", styleId);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sort", sort);
        session.setAttribute("urlHistory", "productlist");
        RequestDispatcher dispatcher = request.getRequestDispatcher("managerProduct.jsp");
        dispatcher.forward(request, response);
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
