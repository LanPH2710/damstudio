package controller.admin;

import dal.*;
import java.io.*;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import model.*;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        if (productId == null || productId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu productId");
            return;
        }

        try {
            ProductDAO pdao = new ProductDAO();
            BrandDAO bdao = new BrandDAO();
            StyleDAO sdao = new StyleDAO();
            ColorDAO cdao = new ColorDAO();
            SizeDAO sizedao = new SizeDAO();
            ProductDetailDAO pddao = new ProductDetailDAO();

            Product pro = pdao.getProductById(productId);
            if (pro == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
                return;
            }

            List<Brand> brandList = bdao.getAllBrand();
            List<Style> styleList = sdao.getAllStyle();
            List<Color> colorList = cdao.getColorOfProduct(productId);
            List<Size> sizeList = sizedao.getAllSizeOfProduct(productId);
            List<DetailProduct> detailList = pddao.getListProductDetail(productId);

            request.setAttribute("product", pro);
            request.setAttribute("brandList", brandList);
            request.setAttribute("styleList", styleList);
            request.setAttribute("colorList", colorList);
            request.setAttribute("sizeList", sizeList);
            request.setAttribute("detailList", detailList);

            request.getRequestDispatcher("editProduct.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Lỗi khi tải sản phẩm: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // --- Lấy dữ liệu từ form ---
            String productId = request.getParameter("productId");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            double vat = Double.parseDouble(request.getParameter("VAT"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int styleId = Integer.parseInt(request.getParameter("styleId"));
            int status = Integer.parseInt(request.getParameter("productStatus"));

            ProductDAO pdao = new ProductDAO();
            ProductImageDAO imgDao = new ProductImageDAO();

            // --- Cập nhật thông tin sản phẩm ---
            pdao.updateProduct(productId, name, price, description, vat, brandId, styleId, status);

            // --- Xử lý ảnh ---
            Part avatarFile = request.getPart("avatar");
            if (avatarFile != null && avatarFile.getSize() > 0) {
                String fileName = Paths.get(avatarFile.getSubmittedFileName()).getFileName().toString();
                String uploadDirPath = getServletContext().getRealPath("/image/ao");
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String uploadPath = uploadDirPath + File.separator + fileName;

                try (InputStream is = avatarFile.getInputStream(); FileOutputStream fos = new FileOutputStream(uploadPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                // --- Lưu vào DB ---
                imgDao.insertProductImage(productId, fileName, true); // true = ảnh chính
            }

            // --- Xử lý ảnh phụ (nếu có) ---
            Part newImage = request.getPart("newImage");
            if (newImage != null && newImage.getSize() > 0) {
                String fileName = Paths.get(newImage.getSubmittedFileName()).getFileName().toString();
                String uploadDirPath = getServletContext().getRealPath("/image/ao");
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String uploadPath = uploadDirPath + File.separator + fileName;

                try (InputStream is = newImage.getInputStream(); FileOutputStream fos = new FileOutputStream(uploadPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                imgDao.insertProductImage(productId, fileName, false); // false = ảnh phụ
            }

            response.sendRedirect("managerproduct");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi cập nhật sản phẩm: " + e.getMessage(), e);
        }
    }
}
