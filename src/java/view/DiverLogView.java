package view;

import SQL.DbConn;
import SQL.FormatUtils;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Dan Kauffman
 */
public class DiverLogView {

    private static String tdCSS(boolean row) {
        if(row) {
            return "row-odd";
        }
        else {
            return "row-even";
        }
    }

    private static String tdCSSops(String ops, boolean row) {
        if(row) {
            return "row-odd " + ops;
        }
        else {
            return "row-even " + ops;
        }
    }
    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * @param cssClassForResultSetTable
     * @param dbc an open database connection.
     * @return
     */

    public static String listAllUsers(String cssClassForResultSetTable, DbConn dbc) {
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;

        boolean oddRow = true;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            //      String sql = "select web_user_id, user_email, user_password, membership_fee, user_role_id, birthday from web_user";
            String sql = "SELECT wu.user_email,ur.user_role_title,loc.location_name,loc.city,loc.state,log.dive_date,log.number_dives,log.minutes_per_dive,log.air_type,log.max_depth,(SELECT wu.user_email FROM web_user wu WHERE wu.web_user_id = log.dive_buddy) as dive_buddy,log.notes FROM dive_location loc, dive_log log, web_user wu, user_role ur WHERE loc.dive_location = log.dive_location_id  AND wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id ORDER BY log.dive_date,wu.user_email";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            sb.append("<table class='");
            sb.append(cssClassForResultSetTable);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:left'>Email</th>");
            sb.append("<th style='text-align:left'>Role</th>");
            sb.append("<th style='text-align:left'>Location</th>");
            sb.append("<th style='text-align:left'>City</th>");
            sb.append("<th style='text-align:right'>ST</th>");
            sb.append("<th style='text-align:center'>Date</th>");
            sb.append("<th style='text-align:right'>Dives</th>");
            sb.append("<th style='text-align:right'>Time</th>");
            sb.append("<th style='text-align:left'>Air</th>");
            sb.append("<th style='text-align:right'>Depth</th>");
            sb.append("<th style='text-align:left'>Buddy</th>");
            sb.append("<th style='text-align:left'>Notes</th></tr>");

            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatStringTd(tdCSSops("sm", oddRow), results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_role_title")));
                sb.append(FormatUtils.formatStringTd(tdCSSops("bold", oddRow), results.getObject("location_name"), 2));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("city")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("state")));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("dive_date")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("number_dives")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("minutes_per_dive")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("air_type")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("max_depth")));
                sb.append(FormatUtils.formatStringTd(tdCSSops("sm", oddRow), results.getObject("dive_buddy")));
                sb.append(FormatUtils.formatStringTd(tdCSSops("notes", oddRow), results.getObject("notes")));
                sb.append("</tr>\n");
                oddRow = !oddRow;
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
            return "Exception thrown in DiverLogView.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    }

    public static String listAllUsers(String cssClassForResultSetTable, String delFn, String delIcon,
                                      String bgColor, DbConn dbc) {
        boolean oddRow = true;



        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if((delIcon == null) || (delIcon.length() == 0)) {
            return " DiveLog.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if((delFn == null) || (delFn.length() == 0)) {
            return " DiveLog.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:" + bgColor + "'><a title=\"Delete This Row\" href='" + delFn + "(";
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
            String sql = "SELECT log.dive_log_id, wu.user_email,ur.user_role_title,loc.location_name,loc.city,loc.state,log.dive_date,log.number_dives,log.minutes_per_dive,log.air_type,log.max_depth,(SELECT wu.user_email FROM web_user wu WHERE wu.web_user_id = log.dive_buddy) as dive_buddy,log.notes FROM dive_location loc, dive_log log, web_user wu, user_role ur WHERE loc.dive_location = log.dive_location_id  AND wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id ORDER BY log.dive_date,wu.user_email";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");

            sb.append("<table class='" + cssClassForResultSetTable + "'>");
            sb.append("<tr>");
            sb.append("<td style='vertical-align:middle;text-align:right; border:none; padding-right:2px; background-color:"
                      + bgColor + "'>&nbsp;</td>");// extra column at left for delete icon
            sb.append("<th style='text-align:left'>Email</th>");
            sb.append("<th style='text-align:left'>Role</th>");
            sb.append("<th style='text-align:left'>Location</th>");
            sb.append("<th style='text-align:left'>City</th>");
            sb.append("<th style='text-align:right'>St</th>");
            sb.append("<th style='text-align:center'>Date</th>");
            sb.append("<th style='text-align:right'>Dives</th>");
            sb.append("<th style='text-align:right'>Time</th>");
            // sb.append("<th style='text-align:left'>Air</th>");
            sb.append("<th style='text-align:right'>Depth</th>");
            sb.append("<th style='text-align:left'>Buddy</th>");
            sb.append("<th style='text-align:left'>Notes</th>");
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
                sb.append("<tr>");

                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(delStart + primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatStringTd(tdCSSops("sm", oddRow), rst.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject("user_role_title")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject("location_name"), 2));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject("city")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject("state")));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), rst.getObject("dive_date")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), rst.getObject("number_dives")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), rst.getObject("minutes_per_dive")));
                //   sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), rst.getObject("air_type")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), rst.getObject("max_depth")));
                sb.append(FormatUtils.formatStringTd(tdCSSops("sm", oddRow), rst.getObject("dive_buddy")));
                sb.append(FormatUtils.formatStringTd(tdCSSops("notes", oddRow), rst.getObject("notes")));
                sb.append("</tr>\n");
                oddRow = !oddRow;
            }//while loop
            sb.append("</table>");
            rst.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
            return "Exception thrown in  DiveLog.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}