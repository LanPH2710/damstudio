package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

public class AccountDAO extends DBContext{
    public Account getAccountById(int userId) {
        String sql = "SELECT * FROM Account WHERE userId=?";
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
                        rs.getInt(6), // gender
                        rs.getString(7), // email
                        rs.getString(8), // mobile
                        rs.getString(9), // address
                        rs.getInt(10), // roleId
                        rs.getString(11), // avatar
                        rs.getInt(12), // status
                        rs.getBigDecimal(13) // money
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean isValidMobile(String mobile) {
        System.out.println("Checking mobile validity: " + mobile);
        return mobile != null && mobile.matches("\\d{10}");
    }
    
    public void editAccount(String userName, String password, String firstName, String lastName, int gender, String email, String mobile, String address, int roleId, String avatar, int status, int userId) {
        String sql = "UPDATE Account SET "
                + "userName = ?, "
                + "password = ?, "
                + "firstName = ?, "
                + "lastName = ?, "
                + "gender = ?, "
                + "email = ?, "
                + "mobile = ?, "
                + "address = ?, "
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
            st.setString(8, address);
            st.setInt(9, roleId);
            st.setString(10, avatar);
            st.setInt(11, status);
            st.setInt(12, userId);

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
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getBigDecimal(13)
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
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getBigDecimal(13)
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
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getBigDecimal(13)
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
                    + "(userName, password, firstName, lastName, gender, email, mobile, address, roleId, avatar) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, acc.getUserName());
            //stm.setString(2, hashedPassword);
            stm.setString(2, acc.getPassword());
            stm.setString(3, acc.getFirstName());
            stm.setString(4, acc.getLastName());
            stm.setInt(5, acc.getGender());
            stm.setString(6, acc.getEmail());
            stm.setString(7, acc.getMobile());
            stm.setString(8, acc.getAddress());
            stm.setInt(9, 4); //role mac dinh - customer
            stm.setString(10, "avatar-trang-4.jpg"); //ava mac dinh
            stm.executeUpdate();
            System.out.println("Account đã được thêm thành công!");
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm account: " + e.getMessage());
        }
    }
}
