/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLog;

import validationUtils.*;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class Validate {

    private String dive_dateMsg = "",
        number_divesMsg = "",
        minutes_per_diveMsg = "",
        air_typeMsg = "", max_depthMsg = "",
        dive_buddyMsg = "", notesMsg = "",
        dive_location_idMsg = "",
        web_user_idMsg = "";
    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";
    private StringData dl = new StringData();
    // Web User data fields after validation (various data types), bundled into this object
    private TypedData dlt = new TypedData();

    public Validate() {
    }

    public Validate(StringData dl) {
        // validationUtils method validates each user input (String even if destined for other type) from WebUser object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.dl = dl;
        String allMsg = "";
        ValidateDate vdate = new ValidateDate(dl.dive_date, true);
        dlt.setDive_date(vdate.getConvertedDate());
        this.dive_dateMsg = vdate.getError();
        allMsg += this.dive_dateMsg;

        ValidateInteger vi = new ValidateInteger(dl.number_dives, true);
        dlt.setNumber_dives(vi.getConvertedInteger());
        this.number_divesMsg = vi.getError();
        allMsg += this.number_divesMsg;

        vi = new ValidateInteger(dl.minutes_per_dive, false);
        dlt.setMinutes_per_dive(vi.getConvertedInteger());
        this.minutes_per_diveMsg = vi.getError();
        allMsg += this.minutes_per_diveMsg;

        ValidateString vstr = new ValidateString(dl.air_type, 45, false);
        dlt.setAir_type(vstr.getConvertedString());
        this.air_typeMsg = vstr.getError();
        allMsg += this.air_typeMsg;

        vi = new ValidateInteger(dl.max_depth, false);
        dlt.setMax_depth(vi.getConvertedInteger());
        this.max_depthMsg = vi.getError();
        allMsg += this.max_depthMsg;

        vi = new ValidateInteger(dl.dive_buddy, true);
        dlt.setDive_buddy(vi.getConvertedInteger());
        if(vi.getError().length() > 0) {
            this.dive_buddyMsg = "Please select your dive buddy from the drop down list";
        }
        allMsg += this.dive_buddyMsg;

        vstr = new ValidateString(dl.notes, 200, false);
        dlt.setNotes(vstr.getConvertedString());
        this.notesMsg = vstr.getError();
        allMsg += this.notesMsg;

        vi = new ValidateInteger(dl.dive_location_id, true);
        dlt.setDive_location_id(vi.getConvertedInteger());
        this.dive_location_idMsg = vi.getError();
        allMsg += this.dive_location_idMsg;

        //if(dl.web_user_id != null && dl.web_user_id.length() != 0) {
        vi = new ValidateInteger(dl.web_user_id, true);
        dlt.setWeb_user_id(vi.getConvertedInteger());
        this.web_user_idMsg = vi.getError();
        allMsg += this.web_user_idMsg;
        //        }
//          ValidateString vstr = new ValidateString(wu.userPw, 45, true);
//        wut.setUserPw(vstr.getConvertedString());
//        this.userPwMsg = vstr.getError();

        isValidated = (allMsg.length() == 0);
    }

    public boolean isValidated() {
        return this.isIsValidated();
    }

    /**
     * @return the dive_dateMsg
     */
    public String getDive_dateMsg() {
        return dive_dateMsg;
    }

    /**
     * @param dive_dateMsg the dive_dateMsg to set
     */
    public void setDive_dateMsg(String dive_dateMsg) {
        this.dive_dateMsg = dive_dateMsg;
    }

    /**
     * @return the number_divesMsg
     */
    public String getNumber_divesMsg() {
        return number_divesMsg;
    }

    /**
     * @param number_divesMsg the number_divesMsg to set
     */
    public void setNumber_divesMsg(String number_divesMsg) {
        this.number_divesMsg = number_divesMsg;
    }

    /**
     * @return the minutes_per_diveMsg
     */
    public String getMinutes_per_diveMsg() {
        return minutes_per_diveMsg;
    }

    /**
     * @param minutes_per_diveMsg the minutes_per_diveMsg to set
     */
    public void setMinutes_per_diveMsg(String minutes_per_diveMsg) {
        this.minutes_per_diveMsg = minutes_per_diveMsg;
    }

    /**
     * @return the air_typeMsg
     */
    public String getAir_typeMsg() {
        return air_typeMsg;
    }

    /**
     * @param air_typeMsg the air_typeMsg to set
     */
    public void setAir_typeMsg(String air_typeMsg) {
        this.air_typeMsg = air_typeMsg;
    }

    /**
     * @return the max_depthMsg
     */
    public String getMax_depthMsg() {
        return max_depthMsg;
    }

    /**
     * @param max_depthMsg the max_depthMsg to set
     */
    public void setMax_depthMsg(String max_depthMsg) {
        this.max_depthMsg = max_depthMsg;
    }

    /**
     * @return the dive_buddyMsg
     */
    public String getDive_buddyMsg() {
        return dive_buddyMsg;
    }

    /**
     * @param dive_buddyMsg the dive_buddyMsg to set
     */
    public void setDive_buddyMsg(String dive_buddyMsg) {
        this.dive_buddyMsg = dive_buddyMsg;
    }

    /**
     * @return the notesMsg
     */
    public String getNotesMsg() {
        return notesMsg;
    }

    /**
     * @param notesMsg the notesMsg to set
     */
    public void setNotesMsg(String notesMsg) {
        this.notesMsg = notesMsg;
    }

    /**
     * @return the dive_location_idMsg
     */
    public String getDive_location_idMsg() {
        return dive_location_idMsg;
    }

    /**
     * @param dive_location_idMsg the dive_location_idMsg to set
     */
    public void setDive_location_idMsg(String dive_location_idMsg) {
        this.dive_location_idMsg = dive_location_idMsg;
    }

    /**
     * @return the web_user_idMsg
     */
    public String getWeb_user_idMsg() {
        return web_user_idMsg;
    }

    /**
     * @param web_user_idMsg the web_user_idMsg to set
     */
    public void setWeb_user_idMsg(String web_user_idMsg) {
        this.web_user_idMsg = web_user_idMsg;
    }

    /**
     * @return the isValidated
     */
    public boolean isIsValidated() {
        return isValidated;
    }

    /**
     * @param isValidated the isValidated to set
     */
    public void setIsValidated(boolean isValidated) {
        this.isValidated = isValidated;
    }

    /**
     * @return the debugMsg
     */
    public String getDebugMsg() {
        return debugMsg;
    }

    /**
     * @param debugMsg the debugMsg to set
     */
    public void setDebugMsg(String debugMsg) {
        this.debugMsg = debugMsg;
    }

    /**
     * @return the dl
     */
    public StringData getDl() {
        return dl;
    }

    /**
     * @param dl the dl to set
     */
    public void setDl(StringData dl) {
        this.dl = dl;
    }

    /**
     * @return the dlt
     */
    public TypedData getDlt() {
        return dlt;
    }

    /**
     * @param dlt the dlt to set
     */
    public void setDlt(TypedData dlt) {
        this.dlt = dlt;
    }
}
