package model;
public class Size {
    private int sizeId;
    private String sizeName;
    private int heightMin;
    private int heightMax;
    private int weightMin;
    private int weightMax;
    private int sizeStatus;

    public Size() {
    }

    public Size(int sizeId, String sizeName, int heightMin, int heightMax, int weightMin, int weightMax, int sizeStatus) {
        this.sizeId = sizeId;
        this.sizeName = sizeName;
        this.heightMin = heightMin;
        this.heightMax = heightMax;
        this.weightMin = weightMin;
        this.weightMax = weightMax;
        this.sizeStatus = sizeStatus;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getHeightMin() {
        return heightMin;
    }

    public void setHeightMin(int heightMin) {
        this.heightMin = heightMin;
    }

    public int getHeightMax() {
        return heightMax;
    }

    public void setHeightMax(int heightMax) {
        this.heightMax = heightMax;
    }

    public int getWeightMin() {
        return weightMin;
    }

    public void setWeightMin(int weightMin) {
        this.weightMin = weightMin;
    }

    public int getWeightMax() {
        return weightMax;
    }

    public void setWeightMax(int weightMax) {
        this.weightMax = weightMax;
    }

    public int getSizeStatus() {
        return sizeStatus;
    }

    public void setSizeStatus(int sizeStatus) {
        this.sizeStatus = sizeStatus;
    }
    
}
