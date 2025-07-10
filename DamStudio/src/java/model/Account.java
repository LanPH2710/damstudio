package model;

import java.math.BigDecimal;

public class Account {

    private int userId;
    private String userName;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String mobile;
    private int gender;
    private int roleId;
    private String avatar;
    private int accountStatus;
    private BigDecimal money;

    // Constructor mặc định
    public Account() {
    }

    // Constructor full tham số đúng thứ tự như DB
    public Account(int userId, String userName, String password, String firstName, String lastName,
            String email, String mobile, int gender, int roleId, String avatar, int accountStatus, BigDecimal money) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.mobile = mobile;
        this.gender = gender;
        this.roleId = roleId;
        this.avatar = avatar;
        this.accountStatus = accountStatus;
        this.money = money;
    }

    // Constructor dùng cho insert nhanh (không có userId, money)
    public Account(String userName, String password, String firstName, String lastName,
            String email, String mobile, int gender, int roleId, String avatar, int accountStatus) {
        this.userName = userName;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.mobile = mobile;
        this.gender = gender;
        this.roleId = roleId;
        this.avatar = avatar;
        this.accountStatus = accountStatus;
    }

    // Getters and setters (giữ nguyên)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(int accountStatus) {
        this.accountStatus = accountStatus;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }
}
