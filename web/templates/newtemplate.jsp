<%-- 
    Document   : template
    Created on : Mar 2, 2013, 1:27:18 AM
    Author     : Dan Kauffman @ Temple
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <!--head-content cottains css and js links common to most pages-->
        <%@ include file= "head-content.html" %> 
        <title>SCUBA - Home</title> 
    </head>
    <body onload="setSelectedTab('??????')">
        <%@ include file= "pre-content.html" %> 
                     
    <%@ include file= "css-chooser.html" %> 
    <%@ include file= "post-content.html" %>         
   