package model;

public class Role {

    private int roleId;
    private String roleName;
    private int status;

    public Role() {
    }

    public Role(int roleId, String roleName, int status) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.status = status;
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
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
