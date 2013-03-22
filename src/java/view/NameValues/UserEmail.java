/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package view.NameValues;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class UserEmail {
 public String EmailAddress ="";
 public int UserId;

 
 public UserEmail() {
    
}
 
 public UserEmail(int id, String email)
 {
     this.UserId = id;
     this.EmailAddress = email;
 }
         
         
    /**
     * @return the EmailAddress
     */
    public String getEmailAddress() {
        return EmailAddress;
    }

    /**
     * @param EmailAddress the EmailAddress to set
     */
    public void setEmailAddress(String EmailAddress) {
        this.EmailAddress = EmailAddress;
    }

    /**
     * @return the UserId
     */
    public int getUserId() {
        return UserId;
    }

    /**
     * @param UserId the UserId to set
     */
    public void setUserId(int UserId) {
        this.UserId = UserId;
    }
 
 
}
