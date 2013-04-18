<%@page contentType="text/html" pageEncoding="UTF-8" %> 
<%@page language="java" import="model.DiveLocations.*" %>
<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.DiveLocations" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Locations</title>

        <style type="text/css">
            /* popup_box DIV-Styles*/
            #popup_box { 
                display:none; /* Hide the DIV */
                position:fixed;  
                _position:absolute; /* hack for internet explorer 6 */  
                height:470px;  
                width:750px;  
                background:#FFFFFF;  
                left: 250px;
                top: 100px;
                z-index:104; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
                margin-left: 15px;  
                /* additional features, can be omitted */
                border:2px solid #ff0000;  	
                padding:15px;  
                font-size:15px;  
                -moz-box-shadow: 0 0 5px #ff0000;
                -webkit-box-shadow: 0 0 5px #ff0000;
                box-shadow: 0 0 5px #ff0000;

            }
        </style>  
        <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>

        <script type="text/javascript">
	
            $(document).ready( function() {


                $("input").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("input").blur(function () {
                    $(this).css("background-color", "#FFF");
                });
                $("textarea").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("textarea").blur(function () {
                    $(this).css("background-color", "#FFF");
                });
                $("select").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("select").blur(function () {
                    $(this).css("background-color", "#FFF");
                });
                // When site loaded, load the Popupbox First
                //loadPopupBox();
	
                $('#popupBoxClose').click( function() {			
                    unloadPopupBox();
                });
		
                $('#load').click( function() {
                    loadPopupBox();
                });
                $('#load2').click( function() {
                    loadPopupBox();
                });
                $('#tryagain').click( function() {
                    loadPopupBox();
                });
            
                $('.updateImg').click( function() {
                    loadPopupBox();
                });

                function unloadPopupBox() {	// TO Unload the Popupbox
                    $('#popup_box').fadeOut("slow");
                    $('#outcontainer').hide();  
                }	
		
                function loadPopupBox() {	// To Load the Popupbox
                    $('#popup_box').fadeIn("slow");
                    $('#outcontainer').show();  
                }
                /**********************************************************/
		
            });
        </script>
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
            String dbDataOrError = "";
