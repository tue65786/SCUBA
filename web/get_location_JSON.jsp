<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="SQL.*"%>
<%@page language="java" import="model.DiveLocations.*"%>

<%
            String webUserId = request.getParameter("primaryKey");
            StringData sd = new StringData();// all properties empty
           // Validate wuValidate = new Validate(); // all error messages empty
            DbConn dbc = new DbConn();  // get an OPEN db connection. 
            String dbError = dbc.getErr();
            if (dbError.length() != 0) { // could not get connection
                sd.setRecordStatus("Database connection error in get_location_JSON.jsp: " + dbError); 
            } else { // got connection
                   DiveLocationsMods sqlMods = new DiveLocationsMods(dbc);
                //SqlPrep wuSqlPrep = new SqlPrep();
                sd = sqlMods.findByUserId(dbc,webUserId);
                if (sd == null) {
                    sd.setRecordStatus("get_location_JSON.jsp. Problem finding record with id "+webUserId+": " + sqlMods.getErrorMsg());
                } else {
                    sd.setRecordStatus ("If found, fields have values. If not found, all fields are empty string."); // wu.toString(); 
                }
            }
            out.print(sd.toJSON());
%>
