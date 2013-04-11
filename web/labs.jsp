<%-- 
    Document   : [[RECTRACT]]
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
        <title>SCUBA - Labs</title> 
    </head>
    <body onload="setSelectedTab('Labs'">
        <jsp:include page="pre-content.jsp" /> 
        <p>
        <ul>
            <li>Added mobile support for site.</li>
        </ul>
  
<h3>Lab10 Ajax</h3>

In this lab you are to get the sample code (update using ajax technique) to work on your web_user table (must use classes as in the sample code). Then, implement update using ajax on your "other" table (also, using classes). <br><br><b>SW design:</b><br>  <ul><li>If you do not already have it, add a package (under your "model" package).&nbsp; The new package should be named as your have named your "other" table in your database (don't name your package "other").&nbsp; Under this new package, add classes for StringData, TypedData, Validate, and xxxMods ("xxx" representing the name of your other table in your database). In xxxMods, you should have the same or similar methods the WebUserMods class from the sample code, e.g., insert, delete, find, update. </li><li>Reminder:</li><li style="list-style: none outside none;"> <ul><li>In
 your java classes and inside your JSP pages, do not use names that 
include "other" or "assoc" -- use class and variable names like your DB 
table names and field names. Use indentation and comments.</li><li>Never
 import java.sql.anything into any jsp page. Import only your own java 
wrapper classes. JSP pages should minimal code -- ONLY what is needed to
 get user input and display the desired output.&nbsp;</li><li>In your JSP 
page, put your JSP code before the HTML layout. In your JSP code, set 
all the values you need to include on your page, then use 
&lt;%=variable%&gt; where needed inside your HTML layout.</li></ul> </li><li>Homework submission: publish and test.&nbsp; Attach a zip file of your project right here into this BB assignment.</li></ul> <b>Debugging Tips:</b>&nbsp; <br>    <ul><li>If
 you need to figure out what's going on in your class code, you can use 
System.out.println ("******"+..); and you'll see that output in the 
tomcat or glassfish log in the Netbeans output window (bottom right of 
the IDE). I don't believe you can use breakpoints etc. since tomcat (or 
glassfish JSP application server) is running a copy of the compiled 
classes.</li><li>You are writing java code that generates HTML. If your problem has to do with links, you can also hover your mouse over links (look lower left on
 the browser screen) to see if the href attribute is well-formed.  If your
 HTML is generally not well formed, right click the browser and View Source on the
 HTML page.</li><li>If you 
think you might have a javascript error, you can 
always add javascript alert functions to confirm what code is running 
and showing intermediate values. Or, you can use a javascript debugger such as the firebug plugin in firefox or F12 in chrome or IE.&nbsp; In the debugger, click on script 
(make sure script debugging is enabled), then search for any javascript syntax errors.&nbsp; </li></ul>Publish to your web app. Attach zip file of your code right here.

      </p>
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />         
