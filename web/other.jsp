<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.DiveLocations.DiveLocationsMods"%>
<%@page language="java"  import="SQL.DbConn" %>
<%@page language="java" import="view.DiveLocations" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Locations</title>
        <style>        
            .resultSetFormat {
            }
            .resultSetFormat table { 
                /*border-collapse:  collapse;*/
                width: 80%;
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
            .it {
                color:black;
                padding:10px;
                vertical-align: top;
            }
            .rt {
                vertical-align: top;
                color:  #010101; font-size:  10pt;font: 12px/18px Arial,Arial,Helvetica,sans-serif;


            }
            h2{

                color:black;
                font-variant: small-caps;
                font-weight: bolder; font-size:  xx-large;
            }
            h3{    margin: 0px 0px 4px;
                   font-weight: bold;
                   color: black; border-bottom: 2px solid black;
            }
            /*{border: medium solid brown; background-color:powderblue; padding:5px;}*/
            .resultSetFormat td.row-odd {
                color: black; font-weight: 400; 
                font-style: normal; vertical-align: bottom; white-space: nowrap; border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; 
                border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color: #DAEEF3;
            }
            .resultSetFormat td.row-even {
                color: black; font-weight: 400;  vertical-align: bottom; white-space: nowrap; border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color:  white;

            }


            div.img
            {
                margin: 2px;
                border: 1px solid #0000ff;
                height: auto;
                width: auto;
                text-align: center;
            }	
            div.img img
            {
                margin: 3px;
                border: 1px solid #ffffff;
            }
            div.img img:hover {
                border: 1px solid #0000ff;
            }

            div.location
            {
                text-align: center;
                color:darkblue;
                font-style: italic;
                font-weight: normal;
                margin: 2px;
            }     

        </style>

    </head>
    <body onload="setSelectedTab('Locations');">
        <jsp:include page="pre-content.jsp" /> 
        <%
            boolean redirect = false;
            String msg = "Don't know who you are.";
            String redirectMsg = "";
            String user_Name = (String) session.getAttribute("userName");
            String user_Role = (String) session.getAttribute("userRole");
            if(user_Name == null) {
                redirectMsg = "Sorry you cannot access page because you are not logged in.";
            }
            else if(!user_Role.equalsIgnoreCase("admin") && !user_Role.equalsIgnoreCase("editor")) {
//                if(!user_Role.equalsIgnoreCase("editor")) {
                System.out.println("*****" + user_Role);
                redirectMsg = "Sorry you cannot access page because do not have permission.";
            }
            if(redirectMsg.length() != 0) {
                try {
                    response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
                }
                catch (Exception e) {
                    msg += " *****Exception was thrown: " + e.getMessage();
                    System.out.println(msg);
                }
            }
            //msg = "Hello " + user_Name + " (your role is " + user_Role + ")";

        %>
        <h1>Dive Locations</h1>
        <div class="newLine"></div> 

        <form name="updateDelete" action="other.jsp" method="get">
            <input type="hidden" name="deletePK">
        </form>
        <div style="padding-left:240px; padding-bottom:150px;">

            <%
                if(!redirect) {
                    String dbDataOrError = "";
                    // Get database connection and check if you got it.
                    DbConn dbc = new DbConn();
                    String dbError = dbc.getErr();
                    if(dbError.length() == 0) {

                        // got open connection, check to see if the user wants to delete a row.
                        String delKey = request.getParameter("deletePK");
                        if(delKey != null && delKey.length() > 0) {

                            // yep, they want to delete a row, instantiate objects needed to do the delete.
                            DiveLocationsMods sqlMods = new DiveLocationsMods(dbc);

                            // try to delete the row that has PK = delKey
                            String delMsg = sqlMods.delete(delKey);
                            if(delMsg.length() == 0) {
                                out.println("<h3>Dive Location " + delKey + " has been deleted</h3>");
                            }
                            else {
                                out.println("<h5>Unable to delete Dive Location " + delKey + ".</h5>" + sqlMods.getErrorMsg());
                            }
                        }
                        // delete processed (if necessary)

                        // now print out the whole table
                        dbDataOrError = DiveLocations.listAllUsers("resultSetFormat", "javascript:deleteRow", "./images/icons/delete.png", "#bcd8e9", dbc);
                        if(!dbc.getConn().isClosed()) {
                            dbc.close();
                        }
                    }
                    else {
                        dbDataOrError = dbError;
                    }
                    if(!dbc.getConn().isClosed()) {
                        dbc.close();
                    }
                    out.print(dbDataOrError);
                }
            %>


        </div>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />    
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->