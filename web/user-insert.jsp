<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.WebUserView" %>


<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Register</title>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">
        </script>
        <script type="text/javascript">
            $(document).ready(function () {

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

                //        $("select").change(function () {
                //            $(this).css("background-color", "#D6D6FF");
                //    });
            });
        </script>
    </head>
    <body onload="setSelectedTab('UserInsert'); ">
        <%
            String msg = "Don't know who you are.";
            String redirectMsg = "";
            String user_Name = (String) session.getAttribute("userName");
            String user_Role = (String) session.getAttribute("userRole");
            if(user_Name != null) {
                redirectMsg = "You already have an account, ya big dummy!";
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
            <h1>Register</h1>
            <div class="newLine"></div>

            <%


                DbConn dbc2 = new DbConn();
                String dbErrorOrData = dbc2.getErr();
                if(dbErrorOrData.length() == 0) { // got open connection

                    // this returns a string that contains a HTML table with the data in it
                    String selectedVal;
                    selectedVal = (request.getParameter("userRoleId") == null || request.getParameter("userRoleId").length() == 0 ? "0" : request.getParameter("userRoleId"));
                    // selectedVal = request.getParameter("userRoleId");
                    // selValInt ? "selected" : ""
                    dbErrorOrData = WebUserView.listAllUserRoles("option", "role", "setDDLSelectionUserRole()", selectedVal, true, dbc2);

                    // PREVENT DB connection leaks:
                    //    EVERY code path that opens a db connection, must also close it.
                    dbc2.close();

                }
            %>
            <%


                String formMsg = "";
                StringData wuData = new StringData();  // all properties of a new WebUser object are "" (empty string)

                Validate wuValidate;
                if(request.getParameter("userEmail") == null) {
                    // first display.  All form fields are null, if and only iff any one form field is null.
                    wuValidate = new Validate(); // no error messages
                }
                else {
                    // postback -- fill WebUserData object with form data.
                    wuData.userEmail = request.getParameter("userEmail");
                    wuData.userPw = request.getParameter("userPw");
                    wuData.userPw2 = request.getParameter("userPw2");
                    wuData.membershipFee = request.getParameter("membershipFee");
                    wuData.birthday = request.getParameter("birthday");
                    wuData.userRoleId = request.getParameter("userRoleId");

                    wuValidate = new Validate(wuData); // populate error messages from user inputs

                    if(wuValidate.isValidated()) {

                        // get an OPEN db connection.  Using default constructor (no inputs)
                        // means the dbconn object will try to determine where it's running
                        // and use the right connection string.
                        DbConn dbc = new DbConn();
                        //out.print("<h4>Connection Msg: "+dbc.getConnectionMsg()+"</h4>");
                        String dbError = dbc.getErr();
                        if(dbError.length() == 0) {
                            WebUserMods wus = new WebUserMods(dbc);

                            // insert the validated web user object
                            formMsg = wus.insert(wuValidate);
                            if(formMsg.length() == 0) { //trying to insert from a web user validation object.
                                formMsg = "Record inserted. ";
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

            <form name="myForm"  action="user-insert.jsp" method="GET">
                <table style="text-align:left; padding:5px; margin-left: 40px;">
                    <tr>
                        <td> User Email</td>
                        <td>
                            <input type="text" name="userEmail" size="45" class="field2" value="<%= wuData.userEmail%>" /></td>
                        <td class="error"><%=wuValidate.getUserEmailMsg()%></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="userPw" class="field2" size="45" value="<%= wuData.userPw%>" /></td>
                        <td class="error"><%=wuValidate.getUserPwMsg()%></td>
                    </tr>
                    <tr>
                        <td>Re-type Password</td>
                        <td><input type="password" class="field2" size="45" name="userPw2" value="<%= wuData.userPw%>" /></td>
                        <td class="error"><%=wuValidate.getUserPw2Msg()%></td>
                    </tr>
                    <tr>
                        <td>Membership Fee</td>
                        <td><input class="field2" type="text" size="25" name="membershipFee" value="<%= wuData.membershipFee%>" /></td>
                        <td class="error"><%=wuValidate.getMembershipFeeMsg()%></td>
                    </tr>
                    <tr>
                        <td>User Role</td>
                        <td> 


                            <% out.print(dbErrorOrData);%>
                            <input type="hidden" name="userRoleId" id="userRoleid" value="<%= wuData.userRoleId%>" /></td>
                        <td class="error"><%=wuValidate.getUserRoleMsg()%></td>
                    </tr>
                    <tr>
                        <td>Birthday</td>
                        <td><input type="text" class="field2" name="birthday" size="25" value="<%= wuData.birthday%>" /></td>
                        <td class="error"><%=wuValidate.getBirthdayMsg()%></td>                    </tr>
                    <tr><td><p/></td></tr>
                    <tr style="min-height: 90px;">
                        <td colspan="2" style=" min-height: 90px; text-align: center; vertical-align: bottom;"><input class="field2" style="text-align: center; width: 70%;" type="submit" value="Submit" /></td>
                        <td colspan="1" style="vertical-align: bottom;" class="error"><%=formMsg%></td>
                    </tr>
                </table>
            </form>


        </div>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />    
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->