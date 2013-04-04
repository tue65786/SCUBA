package model.WebUser;

import SQL.DbConn;
import SQL.DbEncodeUtils;
import java.sql.*;

/**
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually). Right now, it's just doing DELETE.
 * <p/>
 * This class requires an open database connection for its constructor method.
 * WebUserMods.java: in this version, a new method: insert is added (to the
 * delete method that was there from before). The insert method takes a Validate
 * object (with the typed data), creates the PreparedStatement and executes the
 * insert.
 */
public class WebUserMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    /**
     *
     * @param dbc
     */
    public WebUserMods(DbConn dbc) {
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

    public model.WebUser.StringData findLogonUser(DbConn dbc, String email, String pwd) {

        StringData user = new StringData();
        String sql = "select web_user_id, user_email, user_password, membership_fee, user_role_id, birthday from web_user WHERE user_email='" + email 
                + "' AND user_password='" + pwd + "';";
        System.out.println("*****" + sql);
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
         
            if (!results.next() )
            { 
                System.out.println("****asdfjklshfsjlaf");
                return null;
            }
            user.userEmail = results.getObject("user_email").toString();
            user.userPw = results.getObject("user_password").toString();
            user.membershipFee = results.getObject("membership_fee").toString();
            user.userRoleId = results.getObject("user_role_id").toString();
            user.birthday = results.getObject("birthday").toString();
        } catch (Exception ex) {
       System.out.println("****Exception thrown in WebUserSql.findUserLogon(): " + ex.getMessage());
        return null;
        }
        return user;

    }

    /**
     *
     * @param primaryKey
     * @return
     */
    public String delete(String primaryKey) {
        this.errorMsg = SQL.DbConn.SQL_ERROR_DIV_TAG;  // clear any error message from before.

        String sql = "DELETE FROM web_user where web_user_id=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if (numRows == 1) {
                this.errorMsg = "";
                return ""; // all is GOOD
            } else {
                this.errorMsg += new Integer(numRows).toString()
                        + " records were deleted when only 1 expected for delete."; // probably never get here
                return this.errorMsg + "</div>";
            }
        } // try
        catch (SQLException e) {
            //this.errorMsg =
            if (e.getSQLState().equalsIgnoreCase(SQL.DbConn.SQL_ERROR_CODE_FK_VIOLATION)) {
                this.errorMsg += "<b>ERROR: This row is referenced by rows in other tables. Deleting foreign references will resolve this error. <span style=\"font-size:7pt; font-style:italic;\">Details: [" + e.getMessage() + "]</span>";
                return this.errorMsg + "</div>";
            }
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg += "Could not delete.";
            }

            this.errorMsg += "Problem with SQL in WebUserSql.delete: "
                    + "SQLState [" + e.getSQLState()
                    + "], error message [" + e.getMessage() + "]";
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg + "</div>";
        } // catch
        catch (Exception e) {
            this.errorMsg += "General Error in WebUserSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg + "</div>";
        } // catch
    }// method delete

    /**
     *
     * @param wuValidate
     * @return
     */
    public String insert(Validate wuValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!wuValidate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit before inserting";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
        String sql = "INSERT INTO web_user (user_email, user_password, membership_fee, user_role_id, birthday"
                + ") VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pStatement = dbc.getConn().prepareStatement(sql);
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 1, wuTypedData.getUserEmail());
            this.debugMsg += DbEncodeUtils.encodeString(pStatement, 2, wuTypedData.getUserPw());
            this.debugMsg += DbEncodeUtils.encodeDecimal(pStatement, 3, wuTypedData.getMembershipFee());
            this.debugMsg += DbEncodeUtils.encodeInteger(pStatement, 4, wuTypedData.getUserRoleId());
            this.debugMsg += DbEncodeUtils.encodeDate(pStatement, 5, wuTypedData.getBirthday());

            //System.out.println("************* got past encoding");
            try {
                int numRows = pStatement.executeUpdate();
                if (numRows == 1) {
                    return ""; // all is GOOD, one record inserted is what we expect
                } else {
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                            + " records were inserted where only 1 expected."; // probably never get here, bulk sql insert
                    return this.errorMsg;
                }
            } // try execute the statement
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot insert: a record with that ID already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: duplicate entry."; // for example a unique key constraint.
                } else if (e.getMessage().toLowerCase().contains("foreign key")) {
                    this.errorMsg = "Cannot insert: invalid reference (bad foreign key value)."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "WebUserMods.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "WebUserMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            } // catch
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "WebUserMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }// method
} // class