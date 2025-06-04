package model;

public class Brand {
     private int brandId;
    private String name;
    private int brandStatus;

    public Brand() {
    }

    public Brand(int brandId, String name, int brandStatus) {
        this.brandId = brandId;
        this.name = name;
        this.brandStatus = brandStatus;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getBrandStatus() {
        return brandStatus;
    }

    public void setBrandStatus(int brandStatus) {
        this.brandStatus = brandStatus;
    }
    
    
}
