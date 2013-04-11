/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLog;
import SQL.DbEncodeUtils;
import SQL.DbConn;
import java.sql.*;
//import java.sql.SQLException;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class DiveLogMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    /**
     *
     * @param dbc
     */
    public DiveLogMods(DbConn dbc) {
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
     * @param primaryKey
     * <p/>
     * @return
     */
    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.

        String sql = "DELETE FROM dive_log where dive_log_id=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if(numRows == 1) {
                this.errorMsg = "";
                return this.errorMsg; // all is GOOD
            }
            else {
                this.errorMsg = new Integer(numRows).toString()
                                + " records were deleted when only 1 expected for delete."; // probably never get here
                return this.errorMsg;
            }
        } // try
        catch (SQLException e) {
            this.errorMsg = "";
            if(e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg = "Could not delete.";
            }

            this.errorMsg += "Problem with SQL in DiveLogSql.delete: "
                             + "SQLState [" + e.getSQLState()
                             + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in DiveLogSql.delete: "
                            + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method delete


public String insert(Validate dlValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if(!dlValidate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit before inserting";
            return this.errorMsg;
        }

        TypedData dlTypedData = (TypedData) dlValidate.getDlt();
        //String sql = "INSERT INTO web_user (user_email, user_password, membership_fee, user_role_id, birthday"
                //     + ") VALUES (?,?,?,?,?)";
       String sql = "INSERT INTO dive_log (dive_date, number_dives, minutes_per_dive, air_type, max_depth, dive_buddy, notes, dive_location_id, web_user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pStatement = dbc.getConn().prepareStatement(sql);
            this.debugMsg += DbEncodeUtils.encodeDate(pStatement, 1, dlTypedData.getDive_date());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 2, dlTypedData.getNumber_dives());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 3, dlTypedData.getMinutes_per_dive());
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 4, dlTypedData.getAir_type());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 5, dlTypedData.getMax_depth());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 6, dlTypedData.getDive_buddy());
this.debugMsg += DbEncodeUtils.encodeString(pStatement, 7, dlTypedData.getNotes());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 8, dlTypedData.getDive_location_id());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 9, dlTypedData.getWeb_user_id());

//System.out.println("************* got past encoding");
            try {
                int numRows = pStatement.executeUpdate();
                if(numRows == 1) {
                    return ""; // all is GOOD, one record inserted is what we expect
                }
                else {
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                                    + " records were inserted where only 1 expected."; // probably never get here, bulk sql insert
                    return this.errorMsg;
                }
            } // try execute the statement
            catch (SQLException e) {
                if(e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot insert: a record with that ID already exists.";
                }
                else if(e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: duplicate entry."; // for example a unique key constraint.
                }
                else if(e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Cannot insert: invalid reference (bad foreign key value)."; // for example a unique key constraint.
                }
                else {
                    this.errorMsg = "DiveLogMods.insert: SQL Exception while attempting insert. "
                                    + "SQLState:" + e.getSQLState()
                                    + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "DiveLogMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            } // catch
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "DiveLogMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }// method
}


//INSERT INTO dive_log (dive_date, number_dives, minutes_per_dive, air_type, max_depth, dive_buddy, notes, dive_location_id, web_user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);