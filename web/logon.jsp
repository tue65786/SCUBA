
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
        <%@ include file= "pre-content.html" %> 


        <%
            String msg = ""; // first display will show nothing on screen.
            String user_Name = request.getParameter("uname");
            String user_Role = "";
            String pwEncrypted = "";
            if(user_Name == null) {
                user_Name = ""; // surpress "NULL" (first display) from showing up in the username text field.
            } // postback, check username and password
            else {
                String passW = request.getParameter("pw");

                // For this simple/sample code, username must = password.  In a real
                // application you would encrypt the password before storing it in the DB and also
                // encrypt the pw entered by the user -- checking for a match with what's in the db.
                if(passW.equalsIgnoreCase(user_Name)) {
                    if(user_Name.equalsIgnoreCase("Bob")) {
                        user_Role = "view";  // can view private pages (no edit)
                        msg = "Hello " + user_Name + " (your role is " + user_Role + ")";
                    }
                    else if(user_Name.equalsIgnoreCase("Dave")) {
                        user_Role = "edit"; // can edit (but not admin)
                        msg = "Hello " + user_Name + " (your role is " + user_Role + ")";
                    }
                    else if(user_Name.equalsIgnoreCase("Eugene")) {
                        user_Role = "admin"; // can access admin page
                        msg = "Hello " + user_Name + ".  You are almost God (your role is " + user_Role + ")";
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
