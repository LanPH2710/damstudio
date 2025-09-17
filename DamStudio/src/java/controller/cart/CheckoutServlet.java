package controller.cart;

import dal.*;
import model.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy cartIds từ URL
        String cartIdsStr = request.getParameter("cartIds");
        List<Integer> selectedCartIds = new ArrayList<>();
        if (cartIdsStr != null && !cartIdsStr.trim().isEmpty()) {
            String[] arrCartIds = cartIdsStr.split(",");
            for (String id : arrCartIds) {
                try {
                    selectedCartIds.add(Integer.parseInt(id.trim()));
                } catch (Exception ignore) {
                }
            }
        }
        if (selectedCartIds.isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn sản phẩm để thanh toán!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin cart, product
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        ColorDAO colorDAO = new ColorDAO();
        SizeDAO sizeDAO = new SizeDAO();
        VoucherDAO voucherDAO = new VoucherDAO();

        List<Cart> cartList = cartDAO.getCartsByCartIds(selectedCartIds);
        Map<String, Product> productMap = new HashMap<>();
        Map<Integer, Color> colorMap = new HashMap<>();
        Map<Integer, Size> sizeMap = new HashMap<>();
        for (Cart c : cartList) {
            productMap.put(c.getProductId(), productDAO.getProductById(c.getProductId()));
            colorMap.put(c.getColorId(), colorDAO.getColorByProductId(c.getColorId()));
            sizeMap.put(c.getSizeId(), sizeDAO.getSizeOfProduct2(c.getSizeId()));
        }
        // Lấy tổng tiền
        BigDecimal totalMoney = BigDecimal.ZERO;
        for (Cart cart : cartList) {
            Product prod = productMap.get(cart.getProductId());
            if (prod != null) {
                BigDecimal price = BigDecimal.valueOf(prod.getPrice());
                totalMoney = totalMoney.add(price.multiply(BigDecimal.valueOf(cart.getCartQuantity())));
            }
        }

        // Lấy địa chỉ giao hàng
        AddressUserDAO addressDAO = new AddressUserDAO();
        List<AddressUser> addressUsers = addressDAO.getAddressByUserId(acc.getUserId());
        List<Voucher> voucherList = voucherDAO.getAvailableVouchersForUser(acc.getUserId(), totalMoney);
        // Lấy số dư
        AccountDAO accountDAO = new AccountDAO();
        double balance = accountDAO.getMoneyByUserId(acc.getUserId());

        // Đẩy dữ liệu sang checkout.jsp
        request.setAttribute("cartList", cartList);
        request.setAttribute("productMap", productMap);
        request.setAttribute("colorMap", colorMap);
        request.setAttribute("sizeMap", sizeMap);
        request.setAttribute("addressUsers", addressUsers != null ? addressUsers : new ArrayList<>());
        request.setAttribute("totalMoney", totalMoney);
        request.setAttribute("voucherList", voucherList);
        request.setAttribute("balance", balance);

        // Đưa cartIds vào form để POST lại
        request.setAttribute("cartIds", cartIdsStr);

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
        // 1. Nhận voucherId
        String voucherIdStr = request.getParameter("voucherId");
        Integer voucherId = null;
        if (voucherIdStr != null && !voucherIdStr.equals("0")) {
            try {
                voucherId = Integer.parseInt(voucherIdStr);
            } catch (Exception ignore) {
            }
        }
        // 2. Nhận lại cartIds (từ form hidden input)
        String cartIdsStr = request.getParameter("cartIds");
        if (cartIdsStr == null || cartIdsStr.trim().isEmpty()) {
            request.setAttribute("error", "Không nhận được danh sách sản phẩm cần mua.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }
        List<Integer> selectedCartIds = new ArrayList<>();
        for (String id : cartIdsStr.split(",")) {
            try {
                selectedCartIds.add(Integer.parseInt(id.trim()));
            } catch (Exception ignore) {
            }
        }
        if (selectedCartIds.isEmpty()) {
            request.setAttribute("error", "Không có sản phẩm hợp lệ được chọn!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }
        // 3. Lấy lại danh sách cart và tính tổng tiền gốc
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Cart> cartList = cartDAO.getCartsByCartIds(selectedCartIds);
        BigDecimal totalMoney = BigDecimal.ZERO;
        for (Cart cart : cartList) {
            Product prod = productDAO.getProductById(cart.getProductId());
            if (prod != null) {
                totalMoney = totalMoney.add(BigDecimal.valueOf(prod.getPrice())
                        .multiply(BigDecimal.valueOf(cart.getCartQuantity())));
            }
        }
        // 4. Áp dụng voucher nếu có
        BigDecimal discount = BigDecimal.ZERO;
        if (voucherId != null) {
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherById(voucherId);
            // Kiểm tra điều kiện hợp lệ của voucher
            boolean valid = false;
            if (voucher != null && voucher.isIsActive()) {
                // Kiểm tra thời gian hiệu lực
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                boolean inTime = !now.isBefore(voucher.getStartDate()) && !now.isAfter(voucher.getEndDate());
                // Kiểm tra user sở hữu và chưa dùng voucher này
                boolean userHasVoucher = voucherDAO.userHasUnusedVoucher(acc.getUserId(), voucherId);
                // Kiểm tra minOrderValue
                boolean enoughOrder = totalMoney.compareTo(voucher.getMinOrderValue()) >= 0;
                // Kiểm tra số lượng còn lại
                boolean hasQuantity = voucher.getTotalQuantity() == null || voucher.getUsedQuantity() < voucher.getTotalQuantity();

                valid = inTime && userHasVoucher && enoughOrder && hasQuantity;
            }
            if (valid) {
                if ("percent".equals(voucher.getDiscountType())) {
                    discount = totalMoney.multiply(voucher.getDiscountValue()).divide(BigDecimal.valueOf(100));
                    if (voucher.getMaxDiscountValue() != null && discount.compareTo(voucher.getMaxDiscountValue()) > 0) {
                        discount = voucher.getMaxDiscountValue();
                    }
                } else if ("amount".equals(voucher.getDiscountType())) {
                    discount = voucher.getDiscountValue();
                }
                if (discount.compareTo(totalMoney) > 0) {
                    discount = totalMoney;
                }
            } else {
                // Không hợp lệ thì không áp dụng, reset voucherId về null để không lưu vào order
                voucherId = null;
            }
        }
        BigDecimal finalTotal = totalMoney.subtract(discount);
        // 5. Lấy địa chỉ giao hàng
        String addressIdStr = request.getParameter("addressId");
        AddressUser selectedAddress = null;
        if (addressIdStr != null && !addressIdStr.trim().isEmpty()) {
            AddressUserDAO addressDAO = new AddressUserDAO();
            try {
                selectedAddress = addressDAO.getAddressById(Integer.parseInt(addressIdStr));
            } catch (Exception ignore) {
            }
        }
        if (selectedAddress == null) {
            request.setAttribute("error", "Vui lòng chọn địa chỉ giao hàng!");
            request.setAttribute("cartIds", cartIdsStr);
            doGet(request, response); // Render lại
            return;
        }
        // 6. Lấy phương thức thanh toán
        String payMethod = request.getParameter("payMethod");
        if (payMethod == null || payMethod.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn phương thức thanh toán!");
            request.setAttribute("cartIds", cartIdsStr);
            doGet(request, response); // Render lại
            return;
        }
        // 7. Xử lý đặt hàng theo phương thức thanh toán
        AccountDAO accountDAO = new AccountDAO();
        if (payMethod.equalsIgnoreCase("balance")) {
            double balance = accountDAO.getMoneyByUserId(acc.getUserId());
            if (BigDecimal.valueOf(balance).compareTo(finalTotal) < 0) {
                request.setAttribute("error", "Số dư không đủ để thanh toán!");
                request.setAttribute("cartIds", cartIdsStr);
                doGet(request, response); // Render lại
                return;
            }
            boolean minusOK = accountDAO.updateMoneyAfterPurchase(acc.getUserId(), finalTotal);
            if (!minusOK) {
                request.setAttribute("error", "Không thể trừ tiền từ ví. Vui lòng thử lại!");
                request.setAttribute("cartIds", cartIdsStr);
                doGet(request, response);
                return;
            }
        } else if (payMethod.equalsIgnoreCase("online")) {
            session.setAttribute("pendingCheckoutCartIds", cartIdsStr);
            session.setAttribute("pendingCheckoutAddressId", selectedAddress.getAddressId());
            session.setAttribute("pendingCheckoutTotal", finalTotal);
            session.setAttribute("pendingCheckoutVoucherId", voucherId); // lưu voucherId nếu cần
            response.sendRedirect("vnpay_pay.jsp");
            return;
        }
        // 8. Tạo đơn hàng (ghi nhận voucherId và giá đã trừ giảm giá)
        int orderStatus = 1; // Pending
        int payMethodCode = payMethod.equalsIgnoreCase("cod") ? 2 : 3;
        OrderDAO orderDAO = new OrderDAO();
        String fullAddress = selectedAddress.getAddressDetail() + ", " 
                   + selectedAddress.getWard() + ", " 
                   + selectedAddress.getDistrict() + ", " 
                   + selectedAddress.getProvince();
        int orderId = orderDAO.addOrder(
                acc.getUserId(),
                selectedAddress.getName(),
                selectedAddress.getEmail(),
                selectedAddress.getPhone(),
                finalTotal, // <-- tổng tiền đã trừ giảm giá!
                null,
                orderStatus,
                payMethodCode,
                voucherId, // <-- ghi nhận voucher đã dùng
                null,
                fullAddress
        );
        if (orderId <= 0) {
            request.setAttribute("error", "Không thể tạo đơn hàng, vui lòng thử lại!");
            request.setAttribute("cartIds", cartIdsStr);
            doGet(request, response);
            return;
        }
        // 9. Thêm orderDetail, update kho, xóa cart
        ProductDetailDAO productDetailDAO = new ProductDetailDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        boolean allSuccess = true;
        for (Cart cart : cartList) {
            boolean addDetailOK = orderDetailDAO.addOrderDetail(
                    orderId, cart.getProductId(), cart.getSizeId(), cart.getColorId(), cart.getCartQuantity(), 0);
            boolean updateStockOK = productDetailDAO.updateStock(
                    cart.getProductId(), cart.getSizeId(), cart.getColorId(), cart.getCartQuantity());
            boolean deleteCartOK = false;
            try {
                deleteCartOK = cartDAO.deleteCartItem(cart.getCartId());
            } catch (Exception ignore) {
            }
            if (!addDetailOK || !updateStockOK || !deleteCartOK) {
                allSuccess = false;
            }
        }
        // 10. Đánh dấu đã dùng voucher nếu có
        if (voucherId != null) {
            VoucherDAO voucherDAO = new VoucherDAO();
            voucherDAO.markVoucherAsUsed(acc.getUserId(), voucherId);
            voucherDAO.increaseUsedQuantity(voucherId); // cập nhật số lần đã dùng
        }
        if (allSuccess) {
            response.sendRedirect("thanks.jsp");
        } else {
            request.setAttribute("error", "Có lỗi khi xử lý đơn hàng, vui lòng kiểm tra lại.");
            request.setAttribute("cartIds", cartIdsStr);
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "CheckoutServlet for DamStudio - chuẩn hóa business - Gen Z style!";
    }
}
