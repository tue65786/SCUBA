package model.WebUser;

import SQL.DbConn;
import java.sql.*;

/** 
 * This class contains all code that modifies records in a table in the database. 
 * So, Insert, Update, and Delete code will be in this class (eventually). Right now, 
 * it's just doing DELETE.
 * 
 * This class requires an open database connection for its constructor method.
 */
public class WebUserMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public WebUserMods(DbConn dbc) {
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
        
        String sql = "DELETE FROM web_user where web_user_id=?";
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

            this.errorMsg += "Problem with SQL in WebUserSql.delete: "
                    + "SQLState [" + e.getSQLState()
                    + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in WebUserSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method delete
} // class