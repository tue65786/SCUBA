<%

    boolean loggedIn = false;
    boolean isAdmin = false;
    String user_Name = (String) session.getAttribute("userName");
    String user_Role = (String) session.getAttribute("userRole");
    if(user_Name != null) {
        loggedIn = true;
        if(user_Role.equalsIgnoreCase("admin")) {
            isAdmin = true;
        }
    }
%>
<div class="container">
    <div class="title">
        <div style="float: right; border:8px dashed white;
             outline:5px solid red;
             outline-offset:3px 2px; margin-bottom:20px;">
            <h1>SCUBA Diver Log</h1></div>
        <div class="newLine"></div>
        <div style=" white-space:  nowrap; ">
            <div id="Home" class="tab"><a href="index.jsp">Home</a></div>
            <div id="Locations" class="tab"><a href="other.jsp">Locations</a></div>
            <div id="Log" class="tab"><a href="assoc.jsp">Log</a></div>
            <div id="Contact"  class="tab"><a href="contact.jsp">Contact Us</a></div>
            <div id="UserList"  class="tab menu">Users
                <a  id="UserList" style="color: red;" href="user.jsp">List</a>
                <a id="serInsert" style="color: red;" href="user-insert.jsp">Register</a>
            </div>
            <div id="Labs" class="tab menu">  Labs
                <a style="color: red;" href="lab4.jsp">Lab 4</a>
                <a style="color: red;" href="lab5.jsp">Lab 5</a>
                <a style="color: red;" href="testSelect.jsp">Test Select</a>

            </div> </div>
        <div class="newLine"></div>
    </div>  <!-- finishes off the title div -->
    <div class="content selected">
        <div id="crumbs"></div>
