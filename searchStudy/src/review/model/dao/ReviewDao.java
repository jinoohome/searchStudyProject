package review.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import review.model.vo.Review;
import review.model.vo.ReviewImage;

import static common.JDBCTemplate.*;

public class ReviewDao {
	public ReviewDao(){}
	
	public ArrayList<Review> selectReview(Connection con, String storeId, Review review) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Review> list = null;
		
		String query = "select * from review where store_id = ?";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				list = new ArrayList<Review>();
				flag = false;
			}
			Review r = new Review();
			r.setListNo(rset.getInt("list_no"));
			r.setStoreId(rset.getString("store_id"));
			r.setNickName(rset.getString("nickname"));
			r.setEnrollDate(rset.getDate("enroll_date"));
			r.setScore(rset.getInt("score"));
			r.setContents(rset.getString("contents"));
			
			list.add(r);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int addReview(Connection con, Review review) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into review " + "values(SEQ_LIST_NO.NEXTVAL, ?, ?, sysdate, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, review.getStoreId());
			pstmt.setString(2, review.getNickName());
			pstmt.setDouble(3, review.getScore());
			pstmt.setString(4, review.getContents());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Review> selectReview(Connection con, String storeId) {
		PreparedStatement pstmt = null;
		ArrayList<Review> list = null;
		ResultSet rset = null;
		
		String query = "select * from review where store_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Review>();
					flag = false;
				}
				
				Review r = new Review();
				r.setListNo(rset.getInt("list_no"));
				r.setStoreId(rset.getString("store_id"));
				r.setNickName(rset.getString("nickname"));
				r.setEnrollDate(rset.getDate("enroll_date"));
				r.setScore(rset.getDouble("score"));
				r.setContents(rset.getString("contents"));
				
				list.add(r);
			}
			System.out.println("----------------------------------------------------------------------------");
			System.out.println("----------------------------------------------------------------------------");
			/*System.out.println("review list size : " + list.size());*/
			/*if(list !=null){
			for(Review r : list){
				System.out.println(r);
			}}
			*/
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int selectListNo(Connection con, String nickName) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int listNo = 0;
		String query = 
				"select list_no from (select list_no, store_id, nickname, enroll_date, rank() over(order by enroll_date desc) as rank "
									+ "from review where nickname = ?) "
				+ "where rank = 1";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nickName);
			rset = pstmt.executeQuery();
			while(rset.next()){
				listNo = Integer.parseInt(rset.getString("list_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listNo;
	}

	public int addReviewImage(Connection con, ReviewImage reviewimage) {
		PreparedStatement pstmt = null;
		int result = 0;
		System.out.println("111111reviewimage"+reviewimage.getListNo());
		String query = "insert into review_image " + "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewimage.getListNo());
			pstmt.setString(2, reviewimage.getOriginPhoto1());
			pstmt.setString(3, reviewimage.getRenamePhoto1());
			pstmt.setString(4, reviewimage.getOriginPhoto2());
			pstmt.setString(5, reviewimage.getRenamePhoto2());
			pstmt.setString(6, reviewimage.getOriginPhoto3());
			pstmt.setString(7, reviewimage.getRenamePhoto3());
			pstmt.setString(8, reviewimage.getOriginPhoto4());
			pstmt.setString(9, reviewimage.getRenamePhoto4());
			pstmt.setString(10, reviewimage.getOriginPhoto5());
			pstmt.setString(11, reviewimage.getRenamePhoto5());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<ReviewImage> selectRImage(Connection con, String storeId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<ReviewImage> listRImage = null;
		
		String query = "select * from store join review using(store_id) join review_image using(list_no) where store_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
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
			
			System.out.println("----------------------------------------------------------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listRImage;
	}

	public int DeleteReview(Connection con, String listNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete "
				+ "		from review "
				+ "		where list_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, listNo);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	//리뷰 수정(업데이트) 기능 보류.
	public int UpdateReview(Connection con, int listNo) {
		int result = 0;
		return result;
	}

	//해당하는 storeId 전체 리뷰 카운트
	public int getListCount(Connection con, String storeId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int listRCount = 0;
		String query = "select count(*) from (select * from review where store_id = ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			rset = pstmt.executeQuery();
			
			if(rset.next())
				listRCount = rset.getInt(1); //select 한 첫번째 항목값
				System.out.println("storeId " + storeId + "에 해당하는 전체 리뷰 갯수 : " + listRCount);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listRCount;
	}

	public ArrayList<Review> searchReviewInfo(Connection con, String storeId, int limit, int currentPage) {
		ArrayList<Review> reviewPageList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * "
				+ "		from (select rownum rnum, list_no, store_id, nickname, enroll_date, score, contents "
				+ "			  from (select * "
				+ "					from review "
				+ "					where store_id = ? "
				+ "					order by list_no desc)) "
				+ "		where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * 5 + 1; // 읽기 시작할 row 번호
		int endRow = startRow + limit - 1; //읽을 마지막  row 번호
		System.out.println("dao startRow : "+startRow);
		System.out.println("dao endRow : "+endRow);
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					reviewPageList = new ArrayList<Review>();
					flag = false;
				}
				Review r = new Review();
				r.setListNo(rset.getInt("list_no"));
				r.setStoreId(rset.getString("store_id"));
				r.setNickName(rset.getString("nickname"));
				r.setEnrollDate(rset.getDate("enroll_date"));
				r.setScore(rset.getDouble("score"));
				r.setContents(rset.getString("contents"));
				
				System.out.println("22222222222222222222222222 : " + r.toString());
				reviewPageList.add(r);
					
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return reviewPageList;
	}

	public ArrayList<ReviewImage> searchReviewImageInfo(Connection con, String storeId, int limit, int currentPage) {
		ArrayList<ReviewImage> reviewImagePageList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * "
				+ "		from (select rownum rnum, list_no, ORIGINAL_PHOTO1, RENAME_PHOTO1, ORIGINAL_PHOTO2, RENAME_PHOTO2, ORIGINAL_PHOTO3, RENAME_PHOTO3, ORIGINAL_PHOTO4, RENAME_PHOTO4, ORIGINAL_PHOTO5, RENAME_PHOTO5 "
				+ "			  from (select * "
				+ "					from store "
				+ "					join review using (store_id) "
				+ "					join review_image using (list_no) "
				+ "					where store_id = ? "
				+ "					order by list_no desc)) "
				+ "		where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * 5 + 1; // 읽기 시작할 row 번호
		int endRow = startRow + limit - 1; //읽을 마지막  row 번호
		System.out.println("dao startRow : "+startRow);
		System.out.println("dao endRow : "+endRow);
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			rset = pstmt.executeQuery();
			System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
			boolean flag = true;
			while(rset.next()){
				System.out.println("dddddddddddddddddd : " + rset.getBoolean(1));
				if(flag == true){
					reviewImagePageList = new ArrayList<ReviewImage>();
					flag = false;
				}
				ReviewImage r = new ReviewImage();
				r.setListNo(rset.getInt("list_no"));
				r.setOriginPhoto1(rset.getString("ORIGINAL_PHOTO1"));
				r.setRenamePhoto1(rset.getString("RENAME_PHOTO1"));
				r.setOriginPhoto2(rset.getString("ORIGINAL_PHOTO2"));
				r.setRenamePhoto2(rset.getString("RENAME_PHOTO2"));
				r.setOriginPhoto3(rset.getString("ORIGINAL_PHOTO3"));
				r.setRenamePhoto3(rset.getString("RENAME_PHOTO3"));
				r.setOriginPhoto4(rset.getString("ORIGINAL_PHOTO4"));
				r.setRenamePhoto4(rset.getString("RENAME_PHOTO4"));
				r.setOriginPhoto5(rset.getString("ORIGINAL_PHOTO5"));
				r.setRenamePhoto5(rset.getString("RENAME_PHOTO5"));
				
				System.out.println("sssssssssssssss: " + r);
				reviewImagePageList.add(r);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return reviewImagePageList;
	}

	public Review selectReview(Connection con, int listNo) {
		Review review = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from review where list_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, listNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				review = new Review();
				review.setListNo(rset.getInt("list_no"));
				review.setStoreId(rset.getString("store_id"));
				review.setNickName(rset.getString("nickname"));
				review.setEnrollDate(rset.getDate("enroll_date"));
				review.setScore(rset.getDouble("score"));
				review.setContents(rset.getString("contents"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return review;
	}

	public ReviewImage selectRImage(Connection con, int listNo) {
		ReviewImage reviewImage = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from review_image where list_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, listNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				reviewImage = new ReviewImage();
				reviewImage.setListNo(rset.getInt("list_no"));
				reviewImage.setOriginPhoto1(rset.getString("original_photo1"));
				reviewImage.setRenamePhoto1(rset.getString("rename_photo1"));
				reviewImage.setOriginPhoto2(rset.getString("original_photo2"));
				reviewImage.setRenamePhoto2(rset.getString("rename_photo2"));
				reviewImage.setOriginPhoto3(rset.getString("original_photo3"));
				reviewImage.setRenamePhoto3(rset.getString("rename_photo3"));
				reviewImage.setOriginPhoto4(rset.getString("original_photo4"));
				reviewImage.setRenamePhoto4(rset.getString("rename_photo4"));
				reviewImage.setOriginPhoto5(rset.getString("original_photo5"));
				reviewImage.setRenamePhoto5(rset.getString("rename_photo5"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return reviewImage;
	}
}














