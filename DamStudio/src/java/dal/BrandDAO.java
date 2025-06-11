package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Brand;

public class BrandDAO extends DBContext {

    public String getBrandById(int brandId) {
        String sql = "select * from Brand where brandId=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, brandId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getString(2);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Brand> getAllBrand() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM brand where brandStatus =1";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brandId"));
                brand.setName(rs.getString("name"));
                list.add(brand);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllBrand: " + e.getMessage());
        }
        return list;
    }
    
    public static void main(String[] args) {
        BrandDAO brandDao = new BrandDAO();

        // Test getBrandById
        int testId = 1; // thay đổi ID cho phù hợp với DB của bạn
        String brandName = brandDao.getBrandById(testId);
        if (brandName != null) {
            System.out.println("Tên thương hiệu với ID " + testId + " là: " + brandName);
        } else {
            System.out.println("Không tìm thấy thương hiệu với ID " + testId);
        }

        // Test getAllBrand
        List<Brand> allBrands = brandDao.getAllBrand();
        System.out.println("Danh sách thương hiệu đang hoạt động:");
        for (Brand brand : allBrands) {
            System.out.println("- ID: " + brand.getBrandId() + ", Tên: " + brand.getName());
        }
    }
}
