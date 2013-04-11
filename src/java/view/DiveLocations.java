/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * TODO: Add date last of last dive and email of diver.
 */
package view;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import SQL.DbConn;
import SQL.FormatUtils;

/**
 *
 * @author Dan Kauffman
 */
public class DiveLocations {
    //have 1 method that passes off to all others.

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
     * @param dbc                       < p/>
     * <p/>
     * @return
     */
    public static String listAllUsers(String cssClassForResultSetTable, DbConn dbc) {
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        final String imagePath = "http://cis-linux2.temple.edu:8080/SP13_2308_tue65786/images/locations/";
        boolean oddRow = true;
        try {


            String sql = "SELECT dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref, cnt.CountDives FROM dive_location dloc  INNER JOIN (select dive_location_id, COUNT(dive_location_id) AS CountDives FROM dive_log dlog GROUP BY dlog.dive_location_id) AS cnt ON cnt.dive_location_id = dloc.dive_location";
            String locationTbl = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"90%\">"
                                 + "<tr>"
                                 + "<td valign=\"top\" colspan=\"3\" height=\"53\">"
                                 + "<h2 align=\"center\">"
                                 + "[[[location_name]]]"
                                 + "</h2><div style=\"padding-left:30px; font-size:smaller; color:red;font-weight:bold;\">[[[city]]], [[[state]]]</div>"
                                 + "</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td rowspan=\"2\" style=\"text-align:right;border-bottom: medium dashed #92CDDC;vertical-align:top;\" width=\"275\">"
                                 + "<img  src=\"[[[picture_ref]]]\" style\"=max-height:\"250px\"; max-width:\"270px\"; border:\"0px\" vertical-align:  top; \"/>"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" width=\"70%\" class=\"it\">"
                                 + "([[[dive_location]]])  [[[features]]]"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" style=\"font-size: 8pt color:black;\" width=\"20%\" class=\"rt\">"
                                 + "<h3>Location Stats:</h3><u>Type</u>: [[[type]]]<br/><u>Access</u>: [[[access_via]]]<br/><u>Depth</u>: [[[average_depth]]]ft<br/><u>Visibility</u>: [[[average_visibility]]]"
                                 + "&nbsp;</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td valign=\"top\" style=\"text-align:right;border-bottom: medium dashed #92CDDC\" height=\"36\" colspan=\"2\">"
                                 + "<b>Dives Logged</b>: [[[CountDives]]]"
                                 + "</td>"
                                 + "</tr>"
                                 + "</table>;";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            //    sb.append("<table class='");
            //sb.append(cssClassForResultSetTable);
            //make functions for img / href.. tags
            while (results.next()) {
                String temp = new String(locationTbl);


                temp = temp.replace("[[[dive_location]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("dive_location")));
                temp = temp.replace("[[[location_name]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("location_name"), 1));
                temp = temp.replace("[[[city]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("city")));
                temp = temp.replace("[[[state]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("state")));//.toUpperCase();
                temp = temp.replace("[[[type]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("type")));
                temp = temp.replace("[[[access_via]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("access_via")));
                temp = temp.replace("[[[average_depth]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_depth")));
                temp = temp.replace("[[[average_visibility]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_visibility")));
                temp = temp.replace("[[[features]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("features")));
                temp = temp.replace("[[[picture_ref]]]", imagePath + FormatUtils.formatString(tdCSS(oddRow), results.getObject("picture_ref")));
                temp = temp.replace("[[[CountDives]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("CountDives")));

//                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_password")));
//                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow), results.getObject("membership_fee")));
//                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("user_role_id")));
//                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("   birthday")));
//                sb.append("</tr>\n");

                sb.append(temp);
                oddRow = !oddRow;
            }
            //sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
            return "Exception thrown in DiveLocations.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    }//eo method

    /**
     *
     * @param cssClassForResultSetTable
     * @param delFn
     * @param delIcon
     * @param bgColor
     * @param dbc
     * <
     * p/>
     * @return
     */
    public static String listAllUsers(String cssClassForResultSetTable, String delFn, String delIcon,
                                      String bgColor, DbConn dbc) {


        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if((delIcon == null) || (delIcon.length() == 0)) {
            return " DiveLocations.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if((delFn == null) || (delFn.length() == 0)) {
            return " DiveLocations.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        //String delStart = "<td style='border:none; text-align:center; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
        String delStart = "<span style='border:none; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a></span>"; // after PK value/input parameter to js fn.





        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        final String imagePath = "http://cis-linux2.temple.edu:8080/SP13_2308_tue65786/images/locations/";
        boolean oddRow = true;




        try {


            String sql = "SELECT dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref, cnt.CountDives FROM dive_location dloc  INNER JOIN (select dive_location_id, COUNT(dive_location_id) AS CountDives FROM dive_log dlog GROUP BY dlog.dive_location_id) AS cnt ON cnt.dive_location_id = dloc.dive_location";
            String locationTbl = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"90%\">"
                                 + "<tr>"
                                 + "<td valign=\"top\" colspan=\"3\" height=\"53\">"
                                 + "<h2 align=\"center\">"
                                 + "[[[location_name]]]"
                                 + "</h2>"
                                 //                    + "<div style=\"padding-left:30px; font-size:smaller; color:red;font-weight:bold;\"></div>"
                                 + "</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td rowspan=\"2\" style=\"text-align:right;border-bottom: medium dashed #92CDDC;vertical-align:top;\" width=\"150px\">"
                                 + "<div class=\"img\">"
                                 + "<img  src=\"[[[picture_ref]]]\" \"/>"
                                 + "<div class=\"location\"\">[[[city]]], [[[state]]]</div>"
                                 + "</div>"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" width=\"70%\" class=\"it\">"
                                 + "[[[features]]]"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" style=\"font-size: 8pt color:black;\" width=\"20%\" class=\"rt\">"
                                 + "<h3>Location Stats:</h3><u>Type</u>: [[[type]]]<br/><u>Access</u>: [[[access_via]]]<br/><u>Depth</u>: [[[average_depth]]]ft<br/><u>Visibility</u>: [[[average_visibility]]]<p/><h3>Actions:</h3>[[[DelIcon]]] Remove"
                                 + "&nbsp;</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td valign=\"top\" style=\"text-align:right;border-bottom: medium dashed #92CDDC\" height=\"36\" colspan=\"2\">"
                                 + "<b>Dives Logged</b>: [[[CountDives]]]"
                                 + "</td>"
                                 + "</tr>"
                                 + "</table>;";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            //    sb.append("<table class='");
            //sb.append(cssClassForResultSetTable);
            //make functions for img / href.. tags
            while (results.next()) {
                String temp = new String(locationTbl);
                Object primaryKeyObj = results.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;


                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                String deleteIcon = delStart + primaryKeyInt.toString() + delEnd;

                //temp = temp.replace("[[[dive_location]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("dive_location")));
                temp = temp.replace("[[[DelIcon]]]", deleteIcon);
                temp = temp.replace("[[[location_name]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("location_name"), 1));
                temp = temp.replace("[[[city]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("city")));
                temp = temp.replace("[[[state]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("state")));//.toUpperCase();
                temp = temp.replace("[[[type]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("type")));
                temp = temp.replace("[[[access_via]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("access_via")));
                temp = temp.replace("[[[average_depth]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_depth")));
                temp = temp.replace("[[[average_visibility]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_visibility")));
                temp = temp.replace("[[[features]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("features")));
                temp = temp.replace("[[[picture_ref]]]", imagePath + FormatUtils.formatString(tdCSS(oddRow), results.getObject("picture_ref")));
                temp = temp.replace("[[[CountDives]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("CountDives")));

//                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_password")));
//                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow), results.getObject("membership_fee")));
//                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("user_role_id")));
//                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("   birthday")));
//                sb.append("</tr>\n");

                sb.append(temp);
                oddRow = !oddRow;
            }
            //sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
            return "Exception thrown in DiveLocations.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    }//eo method

    public static String listAllUsers(String cssClassForResultSetTable, String delFn, String delIcon, String userName, String insAssocIcon,
                                      String bgColor, DbConn dbc) {

        boolean loggedIn = true;
        // Prepare some HTML that will be used repeatedly for the delete icon that
        if((userName == null) || (userName.length() == 0)) {
            loggedIn = false;
        }

        if((insAssocIcon == null) || (insAssocIcon.length() == 0)) {
            return " DiveLocations.listAllUsers() error: Insert Icon file name (String input parameter) is null or empty.";
        }
        if((delIcon == null) || (delIcon.length() == 0)) {
            return " DiveLocations.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if((delFn == null) || (delFn.length() == 0)) {
            return " DiveLocations.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        //String delStart = "<td style='border:none; text-align:center; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
        String delStart = "<span style='border:none; background-color:" + bgColor + "'><a title=\"Delete\" href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a></span>"; // after PK value/input parameter to js fn.

        String insStart = "<span style='border:none; background-color:" + bgColor + "'><a title=\"Insert Log\" href=\"insert-assoc.jsp?id=";

        String insEnd = "\"> <img src='" + insAssocIcon + "'></a></span>";



        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        final String imagePath = "http://cis-linux2.temple.edu:8080/SP13_2308_tue65786/images/locations/";
        boolean oddRow = true;

        try {


            String sql = "SELECT dive_location, location_name,city, state, type, access_via, average_depth, average_visibility,features, picture_ref, cnt.CountDives FROM dive_location dloc  INNER JOIN (select dive_location_id, COUNT(dive_location_id) AS CountDives FROM dive_log dlog GROUP BY dlog.dive_location_id) AS cnt ON cnt.dive_location_id = dloc.dive_location";
            String locationTbl = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"90%\">"
                                 + "<tr>"
                                 + "<td valign=\"top\" colspan=\"3\" height=\"53\">"
                                 + "<h2 align=\"center\">"
                                 + "[[[location_name]]]"
                                 + "</h2>"
                                 //                    + "<div style=\"padding-left:30px; font-size:smaller; color:red;font-weight:bold;\"></div>"
                                 + "</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td rowspan=\"2\" style=\"text-align:right;border-bottom: medium dashed #92CDDC;vertical-align:top;\" width=\"150px\">"
                                 + "<div class=\"img\">"
                                 + "<img  src=\"[[[picture_ref]]]\" \"/>"
                                 + "<div class=\"location\"\">[[[city]]], [[[state]]]</div>"
                                 + "</div>"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" width=\"70%\" class=\"it\">"
                                 + "[[[features]]]"
                                 + "</td>"
                                 + "<td valign=\"top\" height=\"304\" style=\"font-size: 8pt color:black;\" width=\"20%\" class=\"rt\">"
                                 + "<h3>Location Stats:</h3><u>Type</u>: [[[type]]]<br/><u>Access</u>: [[[access_via]]]<br/><u>Depth</u>: [[[average_depth]]]ft<br/><u>Visibility</u>: [[[average_visibility]]]<p/>"
                                 + (loggedIn ? "<h3>Actions:</h3>[[[DelIcon]]] Remove<br/>[[[InsIcon]]] Log Dive" : " ")
                                 + "</td>"
                                 + "</tr>"
                                 + "<tr>"
                                 + "<td valign=\"top\" style=\"text-align:right;border-bottom: medium dashed #92CDDC\" height=\"36\" colspan=\"2\">"
                                 + "<b>Dives Logged</b>: [[[CountDives]]]"
                                 + "</td>"
                                 + "</tr>"
                                 + "</table>;";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            //    sb.append("<table class='");
            //sb.append(cssClassForResultSetTable);
            //make functions for img / href.. tags
            while (results.next()) {
                String temp = new String(locationTbl);
                Object primaryKeyObj = results.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;


                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                String deleteIcon = delStart + primaryKeyInt.toString() + delEnd;
                String insertIcon = insStart + primaryKeyInt.toString() + "&locName=" + results.getObject("location_name").toString() + insEnd;
                //temp = temp.replace("[[[dive_location]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("dive_location")));
                temp = temp.replace("[[[DelIcon]]]", deleteIcon);
                temp = temp.replace("[[[InsIcon]]]", insertIcon);
                temp = temp.replace("[[[location_name]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("location_name"), 1));
                temp = temp.replace("[[[city]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("city")));
                temp = temp.replace("[[[state]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("state")));//.toUpperCase();
                temp = temp.replace("[[[type]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("type")));
                temp = temp.replace("[[[access_via]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("access_via")));
                temp = temp.replace("[[[average_depth]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_depth")));
                temp = temp.replace("[[[average_visibility]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("average_visibility")));
                temp = temp.replace("[[[features]]]", FormatUtils.formatString(tdCSS(oddRow), results.getObject("features")));
                temp = temp.replace("[[[picture_ref]]]", imagePath + FormatUtils.formatString(tdCSS(oddRow), results.getObject("picture_ref")));
                temp = temp.replace("[[[CountDives]]]", FormatUtils.formatInteger(tdCSS(oddRow), results.getObject("CountDives")));

//                sb.append(FormatUtils.formatStringTd(tdCSS(oddRow), results.getObject("user_password")));
//                sb.append(FormatUtils.formatDollarTd(tdCSS(oddRow), results.getObject("membership_fee")));
//                sb.append(FormatUtils.formatIntegerTd(tdCSS(oddRow), results.getObject("user_role_id")));
//                sb.append(FormatUtils.formatDateTd(tdCSS(oddRow), results.getObject("   birthday")));
//                sb.append("</tr>\n");

                sb.append(temp);
                oddRow = !oddRow;
            }
            //sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        }
        catch (Exception e) {
            return "Exception thrown in DiveLocations.listAllUsers(): " + e.getMessage()
                   + "<br/> partial output: <br/>" + sb.toString();
        }
    }//eo method
}
/*
 
 
String locTable = <table border="0" cellpadding="0" cellspacing="0" width="70%">
<tr>
<td valign="top" colspan="3" height="53">
<p align="center">Location Name</td>
</tr>
<tr>
<td msopnltype="NavBody" rowspan="2" width="275">
<img border="0" src="">picture_ref </td>
<td valign="top" height="304" width="50%" class="it">
dive_location - city, state<br>
<br>
Features<br>
&nbsp;</td>
<td valign="top" height="304" width=^50%" class="it">
type<p>access_via, average_depth, average_visibility,</p>
<p>&nbsp;</td>
</tr>
<tr>
<td valign="top" height="36" colspan="2">

&nbsp;</td>
</tr>
</table>
 
 * 
 * 
 * 
 "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"70%\">"+
"<tr>"+
"<td valign=\"top\" colspan=\"3\" height=\"53\">"+
"<h2 align=\"center\">"+
"Location Name
"</h2>"+
"</td>"+
"</tr>"+
"<tr>"+
"<td msopnltype=\"NavBody\" rowspan=\"2\" width=\"275\">"+
"<img border=\"0\" src=\"\">"+
"picture_ref"+
"</td>"+
"<td valign=\"top\" height=\"304\" width=\"50%\" class=\"it\">"+
"dive_location - city, state Features"+
"&nbsp;</td>"+
"<td valign=\"top\" height=\"304\" width=^50%\" class=\"it\">"+
"type access_via, average_depth, average_visibility,"+
"&nbsp;</td>"+
"</tr>"+
"<tr>"+
"<td valign=\"top\" height=\"36\" colspan=\"2\">"+
footer
"</td>"+
"</tr>"+
"</table>"
 */