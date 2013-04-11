</div> <!-- content -->
<%
String mobile = (String) session.getAttribute("mobile");
    String strMobile ="";
    if (mobile.equals("mobile")){
               strMobile = "<i>Mobile Site</i>";
    }
    String link = "<a style=\"color:blue;text-decoration: none;\" href='user-insert.jsp'> Register </a> / <a href='logon.jsp'> Log On </a> ";
    String user_Name = (String) session.getAttribute("userName");
    if(user_Name != null) {
        link = "Welcome " + user_Name + " <a \"color:blue;text-decoration: none;\" href ='logout.jsp'> Log Out </a >";
    }
%>
<div class="footer"><table style="width:95%;"><tr><td style="text-align: left;">Daniel Kauffman - copyright &copy;2011</td><td><%=strMobile%></td>
            <td style="text-align: right;"><%=link%></td></tr></table> </div>
</div> <!-- finishes off the container div -->
</body>
</html>
