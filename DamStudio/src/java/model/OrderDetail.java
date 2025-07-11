package model;

public class OrderDetail {

    private int orderDetailId;
    private int orderId;
    private String productId;
    private int sizeId;
    private int colorId;
    private int quantity;
    private int isFeedback;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, String productId, int sizeId, int colorId, int quantity, int isFeedback) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.quantity = quantity;
        this.isFeedback = isFeedback;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getIsFeedback() {
        return isFeedback;
    }

    public void setIsFeedback(int isFeedback) {
        this.isFeedback = isFeedback;
    }

}
