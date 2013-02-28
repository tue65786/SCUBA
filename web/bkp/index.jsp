<%-- 
    Document   : index
    Created on : Feb 6, 2013, 11:21:10 AM
    Author     : tue65786 
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <script src="js/myscript.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA</title>
      
    </head>
    <body onload="setSelectedTab('log')">
        <div class="container">
            <div class="title">
                <h1>SCUBA Diver Log</h1>
                <div class="newLine"></div>
                <div id="home" class="tab selected "><a href="index.jsp">Home</a></div>
                <div id="sites" class="tab"><a href="tab2page.html">Tab 2</a></div>
                <div id="divers"  class="tab"><a href="tab3page.html">Tab 3</a></div>
                <div id="log"  class="tab"><a href="tab4page.html">Tab 4</a></div>
<!--                TODO re: css challenge move log tab under divers -->
                <div class="newLine"></div>
            </div>  <!-- finishes off the title div -->
            <div class="content selected">
                <p>
                <h2>Welcome to the SCUBA Dive Log web site!</h2>
                </p>
                Here you can:
                <ul>
                    <li>keep track of your dives</li>
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
            </div> <!-- content -->
            <div class="footer">Daniel Kauffman - copyright &copy;2011</div>
        </div> <!-- finishes off the container div -->

    </body>
</html>

<!-- http://localhost:8080/Kauffman_Lab3/index.jsp 
  cis-linux2.temple.edu       
/var/lib/tomcat6/webapps/SP13_2308_tue65786

-->
