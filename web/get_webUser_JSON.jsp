<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="SQL.*"%>
<%@page language="java" import="model.WebUser.*"%>

<%
            String webUserId = request.getParameter("primaryKey");
            StringData wuStringData = new StringData();// all properties empty
           // Validate wuValidate = new Validate(); // all error messages empty
            DbConn dbc = new DbConn();  // get an OPEN db connection. 
            String dbError = dbc.getErr();
            if (dbError.length() != 0) { // could not get connection
                wuStringData.setRecordStatus("Database connection error in getWebUser.jsp: " + dbError); 
            } else { // got connection
                  WebUserMods sqlMods = new WebUserMods(dbc);
                //SqlPrep wuSqlPrep = new SqlPrep();
                wuStringData = sqlMods.findByUserId(dbc,webUserId);
                if (wuStringData == null) {
                    wuStringData.setRecordStatus("get_webUser.JSON.jsp. Problem finding record with id "+webUserId+": " + sqlMods.getErrorMsg());
                } else {
                    wuStringData.setRecordStatus ("If found, fields have values. If not found, all fields are empty string."); // wu.toString(); 
                }
            }
            out.print(wuStringData.toJSON());
%>
