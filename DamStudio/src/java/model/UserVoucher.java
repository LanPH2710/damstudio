package model;

public class UserVoucher {
    private int userId;
    private int voucherId;
    private boolean isUse;

    public UserVoucher() {
    }

    public UserVoucher(int userId, int voucherId, boolean isUse) {
        this.userId = userId;
        this.voucherId = voucherId;
        this.isUse = isUse;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public boolean isIsUse() {
        return isUse;
    }

    public void setIsUse(boolean isUse) {
        this.isUse = isUse;
    }
    
}
