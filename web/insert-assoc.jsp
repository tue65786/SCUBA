<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.DiveLog.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.DiverLogView" %>
<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %>         
        <script src="js/datetimepicker_css.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA -Insert Dive Log</title>



    </head>
    <body onload="setSelectedTab('Log');">
        <jsp:include page="pre-content.jsp" /> 
        <%
            DbConn dbc2 = new DbConn();
            String dbErrorOrData = dbc2.getErr();
            String diveBuddyId = "";
            String userId = (String) session.getAttribute("userid");
            if(request.getParameter("diveBuddyId") != null) {
                diveBuddyId = request.getParameter("diveBuddyId");
            }

            String selectedVal;
            selectedVal = (request.getParameter("diveBuddyId") == null || request.getParameter("diveBuddyId").length() == 0 ? "0" : request.getParameter("buddy"));
            if(dbErrorOrData.length() == 0) { // got open connection
                dbErrorOrData = DiverLogView.listAllUsersDDL("option", "buddy", "setDDLSelectionUser()", selectedVal, true, dbc2, userId);
                dbc2.close();
            }
        %>
        <% //out.print("id " + ((((String)session.getAttribute("id")))));
            //out.print("userid " + ((((String)session.getAttribute("userid")))));
            //  if ((((String)session.getAttribute("id")).length()==0) || ((String)session.getAttribute("userid")).length() == 0)
            //                            {
            //                response.sendRedirect("deny.jsp?errorMsg=A problem was encountered. Please make sure you are logged in and try again");
            //                        }
            String formMsg = "";
            String locationStr = "";
            //  String uid = (String) session.getAttribute("userid");
            if(userId.length() == 0) {
            }
            model.DiveLog.StringData logData = new StringData();
            //  wuData = new StringData();  // all properties of a new WebUser object are "" (empty string)
            if(request.getParameter("id") != null) {
                session.setAttribute("id", request.getParameter("id"));
                session.setAttribute("locName", request.getParameter("locName"));
                locationStr = (String) session.getAttribute("locName");
                logData.dive_location_id = request.getParameter("id");
                logData.web_user_id = userId;
                //session.setAttribute("userid") = (String) request.getParameter("id");
            }
            model.DiveLog.Validate logValidate;
            if(request.getParameter("DiveDate") == null) {
                // first display.  All form fields are null, if and only iff any one form field is null.
                logValidate = new Validate(); // no error messages

            }
            else {
                locationStr = (String) session.getAttribute("locName");
                // postback -- fill WebUserData object with form data.
                logData.dive_date = request.getParameter("DiveDate");
                logData.number_dives = request.getParameter("NumDives");
                logData.minutes_per_dive = request.getParameter("MinPerDive");
                logData.air_type = request.getParameter("AirType");
                logData.max_depth = request.getParameter("MaxDepth");
                logData.dive_buddy = request.getParameter("buddy");
                logData.notes = request.getParameter("Notes");
                logData.dive_location_id = (String) session.getAttribute("id");
                logData.web_user_id = (String) session.getAttribute("userid");

                // wuData.userRoleId = request.getParameter("userRoleId");

                logValidate = new Validate(logData); // populate error messages from user inputs

                if(logValidate.isValidated()) {

                    // get an OPEN db connection.  Using default constructor (no inputs)
                    // means the dbconn object will try to determine where it's running
                    // and use the right connection string.
                    DbConn dbc = new DbConn();
                    //out.print("<h4>Connection Msg: "+dbc.getConnectionMsg()+"</h4>");
                    String dbError = dbc.getErr();
                    if(dbError.length() == 0) {
                        DiveLogMods dls = new DiveLogMods(dbc);

                        // insert the validated web user object
                        formMsg = dls.insert(logValidate);
                        if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                            formMsg = "Your dive has been logged.Click <a href=\"assoc.jsp\">here </a> to view the log. ";
                            //   session.removeAttribute("id");

                        }
                    }
                    else {
                        formMsg = dbError; // db connection error
                    }
                }
                else {
                    formMsg = "Please try again."; // user data entry error
                }
            } // postback
        %>
        <h1>Dive Log</h1>
        <div class="newLine"></div>
        <form name="myForm" action="insert-assoc.jsp" method="GET">
            <table style="text-align:left; padding:5px; margin-left: 40px;">
                <tr><td colspan="3"><h4>Logging Dive @ <%= locationStr%></h4>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dive Date
                    </td>
                    <td>
                        <input type="text" id="DiveDate" name="DiveDate" size="15" 
                               class="field2" value="<%= logData.dive_date%>" />
                        <img src="./images/icons/calendar_n.gif" alt="C;ick to set date" 
                             onclick="NewCssCal('DiveDate','MMddYYYY','','','','','past')" style="cursor:pointer"/>
                    </td>
                    <td class="error">
                        <%=logValidate.getDive_dateMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Number of Dives
                    </td>
                    <td>
                        <input type="text" name="NumDives" size="15" class="field2" value="<%= logData.number_dives%>" />
                    </td>
                    <td class="error">
                        <%=logValidate.getNumber_divesMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Minutes Per Dive
                    </td>
                    <td>
                        <input type="text" name="MinPerDive" size="15" class="field2" value="<%= logData.minutes_per_dive%>" />
                    </td>
                    <td class="error">
                        <%=logValidate.getMinutes_per_diveMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Air Type
                    </td>
                    <td>
                        <input type="text" name="AirType" size="15" class="field2" value="<%= logData.air_type%>" />
                    </td>
                    <td class="error">
                        <%=logValidate.getAir_typeMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Max Depth
                    </td>
                    <td>
                        <input type="text" name="MaxDepth" size="15" class="field2" value="<%= logData.max_depth%>" />
                    </td>
                    <td class="error">
                        <%=logValidate.getMax_depthMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dive Buddy
                    </td>
                    <td>
                        <% out.print(dbErrorOrData);%>
                        <input type="hidden" name="diveBuddyId" id="diveBudyId" value="<%= logData.dive_buddy%>" />
                    </td>
                    <td class="error">
                        <%=logValidate.getDive_buddyMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Notes
                    </td>
                    <td>
                        <textarea name="Notes" cols="30" rows="3" maxlength="100" class="field2"><%= logData.notes%></textarea>
                    </td>
                    <td class="error">                        <input  type="hidden" name="DiveLocation" value="<%= logData.dive_location_id%>" />
                        <input type="hidden" name="WebUser" value="<%= logData.web_user_id%>" />
                      <%=logValidate.getNotesMsg()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit"  class="field2" value="Add Dive Log"/></td><td colspan="2"><%=formMsg%>
                    </td>
                </tr>
            </table>
        </form>

        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />     
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->