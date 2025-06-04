package model;

public class Color {

    private int colorId;
    private String colorName;
    private int colorStatus;

    public Color() {
    }

    public Color(int colorId, String colorName, int colorStatus) {
        this.colorId = colorId;
        this.colorName = colorName;
        this.colorStatus = colorStatus;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public int getColorStatus() {
        return colorStatus;
    }

    public void setColorStatus(int colorStatus) {
        this.colorStatus = colorStatus;
    }
    
}
