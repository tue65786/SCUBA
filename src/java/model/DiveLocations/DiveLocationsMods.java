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
    public DiveLocationsMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.
        
        String sql = "DELETE FROM dive_location where dive_location=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if (numRows == 1) {
                this.errorMsg = "";
                return this.errorMsg; // all is GOOD
            } else {
                this.errorMsg = new Integer(numRows).toString()
                        + " records were deleted when only 1 expected for delete."; // probably never get here
                return this.errorMsg;
            }
        } // try
        catch (SQLException e) {
            this.errorMsg = "";
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg = "Could not delete.";
            }

            this.errorMsg += "Problem with SQL in DiveLocationsSQL.delete: "
                    + "SQLState [" + e.getSQLState()
                    + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in DiveLocationsSQL.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method delete
}
