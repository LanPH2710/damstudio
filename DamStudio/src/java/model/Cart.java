package model;

public class Cart {

    int cartId;
    int userId;
    private String productId;
    private int sizeId;
    private int colorId;
    private int cartQuantity;

    public Cart() {
    }

    public Cart(int cartId, int userId, String productId, int sizeId, int colorId, int cartQuantity) {
        this.cartId = cartId;
        this.userId = userId;
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.cartQuantity = cartQuantity;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public int getCartQuantity() {
        return cartQuantity;
    }

    public void setCartQuantity(int cartQuantity) {
        this.cartQuantity = cartQuantity;
    }
   
}