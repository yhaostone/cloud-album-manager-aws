package priv.yhao.album.model;

import java.sql.*;

public class PhotoModel {

	/**
	 * insert description to database
	 * @param photoName
	 * @param description
	 * @return
	 */
	public int saveDescription(String photoName, String description){
		int i=0;
		String sql = "insert into description (photoName,description) values(?,?) ";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://yhao.c8zjbixrssjy.ap-southeast-2.rds.amazonaws.com/ALBUM?user=yhao&password=100026051");
			
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, photoName);
			pstmt.setString(2, description);
			
			i = pstmt.executeUpdate();
	        pstmt.close();
	        conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}
	
}
