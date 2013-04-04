<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.DiveLog.DiveLogMods" %>
<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.DiverLogView" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %>         
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Dive Log</title>

        <style>        
            .resultSetFormat {
                margin:auto;
            }
            .resultSetFormat table { 
                max-width: 95%;
                border-collapse:collapse;
                margin: auto;
                font-family: Arial Verdana Sans-serf;
                font-size: 9pt;
                border: 4px solid  black;
            }
            .resultSetFormat th{
                color: white; 
                font-weight: 700; 
                vertical-align: bottom; 
                white-space: nowrap; 
                border-left: .5pt solid #92CDDC; 
                border-right: medium none; 
                border-top: .5pt solid #92CDDC; 
                border-bottom: .5pt solid #92CDDC; 
                padding-left: 1px; padding-right: 1px; 
                padding-top: 1px;  
                background-color: #4BACC6;
                text-align: center;
            } 

            .resultSetFormat td{  
                font-size: 9pt;
            }
            /*{border: medium solid brown; background-color:powderblue; padding:5px;}*/
            .resultSetFormat td.row-odd {
                color: black; font-weight: 400; 
                font-style: normal; vertical-align: top; border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; 
                border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color: #DAEEF3;
            }
            .resultSetFormat td.row-even {
                color: black; font-weight: 400;  vertical-align: top;  border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color:  white;

            }
            .notes {
                font-size:8pt;
                min-width: 120px;

            }
            .sm {
                font-size:7pt;

            }
            .bold {
                font-weight: bold;
                text-wrap:  none;
            }
        </style>

    </head>
    <body onload="setSelectedTab('Log');">
       <%
            String msg = "Don't know who you are.";
            String redirectMsg = "";
            String user_Name = (String) session.getAttribute("userName");
            String user_Role = (String) session.getAttribute("userRole");
            if (user_Name == null) {
                redirectMsg = "Sorry you cannot access page because you are not logged in.";
            } else if (!user_Role.equalsIgnoreCase("admin") ||!user_Role.equalsIgnoreCase("editor")  ) {
                redirectMsg = "Sorry you cannot access page because you are not logged in.";
            }
            if (redirectMsg.length() != 0) {
                try {
                    response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
                } catch (Exception e) {
                    msg += " Exception was thrown: " + e.getMessage();
                }
            }
            //msg = "Hello " + user_Name + " (your role is " + user_Role + ")";
            
        %>
        <%@ include file= "pre-content.html" %> 
        <h1>Dive Log</h1>

        <form name="updateDelete" action="assoc.jsp" method="get">
            <input type="hidden" name="deletePK">
        </form>

        <%
            String dbDataOrError = "";
            DbConn dbc = new DbConn();
            String dbError = dbc.getErr();
            if (dbError.length() == 0) {

                // got open connection, check to see if the user wants to delete a row.
                String delKey = request.getParameter("deletePK");
                if (delKey != null && delKey.length() > 0) {

                    // yep, they want to delete a row, instantiate objects needed to do the delete.
                    DiveLogMods sqlMods = new DiveLogMods(dbc);

                    // try to delete the row that has PK = delKey
                    String delMsg = sqlMods.delete(delKey);
                    if (delMsg.length() == 0) {
                        out.println("<h3>Dive Log " + delKey + " has been deleted</h3>");
                    } else {
                        out.println("<h3>Unable to delete Dive Log " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>");
                    }
                }
                // delete processed (if necessary)

                // now print out the whole table
                dbDataOrError = DiverLogView.listAllUsers("resultSetFormat", "javascript:deleteRow", "./images/icons/delete.png", "#bcd8e9", dbc);
                if (!dbc.getConn().isClosed()) {
                    dbc.close();
                }


            } else {
                if (!dbc.getConn().isClosed()) {
                    dbc.close();
                }
                dbDataOrError = dbError;

            }

            out.println(dbDataOrError);
        %>



        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->