package mypage.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import mypage.model.dao.MemberDao;
import member.model.vo.Member;
import mypage.model.vo.Review;

public class MemberService {


	public ArrayList<Member> selectUserList(int currentPage, int limit) {
		//userManagement List 
		Connection con = getConnection();
		
		ArrayList<Member> list = new MemberDao().selectUserList(con, currentPage, limit);		
		
		close(con);
		return list;
	}

	public int getUserListCount() {
		Connection con = getConnection();
		int listCount = new MemberDao().getListCount(con);
		close(con);
		return listCount;
	}

	public int memberDelete(String userId) {
		Connection con = getConnection();
		int result = new MemberDao().deleteUser(con, userId);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int memberAllDelete(String[] userIDs) {
		Connection con = getConnection();
		int resultAll = 0;
		
		for(int i = 0; i < userIDs.length; i++){
			int result = new MemberDao().deleteAllUser(con, userIDs[i]);
			if(result > 0){
				resultAll++;
				
			}else{
				System.out.println("실패 발생");
				break;
			}			
		}
		int result = 0;
		if(resultAll == userIDs.length){
			System.out.println("dao 성공 ");
			commit(con);
			result = 1;
		}else{
			System.out.println("dao 실패 ");
			rollback(con);
		}
		close(con);
		
		return result;
	}
	
	public ArrayList<Member> selectUserid(String userid) {
		Connection con = getConnection();
		ArrayList<Member> list = new MemberDao().selectUserid(con, userid);
		close(con);
		return list;
	}

	public ArrayList<Member> selectUserNicname(String nickname) {
		Connection con = getConnection();
		ArrayList<Member> list = new MemberDao().selectUserNicname(con, nickname);
		close(con);
		return list;
	}

	public ArrayList<Member> selectDate(Date startDate, Date endDate) {
		Connection con = getConnection();
		System.out.println("서비스 실행");
		ArrayList<Member> list = new MemberDao().selectDate(con, startDate, endDate);
		close(con);
		return list;
	}

	public int Userinfo(String userid, String password) {
		Connection con = getConnection();
		System.out.println("서비스 실행");
		int result = new MemberDao().userinfo(con, userid, password);
		System.out.println("result" + result);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		close(con);
		}
		return result;
	}
	
	public int bookmarkwhere(String userid) {
		Connection con = getConnection();
		int result = new MemberDao().bookmarkwhere(con, userid);
		close(con);
		return result;
	}
	
	public int bookmarkwheredel(String userid, String storeid) {
		Connection con = getConnection();
		int result = new MemberDao().bookmarkwheredel(con, userid, storeid);
		close(con);
		return result;
	}

	public int updateBookmark(String storeid, int where, String userid) {
		Connection con = getConnection();
		
		int result = new MemberDao().updateBookmark(con, where,storeid, userid);
				
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public ArrayList<Review> selectReviewList(String nickname, int currentPage, int limit) {
		Connection con = getConnection();
		
		ArrayList<Review> list = new MemberDao().selectReviewList(con, nickname, currentPage, limit);		
		
		close(con);
		return list;
	}

	public int getReviewListCount(String nickname) {
		Connection con = getConnection();
		int listCount = new MemberDao().getReviewListCount(con, nickname);
		close(con);
		return listCount;
	}

	public int deleteBookmark(int where, String userid) {
		Connection con = getConnection();
		
		int result = new MemberDao().deleteBookmark(con, where, userid);
				
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public String[] selectBookmarksList(String userid) {
		Connection con = getConnection();
		String[] bookmarks = new MemberDao().selectBookmarksList(con, userid);
		close(con);
		return bookmarks;
	}




	
}
