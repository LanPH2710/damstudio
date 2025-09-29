package model;

import java.sql.Timestamp;

public class OrderDetail {

    private int orderDetailId;
    private int orderId;
    private String productId;
    private int sizeId;
    private int colorId;
    private int quantity;
    private int isFeedback;

    private String productName;
    private String colorName;
    private String sizeName;
    private String imageUrl;
    private Timestamp createDate;
    private double price;

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

    public OrderDetail(int orderDetailId, int orderId, String productId, int sizeId, int colorId, int quantity, int isFeedback, String productName, String colorName, String sizeName, String imageUrl, Timestamp createDate, double price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.quantity = quantity;
        this.isFeedback = isFeedback;
        this.productName = productName;
        this.colorName = colorName;
        this.sizeName = sizeName;
        this.imageUrl = imageUrl;
        this.createDate = createDate;
        this.price = price;
    }

    public OrderDetail(int orderId, java.sql.Timestamp createDate, String productId,
            String productName, int quantity, String colorName, String imageUrl,
            int isFeedback, int orderDetailId, double price, String sizeName) {
        this.orderId = orderId;
        this.createDate = createDate;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.colorName = colorName;
        this.imageUrl = imageUrl;
        this.isFeedback = isFeedback;
        this.orderDetailId = orderDetailId;
        this.price = price;
        this.sizeName = sizeName;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

}
