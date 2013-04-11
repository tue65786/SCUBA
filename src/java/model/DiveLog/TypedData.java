/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLog;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class TypedData {
 private java.sql.Date dive_date=null;
private Integer number_dives=null; 
private Integer minutes_per_dive=null; 
private String air_type=""; 
private Integer max_depth=null; 
private Integer dive_buddy=null; 
private String notes=""; 
private Integer dive_location_id=null; 
private Integer web_user_id=null;

    /**
     * @return the dive_date
     */
    public java.sql.Date getDive_date() {
        return dive_date;
    }

    /**
     * @param dive_date the dive_date to set
     */
    public void setDive_date(java.sql.Date dive_date) {
        this.dive_date = dive_date;
    }

    /**
     * @return the number_dives
     */
    public Integer getNumber_dives() {
        return number_dives;
    }

    /**
     * @param number_dives the number_dives to set
     */
    public void setNumber_dives(Integer number_dives) {
        this.number_dives = number_dives;
    }

    /**
     * @return the minutes_per_dive
     */
    public Integer getMinutes_per_dive() {
        return minutes_per_dive;
    }

    /**
     * @param minutes_per_dive the minutes_per_dive to set
     */
    public void setMinutes_per_dive(Integer minutes_per_dive) {
        this.minutes_per_dive = minutes_per_dive;
    }

    /**
     * @return the air_type
     */
    public String getAir_type() {
        return air_type;
    }

    /**
     * @param air_type the air_type to set
     */
    public void setAir_type(String air_type) {
        this.air_type = air_type;
    }

    /**
     * @return the max_depth
     */
    public Integer getMax_depth() {
        return max_depth;
    }

    /**
     * @param max_depth the max_depth to set
     */
    public void setMax_depth(Integer max_depth) {
        this.max_depth = max_depth;
    }

    /**
     * @return the dive_buddy
     */
    public Integer getDive_buddy() {
        if (dive_buddy > 0)
        {return dive_buddy;}
        else 
        {return web_user_id;}
    }

    /**
     * @param dive_buddy the dive_buddy to set
     */
    public void setDive_buddy(Integer dive_buddy) {
        this.dive_buddy = dive_buddy;
    }

    /**
     * @return the notes
     */
    public String getNotes() {
        return notes;
    }

    /**
     * @param notes the notes to set
     */
    public void setNotes(String notes) {
        this.notes = notes;
    }

    /**
     * @return the dive_location_id
     */
    public Integer getDive_location_id() {
        return dive_location_id;
    }

    /**
     * @param dive_location_id the dive_location_id to set
     */
    public void setDive_location_id(Integer dive_location_id) {
        this.dive_location_id = dive_location_id;
    }

    /**
     * @return the web_user_id
     */
    public Integer getWeb_user_id() {
        return web_user_id;
    }

    /**
     * @param web_user_id the web_user_id to set
     */
    public void setWeb_user_id(Integer web_user_id) {
        this.web_user_id = web_user_id;
    }

}
