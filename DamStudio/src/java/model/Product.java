package model;

import java.util.List;

public class Product {

    private String productId;
    private String name;
    private double price;
    private String description;
    private double VAT;
    private int brandId;
    private int styleId;
    private int status;
    private List<DetailProduct> detailProduct;
    private List<ProductImage> images;

    public Product() {
    }

    public Product(String productId, String name, double price, String description, double VAT, int brandId, int styleId, int status, List<DetailProduct> detailProduct) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.description = description;
        this.VAT = VAT;
        this.brandId = brandId;
        this.styleId = styleId;
        this.status = status;
        this.detailProduct = detailProduct;
    }

    public Product(String productId, String name, double price, String description, double VAT, int brandId, int styleId, int status, List<DetailProduct> detailProduct, List<ProductImage> images) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.description = description;
        this.VAT = VAT;
        this.brandId = brandId;
        this.styleId = styleId;
        this.status = status;
        this.detailProduct = detailProduct;
        this.images = images;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getVAT() {
        return VAT;
    }

    public void setVAT(double VAT) {
        this.VAT = VAT;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getStyleId() {
        return styleId;
    }

    public void setStyleId(int styleId) {
        this.styleId = styleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<DetailProduct> getDetailProduct() {
        return detailProduct;
    }

    public void setDetailProduct(List<DetailProduct> detailProduct) {
        this.detailProduct = detailProduct;
    }

    public List<ProductImage> getImages() {
        return images;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }
}
