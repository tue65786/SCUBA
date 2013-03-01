/* x
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 
function setSelectedTab(elementId) {
    //Breadcrumbs
    if (elementId == "Labs")
    {
        document.getElementById(elementId).className = "tab menu selected";
    }
    else
    {
        document.getElementById(elementId).className = "tab selected";
    }   
    var htmlCrumbs = null;  
    var refHome = '> <a href="index.jsp">Home</a>  ';
    
    
    switch (elementId) {
        case "Home" :
            htmlCrumbs = '> Home';
            break;
        //diver will be a drop down menu. so will need to append breadcrumbs.
        case "Contact" :
            htmlCrumbs = refHome +  " >" +  elementId + "Contact Us" ;            
            break; 
        case "UserList" :
            htmlCrumbs = refHome +  " >" +  elementId + "Members" ;            
        default:
            htmlCrumbs = refHome +  " >" +  elementId;
    }//eo switch
    document.getElementById("crumbs").innerHTML =  htmlCrumbs;
    
    //Set CSS File
    var style;
    style = readCookie("cssFile");
    if(style==null){
        style = "css/main.css";
    }
    changeStyle(style);
    return;
}



// Cookies
function createCookie(name,value,days) {
    // alert ("Creating a cookie with name "+name+" and value "+value+" that will last "+days+ " days");
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}
function showCookie(name) {
    var cookieVal = readCookie(name);
    if (cookieVal == null) {
        alert ("No cookie value was stored with name " + name);
    } else {
        alert ("The cookie named " + name + " has value " + cookieVal);
    }
}

function changeStyle(choice) {
    eraseCookie("cssFile");
    createCookie("cssFile",choice,30);
    document.getElementById('cssLinkID').href = choice;
    //Sets Dropdownlist
    switch (choice) {
        case "css/main.css" :
            document.getElementById('mainCSS').selected = true;
            break;
        case "css/dark.css" :
            document.getElementById('darkCSS').selected = true;
            break;
        case "css/light.css" :
            document.getElementById('lightCSS').selected = true;
            break;
    }
}
