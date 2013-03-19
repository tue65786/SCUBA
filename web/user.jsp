<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.WebUserMods" %>
<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.WebUserView" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Users</title>

        <style>        
            .resultSetFormat {
            }
            .resultSetFormat table { 
                /*border-collapse:  collapse;*/
                max-width: 90%;
                margin: auto;
                font-family: Calibri; 
                font-size: 12pt;
                border: 4px solid  black;
            }
            .resultSetFormat th{
                color: white; 
                font-weight: 700; 
                vertical-align: bottom; white-space: nowrap; border-left: .5pt solid #92CDDC; 
                border-right: medium none; 
                border-top: .5pt solid #92CDDC; border-bottom: .5pt solid #92CDDC; 
                padding-left: 1px; padding-right: 1px; 
                padding-top: 1px; 
                background-color: #4BACC6;
                text-align: center;

            } 
            /*{border: medium solid brown; background-color:powderblue; padding:5px;}*/
            .resultSetFormat td.row-odd {
                color: black; font-weight: 400; 
                font-style: normal; vertical-align: bottom;  border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; 
                border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color: #DAEEF3;
            }
            .resultSetFormat td.row-even {
                color: black; font-weight: 400;  vertical-align: bottom;  border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color:  white;

            }
        </style>

    </head>
    <body onload="setSelectedTab('UserList');">
        <%@ include file= "pre-content.html" %> 

        <!--        < %
                    DbConn dbc = new DbConn();
                    String dbErrorOrData = dbc.getErr();
                    if (dbErrorOrData.length() == 0) { // got open connection
        
                        // this returns a string that contains a HTML table with the data in it
                        dbErrorOrData = WebUserView.listAllUsers("resultSetFormat", dbc);
        
                        // PREVENT DB connection leaks:
                        //    EVERY code path that opens a db connection, must also close it.
                        dbc.close();
                    }
                % >-->

        <h1>Web Users</h1>
        <div style="margin:auto; padding-bottom:50px;">
            <table style="margin: auto; border: black solid 0px"><tr><Td>
                        <form name="updateDelete" action="user.jsp" method="get">
                            <input type="hidden" name="deletePK">
                        </form>

                        <%
                            String dbDataOrError = "";
                            // Get database connection and check if you got it.
                            DbConn dbc = new DbConn();
                            String dbError = dbc.getErr();
                            if (dbError.length() == 0) {

                                // got open connection, check to see if the user wants to delete a row.
                                String delKey = request.getParameter("deletePK");
                                if (delKey != null && delKey.length() > 0) {

                                    // yep, they want to delete a row, instantiate objects needed to do the delete.
                                    WebUserMods sqlMods = new WebUserMods(dbc);

                                    // try to delete the row that has PK = delKey
                                    String delMsg = sqlMods.delete(delKey);
                                    if (delMsg.length() == 0) {
                                        out.println("<h3>Web User " + delKey + " has been deleted</h3>");
                                    } else {
                                        out.println("<h3>Unable to delete Web User " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>");
                                    }
                                }
                                // delete processed (if necessary)

                                // now print out the whole table
                                dbDataOrError = WebUserView.listAllUsers("resultSetFormat", "javascript:deleteRow", "./images/icons/delete.png", "#bcd8e9", dbc);
                                if (!dbc.getConn().isClosed()) {
                                    dbc.close();
                                }
                            } else {
                                dbDataOrError = dbError;
                            }
                            if (!dbc.getConn().isClosed()) {
                                dbc.close();
                            }
                            out.print(dbDataOrError);
                        %>


                    </td>
                </tr>
            </table>
        </div>
        <%@ include file= "css-chooser.html" %> 
        <%@ include file= "post-content.html" %> 
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->