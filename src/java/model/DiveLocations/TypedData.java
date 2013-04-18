/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLocations;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class TypedData {
    public Integer diveLocation  = null;
public String locationName  = "";
public String city  = "";
public String state  = "";
public String type  = "";
public String accesssVia  = "";
public Integer averageDepth  = null;
public Integer averageVisibility  = null;
public String features  = "";
public String pictureRef  = "";

    /**
     * @return the diveLocation
     */
    public Integer getDiveLocation() {
        return diveLocation;
    }

    /**
     * @param diveLocation the diveLocation to set
     */
    public void setDiveLocation(Integer diveLocation) {
        this.diveLocation = diveLocation;
    }

    /**
     * @return the locationName
     */
    public String getLocationName() {
        return locationName;
    }

    /**
     * @param locationName the locationName to set
     */
    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return the accesssVia
     */
    public String getAccesssVia() {
        return accesssVia;
    }

    /**
     * @param accesssVia the accesssVia to set
     */
    public void setAccesssVia(String accesssVia) {
        this.accesssVia = accesssVia;
    }

    /**
     * @return the averageDepth
     */
    public Integer getAverageDepth() {
        return averageDepth;
    }

    /**
     * @param averageDepth the averageDepth to set
     */
    public void setAverageDepth(Integer averageDepth) {
        this.averageDepth = averageDepth;
    }

    /**
     * @return the averageVisibility
     */
    public Integer getAverageVisibility() {
        return averageVisibility;
    }

    /**
     * @param averageVisibility the averageVisibility to set
     */
    public void setAverageVisibility(Integer averageVisibility) {
        this.averageVisibility = averageVisibility;
    }

    /**
     * @return the features
     */
    public String getFeatures() {
        return features;
    }

    /**
     * @param features the features to set
     */
    public void setFeatures(String features) {
        this.features = features;
    }

    /**
     * @return the pictureRef
     */
    public String getPictureRef() {
        return pictureRef;
    }

    /**
     * @param pictureRef the pictureRef to set
     */
    public void setPictureRef(String pictureRef) {
        this.pictureRef = pictureRef;
    }
}
