<%-- 6
    Document   : Contact Us
    Created on : Feb 6, 2013, 11:21:10 AM
    Author     : tue65786 
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <script src="js/myscript.js" type="text/javascript"></script>
        <script src="./js/datetimepicker_css.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCUBA - Contact Us</title>

    </head>
    <body onload="setSelectedTab('Contact');">
        <%@ include file= "pre-content.html" %> 

        <form>
            <fieldset>          
                <legend>Please take a moment to let us know how were doing!</legend>

                <p><label class="lbl" for="subject">Subject:</label><select  name="subject" size="1" class="field-300">
                        <option value="General Inquiry" selected="selected">General Inquiry</option>
                        <option value="Your_Account">Your Account</option>
                        <option value="Looking for a Dive Buddy">Looking for a Dive Buddy</option>
                        <option value="Something Else">Something Else</option>
                    </select>
                </p>
                <p><label class="lbl" for="name">Your Name</label><input type="text" class="field-300" name="name"/></p>
                <p><label class="lbl" for="email">Your Email</label><input type="text" class="field-300" name="email"/></p>
                <p><label class="lbl" for=""></label><input type="text" class="field-300" name=""/></p>
                <p>
                  <label class="field-multi-choice-input" for="US-SoEa">Where do you do most of your diving?</label>
                    <span class="form-group">
                    <span class="multichoice"><input type="checkbox" name="US-SoEa" value=""/> South Eastern US</span>
                    <span class="multichoice"><input type="checkbox" name="US-West" value="US-West"/>West Coast US</span>
                    <span class="multichoice"><input type="checkbox" name="US-Inland" value="US-Inlind"/>Inlandt US</span>
                </span>
                </p>
                <p>
                    <label class="field-multi-choice-input" for="howoften">How often do you dive?</label>

<!--                    TODO: Switch Multichoice fiekds to table-->

                <div class="form-group">
                     <span class="multichoice"><input type="radio" name="Never" group="howoften" value="Never been" /><label  for="Never">Never been</label></span>
                     <span class="multichoice"><input type="radio" name="Never" group="howoften" value="Less than once a year" /><label for="InsertRecordInternal_Comments1">Less 
                        than once a year</label></span>
                     <span class="multichoice"><input type="radio" name="Yearly" group="howoften"  value="Atleast Once A Year" /><label for="InsertRecordInternal_Comments2">Atleast 
                        Once A Year</label></span>
                     <span class="multichoice"><input type="radio" name="Often" group="howoften" value="Couple times a year" /><label for="InsertRecordInternal_Comments3">Couple 
                        times a year</label></span>
                     <span class="multichoice"><input type="radio" name="Regularly" group="howoften" value="Couple times a month" /><label for="Regularly">Couple 
                             times a month</label></span>
                </div>
                </p>
                <p>
                    <label for="date">Please enter a date here &gt;&gt; </label>
                    <input type="Text" id="date" class="field-300" onfocus="NewCssCal('date','yyyyMMdd','','','','','past');blur()"/>
                    <img src="images/images2/cal.gif" onclick="NewCssCal('date','yyyyMMdd','','','','','past')" style="cursor:pointer"/>
                </p>
                <p><label for="comments">Comments</label>
                    <textarea type="textarea" class="field-300"  
                     rows="4" maxlength="4000" name="comments"  />
                    >
                 
                    <input type="checkbox" name="InsertRecordNewsletter" value="PADI" />PADI
                <td colspan="2" class="cbFormFieldCell">
                    <span class="cbFormData">
                        <input type="checkbox" name="InsertRecordLast_Name" id="InsertRecordLast_Name" value="NAUI" /> 
                        NAUI</span></td>
                </tr>
                </table>

            </fieldset>







        </form>







        <form name="go" id="go" onsubmit="converturl();location.href=fullurl.value;return false">
            <fieldset id="personal">
                <legend>Canvasser Results</legend>
                <i>How?</i><ol>
                    <li><u>Login to votebuilder</u>: In a separate tab, login to votebuilder and click 
                    on the <b>my campaign tab</b> </li>
                    <li><u>Canvasser</u>: Select name from dropdown list.</li>
                    <li><u>Date</u>: Click calendar icon to choose date.</li>
                    <li><u>Done</u>! Click GO! </li>
                </ol>
                <input name="url" type="hidden" value="votebuilder.com/CanvassResultsDailyLogList.aspx" title="read only" />
                <table>
                    <tr>
                        <td>
                            <select name="canvasser" style="width:90%" id="canvasser" onchange="updateTB()">
                                <option selected="selected" value>&lt;select a canvasser&gt;</option>
                                <option value="">Jim R</option>
                                <option value="">Jed G</option>
                                <option value="">Harriet K</option>
                                <option value="">Carol M</option>
                                <option value="">Craig O</option>
                                <option value="">Dan K</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="lname">Last name : </label>
                            <input name="lname" type="text" id="lname" onfocus="getValue(this)" onblur="setValue(this)" /></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="fname">First name : </label>
                            <input name="fname" type="text" onfocus="getValue(this)" onblur="setValue(this)" /></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cid">CvID : </label>
                            <input name="cid" id="cid" type="text" onfocus="getValue(this)" onblur="setValue(this)" /></td>
                    </tr>
                    <tr>
                        <td>
                            <!--                                <label for="demo2">Date: (click_icon) </label>
                                                            <input id="demo2" name="demo2" readonly="readonly" type="text" size="25" /><a href="javascript:NewCal('demo2','mmddyyyy')"><img src="cal.gif" width="22" align="texttop" height="22" border="0" alt="Pick a date" />-->

                            <label for="demo1">Please enter a date here &gt;&gt; </label>
                            <input type="Text" id="demo1" maxlength="25" size="25" onfocus="NewCssCal('demo1','yyyyMMdd','','','','','past');blur()"/>
                            <img src="images/images2/cal.gif" onclick="NewCssCal('demo1','yyyyMMdd','','','','','past')" style="cursor:pointer"/>




                            </a>
                        </td>
                    </tr>
                </table>
                <input name="fullurl" type="hidden" />
                <div style="float:right; padding-right:50px;">
                    <input type="submit" id="go" value=" Go " /> </div>
            </fieldset>
        </form>
    </div>

    <%@ include file= "post-content.html" %> 
    <!-- Master page contains div tags: JUST ENTER CONTENT!-->