/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLocations;

import validationUtils.*;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class Validate {
    public String allErrors ="";
    public String diveLocationMsg = "";
    public String locationNameMsg = "";
    public String cityMsg = "";
    public String stateMsg = "";
    public String typeMsg = "";
    public String accesssViaMsg = "";
    public String averageDepthMsg = "";
    public String averageVisibilityMsg = "";
    public String featuresMsg = "";
    public String pictureRefMsg = "";
    public boolean isValidated = false; // true iff all fields validate ok.
    public String debugMsg = "";
    // Web User data fields from form (all String, pre-validation), bundled in this object
    public StringData loc = new StringData();
    // Web User data fields after validation (various data types), bundled into this object
    public TypedData locT = new TypedData();

    public Validate() {
    }

    public Validate(StringData loc) {
        this.loc = loc;
            ValidateInteger vi;
            ValidateString vstr;
        if(loc.diveLocation != null && loc.diveLocation.length() != 0) {
            vi = new ValidateInteger(loc.diveLocation, true);
            locT.setDiveLocation(vi.getConvertedInteger());
        }
        
        
        
vstr = new ValidateString(loc.locationName,45,true);
locT.setLocationName(vstr.getConvertedString());
this.locationNameMsg = vstr.getError();





vstr = new ValidateString(loc.city,25,true);
locT.setCity(vstr.getConvertedString());
this.cityMsg = vstr.getError();


vstr = new ValidateString(loc.state,2,true);
locT.setState(vstr.getConvertedString());
this.stateMsg = vstr.getError();


vstr = new ValidateString(loc.type,45,true);
locT.setType(vstr.getConvertedString());
this.typeMsg = vstr.getError();


vstr = new ValidateString(loc.accesssVia,45,false);
locT.setAccesssVia(vstr.getConvertedString());
this.accesssViaMsg = vstr.getError();



vi = new ValidateInteger(loc.averageDepth,false);
locT.setAverageDepth(vi.getConvertedInteger());
this.averageDepthMsg = vi.getError();


vi =  new ValidateInteger(loc.averageVisibility,false);
locT.setAverageVisibility(vi.getConvertedInteger());
this.averageVisibilityMsg = vi.getError();


vstr = new ValidateString(loc.features,1008,false);
locT.setFeatures(vstr.getConvertedString());
this.featuresMsg = vstr.getError();


vstr = new ValidateString(loc.pictureRef,100,false);
locT.setPictureRef(vstr.getConvertedString());
this.pictureRefMsg = vstr.getError();


allErrors += "" + this.locationNameMsg;
allErrors += "" + this.cityMsg;
allErrors += "" + this.stateMsg;
allErrors += "" + this.typeMsg;
allErrors += "" + this.accesssViaMsg;
allErrors += "" + this.averageDepthMsg;
allErrors += "" + this.averageVisibilityMsg;
allErrors += "" + this.featuresMsg;
allErrors += "" + this.pictureRefMsg;

System.out.println("**********************ERrOR MESSAGES:  "+allErrors); 
 isValidated = (allErrors.length() == 0);   
        

    }

    /**
     * @return the diveLocationMsg
     */
    public String getDiveLocationMsg() {
        return diveLocationMsg;
    }

    /**
     * @param diveLocationMsg the diveLocationMsg to set
     */
    public void setDiveLocationMsg(String diveLocationMsg) {
        this.diveLocationMsg = diveLocationMsg;
    }

    /**
     * @return the locationNameMsg
     */
    public String getLocationNameMsg() {
        return locationNameMsg;
    }

    /**
     * @param locationNameMsg the locationNameMsg to set
     */
    public void setLocationNameMsg(String locationNameMsg) {
        this.locationNameMsg = locationNameMsg;
    }

    /**
     * @return the cityMsg
     */
    public String getCityMsg() {
        return cityMsg;
    }

    /**
     * @param cityMsg the cityMsg to set
     */
    public void setCityMsg(String cityMsg) {
        this.cityMsg = cityMsg;
    }

    /**
     * @return the stateMsg
     */
    public String getStateMsg() {
        return stateMsg;
    }

    /**
     * @param stateMsg the stateMsg to set
     */
    public void setStateMsg(String stateMsg) {
        this.stateMsg = stateMsg;
    }

    /**
     * @return the typeMsg
     */
    public String getTypeMsg() {
        return typeMsg;
    }

    /**
     * @param typeMsg the typeMsg to set
     */
    public void setTypeMsg(String typeMsg) {
        this.typeMsg = typeMsg;
    }

    /**
     * @return the accesssViaMsg
     */
    public String getAccesssViaMsg() {
        return accesssViaMsg;
    }

    /**
     * @param accesssViaMsg the accesssViaMsg to set
     */
    public void setAccesssViaMsg(String accesssViaMsg) {
        this.accesssViaMsg = accesssViaMsg;
    }

    /**
     * @return the averageDepthMsg
     */
    public String getAverageDepthMsg() {
        return averageDepthMsg;
    }

    /**
     * @param averageDepthMsg the averageDepthMsg to set
     */
    public void setAverageDepthMsg(String averageDepthMsg) {
        this.averageDepthMsg = averageDepthMsg;
    }

    /**
     * @return the averageVisibilityMsg
     */
    public String getAverageVisibilityMsg() {
        return averageVisibilityMsg;
    }

    /**
     * @param averageVisibilityMsg the averageVisibilityMsg to set
     */
    public void setAverageVisibilityMsg(String averageVisibilityMsg) {
        this.averageVisibilityMsg = averageVisibilityMsg;
    }

    /**
     * @return the featuresMsg
     */
    public String getFeaturesMsg() {
        return featuresMsg;
    }

    /**
     * @param featuresMsg the featuresMsg to set
     */
    public void setFeaturesMsg(String featuresMsg) {
        this.featuresMsg = featuresMsg;
    }

    /**
     * @return the pictureRefMsg
     */
    public String getPictureRefMsg() {
        return pictureRefMsg;
    }

    /**
     * @param pictureRefMsg the pictureRefMsg to set
     */
    public void setPictureRefMsg(String pictureRefMsg) {
        this.pictureRefMsg = pictureRefMsg;
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
     * @return the loc
     */
    public StringData getLoc() {
        return loc;
    }

    /**
     * @param loc the loc to set
     */
    public void setLoc(StringData loc) {
        this.loc = loc;
    }

    /**
     * @return the locT
     */
    public TypedData getLocT() {
        return locT;
    }

    /**
     * @param locT the locT to set
     */
    public void setLocT(TypedData locT) {
        this.locT = locT;
    }

    /**
     * @return the allErrors
     */
    public String getAllErrors() {
        return allErrors;
    }

    /**
     * @param allErrors the allErrors to set
     */
    public void setAllErrors(String allErrors) {
        this.allErrors = allErrors;
    }
}
