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
        String sql = "SELECT * FROM addressuser WHERE userId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AddressUser addressUser = new AddressUser();
                addressUser.setAddressId(rs.getInt("addressId"));
                addressUser.setUserId(rs.getInt("userId"));
                addressUser.setProvince(rs.getString("province"));
                addressUser.setDistrict(rs.getString("district"));
                addressUser.setWard(rs.getString("ward"));
                addressUser.setAddressDetail(rs.getString("addressDetail"));
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
        String sql = "SELECT * FROM addressuser WHERE addressId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    addressUser = new AddressUser();
                    addressUser.setUserId(rs.getInt("userId"));
                    addressUser.setAddressId(rs.getInt("addressId"));
                    addressUser.setProvince(rs.getString("province"));
                    addressUser.setDistrict(rs.getString("district"));
                    addressUser.setWard(rs.getString("ward"));
                    addressUser.setAddressDetail(rs.getString("addressDetail"));
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

    public void editAddress(int userId, int addressId, String province, String district, String ward,
            String addressDetail) {
        String sql = "UPDATE addressuser "
                + "SET province = ?, district = ?, ward = ?, addressDetail = ?"
                + "WHERE userId = ? AND addressId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, province);
            st.setString(2, district);
            st.setString(3, ward);
            st.setString(4, addressDetail);
            st.setInt(5, userId);
            st.setInt(6, addressId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void editCartAddress(int userId, int addressId, String province, String district, String ward,
            String addressDetail, String name, String email, String phone) {
        String sql = "UPDATE addressuser "
                + "SET province = ?, district = ?, ward = ?, addressDetail = ?, "
                + "name = ?, email = ?, phone = ? "
                + "WHERE userId = ? AND addressId = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, province);
            st.setString(2, district);
            st.setString(3, ward);
            st.setString(4, addressDetail);
            st.setString(5, name);
            st.setString(6, email);
            st.setString(7, phone);
            st.setInt(8, userId);
            st.setInt(9, addressId);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating address: " + e.getMessage());
        }
    }

    public void insertCartAddress(int userId, String province, String district, String ward,
            String addressDetail, String name, String email, String phone) {
        String sql = "INSERT INTO addressuser (userId, province, district, ward, addressDetail, name, email, phone) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setString(2, province);
            st.setString(3, district);
            st.setString(4, ward);
            st.setString(5, addressDetail);
            st.setString(6, name);
            st.setString(7, email);
            st.setString(8, phone);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting address: " + e.getMessage());
        }
    }

    public void insertAddress(AddressUser address) {
        String sql = "INSERT INTO addressuser (userId, province, district, ward, addressDetail, name, email, phone) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, address.getUserId());
            st.setString(2, address.getProvince());
            st.setString(3, address.getDistrict());
            st.setString(4, address.getWard());
            st.setString(5, address.getAddressDetail());
            st.setString(6, address.getName());
            st.setString(7, address.getEmail());
            st.setString(8, address.getPhone());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
