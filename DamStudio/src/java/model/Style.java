package model;

public class Style {
    private int styleId;
    private String styleName;
    private int styleStatus;

    public Style() {
    }

    public Style(int styleId, String styleName, int styleStatus) {
        this.styleId = styleId;
        this.styleName = styleName;
        this.styleStatus = styleStatus;
    }

    public int getStyleId() {
        return styleId;
    }

    public void setStyleId(int styleId) {
        this.styleId = styleId;
    }

    public String getStyleName() {
        return styleName;
    }

    public void setStyleName(String styleName) {
        this.styleName = styleName;
    }

    public int getStyleStatus() {
        return styleStatus;
    }

    public void setStyleStatus(int styleStatus) {
        this.styleStatus = styleStatus;
    }
    
}
