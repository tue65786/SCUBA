<%-- 6
637647

    Document   : Contact Us
    Created on : Feb 6, 2013, 11:21:10 AM
    Author     : tue65786 
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="js/myscript.js" type="text/javascript" ></script>
        <link id ="cssLinkID" href="css/main.css" rel="stylesheet" type="text/css" /> 
        <script src="js/datetimepicker_css.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Contact Us</title>

    </head>
    <body onload="setSelectedTab('Diver');">
        <%@ include file= "pre-content.html" %> 
        <form name="contact" method="post" action="http://www.temple.edu/cgi-bin/mail?tue65786@temple.edu">
            <fieldset>          
                <legend>Please take a moment to let us know how were doing!</legend>
                <table>
                    <tr><td align="right"><label class="lbl" for="subject">Subject:</label></td><td><select  name="subject" size="1" class="field-300">
                                <option value="General Inquiry" selected="selected">General Inquiry</option>
                                <option value="Your_Account">Your Account</option>
                                <option value="Looking for a Dive Buddy">Looking for a Dive Buddy</option>
                                <option value="Something Else">Something Else</option>
                            </select>
                        </td></tr>
                    <tr><td align="right"><label class="lbl" for="name">Your Name</label></td><td><input type="text" class="field-300" name="name"/></td></tr>
                    <tr><td align="right"><label class="lbl" for="email">Your Email</label><td><input type="text" class="field-300" name="email"/></td></tr>
                    <tr><td align="right">
                            <label class="lbl" for="US-SoEa">Where do you do most of your diving?</label>
                        </td><td><span class="form-group">
                                <span class="multichoice"><input type="checkbox" name="US-SoEa" value=""/> South Eastern US</span>
                                <span class="multichoice"><input type="checkbox" name="US-West" value="US-West"/>West Coast US</span>
                                <span class="multichoice"><input type="checkbox" name="US-Inland" value="US-Inlind"/>Inland US</span>
                            </span>
                        </td></tr>
                    <tr><td align="right">
                            <label class="lbl" id="howoften">How often did you dive last year?</label>
                        </td>
                        <td>

                            <span class="multichoice"><input type="radio" name="freq"  value="Never been" /><label for="Never">Never been</label></span>
                            <span class="multichoice"><input type="radio" name="freq" value="Less than once a year" /><label for"">&lt; 1</label></span>
                            <span class="multichoice"><input type="radio" name="freq"   value="Atleast Once A Year" /><label for="">1-2</label></span>
                            <span class="multichoice"><input type="radio" name="freq"  value="Couple times a year" /><label for="Often"> 3+ </label></span> 
                        </td></tr>

                    <tr><td align="right"><label for="date" class="lbl">When is your next trip? (click button))</label></td><td>
                            <input type="Text" id="date" class="field-300" onfocus="NewCssCal('date','yyyyMMdd','','','','','past');blur()"/>
                            <img src="images/images2/cal.gif"" alt="C;ick to set date" onclick="NewCssCal('date','yyyyMMdd','','','','','past')" style="cursor:pointer"/>
                        </td></tr>

                    <tr><td colspan=2>
                            <!--                <p style="margin: 1em 0;s"/>-->
                            <textarea type="textarea" class="field-500" rows="6" cols="60" maxlength="4000" name="comments"></textarea>
                        </td>
                    </tr>

                    <tr><td align="right">
                            <input type="submit" value="Submit" name=syb"></td></tr></table>
            </fieldset>


        </form>
        <%@ include file= "css-chooser.html" %> 
        <%@ include file= "post-content.html" %> 
        <!-- Master page contains div tags: JUST ENTER CONTENT!-->