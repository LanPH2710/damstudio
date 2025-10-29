package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import java.math.BigDecimal;

public class AccountDAO extends DBContext {

    public Account getAccountById(int userId) {
        String sql = "SELECT * FROM account WHERE userId=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt(1), // userId
                        rs.getString(2), // userName
                        rs.getString(3), // password
                        rs.getString(4), // firstName
                        rs.getString(5), // lastName
                        rs.getString(6), // email
                        rs.getString(7), // mobile
                        rs.getInt(8), // gender
                        rs.getInt(9), // roleId
                        rs.getString(10),// avatar
                        rs.getInt(11), // accountStatus
                        rs.getBigDecimal(12) // money
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[A-Z])(?=.*\\d).+$");
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(
                        rs.getInt(1), // userId
                        rs.getString(2), // userName
                        rs.getString(3), // password
                        rs.getString(4), // firstName
                        rs.getString(5), // lastName
                        rs.getString(6), // email
                        rs.getString(7), // mobile
                        rs.getInt(8), // gender
                        rs.getInt(9), // roleId
                        rs.getString(10), // avatar
                        rs.getInt(11), // accountStatus
                        rs.getBigDecimal(12) // money
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Account> getAccountByKeyword(String key) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account "
                + "WHERE REPLACE(name, ' ', '') LIKE CONCAT('%', REPLACE(?, ' ', ''), '%')";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, key);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Account a = new Account(
                            rs.getInt(1), // userId
                            rs.getString(2), // userName
                            rs.getString(3), // password
                            rs.getString(4), // firstName
                            rs.getString(5), // lastName
                            rs.getString(6), // email
                            rs.getString(7), // mobile
                            rs.getInt(8), // gender
                            rs.getInt(9), // roleId
                            rs.getString(10), // avatar
                            rs.getInt(11), // accountStatus
                            rs.getBigDecimal(12) // money
                    );
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error at getAccountByKeyword: " + e.getMessage());
        }
        return list;
    }

    public boolean isValidMobile(String mobile) {
        System.out.println("Checking mobile validity: " + mobile);
        return mobile != null && mobile.matches("\\d{10}");
    }

    public void editAccount(String userName, String password, String firstName, String lastName, int gender, String email, String mobile, int roleId, String avatar, int status, int userId) {
        String sql = "UPDATE account SET "
                + "userName = ?, "
                + "password = ?, "
                + "firstName = ?, "
                + "lastName = ?, "
                + "gender = ?, "
                + "email = ?, "
                + "mobile = ?, "
                + "roleId = ?, "
                + "avatar = ?, "
                + "accountStatus = ? "
                + "WHERE userId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, password);
            st.setString(3, firstName);
            st.setString(4, lastName);
            st.setInt(5, gender);
            st.setString(6, email);
            st.setString(7, mobile);
            st.setInt(8, roleId);
            st.setString(9, avatar);
            st.setInt(10, status);
            st.setInt(11, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Kiểm tra nếu username đã tồn tại trong database
    public Account checkUserNameExists(String userName) {
        String sql = "SELECT * FROM account WHERE userName = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, userName);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("userId"), // 1
                        rs.getString("userName"), // 2
                        rs.getString("password"), // 3
                        rs.getString("firstName"), // 4
                        rs.getString("lastName"), // 5
                        rs.getString("email"), // 6
                        rs.getString("mobile"), // 7
                        rs.getInt("gender"), // 8
                        rs.getInt("roleId"), // 9
                        rs.getString("avatar"), // 10
                        rs.getInt("accountStatus"), // 11
                        rs.getBigDecimal("money") // 12
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, "Error checking username", e);
        }
        return null;
    }

    public Account checkEmailExists(String email) {
        String sql = "SELECT * FROM account WHERE email = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("userId"), // 1
                        rs.getString("userName"), // 2
                        rs.getString("password"), // 3
                        rs.getString("firstName"), // 4
                        rs.getString("lastName"), // 5
                        rs.getString("email"), // 6
                        rs.getString("mobile"), // 7
                        rs.getInt("gender"), // 8
                        rs.getInt("roleId"), // 9
                        rs.getString("avatar"), // 10
                        rs.getInt("accountStatus"), // 11
                        rs.getBigDecimal("money") // 12
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, "Error checking email", e);
        }
        return null;
    }

    public Account checkMobileExists(String mobile) {
        String sql = "SELECT * FROM account WHERE mobile = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, mobile);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("userId"), // 1
                        rs.getString("userName"), // 2
                        rs.getString("password"), // 3
                        rs.getString("firstName"), // 4
                        rs.getString("lastName"), // 5
                        rs.getString("email"), // 6
                        rs.getString("mobile"), // 7
                        rs.getInt("gender"), // 8
                        rs.getInt("roleId"), // 9
                        rs.getString("avatar"), // 10
                        rs.getInt("accountStatus"), // 11
                        rs.getBigDecimal("money") // 12
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, "Error checking mobile", e);
        }
        return null;
    }

    public void insertAccount(Account acc) {
        try {
            String sql = "INSERT INTO account "
                    + "(userName, password, firstName, lastName, gender, email, mobile, roleId, avatar) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, acc.getUserName());
            stm.setString(2, acc.getPassword());
            stm.setString(3, acc.getFirstName());
            stm.setString(4, acc.getLastName());
            stm.setInt(5, acc.getGender());
            stm.setString(6, acc.getEmail());
            stm.setString(7, acc.getMobile());
            stm.setInt(8, acc.getRoleId());
            stm.setString(9, acc.getAvatar());
            stm.executeUpdate();
            System.out.println("Account đã được thêm thành công!");
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm account: " + e.getMessage());
        }
    }

    public List<Account> getUserNameByProductId(String productId) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT a.* FROM feedback f JOIN account a ON f.userId = a.userId WHERE f.productId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Account p = new Account(
                            rs.getInt("userId"),
                            rs.getString("userName"),
                            rs.getString("password"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("email"),
                            rs.getString("mobile"),
                            rs.getInt("gender"),
                            rs.getInt("roleId"),
                            rs.getString("avatar"),
                            rs.getInt("accountStatus"),
                            rs.getBigDecimal("money")
                    );
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public double getMoneyByUserId(int userId) {
        String sql = "SELECT money FROM account WHERE userId = ?";
        double money = -1.0; // Default to -1.0 if no money is found

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    money = rs.getDouble("money");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // You could also log the exception instead of printing it
        }

        return money;
    }

    public boolean updateMoneyAfterPurchase(int userId, BigDecimal totalPrice) {
        String sql = "UPDATE account SET money = money - ? WHERE userId = ? AND money >= ?";
        boolean success = false;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, totalPrice);
            ps.setInt(2, userId);
            ps.setBigDecimal(3, totalPrice); // Money luôn BigDecimal
            int affectedRows = ps.executeUpdate();
            success = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    public List<Account> getAccountListByPage(List<Account> acc, int start, int end) {
        ArrayList<Account> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(acc.get(i));
        }
        return arr;
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        List<Account> acc = dao.getUserNameByProductId("ST0001");
        System.out.println(acc.get(0).getFirstName());
    }
}
