
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
        <title>SCUBA - Lgoout</title> 
    </head>
    <body onload="setSelectedTab('Logout')">
        <%@ include file= "pre-content.html" %> 


        <%
            String msg = "You are now logged off!"; // first display will show nothing on screen.
            try {
                session.invalidate();
            } catch (Exception e) {
                msg += " ... but an exception was thrown: " + e.getMessage();
            }

        %>
        <br/>
        <br/>



            <h3>  <%=msg%></h3>

        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />   
