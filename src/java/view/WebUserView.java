package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import SQL.DbConn;
import SQL.FormatUtils;
 
/**
 *
 * @author Dan Kauffman
 */
public class WebUserView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    private static String tdCSS(boolean row) {
     if (row) 
     {return "row-odd";}
     else 
     {return "row-even";}
    }
    
         public static String listAllUsers(String cssClassForResultSetTable, DbConn dbc) {
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        
        boolean oddRow = true;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "select web_user_id, user_email, user_password, membership_fee, user_role_id, birthday from web_user";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>User ID</th>");
            sb.append("<th style='text-align:left'>User Email</th>");
            sb.append("<th style='text-align:left'>User Password</th>");
            sb.append("<th style='text-align:right'>Membership Fee</th>");
            sb.append("<th style='text-align:right'>User Role</th>");
            sb.append("<th style='text-align:center'>Birthday</th></tr>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow),results.getObject("web_user_id")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow),results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow),results.getObject("user_password")));
                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow),results.getObject("membership_fee")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow),results.getObject("user_role_id")));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow),results.getObject("birthday")));
                sb.append("</tr>\n");
                oddRow = !oddRow;
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
  
   /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * delFn:  the name of a javascript function in the JSP page, a function that expects an
     *   input parameter (String) which is the id of the web_user record to be deleted.
     * delIcon: the name of the file that holds the delete icon (to be repeated for each web_user record).
     * dbc: an open database connection.
     */
    public static String listAllUsers(String cssClassForResultSetTable, String delFn, String delIcon,
            String bgColor, DbConn dbc) {
         boolean oddRow = true;
        


        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if ((delIcon == null) || (delIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if ((delFn == null) || (delFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:"+bgColor+"'><a title=\"Delete\" href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a></td>"; // after PK value/input parameter to js fn.

        // use StringBuilder object instead of plain String because it is more efficient
        // (with all the appending that we are doing here).
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet rst = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "select web_user_id, user_email, user_password, membership_fee,  "
                    + " user_role_id, birthday from web_user order by user_email";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");

            sb.append("<table class='" + cssClassForResultSetTable + "'>");
            sb.append("<tr>");
            sb.append("<td style='border:none; background-color:"+bgColor+"'>&nbsp;</td>");// extra column at left for delete icon
            sb.append("<th>User Id</th>");
            sb.append("<th>User Email</th>");
            sb.append("<th>User Password</th>");
            sb.append("<th>Membership Fee</th>");
            sb.append("<th>User Role</th>");
            sb.append("<th>Birthday</th>");
            sb.append("</tr>");

            while (rst.next()) {
                // I'm pretty sure that you must call the getObject methods from the result
                // set in the same order as the columns you selected in your SQL SELECT.
                // And, you cannot read (do a getObject) on the same column more than once.
                // The result set is like sequential text file which you can only
                // read in order and you only get one shot reading each item.

                // since we want to use the primary key value several times, 
                // we save this object so we reuse it.
                Object primaryKeyObj = rst.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;
                String em = rst.getObject(2).toString();
                sb.append("<tr>");

                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(delStart + "\"" + em + "\"" + "," +primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), primaryKeyObj));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow),em ));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject(3)));
                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow), rst.getObject(4)));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), rst.getObject(5)));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), rst.getObject(6)));
                sb.append("</tr>\n");
                 oddRow = !oddRow;
            }//while loop
            sb.append("</table>");
            rst.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
}
    
}