//            if(user_Name == null) {
//                redirectMsg = "Sorry you cannot access page because you are not logged in.";
//            }
//            else if(!user_Role.equalsIgnoreCase("admin") && !user_Role.equalsIgnoreCase("editor")) {
////                if(!user_Role.equalsIgnoreCase("editor")) {
//                System.out.println("*****" + user_Role);
//                redirectMsg = "Sorry you cannot access page because do not have permission.";
//            }
//            if(redirectMsg.length() != 0) {
//                try {
//                    response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
//                }
//                catch (Exception e) {
//                    msg += " *****Exception was thrown: " + e.getMessage();
//                    System.out.println(msg);
//                }
//            }
            //msg = "Hello " + user_Name + " (your role is " + user_Role + ")";

        %>
        <h1>Dive Locations</h1>
        <div class="newLine"></div> 

        <form name="updateDelete" action="other.jsp" method="get">
            <input type="hidden" name="deletePK">
        </form>
        <div style="padding-left:240px; padding-bottom:150px;">

            <%

                String formMsg = "";
                String addLocation = (user_Name != null ? "Add Location" : "");
                // All properties of a new webUserStringData object are "" (empty string).
                // This is good for first display.
                StringData stringData = new StringData();

                // All error mesages in the new Validate object are "" (empty string)  
                // This is good for first display.
                Validate validate = new Validate();

                // This parameter controls whether the user input area is displayed or hidden.
                String strShowInputArea = request.getParameter("showInputArea");
                if(strShowInputArea == null) {
                    strShowInputArea = "NO"; // body onload javascript event will initialize things properly
                }

                String strOperation = ""; // will be insert or update or none or null. 


                String dbErrorOrData2 = "";
                if(!redirect) {
                    dbDataOrError = "";

                    // Get database connection and check if you got it.
                    DbConn dbc = new DbConn();
                    String dbError = dbc.getErr();
                    DiveLocationsMods sqlMods = new DiveLocationsMods(dbc);
                    if(dbError.length() == 0) {

                        // got open connection, check to see if the user wants to delete a row.
                        String delKey = request.getParameter("deletePK");
                        if(delKey != null && delKey.length() > 0) {

                            // yep, they want to delete a row, instantiate objects needed to do the delete.


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
                        // This parameter indicates if the user is trying to do an "insert" or "update"
                        strOperation = request.getParameter("operation");
                        if(strOperation != null) {
                            if(strOperation.equalsIgnoreCase("insert")
                               || strOperation.equalsIgnoreCase("update")) {

                                // postback -- fill WebUserData object with form data.
                                stringData.accesssVia = request.getParameter("AccesssVia");
                                stringData.averageDepth = request.getParameter("AverageDepth");
                                stringData.averageVisibility = request.getParameter("AverageVisibility");
                                stringData.city = request.getParameter("City");
                                stringData.state = request.getParameter("State");
                                stringData.diveLocation = request.getParameter("DiveLocation");
                                stringData.features = request.getParameter("Features");
                                stringData.locationName = request.getParameter("LocationName");
                                stringData.pictureRef = request.getParameter("PictureRef");
                                stringData.recordStatus = request.getParameter("RecordStatus");
                                stringData.type = request.getParameter("Type");
                                validate = new Validate(stringData); // populate error messages from user inputs

                                if(strOperation.equalsIgnoreCase("insert")) {
                                    // try to insert the Web User record. returns error message or empty string
                                    formMsg = sqlMods.insert(validate); // empty string means went in OK.
                                    if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                                        formMsg = "Record " + stringData.locationName + " inserted. ";
                                    }
                                    strOperation = "insert"; // Let them try again or continue inserting
                                }
                                else if(strOperation.equalsIgnoreCase("update")) {
                                    // try to update the Web User record. returns error message or empty string
                                    formMsg = sqlMods.update(validate); // empty string means went in OK.
                                    if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                                        formMsg = "Record " + stringData.locationName + " updated. ";
                                        strOperation = "none"; //once sucessful, done with update
                                    }
                                    else {
                                        strOperation = "update"; // give another try to pass validation tests.
                                    }
                                }
                            } // if the user was trying to update or insert.
                        }



                        //dbDataOrError = DiveLocations.listAllUsers("resultSetFormat", "javascript:deleteRow", "./images/icons/delete.png", "#bcd8e9", dbc);
                        dbDataOrError = DiveLocations.listAllUsers("resultSetFormat", "javascript:deleteRow",
                                                                   "./images/icons/delete.png",
                                                                   "javascript:updateRow", "./images/icons/update.png",
                                                                   user_Name, "./images/icons/log-dive-sm.png", "#bcd8e9", dbc);
                        //DiveLocations.listAllUsers(cssClassForResultSetTable, delFn, delIcon, userName, insAssocIcon, bgColor, dbc)
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

                }
            %>

            <a id="load" href="#" onclick="clickInsert()"><%= addLocation%></a>
            <div id="popup_box">
                <div style="margin:auto;">
                    <form name="insertUpdate" action="other.jsp" method="post">
                        <input type="hidden" id="operation" name="operation" value="<%=strOperation%>"/> 
                        <input name="RecordStatus" type="hidden" disabled="disabled"/>
                        <!--                            <input type="button" id="insertButton" value="Insert" onclick="clickInsert();"/>     -->
                        <input type="hidden" id="showInputArea" name="showInputArea" value="<%=strShowInputArea%>"/> 
                        <div id="inputArea">
                            <input type="hidden"  name="DiveLocation" value="<%= stringData.diveLocation%>" /> 
                            <table style="text-align:left;  padding:5px;">
                                <tr>
                                    <td>
                                        Location Name
                                    </td>
                                    <td>
                                        <input type="text" name="LocationName" size="45" class="field2" value="<%= stringData.locationName%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getLocationNameMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        City
                                    </td>
                                    <td>
                                        <input type="text" name="City" size="45" class="field2" value="<%= stringData.getCity()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getCityMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        State
                                    </td>
                                    <td>
                                        <input type="text" name="State" size="2" class="field2" value="<%= stringData.getState()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getStateMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Type
                                    </td>
                                    <td>
                                        <input type="text" name="Type" size="45" class="field2" value="<%= stringData.getType()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getTypeMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Access Via
                                    </td>
                                    <td>
                                        <input type="text" name="AccesssVia" size="45" class="field2" value="<%= stringData.getAccesssVia()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getAccesssViaMsg()%></td>
                                </tr>
                                <tr>
                                    <td>
                                        Average Depth
                                    </td>
                                    <td>
                                        <input type="text" name="AverageDepth" size="45" class="field2" value="<%= stringData.getAverageDepth()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getAverageDepthMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Average Visibility
                                    </td>
                                    <td>
                                        <input type="text" name="AverageVisibility" size="45" class="field2" value="<%= stringData.getAverageVisibility()%>" /></td>
                                    <td class="error">
                                        <%=validate.getAverageVisibilityMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Features
                                    </td>
                                    <td>
                                        <textarea name="Features" cols="45" rows="5" class="field2"><%= stringData.getFeatures()%></textarea>

                                    </td>
                                    <td class="error">
                                        <%=validate.getFeaturesMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Picture Reference
                                    </td>
                                    <td>
                                        <input type="text" readonly  name="PictureRef" size="45" class="field2" value="<%= stringData.getPictureRef()%>" />
                                    </td>
                                    <td class="error">
                                        <%=validate.getPictureRefMsg()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <input type="submit" style="width: 120px;" class="field2" value="Submit" />
                                    </td>
                                    <td>
