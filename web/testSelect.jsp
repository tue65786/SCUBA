

<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.WebUserView" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file= "head-content.html" %> 
        <title>Test Select</title> 
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">
</script>
<script> 
$(document).ready(function(){
  $("#flip").click(function(){
    $("#panel").slideToggle("slow");
  });
});
</script>
 
<style type="text/css"> 
#panel,#flip
{
padding:5px;
text-align:center;
background-color:#e5eecc;
border:solid 1px #c3c3c3;
}
#panel
{
padding:50px;
display:none;
}
</style>
    </head>
    <body onload="setSelectedTab('TestSelect')">
        <h1>Register</h1>
        <div class="newLine"></div>
        <%@ include file= "pre-content.html" %> 
        <%
            DbConn dbc2 = new DbConn();
            String dbErrorOrData = dbc2.getErr();
            String userRoleId = "";
            if(request.getParameter("userRoleId") != null) {
                userRoleId = request.getParameter("userRoleId");
            }

            String selectedVal;
            selectedVal = (request.getParameter("userRoleId") == null || request.getParameter("userRoleId").length() == 0 ? "0" : request.getParameter("userRoleId"));
            if(dbErrorOrData.length() == 0) { // got open connection
                dbErrorOrData = WebUserView.listAllUserRoles("option", "role", "setDDLSelectionUserRole()", selectedVal, true, dbc2);

                dbc2.close();

            }
        %>
        
        <form name="myForm" method="GET" action="testSelect.jsp">
            <div style=" width: 50%; padding: 50px; border: 3px black solid; margin:auto;">
                <h4>Testing the Creation and Persistence of Pick List</h4>
            <table><tr><td><% out.print(dbErrorOrData);%></td><td><input class="field2" type="submit" value="Submit" /></td></tr></table></div>
                
            <input type="hidden" name="userRoleId" id="userRoleid" value="<%= userRoleId%>" />
            
        </form>
            <div id="flip">Click to slide the panel down or up</div>
<div id="panel">Hello world!</div>
        <%@ include file= "css-chooser.html" %> 
        <%@ include file= "post-content.html" %>         
