/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLocations;

import SQL.*;
import java.sql.*;
//import java.sql.SQLException;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class DiveLocationsMods {

    private DbConn dbc;  // Open, live database connection
    public String errorMsg = "";
    public String updateStatementError = "";
    public String debugMsg = "";
    public String insertStatementtError = "";
    // all methods of this class require an open database connection.

    /**
     *
     * @param dbc
     */
    public DiveLocationsMods(DbConn dbc) {
        this.dbc = dbc;
    }

    /**
     *
     * @return
     */
    public String getDebugMsg() {
        return this.debugMsg;
    }

    /**
     *
     * @return
     */
    public String getErrorMsg() {
        return this.errorMsg;
    }

    /**
     *
     * @param primaryKey < p/>
     * <p/>
     * @return
     */
    public String delete(String primaryKey) {
        this.setErrorMsg(SQL.DbConn.SQL_ERROR_DIV_TAG);  // clear any error message from before.

        String sql = "DELETE FROM dive_location where dive_location=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if(numRows == 1) {
                this.setErrorMsg("");
                return " "; // all is GOOD
            }
            else {
                this.setErrorMsg(this.getErrorMsg() + new Integer(numRows).toString()
                                 + " records were deleted when only 1 expected for delete.\"</div>\""); // probably never get here
                return this.getErrorMsg();
            }
        } // try
        catch (SQLException e) {
            this.setErrorMsg("");
            if(e.getSQLState().equalsIgnoreCase(SQL.DbConn.SQL_ERROR_CODE_FK_VIOLATION)) {
                this.setErrorMsg("<b>ERROR: This row is referenced by rows in other tables. Deleting foreign references will resolve this error. <span style=\"font-size:7pt; font-style:italic;\">Details: [" + e.getMessage() + "]</span>");
                return this.getErrorMsg() + "</div>";
            }
            if(e.getSQLState().equalsIgnoreCase("S1000")) {
                this.setErrorMsg(this.getErrorMsg() + "Could not delete.");
            }

            this.setErrorMsg(this.getErrorMsg() + "Problem with SQL in DiveLocationsSQL.delete: "
                             + "SQLState [" + e.getSQLState()
                             + "], error message [" + e.getMessage() + "]");
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg() + "</div>";
        }
        catch (Exception e) {
            this.setErrorMsg(this.getErrorMsg() + "General Error in DiveLocationsSQL.delete: "
                             + e.getMessage());
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg() + "</div>";
        } // catch
    }// method delete

    public model.DiveLocations.StringData findByUserId(DbConn dbc, String pk) {

        StringData location = new StringData();
        String sql = "SELECT dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref FROM dive_location "
                     + "WHERE dive_location='"
                     + pk
                     + "'";
        System.out.println("*****" + sql);
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();

            if(!results.next()) {
                System.out.println("****no results (dive locations)");
                return null;
            }
            location.diveLocation = results.getObject("dive_location").toString();
            location.locationName = results.getObject("location_name").toString();
            location.city = results.getObject("city").toString();
            location.state = results.getObject("state").toString();
            location.type = results.getObject("type").toString();
            location.accesssVia = results.getObject("access_via").toString();
            location.averageDepth = results.getObject("average_depth").toString();
            location.averageVisibility = results.getObject("average_visibility").toString();
            location.features = results.getObject("features").toString();
            location.pictureRef = results.getObject("picture_ref").toString();
        }
        catch (Exception ex) {
            System.out.println("****Exception thrown in DiveLocationMods.findUserbyId(): " + ex.getMessage());
            return null;
        }
        return location;
    }//eo method

    public PreparedStatement makeUpdateStatement(DbConn dbc, Validate wuValidate) {

        TypedData td = (TypedData) wuValidate.getLocT();

        this.setUpdateStatementError("");
        this.setDebugMsg("");
//dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref, FROM dive_location "

        String sql = "UPDATE dive_location SET location_name=? "
                     + ", city=?,  state=?,  type=? "
                     + ",  access_via=?, average_depth=?, average_visibility=?, features=?, picture_ref=?  WHERE  dive_location=?";
        System.out.println("SQL UPDATE " + sql);
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            setDebugMsg(getDebugMsg() + "<br/>Sql was: " + sql);
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 1, td.getLocationName()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 2, td.getCity()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 3, td.getState()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 4, td.getType()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 5, td.getAccesssVia()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 6, td.getAverageDepth()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 7, td.getAverageVisibility()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 8, td.getFeatures()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 9, td.getPictureRef()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 10, td.getDiveLocation()));

            return sqlSt;
        }
        catch (Exception e) {
            this.setUpdateStatementError("Problem creating the UPDATE prepared statement in DiveLocation.encodeForUpdate()."
                                         + " Error message: " + e.getMessage());
            return null;
        }
    }

    public PreparedStatement makeInsertStatement(DbConn dbc, Validate wuValidate) {

        TypedData td = (TypedData) wuValidate.getLocT();

        this.setInsertStatementtError("");
        this.setDebugMsg("");
//dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref, FROM dive_location "

        //String sql = "UPDATE dive_location SET location_name=? "
        //             + ", city=?,  state=?,  type=? "
        //             + ",  access_via=?, average_depth=?, average_visibility=?, features=?, picture_ref=?  WHERE  dive_location=?";
        String sql = "INSERT INTO dive_location"
                     + "("
                     + "location_name,"
                     + "city,"
                     + "state,"
                     + "type,"
                     + "access_via,"
                     + "average_depth,"
                     + "average_visibility,"
                     + "features)"
                     //     + "picture_ref)"
                     + "VALUES(?,?,?,?,?,?,?,?)";
        System.out.println("SQL Insert " + sql);
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            setDebugMsg(getDebugMsg() + "<br/>Sql was: " + sql);
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 1, td.getLocationName()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 2, td.getCity()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 3, td.getState()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 4, td.getType()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 5, td.getAccesssVia()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 6, td.getAverageDepth()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeInteger(sqlSt, 7, td.getAverageVisibility()));
            setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 8, td.getFeatures()));
            // setDebugMsg(getDebugMsg() + "<br/>" + DbEncodeUtils.encodeString(sqlSt, 9, td.getPictureRef()));

            return sqlSt;
        }
        catch (Exception e) {
            this.setInsertStatementtError("Problem creating the INSERT prepared statement in DiveLocation.encodeForInsert()."
                                          + " Error message: " + e.getMessage());
            return null;
        }
    }

    public String getUpdateStatementError() {
        return this.updateStatementError;
    }

    public String update(Validate validate) {
        this.setErrorMsg("");

        // dont even try to insert if the user data didnt pass validation.
        if(!validate.isIsValidated()) {
            this.setErrorMsg("Please edit record and resubmit. Click <a href=\"#\" id=\"tryagain\" > here </a> open the form and correct the errors.");
            System.out.println("****************update error: " + this.getErrorMsg());
            return this.getErrorMsg();
        }

        PreparedStatement sqlSt = makeUpdateStatement(dbc, validate);
        if(sqlSt == null) {
            return "DiveLocation.update: Problem encoding the UPDATE prepared statement: " + getUpdateStatementError();
        }
        //System.out.println("******* Trying to update Web User with id: ["+ wu.getIdWebUser() + "]");
        try {
            int numRows = sqlSt.executeUpdate();
            if(numRows == 1) {
                this.setErrorMsg("");
                return this.getErrorMsg(); // all is GOOD, one record was updated like we expected.
            }
            else {
                // we could be here (numRows==0) if record was not found.
                // we could be here (numRows>1) if we forgot where clause -- would update all recs.
                // In either case, it would probalby be a programmer error.
                this.setErrorMsg("Error: " + new Integer(numRows).toString()
                                 + " records were updated (when only 1 record expected for update).");
                return this.getErrorMsg();
            }
        } // try
        catch (SQLException e) {
            this.setErrorMsg("DiveLocationMods.update: SQL error. "
                             + "SQLState [" + e.getSQLState()
                             + "], error message [" + e.getMessage() + "]");
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg();
        }
        catch (Exception e) {
            this.setErrorMsg("SqlMods.update: General Error. "
                             + e.getMessage());
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg();
        } // catch
    }// method

    public String insert(Validate validate) {
        this.setErrorMsg("");

        // dont even try to insert if the user data didnt pass validation.
        if(!validate.isIsValidated()) {
            this.setErrorMsg("Please edit record and resubmit. Click <a href=\"#\" id=\"tryagain\" > here </a> open the form and correct the errors.");
            System.out.println("****************insert error: " + this.getErrorMsg());
            return this.getErrorMsg();
        }

        PreparedStatement sqlSt = makeInsertStatement(dbc, validate);
        if(sqlSt == null) {
            return "DiveLocationMods.insert: Problem encoding the INSERT prepared statement: " + getUpdateStatementError();
        }
        //System.out.println("******* Trying to update Web User with id: ["+ wu.getIdWebUser() + "]");
        try {
            int numRows = sqlSt.executeUpdate();
            if(numRows == 1) {
                this.setErrorMsg("");
                return this.getErrorMsg(); // all is GOOD, one record was updated like we expected.
            }
            else {
                // we could be here (numRows==0) if record was not found.
                // we could be here (numRows>1) if we forgot where clause -- would update all recs.
                // In either case, it would probalby be a programmer error.
                this.setErrorMsg("Error: " + new Integer(numRows).toString()
                                 + " records were inserted (when only 1 record expected for insert).");
                return this.getErrorMsg();
            }
        } // try
        catch (SQLException e) {
            this.setErrorMsg("DiveLocationMods.insert: SQL error. "
                             + "SQLState [" + e.getSQLState()
                             + "], error message [" + e.getMessage() + "]");
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg();
        }
        catch (Exception e) {
            this.setErrorMsg("SqlMods.update: General Error. "
                             + e.getMessage());
            System.out.println(this.getErrorMsg());
            //e.printStackTrace();
            return this.getErrorMsg();
        } // catch
    }// method

    /**
     * @param errorMsg the errorMsg to set
     */
    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    /**
     * @param updateStatementError the updateStatementError to set
     */
    public void setUpdateStatementError(String updateStatementError) {
        this.updateStatementError = updateStatementError;
    }

    /**
     * @param debugMsg the debugMsg to set
     */
    public void setDebugMsg(String debugMsg) {
        this.debugMsg = debugMsg;
    }

    /**
     * @return the insertStatementtError
     */
    public String getInsertStatementtError() {
        return insertStatementtError;
    }

    /**
     * @param insertStatementtError the insertStatementtError to set
     */
    public void setInsertStatementtError(String insertStatementtError) {
        this.insertStatementtError = insertStatementtError;
    }
}
/*
INSERT INTO dive_location
(dive_location,
location_name,
city,
state,
type,
access_via,
average_depth,
average_visibility,
features,
picture_ref)
VALUES
* 
* */