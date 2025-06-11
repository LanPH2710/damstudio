package model;

public class FavoriteProduct {
    private int userId;
    private String productId;

    public FavoriteProduct() {
    }

    public FavoriteProduct(int userId, String productId) {
        this.userId = userId;
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }
    
}
