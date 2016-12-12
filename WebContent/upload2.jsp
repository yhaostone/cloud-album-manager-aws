<html>

<%@ page import="java.io.*"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3Client"%>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata"%>
<%@ page import="com.amazonaws.services.s3.model.CannedAccessControlList"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="priv.yhao.album.*"%>

<%
      String saveFile = "";
      String contentType = request.getContentType();
      
      if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
    	  DataInputStream in = new DataInputStream(request.getInputStream());
          int formDataLength = request.getContentLength();
          byte dataBytes[] = new byte[formDataLength];
          int byteRead = 0;
          int totalBytesRead = 0;
          while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
          }
          String file = new String(dataBytes);
          saveFile = file.substring(file.indexOf("filename=\"") + 10);
          saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
          // get the file name of image
          saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
          int lastIndex = contentType.lastIndexOf("=");
          String boundary = contentType.substring(lastIndex + 1, contentType.length());
          int pos;
          pos = file.indexOf("filename=\"");
          pos = file.indexOf("\n", pos) + 1;
          pos = file.indexOf("\n", pos) + 1;
          pos = file.indexOf("\n", pos) + 1;
          int boundaryLocation = file.indexOf(boundary, pos) - 4;
          int startPos = ((file.substring(0, pos)).getBytes()).length;
          int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
          
		  // get the image's content in bytes        
          byte [] imageContents = Arrays.copyOfRange(dataBytes,startPos,endPos);
		  
          String bucket = "y.hao";
          // url to save in S3
          String fileName = "Album/" + saveFile;
          
          try {
              AmazonS3 client = new AmazonS3Client(new BasicAWSCredentials("AKIAJNG5DMOZ4GGR2W6A", "96BrLsiiBB8NRjNDQgLm1y9lll0wTU0+MZPZgCUP"));
              InputStream stream = new ByteArrayInputStream(imageContents);
              ObjectMetadata meta = new ObjectMetadata();
              meta.setContentLength(imageContents.length);
              // meta.setContentType("application/jpg");
              client.putObject(bucket, fileName, stream, meta);
              client.setObjectAcl(bucket, fileName, CannedAccessControlList.PublicRead);
          } catch (Exception ex) {
              System.out.println(ex);
          }
%>
<head>
</head>
<body>
<Br>
<table border="2">
      <tr>
            <td><b>You have successfully upload the file by the name of:</b>
            <%
                  out.println(saveFile);
                  }
            %>
            </td>
            <td>
            <input type="button" value="Continue Upload" onclick="window.location.href='index.jsp'">
            </td>
      </tr>
</table>
<br>
<form name="form">
<table border="2">
	<tr>
            <td><b>Describe this photo:</b></td>
            <td><input type="text" name="description" size="52">
            <input type="hidden" name="fileName" value="<%=saveFile%>"></td>
      
      	<td><input type="button" value="Save" onclick="saveDescription()">
      	</td>
      </tr>
</table>
</form>
</body>
<script type="text/jscript"> 
function saveDescription(){
	var description = document.form.description.value;
	var fileName = document.form.fileName.value;
	if(fileName!=null&&fileName.length>0){
		window.location.href= "saveDescription.jsp?fileName="+fileName+"&description="+decodeURI(description);
	}else{
		alert("File name cannot be null");
	}
}
</script>
</html>