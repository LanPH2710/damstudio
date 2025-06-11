package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Size;

public class SizeDAO extends DBContext {

    public List<Size> getAllSize() {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM size where sizeStatus = 1";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Size size = new Size();
                size.setSizeId(rs.getInt("sizeId"));
                size.setSizeName(rs.getString("sizeName"));
                size.setHeightMin(rs.getInt("heightMin"));
                size.setHeightMax(rs.getInt("heightMax"));
                size.setWeightMin(rs.getInt("weightMin"));
                size.setWeightMax(rs.getInt("weightMax"));
                list.add(size);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllSize: " + e.getMessage());
        }
        return list;
    }
}
