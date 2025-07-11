package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.AddressUser;

public class AddressUserDAO extends DBContext {

    public List<AddressUser> getAddressByUserId(int userId) {
        List<AddressUser> addressList = new ArrayList<>();
        String sql = "SELECT * FROM addressUser WHERE userId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AddressUser addressUser = new AddressUser();
                addressUser.setAddressId(rs.getInt("addressId"));
                addressUser.setUserId(rs.getInt("userId"));
                addressUser.setAddress(rs.getString("address"));
                addressUser.setName(rs.getString("name"));
                addressUser.setEmail(rs.getString("email"));
                addressUser.setPhone(rs.getString("phone"));
                addressList.add(addressUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return addressList;
    }

    public AddressUser getAddressById(int addressId) {
        AddressUser addressUser = null;
        String sql = "SELECT * FROM addressUser WHERE addressId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    addressUser = new AddressUser();
                    addressUser.setUserId(rs.getInt("userId"));
                    addressUser.setAddressId(rs.getInt("addressId"));
                    addressUser.setAddress(rs.getString("address"));
                    addressUser.setName(rs.getString("name"));
                    addressUser.setEmail(rs.getString("email"));
                    addressUser.setPhone(rs.getString("phone"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // You can log the exception or rethrow it based on your application's needs
        }
        return addressUser;
    }

    public void editAddress(int userId, int addressId, String address) {
        String sql = "UPDATE address SET address = ? where userId = ? and addressId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, address);
            st.setInt(2, userId);
            st.setInt(3, addressId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
