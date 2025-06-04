package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleDAO extends DBContext{
    public String getRoleNameById(int roleId) {
        String sql = "SELECT roleName FROM Role WHERE roleId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("roleName");
            }
        } catch (SQLException e) {
        }
        return "Unknown";
    }
}
