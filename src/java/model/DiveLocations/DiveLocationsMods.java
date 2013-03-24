/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.DiveLocations;

import SQL.DbConn;
import java.sql.*;
//import java.sql.SQLException;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class DiveLocationsMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

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
     * @param primaryKey
     * @return
     */
    public String delete(String primaryKey) {
        this.errorMsg = SQL.DbConn.SQL_ERROR_DIV_TAG;  // clear any error message from before.

        String sql = "DELETE FROM dive_location where dive_location=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if(numRows == 1) {
                this.errorMsg = "";
                return " "; // all is GOOD
            }
            else {
                this.errorMsg += new Integer(numRows).toString()
                                 + " records were deleted when only 1 expected for delete.\"</div>\""; // probably never get here
                return this.errorMsg;
            }
        } // try
        catch (SQLException e) {
            this.errorMsg = "";
            if(e.getSQLState().equalsIgnoreCase(SQL.DbConn.SQL_ERROR_CODE_FK_VIOLATION)) {
                this.errorMsg = "<b>ERROR: This row is referenced by rows in other tables. Deleting foreign references will resolve this error. <span style=\"font-size:7pt; font-style:italic;\">Details: [" + e.getMessage() + "]</span>";
                return this.errorMsg + "</div>";
            }
            if(e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg += "Could not delete.";
            }

            this.errorMsg += "Problem with SQL in DiveLocationsSQL.delete: "
                             + "SQLState [" + e.getSQLState()
                             + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg + "</div>";
        } // catch
        catch (Exception e) {
            this.errorMsg += "General Error in DiveLocationsSQL.delete: "
                             + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg + "</div>";
        } // catch
    }// method delete
}
