<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="view.WebUserView" %>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ include file= "head-content.html" %> 
        <script src="js/datetimepicker_css.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Search</title>
        <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>

        <script type="text/javascript">
	
            $(document).ready( function() {
                $("input").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("input").blur(function () {
                    $(this).css("background-color", "#FFF");
                });
        
                $("select").focus(function () {
                    $(this).css("background-color", "#FFFFCC");
                });
                $("select").blur(function () {
                    $(this).css("background-color", "#FFF");
                });
                // When site loaded, load the Popupbox First
                //loadPopupBox();
	
                $('#popupBoxClose').click( function() {			
                    unloadPopupBox();
                });
		
                $('#load').click( function() {
                    loadPopupBox();
                });
                $('#tryagain').click( function() {
                    loadPopupBox();
                });
            
                $('.updateImg').click( function() {
                    loadPopupBox();
                });

                //                function checkPopUpBox() {
                //                    if (document.getElementById("showInputArea").value == "YES")
                //                        {
                //                            loadPopUpBox();
                //                        }
                //                    
                //                }
                function unloadPopupBox() {	// TO Unload the Popupbox
                    $('#popup_box').fadeOut("slow");
                    //			$("#outcontainer").css({ // this is just for style		
                    //				"opacity": "1"
                    //			}); 
                    $('#outcontainer').hide();  
                }	
		
                function loadPopupBox() {	// To Load the Popupbox
                    $('#popup_box').fadeIn("slow");
                    $('#outcontainer').show();  
                    //                  $("#outcontainer").css({ // this is just for style
                    //				"opacity": ".3"  
			
                    //              });              
                }
                /**********************************************************/
		
            });
        </script>


    </head>
    <body onload="setSelectedTab('Search');">

        <jsp:include page="pre-content.jsp" /> 

        <div style="margin:auto ; padding-bottom:50px;">
            <h1>Filter Dive Log</h1>
            <div class="newLine"></div>

            <table border="0" width="100%">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        By User
                    </td>
                    <td>
                    </td>
                    <td>
                       By Location
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <select size="1" name="D1"></select>
                    </td>
                    <td>
                    </td>
                    <td>
                        <select size="1" name="D2"></select></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        <span style="text-align: center">Date Range</span></td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        First Date</td>
                    <td>
                    </td>
                    <td>
                        Last Date</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <input type="text" name="T1" size="20">
                    </td>
                    <td>
                    </td>
                    <td>
                        <input type="text" name="T2" size="20"></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        <span style="text-align:right">Sort By</span>
                    </td>
                    <td>
                        <select name="SortBy">
                            <option>Date</option>
                            <option>Location</option>
                            <option>User</option>
                            <option>City</option>
                            <option>State</option>
                            <option>Type</option>
                        </select></td>
                    <td>
                    </td>
                    <td style="text-align:  right">
                        <input type="submit" value="Search" name="Search" />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        <span style="text-align:  center; font-weight: bold;text-decoration:  underline;  ">Results</span></td>
                    <td style="text-align:  right">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    
                    <td colspan="5">
                        <div style="border-top: gray dashed 2px"></div>
                    </td>
                 
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <%@ include file= "css-chooser.html" %> 
            <jsp:include page="post-content.jsp" />    
            <!-- Master page contains div tags: JUST ENTER CONTENT!-->