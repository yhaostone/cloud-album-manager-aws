<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Save description</title>
</head>
<% 
	String params = request.getQueryString();
	String photoName = params.substring(params.indexOf("fileName=")+9,params.indexOf("&description="));
	String description = params.substring(params.indexOf("&description=")+13);
	priv.yhao.album.action.PhotoActions pa = new priv.yhao.album.action.PhotoActions();
	int i = pa.saveDescription(photoName, description);
%>

<body>
<%if(i==1){ %>
	Description Saved Successfully!
<%}else{%>
	Sorry. Fail to Save Description.
<%} %>
<input type="button" value="Back to main page" onclick="window.location.href='index.jsp'"><br>
</body>
</html>