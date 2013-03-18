package view;

// classes imported from java.sql.*
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
        if (row) {
            return "row-odd";
        } else {
            return "row-even";
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
            sb.append("<th style='text-align:right'>City</th>");
            sb.append("<th style='text-align:right'>St</th>");
            sb.append("<th style='text-align:center'>Date</th>");
            sb.append("<th style='text-align:right'>Dives</th>");
            sb.append("<th style='text-align:right'>Time</th>");
            sb.append("<th style='text-align:right'>Air</th>");
            sb.append("<th style='text-align:right'>Depth</th>");
            sb.append("<th style='text-align:left'>Buddy</th>");
            sb.append("<th style='text-align:left'>Notes</th></tr>");

            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_role_title")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("location_name"), 2));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("city")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("state")));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("dive_date")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("number_dives")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("minutes_per_dive")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("air_type")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("max_depth")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("dive_buddy")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("notes")));
                sb.append("</tr>\n");
                oddRow = !oddRow;
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in DiverLogView.listAllUsers(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}