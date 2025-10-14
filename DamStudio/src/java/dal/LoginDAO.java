package dal;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import context.DBContext;
import java.io.IOException;
import model.GoogleAccount;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import model.Inconstant;

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
                // account.setAddress(rs.getString("address")); // <-- XÓA DÒNG NÀY
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
    
    public void inserUserByEmail(String username, String password, String firstName,
            String lastName, String gender, String email, String phone, String avatar) {
        String sql = "INSERT INTO account (userName, password, firstName, lastName, gender, email, mobile, roleId, avatar, accountStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, firstName);
            ps.setString(4, lastName);
            ps.setInt(5, Integer.parseInt(gender));
            ps.setString(6, email);
            ps.setString(7, "");
            ps.setInt(8, 4);
            ps.setString(9, avatar);
            ps.setInt(10, 1);

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Account getEmailAndPassword(String username, String password) {
        String sql = "SELECT * FROM damstudio.account WHERE email = ? AND password = ? AND accountStatus = 1";
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
                // account.setAddress(rs.getString("address")); // <-- XÓA DÒNG NÀY
                account.setRoleId(rs.getInt("roleId"));
                account.setAvatar(rs.getString("avatar"));
                account.setAccountStatus(rs.getInt("accountStatus"));
                account.setMoney(rs.getBigDecimal("money"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi truy vấn CSDL: " + e.getMessage());
        }
        return null;
    }

    public Account getByEmail(String email) {
        String sql = "select * from account where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setUserId(rs.getInt("userId"));
                account.setUserName(rs.getString("userName"));
                account.setPassword(rs.getString("password"));
                account.setFirstName(rs.getString("firstName"));
                account.setLastName(rs.getString("lastName"));
                account.setGender(rs.getInt("gender"));
                account.setEmail(rs.getString("email"));
                account.setMobile(rs.getString("mobile"));
                // account.setAddress(rs.getString("address")); // <-- XÓA DÒNG NÀY
                account.setRoleId(rs.getInt("roleId"));
                account.setAvatar(rs.getString("avatar"));
                account.setAccountStatus(rs.getInt("accountStatus"));
                account.setMoney(rs.getBigDecimal("money"));
                return account;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {

        String response = Request.Post(Inconstant.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", Inconstant.GOOGLE_CLIENT_ID)
                                .add("client_secret", Inconstant.GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", Inconstant.GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", Inconstant.GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

        return accessToken;
    }

    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Inconstant.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        GoogleAccount googlePojo = new Gson().fromJson(response, GoogleAccount.class);
        return googlePojo;

    }
}
