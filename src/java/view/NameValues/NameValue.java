/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 
 SELECT user_role_id AS id , user_role_title AS name FROM user_role ORDER BY user_role_title


 */
package view.NameValues;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class NameValue {

    /**
     *
     */
    public String name = "";
    /**
     *
     */
    public int id;

    /**
     *
     */
    public NameValue() {
    }

    /**
     *
     * @param ur
     */
    public NameValue(NameValue ur) {
        this.id = ur.id;
        this.name = ur.name;

    }

    /**
     *
     * @param id
     * @param name
     */
    public NameValue(int id, String name) {
        this.id = id;
        this.name = name;
    }

    /**
     *
     * @param name
     */
    public NameValue(String name) {
        this.id = 0;
        this.name = name;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     *
     * @return
     */
    public String getIdStr() {
        return Integer.toString(id);

    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }
}
