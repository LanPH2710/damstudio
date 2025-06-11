package model;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private String productId;
    private int sizeId;
    private int colorId;
    private int quantity;
    private double productPrice;
    private String orderStatusDescription;
    private int isFeedback;  

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, String productId, int sizeId, int colorId, int quantity, double productPrice, String orderStatusDescription, int isFeedback) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.quantity = quantity;
        this.productPrice = productPrice;
        this.orderStatusDescription = orderStatusDescription;
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

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getOrderStatusDescription() {
        return orderStatusDescription;
    }

    public void setOrderStatusDescription(String orderStatusDescription) {
        this.orderStatusDescription = orderStatusDescription;
    }

    public int getIsFeedback() {
        return isFeedback;
    }

    public void setIsFeedback(int isFeedback) {
        this.isFeedback = isFeedback;
    }
    
}
