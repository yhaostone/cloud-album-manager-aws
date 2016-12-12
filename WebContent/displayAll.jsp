<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.amazonaws.auth.AWSCredentials"%>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3Client"%>
<%@ page import="com.amazonaws.services.s3.model.GeneratePresignedUrlRequest"%>
<%@ page import="com.amazonaws.services.s3.model.Bucket"%>
<%@ page import="com.amazonaws.services.s3.model.ObjectListing"%>
<%@ page import="com.amazonaws.services.s3.model.S3ObjectSummary"%>
<%@ page import="com.amazonaws.util.StringUtils"%>
<%@ page import="com.amazonaws.auth.AWSCredentials"%>
<%@ page import="com.amazonaws.auth.AWSCredentials"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display All Photos</title>
</head>
<body>
	<input type="button" value="Back" onclick="window.location.href='index.jsp'"><br><br>
	<%
		String accessKey = "AKIAJNG5DMOZ4GGR2W6A";
		String secretKey = "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";
	
		AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
		
		// create connection to AWS S3
		AmazonS3 conn = new AmazonS3Client(credentials);
		
		// get objects in bucket named "y.hao"
		ObjectListing objects = conn.listObjects("y.hao");
		
		int i=0;
		do {
			%>
			<table border="1">	
				<tr height="40px">
					<td align="center">No.</td>
					<td align="center">Photo Name</td>
					<td align="center">View</td>
					<td align="center" width="300">Description</td>
				</tr>	
			<%
	        for (S3ObjectSummary objectSummary : objects.getObjectSummaries()) {
                if(i!=0){
                	String photoURL = "https://s3-ap-southeast-2.amazonaws.com/y.hao/" +objectSummary.getKey();
                	String key = objectSummary.getKey();
                	String fileName = key.substring(key.indexOf("/")+1);
                	String description = "------";
                	Class.forName("com.mysql.jdbc.Driver");
               	    Connection con=java.sql.DriverManager.getConnection("jdbc:mysql://yhao.c8zjbixrssjy.ap-southeast-2.rds.amazonaws.com/ALBUM?user=yhao&password=100026051");
               	 	String sql = "select * from description where photoName = ?";
               	    PreparedStatement ps=con.prepareStatement(sql);
                 	ps.setString(1, fileName);
                 	ResultSet rs=ps.executeQuery();
                    while(rs.next()){
                    	description = rs.getString("description");
                    }
                    rs.close();
                    ps.close();
                    con.close();
                    
                    %>
                    <tr>
                    	<td width="30" align="center">
                    		<%=i %>.
                    	</td>
                    	<td width="200" align="center">
                    		<%=key%>
                    	</td>
                    	<td>
                    		<img src="<%=photoURL%>" height="200" width="300" />
                    	</td>
                    	<td align="center">
                    		<%=description%>
                    	</td>
                    </tr>
                    <%
                }
                i++;    
	        }
			%>
			</table>
			<%
	        objects = conn.listNextBatchOfObjects(objects);
		} while (objects.isTruncated());	
	%>
</body>
</html>