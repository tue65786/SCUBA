<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="SQL.DbConn" %>
<%--<%@page language="java" import="view.WebUserView" %>--%>
<%@page language="java" import="view.DiverLogView" %>

<!DOCTYPE HTML>
<!--15.	 Homework Requirements for This Week

User =	tue65786
Password = fohvahni
DB =	SP13_2308_tue65786

1.	Complete the tutorial above which means that you will have a working JSP sample page that reads from your local database (your web_user table) using classes.  Rename this page user.jsp  then change it’s look and feel to match your home page (title, nav bar, content area filled with the data, footer).  
2.	The tutorial above asked you to create a word document and paste the 5 types of errors as obtained by the JSP that uses classes (see sections above entitled “Learn How to Recognize Errors” and “Debugging When Using Classes”).  Attach this word document to your blackboard HW submission.
3.	Write a JSP page named other.jsp that displays data from your “other” database table (whatever you named your “other” table in YOUR database). This JSP page must:
•	have most of its code in classes (minimize the code in the JSP page) and handle database connections as demonstrated and prescribed in this document
•	reference a new class in the view package, a class that is similar to the WebUserView class, but that pulls from your “other” table.  When you are naming classes and methods, use the name of your table – don’t use the word “other”.  
•	have the same look and feel as your home page 

4.	Write a JSP page named assoc.jsp that displays data from your “associative” database table (whatever you named your “associative” table in YOUR database) joined with your “web_user” table and your “other” table (however you named it in your web app).  Show all the fields of your associative table and show at least one (non key) field from the web_user table and at least one (non-key field) from the other table. The requirements for this page are the same as for listother.jsp.
The nav bar of your web application should be “included” (using JSP include directive).  After this lab, you should have the following links working and all of these pages should have the same layout as your index page.
•	The “home” tab should link to index.jsp, 
•	The “Bands” tab (or customers or whatever you called it) should link to user.jsp, 
•	The “Venues” tab (or products or whatever you called your “other” table) should link to other.jsp, 
•	The “Concerts” tab (or purchases or whatever you called your associative table) should link to assoc.jsp. 
•	The “Contact” tab links to contact.jsp
•	The “Labs” tab links to labs.jsp

Attach a zip file of your web application into blackboard. 
Publish your web application to cis-linux2.temple.ed as described in a separate document.  Attach
Please note:  The last time you published to the web server, you only had JSP pages, so the publishing process was relatively straight-forward.  This time, you must follow the publishing instructions (from previous lab) all the way to the end.  The publishing of classes is a little more involved and must be done EXACTLY as described in the publishing document.  Do not get discouraged if it cannot find your class files, just talk to me about it and we can get it to work. 
 
16.	Homework Submission
•	To be graded, your web app must be submitted to blackboard (a zip file of your project, not rar) along with the word document that contains the error analysis.  And your web app must be published to cis-linux2. 
•	To get full credit, this must be done prior to the due date.  You can submit up to one week late with late penalty, but after that, the homework is not accepted.

17.	Grading
Deductions:
•	Not published: not graded.
•	Error messages either not included or not as requested: -0.5/error type (5 types of errors)
•	Jsp files not named as requested: -0.25/page
•	Poor naming in java class code -0.5/table 
•	Associative table not joined (-1.5)
•	For each table, at least one record must have all fields populated and at least one record must have all optional fields not populated.  If not, -0.5/table
•	Table layouts must be as specified in lab 2 (e.g., the optional non-character fields). Data model needs to “make sense”, supporting the functionality you promise in the content on your home page.  If not: -1.5 (and must fix asap).

18.	Studying for the Weekly Quiz
The best way to study for the weekly quiz is to 

1.	Finish your lab on time, 
2.	While you are doing the lab, study the sample code carefully and get “hands on” with it, changing the code in various ways – to make sure you are able to “control it”, 
3.	Study the sections of the lab that explain concepts (that don’t tell you to do something specific),
4.	Review the lab and your code the night before the quiz.-->


<html>
    <head>
        <script src="js/myscript.js" type="text/javascript" ></script>
        <link id ="cssLinkID" href="css/main.css" rel="stylesheet" type="text/css" /> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Dive Log</title>

        <style>        
            .resultSetFormat {
            }
            .resultSetFormat table { 
                /*border-collapse:  collapse;*/
                width: 90%;
                margin: auto;
                font-family: Calibri; 
                font-size: 11pt;
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
                font-style: normal; vertical-align: bottom; white-space: nowrap; border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; 
                border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color: #DAEEF3;
            }
            .resultSetFormat td.row-even {
                color: black; font-weight: 400;  vertical-align: bottom; white-space: nowrap; border-left: medium none; border-right: medium none; border-top: .5pt solid #92CDDC; border-bottom: .5pt solid #92CDDC; padding-left: 1px; padding-right: 1px; padding-top: 1px; background-color:  white;

            }
        </style>

    </head>
    <body onload="setSelectedTab('Log');">
        <%@ include file= "pre-content.html" %> 

        <%            
            DbConn dbc = new DbConn();
            String dbErrorOrData = dbc.getErr();
            if (dbErrorOrData.length() == 0) { // got open connection

                // this returns a string that contains a HTML table with the data in it
                dbErrorOrData = DiverLogView.listAllUsers("resultSetFormat", dbc);

                // PREVENT DB connection leaks:
                //    EVERY code path that opens a db connection, must also close it.
                dbc.close();
            }
        %>

        <h1>Dive Log</h1>
        <div style="padding-left:20px; padding-bottom:150px;"> 
            <% out.print(dbErrorOrData);%>
        </div>
        <%@ include file= "css-chooser.html" %> 
        <%@ include file= "post-content.html" %> 
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->