<!--                                        <input type="button" class="field2"  style="width: 80px;"  value="Reset" onclick="cancel()" />-->
                                    </td>
                                </tr>
                            </table>

                            <!--                                <input type="button" value="Hide Input Area" onclick="inputAreaHide();"/>     -->
                        </div>
                    </form>


                    <a href="#" onclick="clearMsg()" class="LinkButton" id="popupBoxClose">Close Window</a>	

                </div>
            </div>

            <div id="frmMsg"><%=formMsg%>&nbsp;</div>
            <%= dbDataOrError%>
            <a id="load2" href="#" onclick="clickInsert()"><%= addLocation%></a>

            <div id="outcontainer"></div>
            <script type="text/javascript">

                //Note: These next 9 lines of javascript
                //      are global (not in a funtion).
                //Make the XMLHttpRequest Object
                var httpReq;
                if(window.XMLHttpRequest) {
                    httpReq = new XMLHttpRequest();  //For Firefox, Safari, Opera
                }
                else if(window.ActiveXObject){
                    httpReq = new ActiveXObject("Microsoft.XMLHTTP");         //For IE 5+
                } else {
                    alert ('ajax not supported');
                }
                
                function sendRequest(primaryKey) {
                    //alert ('sending request for web user '+primaryKey);
                    httpReq.open("GET","get_location_JSON.jsp?primaryKey=" + primaryKey);
                    httpReq.onreadystatechange = handleResponse;
                    httpReq.send(null);
                }

                function handleResponse() {
                    //alert('handling response');
                    if(httpReq.readyState == 4 && httpReq.status == 200) {
                        //alert('handling response ready 4 status 200');
                        var response = httpReq.responseText;
                        //            alert ("response is " + response);
                        //  document.write(response);
                        // be careful -- field names on the document are case sensative
                        // field names extracted from the JSON response are also case sensative.
                        var locObj = eval(response);
                        //   alert(locObj.diveLocation);
                        //  alert(document.insertUpdate.DiveLocation.value);
                        document.insertUpdate.DiveLocation.value = locObj.diveLocation;
                        document.insertUpdate.LocationName.value = locObj.locationName;
                        document.insertUpdate.City.value = locObj.city;
                        document.insertUpdate.State.value = locObj.state;
                        document.insertUpdate.Type.value = locObj.type;
                        document.insertUpdate.AccesssVia.value = locObj.accessVia;
                        document.insertUpdate.AverageDepth.value = locObj.averageDepth;
                        document.insertUpdate.AverageVisibility.value = locObj.averageVisibility;
                        document.insertUpdate.Features.value = locObj.features;
                        document.insertUpdate.PictureRef.value = locObj.pictureRef;
                        document.insertUpdate.recordStatus.value=locObj.recordStatus;
                    }
                }
                
                function clearMsg(){
                    document.getElementById("operation").value = "none";
                    document.insertUpdate.DiveLocation.value ="";
                    document.insertUpdate.LocationName.value ="";
                    document.insertUpdate.City.value ="";
                    document.insertUpdate.State.value ="";
                    document.insertUpdate.Type.value ="";
                    document.insertUpdate.AccesssVia.value ="";
                    document.insertUpdate.AverageDepth.value ="";
                    document.insertUpdate.AverageVisibility.value ="";
                    document.insertUpdate.Features.value ="";
                    document.insertUpdate.PictureRef.value ="";

                    document.insertUpdate.recordStatus.value="Insert/Update Operation Cancelled";
                    document.getElementById("frmMsg").innerHTML="";
                    document.insertUpdate.submit();
                    
                }
                
                function updateRow (primaryKey) {
                    document.getElementById("operation").value = "update";
                    inputAreaShow();
                    sendRequest(primaryKey);
                }
                            
                function cancel() {
                    document.getElementById("operation").value = "none";
                    document.insertUpdate.DiveLocation.value ="";
                    document.insertUpdate.LocationName.value ="";
                    document.insertUpdate.City.value ="";
                    document.insertUpdate.State.value ="";
                    document.insertUpdate.Type.value ="";
                    document.insertUpdate.AccesssVia.value ="";
                    document.insertUpdate.AverageDepth.value ="";
                    document.insertUpdate.AverageVisibility.value ="";
                    document.insertUpdate.Features.value ="";
                    document.insertUpdate.PictureRef.value ="";

                    document.insertUpdate.recordStatus.value="Insert/Update Operation Cancelled";
                }
       
                function hideOrShowInputArea() {
                    // called from body onload, shows or hides based on saved parameter.
                    if (document.getElementById("showInputArea").value == "YES") {
                        inputAreaShow();
                    } else {
                        inputAreaHide();                                            
                    }
                }
           
                function inputAreaHide() {
                    document.getElementById("inputArea").style.display = "none";
                    document.getElementById("showInputArea").value = "NO";
                    cancel();
                }
         
                function inputAreaShow() {
                    document.getElementById("inputArea").style.display = "block";
                    document.getElementById("showInputArea").value = "YES";
                }
         
                function clickInsert() {
                    document.insertUpdate.DiveLocation.value ="";
                    document.insertUpdate.LocationName.value ="";
                    document.insertUpdate.City.value ="";
                    document.insertUpdate.State.value ="";
                    document.insertUpdate.Type.value ="";
                    document.insertUpdate.AccesssVia.value ="";
                    document.insertUpdate.AverageDepth.value ="";
                    document.insertUpdate.AverageVisibility.value ="";
                    document.insertUpdate.Features.value ="";
                    document.insertUpdate.PictureRef.value ="";
                    document.getElementById("operation").value = "insert";
                  
                    //  inputAreaShow();
                }
            </script>
        </div>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />    
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->