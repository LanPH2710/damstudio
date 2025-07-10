package model;

public class Role {

    private int roleId;
    private String roleName;
    private int roleStatus;

    public Role() {
    }

    public Role(int roleId, String roleName, int roleStatus) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.roleStatus = roleStatus;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public int getStatus() {
        return roleStatus;
    }

    public void setStatus(int status) {
        this.roleStatus = status;
    }
}
