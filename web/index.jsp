<%-- 
    Document   : index
    Created on : Feb 6, 2013, 11:21:10 AM
    Author     : tue65786 
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
    <body onload="setSelectedTab('Home')">
        <jsp:include page="pre-content.jsp" /> 
        <p>
        <h2>Welcome to the SCUBA Dive Log web site!</h2>
        Here you can:
        <ul>
            <li>keep track of your dives</li>
            <li>Check out the dive buddy finder: Browse the list of our members upcoming dives. Looking for a dive buddy?  upcoming trips</li>

            <li>keep track of your dives</li>
            <li>view others diving history</li>
            <li>browse dive spots (near you and around the world!)</li>
        </ul>



        <!--                <div class="outterContainerDiv"> This text is in the outside container.
                            <div class="clear"> </div>
                            <div class="innerContainerDiv"> This text is in the first inner container.
                                This text is in the first inner container.
                                This text is in the first inner container. </div>
                            <div class="innerContainerDiv"> This text is in the first inner container.
                                This text is in the first inner container.
                                This text is in the first inner container. </div>
                            <div class="innerContainerDiv"> This text is in the first inner container.
                                This text is in the first inner container.
                                This text is in the first inner container. </div>
                            <div class="innerContainerDiv"> This text is in the first inner container.
                                This text is in the first inner container.
                                This text is in the first inner container. </div>
                            <div class="innerContainerDiv"> This text is in the first inner container.
                                This text is in the first inner container.
                                This text is in the first inner container. </div>
                            <div class="clear"> </div>
                            This text is in the outside container. 
                            <div class="clear"> </div>
                                            <div class="newLine"></div>
                            <div class="centerText">
                                <div class="center">
                                    <img  src="images/padi.jpg"/>
                                </div>
                                Check out <a href="http://www.padi.com">PADI</a>'s web site for more info on SCUBA Diving
        
                            </div> 
                           
                        </div>  ends the columns  -->
        <%@ include file= "css-chooser.html" %> 
        <jsp:include page="post-content.jsp" />     


        <!-- http://localhost:8080/Kauffman_Lab3/index.jsp 
          cis-linux2.temple.edu       
        /var/lib/tomcat6/webapps/SP13_2308_tue65786
        
        -->
