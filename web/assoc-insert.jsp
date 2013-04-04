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



    </head>
    <body onload="setSelectedTab('Log');">
        <jsp:include page="pre-content.jsp" /> 
        <h1>Dive Log</h1>
        <div class="newLine"></div>


        <form name="myForm"  action="user-insert.jsp" method="GET">
            <table style="text-align:left; padding:5px; margin-left: 40px;">
                <tr>
                    <td>
                        Dive Date</td>
                    <td>
                        <input type="text" name="DiveDate" size="45" class="field2" value="<%= logData.getDiveDateMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getDiveDateMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Num Dives</td>
                    <td>
                        <input type="text" name="NumDives" size="45" class="field2" value="<%= logData.getNumDivesMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getNumDivesMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Min Per Dive</td>
                    <td>
                        <input type="text" name="MinPerDive" size="45" class="field2" value="<%= logData.getMinPerDiveMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getMinPerDiveMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Air Type</td>
                    <td>
                        <input type="text" name="AirType" size="45" class="field2" value="<%= logData.getAirTypeMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getAirTypeMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Max Depth</td>
                    <td>
                        <input type="text" name="MaxDepth" size="45" class="field2" value="<%= logData.getMaxDepthMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getMaxDepthMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Dive Buddy</td>
                    <td>
                        <input type="text" name="DiveBuddy" size="45" class="field2" value="<%= logData.getDiveBuddyMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getDiveBuddyMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Notes</td>
                    <td>
                        <input type="text" name="Notes" size="45" class="field2" value="<%= logData.getNotesMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getNotesMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Dive Location</td>
                    <td>
                        <input type="text" name="DiveLocation" size="45" class="field2" value="<%= logData.getDiveLocationMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getDiveLocationMsg()%></td>
                </tr>
                <tr>
                    <td>
                        Web User</td>
                    <td>
                        <input type="text" name="WebUser" size="45" class="field2" value="<%= logData.getWebUserMsg()%>" /></td>
                    <td class="error">
                        <%=logValidate.getWebUserMsg()%></td>
                </tr>
            </table>
        </form>

        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />     
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->