package mypage.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mypage.model.vo.ReviewImage;

public class ReviewDao {

	public ArrayList<ReviewImage> selectRImage(Connection con, int listNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<ReviewImage> listRImage = null;
		
		String query = "select * from store join review using(store_id) join review_image using(list_no) where LIST_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, listNo);
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					listRImage = new ArrayList<ReviewImage>();
					flag = false;
				}
				ReviewImage RI = new ReviewImage();
				
				RI.setListNo(rset.getInt("list_no"));
				RI.setOriginPhoto1(rset.getString("ORIGINAL_PHOTO1"));
				RI.setRenamePhoto1(rset.getString("RENAME_PHOTO1"));
				RI.setOriginPhoto2(rset.getString("ORIGINAL_PHOTO2"));
				RI.setRenamePhoto2(rset.getString("RENAME_PHOTO2"));
				RI.setOriginPhoto3(rset.getString("ORIGINAL_PHOTO3"));
				RI.setRenamePhoto3(rset.getString("RENAME_PHOTO3"));
				RI.setOriginPhoto4(rset.getString("ORIGINAL_PHOTO4"));
				RI.setRenamePhoto4(rset.getString("RENAME_PHOTO4"));
				RI.setOriginPhoto5(rset.getString("ORIGINAL_PHOTO5"));
				RI.setRenamePhoto5(rset.getString("RENAME_PHOTO5"));
				
				listRImage.add(RI);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listRImage;
	}

}
