
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.WebUserView" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--head-content cottains css and js links common to most pages-->
        <%@ include file= "head-content.html" %> 
        <title>SCUBA - Login</title> 
    </head>
    <body onload="setSelectedTab('Login')">
        <jsp:include page="pre-content.jsp" /> 


        <%
            String msg = ""; // first display will show nothing on screen.
            String user_Name = request.getParameter("uname");
            String user_Role = "";
            String pwEncrypted = "";
            StringData userData = new StringData();
            DbConn dbc = new DbConn();
            String dbError = dbc.getErr();

            if(user_Name == null) {
                user_Name = ""; // surpress "NULL" (first display) from showing up in the username text field.
            } // postback, check username and password
            else {
                String passW = request.getParameter("pw");
                if(dbError.length() == 0) {
                    WebUserMods userMods = new WebUserMods(dbc);
                    userData = userMods.findLogonUser(dbc, user_Name, passW);
                    if(userData != null && userData.userEmail != null) {
                        switch (Integer.parseInt(userData.userRoleId)) {
                            case 1:
                                user_Role = "admin";
                                break;
                            case 2:
                                user_Role = "editor";
                                break;
                            case 3:
                                user_Role = "view";
                                break;
                            default:
                                user_Role = "view";
                                break;
                        }
                    }
                    else {
                        msg = "That username and password were not found in our database."; // log on not sucessful
                    }
                } // bad password (in this contrived example) is when user name <> password.
                else {
                    msg = "Invalid password !!";
                }

                // if username/password is OK, user_Role will have received a value.
                if(user_Role.length() > 0) {
                    session.setAttribute("userName", user_Name);
                    session.setAttribute("userRole", user_Role);
                } // successful log in

                // pwEncrypted = Encrypt.encryptPw(passW);
            } // postback
        %>
        <br/>
        <br/>


        <form method="post" action="logon.jsp" >
            <table><tr><td>Please enter your username:</td><td> <input  size="45" class="field2" type="text" name="uname" value="<%=user_Name%>"></td></tr><tr><td>

                        Please enter your password: </td><td><input  size="45" class="field2" type="password" name="pw"></td></tr><tr><td colspan="2">

                        <br/>  <input style="margin-left: 30px;width: 200px;" class="field2" type="submit" value = "Log On" > <br/>
                    </td></tr></table>

            <h3>  <%=msg%></h3>
        </form>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />   
