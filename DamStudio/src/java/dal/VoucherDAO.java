package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;

public class VoucherDAO extends DBContext {

    public List<Voucher> getAvailableVouchersForUser(int userId, BigDecimal totalOrder) {
        List<Voucher> list = new ArrayList<>();
        String sql = """
            SELECT v.*
            FROM voucher v
            INNER JOIN user_voucher uv ON v.voucherId = uv.voucherId
            WHERE uv.userId = ? 
              AND uv.isUsed = 0
              AND v.isActive = 1
              AND v.startDate <= NOW() 
              AND v.endDate >= NOW()
              AND v.totalQuantity > v.usedQuantity
              AND ? >= v.minOrderValue
            """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setBigDecimal(2, totalOrder);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherId(rs.getInt("voucherId"));
                v.setCode(rs.getString("code"));
                v.setDescription(rs.getString("description"));
                v.setDiscountType(rs.getString("discountType")); // 'percent' hoặc 'amount'
                v.setDiscountValue(rs.getBigDecimal("discountValue"));
                v.setMinOrderValue(rs.getBigDecimal("minOrderValue"));
                v.setMaxDiscountValue(rs.getBigDecimal("maxDiscountValue"));
                v.setTotalQuantity(rs.getInt("totalQuantity"));
                v.setUsedQuantity(rs.getInt("usedQuantity"));
                v.setIsActive(rs.getBoolean("isActive"));
                v.setStartDate(rs.getObject("startDate", java.time.LocalDateTime.class));
                v.setEndDate(rs.getObject("endDate", java.time.LocalDateTime.class));
                list.add(v);
            }
        } catch (SQLException exception) {
        }
        return list;
    }

    public Voucher getVoucherById(int voucherId) {
        String sql = "SELECT * FROM voucher WHERE voucherId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, voucherId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherId(rs.getInt("voucherId"));
                v.setCode(rs.getString("code"));
                v.setDescription(rs.getString("description"));
                v.setDiscountType(rs.getString("discountType"));
                v.setDiscountValue(rs.getBigDecimal("discountValue"));
                v.setMinOrderValue(rs.getBigDecimal("minOrderValue"));
                v.setMaxDiscountValue(rs.getBigDecimal("maxDiscountValue"));
                v.setTotalQuantity(rs.getInt("totalQuantity"));
                v.setUsedQuantity(rs.getInt("usedQuantity"));
                v.setIsActive(rs.getBoolean("isActive"));
                v.setStartDate(rs.getObject("startDate", java.time.LocalDateTime.class));
                v.setEndDate(rs.getObject("endDate", java.time.LocalDateTime.class));
                return v;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean userHasUnusedVoucher(int userId, int voucherId) {
        String sql = "SELECT 1 FROM user_voucher WHERE userId = ? AND voucherId = ? AND isUsed = 0";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, voucherId);
            ResultSet rs = st.executeQuery();
            return rs.next(); // true nếu tồn tại 1 record chưa dùng
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean markVoucherAsUsed(int userId, int voucherId) {
        String sql = "UPDATE user_voucher SET isUsed = 1 WHERE userId = ? AND voucherId = ? AND isUsed = 0";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, voucherId);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean increaseUsedQuantity(int voucherId) {
        String sql = "UPDATE voucher SET usedQuantity = usedQuantity + 1 WHERE voucherId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, voucherId);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        VoucherDAO voucherDAO = new VoucherDAO();

        int userId = 1;
        // Thử các giá trị totalOrder khác nhau để test điều kiện minOrderValue
        BigDecimal totalOrder = new BigDecimal("500000"); // >= 200k sẽ lấy được HEHEHE10

        List<Voucher> vouchers = voucherDAO.getAvailableVouchersForUser(userId, totalOrder);
        System.out.println("Danh sách voucher khả dụng cho userId " + userId + " với đơn " + totalOrder + ":");
        for (Voucher v : vouchers) {
            System.out.println(
                    v.getCode() + " | " + v.getDescription()
                    + " | " + v.getDiscountType() + " | " + v.getDiscountValue()
                    + " | minOrder: " + v.getMinOrderValue()
                    + " | maxDiscount: " + v.getMaxDiscountValue()
                    + " | Active: " + v.isIsActive()
            );
        }
    }
}
