
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
            String errorMessage = request.getParameter("errorMsg");
            if(errorMessage == null) {
                errorMessage = "Apparently you are not allowed to access that page...";
            }
            if(errorMessage.contains("logged")) {
                errorMessage += "<p/><p/>Click <a class=\"field8\" href=\"logon.jsp\">here</a> to login";
            }
        %>


        <br/>
        <br/>
        <h3><%=errorMessage%></h3>    

        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />   
