package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}
