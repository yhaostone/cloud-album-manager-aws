<%@ page import="java.io.*"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3Client"%>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata"%>
<%@ page import="com.amazonaws.services.s3.model.CannedAccessControlList"%>
<%@ page import="javax.servlet.*" %>
<%@ page import ="java.awt.image.BufferedImage"%>
<%@ page import ="java.io.ByteArrayOutputStream"%>
<%@ page import ="javax.imageio.ImageIO"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
	String contentType = request.getContentType();
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
 	   	// Create a new file upload handler
 	   	ServletFileUpload upload = new ServletFileUpload(factory);
 	   	try{ 
      		// Get file items from request
 	      	List fileItems = upload.parseRequest(request);
 	      	// Process the uploaded file items
 	      	Iterator i = fileItems.iterator();
   			while (i.hasNext()){
 	         	FileItem fi = (FileItem)i.next();
 	         	if (!fi.isFormField ()){
 	         		// Get the uploaded file name
 	         		String fileName = fi.getName();   
 	         		
 	         		System.out.println("fileName1="+fileName);
 	         		
 	         		int index = fileName.lastIndexOf("\\");
 	               if(index != -1) {
 	            	  fileName = fileName.substring(index + 1);
 	               }
 	              System.out.println("fileName2="+fileName);
 	         		// String savepath = this.getServletContext().getRealPath("/Album");
 	         		String savepath=request.getSession().getServletContext().getRealPath("/Album");
 	         		System.out.println("savepath="+savepath);
 	         		// String savePath = ServletActionContext.getServletContext().getRealPath("");
		         	// Convert file into byte
		    	  	BufferedImage originalImage = ImageIO.read(new File(fileName));
		         	
		         	// http://stackoverflow.com/questions/12048848/eclipse-bug-javax-imageio-iioexception-cant-read-input-file
		    	  	// BufferedImage originalImage2 = ImageIO.read(this.getClass().getResource(fileName));
		    	  	
		    	  	
		    	  	ByteArrayOutputStream output = new ByteArrayOutputStream();
		    		ImageIO.write( originalImage, "jpg", output );
		    		output.flush();
		    		byte[] imageInByte = output.toByteArray();
		            String bucket = "y.hao";
		            // Set file name saved in S3
		            fileName="Album/"+fileName.substring( fileName.lastIndexOf("\\")+1);
		            try {
		                AmazonS3 client = new AmazonS3Client(new BasicAWSCredentials("AKIAJNG5DMOZ4GGR2W6A", "96BrLsiiBB8NRjNDQgLm1y9lll0wTU0+MZPZgCUP"));
		                InputStream stream = new ByteArrayInputStream(imageInByte);
		                ObjectMetadata meta = new ObjectMetadata();
		                meta.setContentLength(imageInByte.length);
		                meta.setContentType("image/jpg");
		                client.putObject(bucket, fileName, stream, meta);
		                client.setObjectAcl(bucket, fileName, CannedAccessControlList.PublicRead);
		            } catch (Exception ex) {
		                System.out.println(ex);
		            }
         		}
 	       }
 	    }catch(Exception ex) {
 	       System.out.println(ex);
 	       %>
 	       <table border="2">
			      <tr>
			            <td><b>The file you want to upload is not a image.</b>
			            </td>
			            <td>
			            <input type="button" value="Back to Upload" onclick="window.location.href='index.jsp'">
			            </td>
			      </tr>
			</table>
 	       <%
 	       return;
 	    }
 	 }
%>
<Br>
<table border="2">
      <tr>
            <td><b>You have successfully upload the image.</b>

            </td>
            <td>
            <input type="button" value="Continue Upload" onclick="window.location.href='index.jsp'">
            </td>
      </tr>
</table>