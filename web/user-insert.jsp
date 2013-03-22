<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>


<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Register</title>
     
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">
</script>

    </head>
    <body onload="setSelectedTab('UserInsert');">
        <%@ include file= "pre-content.html" %> 
        <div style="margin:auto ; padding-bottom:50px;">
        <h1>Register</h1>
        <div class="newLine"></div>
<%

            String formMsg = "";
            StringData wuData = new StringData();  // all properties of a new WebUser object are "" (empty string)

            Validate wuValidate;
            if (request.getParameter("userEmail") == null) {
                // first display.  All form fields are null, if and only iff any one form field is null.
                wuValidate = new Validate(); // no error messages
            } else {
                // postback -- fill WebUserData object with form data.
                wuData.userEmail = request.getParameter("userEmail");
                wuData.userPw = request.getParameter("userPw");
                wuData.userPw2 = request.getParameter("userPw2");
                wuData.membershipFee = request.getParameter("membershipFee");
                wuData.birthday = request.getParameter("birthday");
                wuData.userRoleId = request.getParameter("userRoleId");

                wuValidate = new Validate(wuData); // populate error messages from user inputs

                if (wuValidate.isValidated()) {

                    // get an OPEN db connection.  Using default constructor (no inputs)
                    // means the dbconn object will try to determine where it's running
                    // and use the right connection string.
                    DbConn dbc = new DbConn();
                    //out.print("<h4>Connection Msg: "+dbc.getConnectionMsg()+"</h4>");
                    String dbError = dbc.getErr();
                    if (dbError.length() == 0) {
                        WebUserMods wus = new WebUserMods(dbc);

                        // insert the validated web user object
                        formMsg = wus.insert(wuValidate);
                        if (formMsg.length() == 0) { //trying to insert from a web user validation object.
                            formMsg = "Record inserted. ";
                        }
                    } else {
                        formMsg = dbError; // db connection error
                    }
                } else {
                    formMsg = "Please try again."; // user data entry error
                }
            } // postback
        %>
        <h1>User Registration</h1>
        <form name="myForm" action="insert_using_classes.jsp" method="POST">
            <table style="text-align:left; border:thin solid gray; padding:5px;">
                <tr>
                    <td>User Email</td>
                    <td><input type="text" name="userEmail" value="<%= wuData.userEmail%>" /></td>
                    <td class="error"><%=wuValidate.getUserEmailMsg()%></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="userPw" value="<%= wuData.userPw%>" /></td>
                    <td class="error"><%=wuValidate.getUserPwMsg()%></td>
                </tr>
                <tr>
                    <td>Re-type Password</td>
                    <td><input type="password" name="userPw2" value="<%= wuData.userPw%>" /></td>
                    <td class="error"><%=wuValidate.getUserPw2Msg()%></td>
                </tr>
                <tr>
                    <td>Membership Fee</td>
                    <td><input type="text" name="membershipFee" value="<%= wuData.membershipFee%>" /></td>
                    <td class="error"><%=wuValidate.getMembershipFeeMsg()%></td>
                </tr>
                <tr>
                    <td>User Role</td>
                    <td><input type="text" name="userRoleId" value="<%= wuData.userRoleId%>" /></td>
                    <td class="error"><%=wuValidate.getUserRoleMsg()%></td>
                </tr>
                <tr>
                    <td>Birthday</td>
                    <td><input type="text" name="birthday" value="<%= wuData.birthday%>" /></td>
                    <td class="error"><%=wuValidate.getBirthdayMsg()%></td>                    </tr>
                <tr>
                    <td><input type="submit" value="Submit" /></td>
                    <td colspan="2" class="error"><%=formMsg%></td>
                </tr>
            </table>
        </form>


        </div>
        <%@ include file= "css-chooser.html" %> 
        <%@ include file= "post-content.html" %> 
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->