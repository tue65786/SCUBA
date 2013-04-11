package view;

import SQL.DbConn;
import SQL.FormatUtils;
import java.sql.*;
import view.NameValues.*;
import java.util.*;

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
        if(row) {
            return "row-odd";
        }
        else {
            return "row-even";
        }
    }

    /**
     *
     * @param cssClassForResultSetTable
     * @param dbc < p/>
     * <p/>
     * @return
     */
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
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("web_user_id")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_email")));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_password")));
                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow), results.getObject("membership_fee")));
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("user_role_id")));
                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("birthday")));
                sb.append("</tr>\n");
                oddRow = !oddRow;
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
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
    /**
     *
     * @param cssClassForResultSetTable
     * @param delFn
     * @param delIcon
     * @param bgColor
     * @param dbc < p/>
     * <p/>
     * @return
     */
    public static String listAllUsers(String cssClassForResultSetTable, String delFn, String delIcon,
                                      String bgColor, DbConn dbc) {
        boolean oddRow = true;



        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if((delIcon == null) || (delIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if((delFn == null) || (delFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
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
            sb.append("<td style='border:none; background-color:" + bgColor + "'>&nbsp;</td>");// extra column at left for delete icon
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
                sb.append(delStart + "\"" + em + "\"" + "," + primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), primaryKeyObj));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), em));
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
        }
        catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    } // eo method

    public static String listAllUsers(String cssClassForResultSetTable,
                                      String delFn, String delIcon,
                                      String updateFn, String updateIcon,
                                      String bgColor, DbConn dbc) {

        boolean oddRow = true;



        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if((delIcon == null) || (delIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if((delFn == null) || (delFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }
        if((updateIcon == null) || (updateIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: update Icon file name (String input parameter) is null or empty.";
        }
        if((updateFn == null) || (updateFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: update javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the update
        // icon which will be linked to a javascript function for updating the current row.
        //String updateStart = "<td style='border:none; text-align:center;'><a href='" + updateFn + "(";
        String updateStart = "<a title=\"Update\" href='" + updateFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        // String updateEnd = ")'><img src='" + updateIcon + "'></a></td>"; // after PK value/input parameter to js fn.
        String updateEnd = ")'><img border=\"0\" class=\"updateImg\" src='" + updateIcon + "'></a></td>"; // after PK value/input parameter to js fn.
        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a>"; // after PK value/input parameter to js fn.

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
            sb.append("<td style='border:none; background-color:" + bgColor + "'>&nbsp;</td>");// extra column at left for delete icon
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
                sb.append(delStart + "\"" + em + "\"" + "," + primaryKeyInt.toString() + delEnd);
                sb.append(updateStart + primaryKeyInt.toString() + updateEnd);
                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), primaryKeyObj));
                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), em));
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
        }
        catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    } // eo method

    /**
     *
     * @param type
     * @param name
     * @param onchangeJS
     * @param selectedValue
     * @param includeDefault
     * @param dbc < p/>
     * <p/>
     * @return < p/>
     * <p/>
     * @throws SQLException
     */
    public static String listAllUserRoles(String type, String name, String onchangeJS, String selectedValue, boolean includeDefault, DbConn dbc) throws SQLException {
        final String TYPE_OPTION = "<option  value=\"[[[value]]]\" id=\"[[[id]]]\"  [[[selected]]]/>[[[name]]]</option>";
        final String WRAPPER_OPTION_PRE = "<select class=\"field-300\" id=\""+ name +"\" " +  "name=\"" + name + "\" onchange=\"" + onchangeJS + "\">";
        final String WRAPPER_OPTION_POST = "</select>";

        ArrayList<NameValue> ur = buildAllUserRoles(false, dbc);



        String template = TYPE_OPTION;
        String temp = "", retVal = "";


        if(ur == null) {
            return new String("error");
        } //no data
        else {
            switch (type.charAt(0)) //</editor-fold>
            {
                case 'o':
                    template = TYPE_OPTION;
                    break;

                default:
                    template = TYPE_OPTION;
                    break;


            }//switch
            if(includeDefault) {
                temp = template;
                temp = temp.replace("[[[value]]]", "");
                temp = temp.replace("[[[id]]]", name + "_0");
                temp = temp.replace("[[[name]]]", "Choose...");
                temp = temp.replace("[[[selected]]]", "");
                retVal += temp;
            }


            for(NameValue aUR : ur) {
                Integer selValInt = Integer.parseInt(selectedValue);
                temp = template;
                temp = temp.replace("[[[value]]]", aUR.getIdStr());
                temp = temp.replace("[[[id]]]", name + "_" + aUR.getIdStr());
                temp = temp.replace("[[[name]]]", aUR.getName());

                temp = temp.replace("[[[selected]]]", aUR.id == selValInt ? "selected" : "");
                retVal += temp;
            }//for
            return WRAPPER_OPTION_PRE + retVal + WRAPPER_OPTION_POST;
        }//builddata
    }

    private static ArrayList<NameValue> buildAllUserRoles(boolean includeNullValue, DbConn dbc) throws SQLException {
        ArrayList<NameValue> dataSet = new ArrayList<NameValue>();
        NameValue aUserRole;
        Object id;
        Object name;

        PreparedStatement stmt = null;
        ResultSet rst = null;
        try {
            String sql = "SELECT user_role_id AS id , user_role_title AS name FROM user_role ORDER BY user_role_title";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();

            if(includeNullValue) {
                dataSet.add(new NameValue("Select..."));
            }
            while (rst.next()) {
                id = rst.getObject("id");
                name = rst.getObject("name");
                aUserRole = new NameValue((Integer) id, name.toString());
                dataSet.add(aUserRole);
            }//EO Wwhile 

            rst.close();
            stmt.close();
            return dataSet;
        }//try
        catch (Exception e) {
            System.err.println(e.getMessage().toString());
            if(!stmt.isClosed()) {
                stmt.close();
            }
            if(!rst.isClosed()) {
                rst.close();
            }
            if(dataSet == null) {
                if(includeNullValue) {
                    dataSet.add(new NameValue("Select..."));
                    return dataSet;
                }//return empty DS with item
                else {
                    return null;
                }//return empty DS

            } //eo if dataSet is null
            else {
                return dataSet;
            }//dataset != null
        }//eo catch


    }
}//eoclass