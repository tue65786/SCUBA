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
public class StringData {
   public String dive_date="", number_dives="", minutes_per_dive="", air_type="", max_depth="", dive_buddy="", notes="", dive_location_id="", web_user_id="",recordStatus="default";	

    /**
     * @return the dive_date
     */
    public String getDive_date() {
        return dive_date;
    }

    /**
     * @param dive_date the dive_date to set
     */
    public void setDive_date(String dive_date) {
        this.dive_date = dive_date;
    }

    /**
     * @return the number_dives
     */
    public String getNumber_dives() {
        return number_dives;
    }

    /**
     * @param number_dives the number_dives to set
     */
    public void setNumber_dives(String number_dives) {
        this.number_dives = number_dives;
    }

    /**
     * @return the minutes_per_dive
     */
    public String getMinutes_per_dive() {
        return minutes_per_dive;
    }

    /**
     * @param minutes_per_dive the minutes_per_dive to set
     */
    public void setMinutes_per_dive(String minutes_per_dive) {
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
    public String getMax_depth() {
        return max_depth;
    }

    /**
     * @param max_depth the max_depth to set
     */
    public void setMax_depth(String max_depth) {
        this.max_depth = max_depth;
    }

    /**
     * @return the dive_buddy
     */
    public String getDive_buddy() {
        return dive_buddy;
    }

    /**
     * @param dive_buddy the dive_buddy to set
     */
    public void setDive_buddy(String dive_buddy) {
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
    public String getDive_location_id() {
        return dive_location_id;
    }

    /**
     * @param dive_location_id the dive_location_id to set
     */
    public void setDive_location_id(String dive_location_id) {
        this.dive_location_id = dive_location_id;
    }

    /**
     * @return the web_user_id
     */
    public String getWeb_user_id() {
        return web_user_id;
    }

    /**
     * @param web_user_id the web_user_id to set
     */
    public void setWeb_user_id(String web_user_id) {
        this.web_user_id = web_user_id;
    }
       
    private String valueOrNull(String in) {
        if(in == null) {
            return "null";
        }
        return in;
    }

    /**
     * @return the recordStatus
     */
    public String getRecordStatus() {
        return recordStatus;
    }

    /**
     * @param recordStatus the recordStatus to set
     */
    public void setRecordStatus(String recordStatus) {
        this.recordStatus = recordStatus;
    }
    
//    public String toJSON() {
//        return "({ webUserId: '" + valueOrNull(webUserId) + "', userEmail: '" + valueOrNull(userEmail)
//               + "', userPw: '" + valueOrNull(userPw) + "', userPw2: '" + valueOrNull(userPw2)
//               + "', membershipFee: '" + valueOrNull(membershipFee) + "', userRoleId: '" + valueOrNull(userRoleId)
//               + "', birthday: '" + valueOrNull(birthday) + "', recordStatus: '" + valueOrNull(recordStatus) + "' })";
//    }
}
