package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Style;

public class StyleDAO extends DBContext{
    public List<Style> getAllStyle() {

        List<Style> listStyle = new ArrayList<>();

        String sql = "SELECT * FROM style where styleStatus = 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Style style = new Style();
                style.setStyleId(rs.getInt("styleId"));
                style.setStyleName(rs.getString("styleName"));
                listStyle.add(style);
            }

        } catch (SQLException e) {
        }
        return listStyle;
    }
}
