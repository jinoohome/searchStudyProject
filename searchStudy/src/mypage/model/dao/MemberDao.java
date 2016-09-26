package mypage.model.dao;



import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import member.model.vo.Member;
import mypage.model.vo.Review;

public class MemberDao{
	public MemberDao(){}

	public ArrayList<Member> selectUserList(Connection con, int currentPage, int limit) {
		// userManagement List 
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		System.out.println("번호 : " + currentPage + ", " + limit);
		//관리자 제외 회원 조회
		String query = " SELECT USER_ID, USER_PWD, NICKNAME, ENROLL_DATE "
				+ " FROM (SELECT USER_ID, USER_PWD, NICKNAME, ENROLL_DATE,  ROW_NUMBER() OVER (ORDER BY USER_ID DESC) RANK "
					    	+ " FROM USERS ) "
					+ " WHERE RANK >= ? AND RANK <= ? "; 
		
		int startRow = (currentPage - 1) * 10 + 1; // 읽기 시작할 row 번호.
		int endRow = startRow + limit - 1; // 읽을 마지막 row 번호.
		System.out.println("번호 : " + startRow + ", " + endRow);
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
				
				Member member = new Member();
				
				member.setUserId(rset.getString("USER_ID"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				
				list.add(member);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getListCount(Connection con) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;

		String query = " select count(*) from users ";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			if (rset.next()) {
				listCount = rset.getInt(1); // select 한 첫번째 항목값
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}

		return listCount;
	}


	
	public int deleteUser(Connection con, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from users where USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteAllUser(Connection con, String userIDs) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		String query = "delete from users where USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userIDs);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Member> selectUserid(Connection con, String userid) {
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select USER_ID, NICKNAME, ENROLL_DATE from users where USER_ID = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,  userid);
			rset = pstmt.executeQuery();
			boolean flag = true;
			
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
				Member member = new Member();
				member.setUserId(rset.getString("USER_ID"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				
				list.add(member);
				System.out.println("Asdf" +member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Member> selectUserNicname(Connection con, String nickname) {
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select USER_ID, NICKNAME, ENROLL_DATE from users where NICKNAME = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,  nickname);
			rset = pstmt.executeQuery();
			boolean flag = true;
			
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
				Member member = new Member();
				member.setUserId(rset.getString("USER_ID"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				
				list.add(member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Member> selectDate(Connection con, Date startDate, Date endDate) {
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select USER_ID, NICKNAME, ENROLL_DATE from users where ENROLL_DATE between TO_DATE(?)  and TO_DATE(?)  +1";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setDate(1, startDate);
			pstmt.setDate(2, endDate);
			rset = pstmt.executeQuery();
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
				Member member = new Member();
				member.setUserId(rset.getString("USER_ID"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				
				list.add(member);
				System.out.println("결과 : " + member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int userinfo(Connection con, String userid, String password) {
		int result = 0;
		PreparedStatement pstmt = null;
		System.out.println("dao");
		String query = "update users set USER_PWD = ?  where USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);		
			pstmt.setString(1, password);
			pstmt.setString(2, userid);	

			result = pstmt.executeUpdate();
			
			System.out.println("결과!!" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public Member loginCheck(String userId, String userPwd) {
		// temp 로그인
		Member member = new Member();
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		System.out.println("dao 실행");
		String query = "select * from users where USER_ID = ? and USER_PWD = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				member.setUserId(rset.getString("USER_ID"));
				member.setUserPwd(rset.getString("USER_PWD"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				System.out.println("dao member" + member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
			close(con);
		}
		
		return member;
	}

	public int bookmarkwhere(Connection con, String userid) {
		// 어느 위치에 입력시켜야할까?
		
		String[] bookmarks = new String[9];
		int result = 10; 
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from USER_BOOKMARKS WHERE USER_ID = ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);			
			rset = pstmt.executeQuery();
			
			
			if(rset.next() ){
				 bookmarks[0] = rset.getString("BOOKMARK_N1");
				 bookmarks[1] = rset.getString("BOOKMARK_N2");
				 bookmarks[2] = rset.getString("BOOKMARK_N3");
				 bookmarks[3] = rset.getString("BOOKMARK_N4");
				 bookmarks[4] = rset.getString("BOOKMARK_N5");
				 bookmarks[5] = rset.getString("BOOKMARK_N6");
				 bookmarks[6] = rset.getString("BOOKMARK_N7");
				 bookmarks[7] = rset.getString("BOOKMARK_N8");
				 bookmarks[8] = rset.getString("BOOKMARK_N9");
			}
			
			for(int i = 0; i <bookmarks.length; i++){
				if(bookmarks[i] == null){
					result = i;
					break;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		

		
		return result;
	}
	
	public int bookmarkwheredel(Connection con, String userid, String storeid) {
		// 어느 위치를 삭제시켜야할까??
		System.out.println("dao 실행");
		String[] bookmarks = new String[9];
		int result = 0; 
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from USER_BOOKMARKS WHERE USER_ID = ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);			
			rset = pstmt.executeQuery();
			System.out.println("성공");
			
			if(rset.next()){
				System.out.println("실행!");
				 bookmarks[0] = rset.getString("BOOKMARK_N1");
				 bookmarks[1] = rset.getString("BOOKMARK_N2");
				 bookmarks[2] = rset.getString("BOOKMARK_N3");
				 bookmarks[3] = rset.getString("BOOKMARK_N4");
				 bookmarks[4] = rset.getString("BOOKMARK_N5");
				 bookmarks[5] = rset.getString("BOOKMARK_N6");
				 bookmarks[6] = rset.getString("BOOKMARK_N7");
				 bookmarks[7] = rset.getString("BOOKMARK_N8");
				 bookmarks[8] = rset.getString("BOOKMARK_N9");
				 System.out.println("adsf" + bookmarks[3]);
				 System.out.println("adf " + rset.getString("BOOKMARK_N1") );
			}else{
				System.out.println("adsfadsfa");
			}
			
				 for(int i = 0; i <bookmarks.length; i++){
						if(storeid.equals(bookmarks[i])){
							result = i;
							System.out.println("번호  : " +  i);
							break;
						}
					}
				 
			
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		
		
		return result;
	}
	
	public int updateBookmark(Connection con, int where, String storeid, String userid) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String[] bookmark = new String[]{"BOOKMARK_N1", "BOOKMARK_N2", "BOOKMARK_N3", "BOOKMARK_N4",
							"BOOKMARK_N5", "BOOKMARK_N6", "BOOKMARK_N7", "BOOKMARK_N8", "BOOKMARK_N9"};
		
String query = null;
		
		switch(bookmark[where]){
		case "BOOKMARK_N1" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N1 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N2" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N2 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N3" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N3 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N4" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N4 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N5" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N5 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N6" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N6 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N7" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N7 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N8" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N8 = ? where USER_ID = ? ";
			break;
		case "BOOKMARK_N9" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N9 = ? where USER_ID = ? ";
			break;
		}
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(2, storeid);
			pstmt.setString(3, userid);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteBookmark(Connection con, int where, String userid) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String[] bookmark = new String[]{"BOOKMARK_N1", "BOOKMARK_N2", "BOOKMARK_N3", "BOOKMARK_N4",
							"BOOKMARK_N5", "BOOKMARK_N6", "BOOKMARK_N7", "BOOKMARK_N8", "BOOKMARK_N9"};
		
		String query = null;
		
		switch(bookmark[where]){
		case "BOOKMARK_N1" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N1 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N2" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N2 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N3" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N3 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N4" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N4 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N5" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N5 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N6" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N6 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N7" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N7 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N8" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N8 = null where USER_ID = ? ";
			break;
		case "BOOKMARK_N9" :  
			query = " update USER_BOOKMARKS set BOOKMARK_N9 = null where USER_ID = ? ";
			break;
		}
		
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);
			System.out.println("여기까지 실행");
			result = pstmt.executeUpdate();
			System.out.println("성공!");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int getReviewListCount(Connection con, String nickname) {
		int ReviewlistCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = " select count(*) from review where NICKNAME = ? ";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nickname);
			
			rset = pstmt.executeQuery();

			if (rset.next()) {
				ReviewlistCount = rset.getInt(1); // select 한 첫번째 항목값
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return ReviewlistCount;


	}

	
	public ArrayList<Review> selectReviewList(Connection con, String nickname, int currentPage, int limit) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Review> list = null;
		System.out.println("dao실행");
		String query = " SELECT LIST_NO, STORE_ID, NICKNAME, ENROLL_DATE, SCORE, CONTENTS "
						+ " FROM ( SELECT LIST_NO, STORE_ID, NICKNAME, ENROLL_DATE, "
											+ "	 SCORE, CONTENTS, ROW_NUMBER() OVER (ORDER BY ENROLL_DATE DESC) RANK "
									+ " FROM REVIEW "
									+ " WHERE NICKNAME = ? ) "
						+ " WHERE RANK >= ? AND RANK <= ? ";
		
		int startRow = (currentPage - 1) * 5 + 1; // 읽기 시작할 row 번호.
		int endRow = startRow + limit - 1; // 읽을 마지막 row 번호.
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nickname);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			
			rset = pstmt.executeQuery();
			System.out.println("실행완료?");
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
				r.setScore(rset.getInt("score"));
				r.setContents(rset.getString("contents"));
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}








	

	
	
	
}
