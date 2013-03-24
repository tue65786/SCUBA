/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLog;

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
}


//INSERT INTO dive_log (dive_date, number_dives, minutes_per_dive, air_type, max_depth, dive_buddy, notes, dive_location_id, web_user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);