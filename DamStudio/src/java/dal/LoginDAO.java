package dal;

import model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import context.DBContext;

public class LoginDAO extends DBContext {

    public Account getUsernameAndPassword(String username, String password) {

        String sql = "SELECT * FROM account WHERE userName = ? AND password = ? AND accountStatus = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Account account = new Account();
                account.setUserId(rs.getInt("userId"));
                account.setUserName(rs.getString("userName"));
                account.setPassword(rs.getString("password"));
                account.setFirstName(rs.getString("firstName"));
                account.setLastName(rs.getString("lastName"));
                account.setGender(rs.getInt("gender"));
                account.setEmail(rs.getString("email"));
                account.setMobile(rs.getString("mobile"));
                account.setAddress(rs.getString("address"));
                account.setRoleId(rs.getInt("roleId"));
                account.setAvatar(rs.getString("avatar"));
                account.setAccountStatus(rs.getInt("accountStatus"));
                account.setMoney(rs.getBigDecimal("money"));
                return account;
            } else {
                System.out.println("Đăng nhập thất bại: Sai thông tin hoặc tài khoản chưa kích hoạt.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi truy vấn CSDL: " + e.getMessage());
        }
        return null;
    }

    public Account getEmailAndPassword(String username, String password) {
        String sql = "select * from damstudio.account where email = ? and password = ? and accountStatus = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setUserId(rs.getInt(1));
                account.setUserName(rs.getString(2));
                account.setPassword(rs.getString(3));
                account.setFirstName(rs.getString(4));
                account.setLastName(rs.getString(5));
                account.setGender(rs.getInt(6));
                account.setEmail(rs.getString(7));
                account.setMobile(rs.getString(8));
                account.setAddress(rs.getString(9));
                account.setRoleId(rs.getInt(10));
                return account;
            }
        } catch (SQLException e) {
        }
        return null;
    }

}
