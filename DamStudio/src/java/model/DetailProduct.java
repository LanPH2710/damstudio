package model;

public class DetailProduct {

    private String productId;
    private int sizeId;
    private int colorId;
    private int imageId;
    private int quantity;

    public DetailProduct() {
    }

    public DetailProduct(String productId, int sizeId, int colorId, int imageId, int quantity) {
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.imageId = imageId;
        this.quantity = quantity;
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

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
