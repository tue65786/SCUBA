/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


package view.NameValues;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import SQL.DbConn;
import SQL.FormatUtils;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class UserRole {
 public String UserRoleName = "";
 public int UserRoleId;

 public UserRole()
 {
     
 }
 
 
 public UserRole(int id, String name)
 {
     this.UserRoleId = id;
     this.UserRoleName = name;
 }
 
 
 
  /**
     * @return the UserRoleName
     */
    public String getUserRoleName() {
        return UserRoleName;
    }

    /**
     * @param UserRoleName the UserRoleName to set
     */
    public void setUserRoleName(String UserRoleName) {
        this.UserRoleName = UserRoleName;
    }

    /**
     * @return the UserRoleId
     */
    public int getUserRoleId() {
        return UserRoleId;
    }

    /**
     * @param UserRoleId the UserRoleId to set
     */
    public void setUserRoleId(int UserRoleId) {
        this.UserRoleId = UserRoleId;
    }
 
}
