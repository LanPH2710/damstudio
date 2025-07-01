package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

public class FeedbackDAO extends DBContext{
    public List<Feedback> getFeedbackByProductId(String productID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE status =1 and productId LIKE ?"
                + "order by feedbackTime desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            // Gán giá trị cho tham số productID
            st.setString(1, "%" + productID + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int feedbackId = rs.getInt("feedbackId");
                int userId = rs.getInt("userId");
                String productId = rs.getString("productId");
                String feedbackInfo = rs.getString("feedbackInfo");
                String feedbackTime = rs.getString("feedbackTime");
                String feedbackImg = rs.getString("feedbackImg");
                int feedbackRate = rs.getInt("feedbackRate");
                int status = rs.getInt("status");

                if (feedbackImg == null) {
                    feedbackImg = "";
                }
                Feedback feedback = new Feedback(feedbackId, userId, productId, feedbackInfo, feedbackTime, feedbackImg, feedbackRate, status);
                list.add(feedback);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Feedback> getFeedbackByRate(String productID, int rate) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE status =1 and productId LIKE ? AND feedbackRate = ? ORDER BY feedbackTime DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, productID);
            st.setInt(2, rate);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int feedbackId = rs.getInt("feedbackId");
                int userId = rs.getInt("userId");
                String productId = rs.getString("productId");
                String feedbackInfo = rs.getString("feedbackInfo");
                String feedbackTime = rs.getString("feedbackTime");
                String feedbackImg = rs.getString("feedbackImg");
                int feedbackRate = rs.getInt("feedbackRate");
                int status = rs.getInt("status");

                if (feedbackImg == null) {
                    feedbackImg = "";
                }

                Feedback feedback = new Feedback(feedbackId, userId, productId, feedbackInfo, feedbackTime, feedbackImg, feedbackRate, status);
                list.add(feedback);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public int getRateProduct(String productId) {
        int rate = 0;
        String sql = "SELECT CEIL(AVG(feedbackRate)) AS avgRate "
                + "FROM feedback "
                + "WHERE productId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getObject("avgRate") != null) {  // Kiểm tra nếu có giá trị trả về
                    rate = rs.getInt("avgRate");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rate;
    }
    
    public List<Feedback> getFeedbackListByPage(List<Feedback> feedbacks, int start, int end) {
        ArrayList<Feedback> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(feedbacks.get(i));
        }
        return arr;
    }
    
    public static void main(String[] args) {
        FeedbackDAO fdao = new FeedbackDAO();
        String productId = "ST0001"; // thay bằng productId thực tế trong CSDL

        System.out.println("=== TẤT CẢ FEEDBACK CỦA SẢN PHẨM ===");
        List<Feedback> feedbacks = fdao.getFeedbackByProductId(productId);
        for (Feedback fb : feedbacks) {
            System.out.println("User ID: " + fb.getUserId());
            System.out.println("Rate: " + fb.getFeedbackRate());
            System.out.println("Info: " + fb.getFeedbackInfo());
            System.out.println("Time: " + fb.getFeedbackTime());
            System.out.println("Image: " + fb.getFeedbackImg());
            System.out.println("-----------");
        }

        System.out.println("\n=== FEEDBACK VỚI RATE = 5 ===");
        List<Feedback> feedbacksRate5 = fdao.getFeedbackByRate(productId, 5);
        for (Feedback fb : feedbacksRate5) {
            System.out.println("Rate 5 - Info: " + fb.getFeedbackInfo());
        }

        System.out.println("\n=== RATE TRUNG BÌNH CỦA SẢN PHẨM ===");
        int avgRate = fdao.getRateProduct(productId);
        System.out.println("Trung bình đánh giá: " + avgRate + " sao");

        System.out.println("\n=== TEST PHÂN TRANG (page 1 - 2 feedbacks) ===");
        int start = 0;
        int end = Math.min(2, feedbacks.size());
        List<Feedback> page1 = fdao.getFeedbackListByPage(feedbacks, start, end);
        for (Feedback fb : page1) {
            System.out.println("Page1 - Feedback: " + fb.getFeedbackInfo());
        }
    }
}
