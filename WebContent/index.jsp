<HTML>
<HEAD>
<TITLE>Display photo upload form to the user</TITLE>
</HEAD>
<BODY>
<FORM ENCTYPE="multipart/form-data" ACTION="upload2.jsp" METHOD="post">
<br>
<br>
<br>
<table border="0" bgcolor=#AAAAFF align="center">
      <tr>
            <td colspan="2" align="center"><B>Photo Upload</B>
            </td>
      </tr>
      <tr>
            <td colspan="2" align="center"></td>
      </tr>
      <tr>
            <td><b>Choose the photo to upload:</b></td>
            <td><INPUT NAME="file" TYPE="file"></td>
      </tr>
      <tr>
            <td colspan="2" align="center"></td>
      </tr>
      <tr>
            <td colspan="2" align="center">
            	<input type="submit" value="Submit" onclick="saveDescription();window.location.href='upload2.jsp?description=123'">
           	</td>
      </tr>
      <table>
            </FORM>
            <br>
      <table border="0" bgcolor=#AAAAFF align="center">
      	<tr>
      		<td colspan="2" align="left">
      			<input type="button" value="Display All Photos" onclick="window.location.href='displayAll.jsp'">
      		</td>
      	</tr>
      </table>
</BODY>

</HTML>