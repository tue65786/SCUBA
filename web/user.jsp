<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.WebUserView" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
          <script src="js/datetimepicker_css.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Users</title>
        <style type="text/css">


            /* popup_box DIV-Styles*/
            #popup_box { 
                display:none; /* Hide the DIV */
                position:fixed;  
                _position:absolute; /* hack for internet explorer 6 */  
                height:370px;  
                width:700px;  
                background:#FFFFFF;  
                left: 300px;
                top: 150px;
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
//                
//$("").submit(function() {
//  if ($("").val() == "correct") {
//    $("span").text("Validated...").show();
//    return true;
//  }
//  $("span").text("Not valid!").show().fadeOut(1000);
//  return false;
//});
//checkPopup();

//var n = $('input#showInputArea').val();



                $("input").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("input").blur(function () {
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
                $('#tryagain').click( function() {
                    loadPopupBox();
                });
            
                $('.updateImg').click( function() {
                    loadPopupBox();
                });

//                function checkPopUpBox() {
//                    if (document.getElementById("showInputArea").value == "YES")
//                        {
//                            loadPopUpBox();
//                        }
//                    
//                }
                function unloadPopupBox() {	// TO Unload the Popupbox
                    $('#popup_box').fadeOut("slow");
                    //			$("#outcontainer").css({ // this is just for style		
                    //				"opacity": "1"
                    //			}); 
                    $('#outcontainer').hide();  
                }	
		
                function loadPopupBox() {	// To Load the Popupbox
                    $('#popup_box').fadeIn("slow");
                    $('#outcontainer').show();  
                    //                  $("#outcontainer").css({ // this is just for style
                    //				"opacity": ".3"  
			
                    //              });              
                }
                /**********************************************************/
		
            });
        </script>
        <style>        
            .resultSetFormat {
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
        <%
            String msg = "Don't know who you are.";
            String redirectMsg = "";
            String user_Name = (String) session.getAttribute("userName");
            String user_Role = (String) session.getAttribute("userRole");
            if(user_Name == null) {
                redirectMsg = "Sorry you cannot access the ADMIN page because you are not logged in.";
            }
            else if(!user_Role.equalsIgnoreCase("admin")) {
                redirectMsg = "Sorry you are not authorized to access the ADMIN page.";
            }
            if(redirectMsg.length() != 0) {
                try {
                    response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
                }
                catch (Exception e) {
                    msg += " Exception was thrown: " + e.getMessage();
                }
            }
            //msg = "Hello " + user_Name + " (your role is " + user_Role + ")";

        %>

        <jsp:include page="pre-content.jsp" /> 

        <div style="margin:auto ; padding-bottom:50px;">
            <h1>Web Users</h1>
            <div class="newLine"></div>
            <table style="margin: auto; border: black solid 0px"><tr><Td>
                        <input type="hidden" name="s">
                        <form name="updateDelete" action="user.jsp" method="get">
                            <input type="hidden" name="deletePK">
                        </form>

                        <%

                            String formMsg = "";

                            // All properties of a new webUserStringData object are "" (empty string).
                            // This is good for first display.
                            StringData webUserStringData = new StringData();

                            // All error mesages in the new Validate object are "" (empty string)  
                            // This is good for first display.
                            Validate webUserValidate = new Validate();

                            // This parameter controls whether the user input area is displayed or hidden.
                            String strShowInputArea = request.getParameter("showInputArea");
                            if(strShowInputArea == null) {
                                strShowInputArea = "NO"; // body onload javascript event will initialize things properly
                            }

                            String strOperation = ""; // will be insert or update or none or null. 

                            String dbDataOrError = "";
                            String dbErrorOrData2 = "";
                            // Get database connection and check if you got it.
                            DbConn dbc = new DbConn();
                            String dbError = dbc.getErr();
                            if(dbError.length() == 0) {
                                DbConn dbc2 = new DbConn();
                                dbErrorOrData2 = dbc2.getErr();
                                String selectedVal;
                                if(dbErrorOrData2.length() == 0) { // got open connection

                                    // this returns a string that contains a HTML table with the data in it

                                    selectedVal = (request.getParameter("userRoleId") == null || request.getParameter("userRoleId").length() == 0 ? "0" : request.getParameter("userRoleId"));
                                    // selectedVal = request.getParameter("userRoleId");
                                    // selValInt ? "selected" : ""
                                    dbErrorOrData2 = WebUserView.listAllUserRoles("option", "role", "setDDLSelectionUserRoleForUpdate()", selectedVal, true, dbc2);

                                    // PREVENT DB connection leaks:
                                    //    EVERY code path that opens a db connection, must also close it.
                                    dbc2.close();
                                }
                                WebUserMods sqlMods = new WebUserMods(dbc);
                                // got open connection, check to see if the user wants to delete a row.
                                String delKey = request.getParameter("deletePK");
                                if(delKey != null && delKey.length() > 0) {

                                    // yep, they want to delete a row, instantiate objects needed to do the delete.


                                    // try to delete the row that has PK = delKey
                                    String delMsg = sqlMods.delete(delKey);
                                    if(delMsg.length() == 0) {
                                        out.println("<h3>Web User " + delKey + " has been deleted</h3>");
                                    }
                                    else {
                                        out.println("<h3>Unable to delete Web User " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>");
                                    }
                                } // delete processed (if necessary)



                                // This parameter indicates if the user is trying to do an "insert" or "update"
                                strOperation = request.getParameter("operation");
                                if(strOperation != null) {
                                    if(strOperation.equalsIgnoreCase("insert")
                                       || strOperation.equalsIgnoreCase("update")) {

                                        // postback -- fill WebUserData object with form data.
                                        webUserStringData.webUserId = request.getParameter("webUserId");
                                        webUserStringData.userEmail = request.getParameter("userEmail");
                                        webUserStringData.userPw = request.getParameter("userPw");
                                        webUserStringData.userPw2 = request.getParameter("userPw2");
                                        webUserStringData.membershipFee = request.getParameter("membershipFee");
                                        webUserStringData.birthday = request.getParameter("birthday");
                                        webUserStringData.userRoleId = request.getParameter("userRoleId");

                                        webUserValidate = new Validate(webUserStringData); // populate error messages from user inputs

                                        if(strOperation.equalsIgnoreCase("insert")) {
                                            // try to insert the Web User record. returns error message or empty string
                                            formMsg = sqlMods.insert(webUserValidate); // empty string means went in OK.
                                            if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                                                formMsg = "Record " + webUserStringData.userEmail + " inserted. ";
                                            }
                                            strOperation = "insert"; // Let them try again or continue inserting
                                        }
                                        else if(strOperation.equalsIgnoreCase("update")) {
                                            // try to update the Web User record. returns error message or empty string
                                            formMsg = sqlMods.update(webUserValidate); // empty string means went in OK.
                                            if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                                                formMsg = "Record " + webUserStringData.userEmail + " updated. ";
                                                strOperation = "none"; //once sucessful, done with update
                                            }
                                            else {
                                                strOperation = "update"; // give another try to pass validation tests.
                                            }
                                        }
                                    } // if the user was trying to update or insert.
                                }



                                // now print out the whole table
                                // dbDataOrError = WebUserView.listAllUsers("resultSetFormat", "javascript:deleteRowPretty", "./images/icons/delete.png", "#bcd8e9", dbc);
                                dbDataOrError = WebUserView.listAllUsers("resultSetFormat", "javascript:deleteRowPretty", "./images/icons/delete.png",
                                                                         "javascript:updateRow", "./images/icons/update.png",
                                                                         "#bcd8e9", dbc);
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
                            //out.print(dbDataOrError);
%>
                        <div id="popup_box">
                            <div style="margin:auto;">
                            <form name="insertUpdate" action="user.jsp" method="get">
                                <input type="hidden" id="operation" name="operation" value="<%=strOperation%>"/> 

                                <input name="recordStatus" type="hidden" disabled="disabled"/>
                                <!--                            <input type="button" id="insertButton" value="Insert" onclick="clickInsert();"/>     -->
                                <input type="hidden" id="showInputArea" name="showInputArea" value="<%=strShowInputArea%>"/> 
                                <div id="inputArea">
                                    <input type="hidden"  name="webUserId" value="<%= webUserStringData.webUserId%>" /> 
                                    <table style="text-align:left; border:thin solid gray; padding:5px;">
                                        <tr>
                                            <td>User Email</td>
                                            <td><input type="text" class="field2" name="userEmail" value="<%= webUserStringData.userEmail%>" /></td>
                                            <td class="error"><%=webUserValidate.getUserEmailMsg()%></td>
                                        </tr>
                                        <tr>
                                            <td>Password</td>
                                            <td><input type="password"  class="field2" name="userPw" value="<%= webUserStringData.userPw%>" /></td>
                                            <td class="error"><%=webUserValidate.getUserPwMsg()%></td>
                                        </tr>
                                        <tr>
                                            <td>Re-type Password</td>
                                            <td><input type="password" name="userPw2"  class="field2" value="<%= webUserStringData.userPw%>" /></td>
                                            <td class="error"><%=webUserValidate.getUserPw2Msg()%></td>
                                        </tr>
                                        <tr>
                                            <td>Membership Fee</td>
                                            <td><input type="text" name="membershipFee"  class="field2" value="<%= webUserStringData.membershipFee%>" /></td>
                                            <td class="error"><%=webUserValidate.getMembershipFeeMsg()%></td>   
                                        <tr>
                                            <td>User Role</td>
                                            <td> <% out.print(dbErrorOrData2);%>
                                                <input type="hidden" name="userRoleId" value="<%= webUserStringData.userRoleId%>" /></td>
                                            <td class="error"><%=webUserValidate.getUserRoleMsg()%></td>
                                        </tr>
                                        <tr>
                                            <td>Birthday</td>
                                            <td>
                                                <input type="text" id="birthday" name="birthday"  class="field2" value="<%= webUserStringData.birthday%>" />
                                            </td>
                                            <td class="error"><%=webUserValidate.getBirthdayMsg()%></td>                    
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><input type="submit"  class="field2" value="Submit" /></td>
                                            <td><input type="button"  class="field2" value="Reset" onclick="cancel()"/></td>
                                        </tr>
                                    </table>
                                    <!--                                <input type="button" value="Hide Input Area" onclick="inputAreaHide();"/>     -->
                                </div>
                            </form>


                            <a href="#" onclick="clearMsg()" class="LinkButton" id="popupBoxClose">Close Window</a>	

                        </div>
                        </div>

                        <div id="frmMsg"><%=formMsg%>&nbsp;</div>
                        <%=dbDataOrError%>
                        <a id="load" href="#" onclick="clickInsert()">Add User</a>
                    </td>
                </tr>
            </table>
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
                function setDDLSelectionUserRoleForUpdate() {
                    var val =  document.insertUpdate.role.value;
                    // document.insertUpdate.userRoleid.value = val;   
                    document.insertUpdate.userRoleId.value = val;
                }
                function sendRequest(primaryKey) {
                    //alert ('sending request for web user '+primaryKey);
                    httpReq.open("GET","get_webUser_JSON.jsp?primaryKey=" + primaryKey);
                    httpReq.onreadystatechange = handleResponse;
                    httpReq.send(null);
                }
                function handleResponse() {
                    //alert('handling response');
                    if(httpReq.readyState == 4 && httpReq.status == 200) {
                        //alert('handling response ready 4 status 200');
                        var response = httpReq.responseText;
               //         alert ("response is " + response);
                      //  document.write(response);
                        // be careful -- field names on the document are case sensative
                        // field names extracted from the JSON response are also case sensative.
                        var webUserObj = eval(response);
                    
                        //alert ("webUserId is "+webUserObj.webUserId);
                        document.insertUpdate.webUserId.value=webUserObj.webUserId;
                                                         
                        //alert ("userEmail is "+webUserObj.userEmail);
                        document.insertUpdate.userEmail.value=webUserObj.userEmail;
                    
                        //alert ("userPw is "+webUserObj.userPw);
                        document.insertUpdate.userPw.value=webUserObj.userPw;
                    
                        //alert ("userPw2 is "+webUserObj.userPw2);
                        document.insertUpdate.userPw2.value=webUserObj.userPw2;
                    
                        //alert ("membershipFee is "+webUserObj.membershipFee);
                        document.insertUpdate.membershipFee.value=webUserObj.membershipFee;
                    
                        //alert ("userRoleId is "+webUserObj.userRoleId);
                        document.insertUpdate.userRoleId.value=webUserObj.userRoleId;
                        document.getElementById("role").value = document.insertUpdate.userRoleId.value;
                  
                        document.insertUpdate.birthday.value=webUserObj.birthday;

                        //alert ("record status is "+webUserObj.recordStatus);
                        document.insertUpdate.recordStatus.value=webUserObj.recordStatus;
                    }
                }
                function clearMsg(){
                                    document.getElementById("operation").value = "none";
 
                    document.insertUpdate.webUserId.value="";
                    document.insertUpdate.userEmail.value="";
                    document.insertUpdate.userPw.value="";
                    document.insertUpdate.userPw2.value="";
                    document.insertUpdate.membershipFee.value="";
                    document.insertUpdate.userRoleId.value="";
                    document.insertUpdate.birthday.value="";

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
 
                    document.insertUpdate.webUserId.value="";
                    document.insertUpdate.userEmail.value="";
                    document.insertUpdate.userPw.value="";
                    document.insertUpdate.userPw2.value="";
                    document.insertUpdate.membershipFee.value="";
                    document.insertUpdate.userRoleId.value="";
                    document.insertUpdate.birthday.value="";

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
                    document.insertUpdate.webUserId.value="";
                    document.insertUpdate.userEmail.value="";
                    document.insertUpdate.userPw.value="";
                    document.insertUpdate.userPw2.value="";
                    document.insertUpdate.membershipFee.value="";
                    document.insertUpdate.userRoleId.value="";
                    document.insertUpdate.birthday.value="";
                    document.getElementById("operation").value = "insert";
                  
                    //  inputAreaShow();
                }
            </script>
        </div>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />    
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->