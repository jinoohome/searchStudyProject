package member.model.dao;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import member.model.vo.Member;

public class MemberDao {
	public MemberDao(){}
	
	//로그인 처리용 메소드
	public Member loginCheck(Connection con, String userId, String userPwd){
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM USERS WHERE USER_ID = ? AND USER_PWD = ?";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			rset = pstmt.executeQuery();
			if(rset.next()){
				member = new Member();
				member.setUserId(rset.getString("USER_ID"));
				member.setUserPwd(rset.getString("USER_PWD"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return member;
	}

	public int memberInsert(Connection con, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO USERS  " + 
					"(USER_ID, USER_PWD, NICKNAME, ENROLL_DATE)"
					+ "VALUES( ?, ?, ?, SYSDATE)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getNickName());
						
			result = pstmt.executeUpdate();
			if(result > 0)
				commit(con);
			else
				rollback(con);
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
			close(con);
		}
		
		return result;
	}
/*
	//사용자 아이디를 이용한 회원 정보 조회용 메소드
	public Member selectOne(String userId) {
		Member member = null;
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from member where user_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				member = new Member();
				
				member.setUserId(userId);
				member.setUserPwd(rset.getString("user_pwd"));
				member.setUserName(rset.getString("USER_NAME"));
				member.setGender(rset.getString("GENDER").charAt(0));
				member.setAge(rset.getInt("AGE"));
				member.setEmail(rset.getString("EMAIL"));
				member.setPhone(rset.getString("PHONE"));
				member.setJob(rset.getString("JOB"));
				member.setHobby(rset.getString("INTERESTING_FIELD"));
				member.setBirthDate(rset.getDate("BIRTH_DATE"));
				member.setAddress(rset.getString("ADDRESS"));
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

	public int memberUpdate(Member member) {
		int result = 0;
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		
		String query = "UPDATE member SET " + 
					"USER_PWD=?, USER_NAME=?, GENDER=?, " +
					"AGE=?, EMAIL=?, PHONE=?, ADDRESS=?, JOB=?, INTERESTING_FIELD=?, "
					+ "BIRTH_DATE=? " + 
					"WHERE USER_ID=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getUserPwd());
			pstmt.setString(2, member.getUserName());
			pstmt.setString(3, String.valueOf(member.getGender()));
			pstmt.setInt(4, member.getAge());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getJob());
			pstmt.setString(9, member.getHobby());
			pstmt.setDate(10, member.getBirthDate());	
			pstmt.setString(11, member.getUserId());
						
			result = pstmt.executeUpdate();
			if(result > 0)
				commit(con);
			else
				rollback(con);
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
			close(con);
		}
		
		return result;
	}

	public int memberDelete(String userId) {
		int result = 0;
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		String query = "DELETE FROM member WHERE USER_ID=?";
	
	try {
		pstmt = con.prepareStatement(query);
		pstmt.setString(1, userId);
					
		result = pstmt.executeUpdate();
		if(result > 0)
			commit(con);
		else
			rollback(con);
			
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		close(pstmt);
		close(con);
	}
	
	return result;
	}

	public ArrayList<Member> selectAll() {
		ArrayList<Member> list = null;
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from member";
		
		try {
			stmt = con.createStatement();
			
			rset = stmt.executeQuery(query);
			
			int count = 1;
			while(rset.next()){
				if(count == 1){
					list = new ArrayList<Member>();
					count = 0;
				}
				
				Member member = new Member();
				
				member.setUserId(rset.getString("user_id"));
				member.setUserPwd(rset.getString("user_pwd"));
				member.setUserName(rset.getString("USER_NAME"));
				member.setGender(rset.getString("GENDER").charAt(0));
				member.setAge(rset.getInt("AGE"));
				member.setEmail(rset.getString("EMAIL"));
				member.setPhone(rset.getString("PHONE"));
				member.setJob(rset.getString("JOB"));
				member.setHobby(rset.getString("INTERESTING_FIELD"));
				member.setBirthDate(rset.getDate("BIRTH_DATE"));
				member.setAddress(rset.getString("ADDRESS"));
				
				list.add(member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
			close(con);
		}
		
		return list;
	}
	*/

	public int idCheck(Connection con, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*)COUNT FROM USERS WHERE USER_ID=?";
	
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
						
			rset = pstmt.executeQuery();
			if(rset.next()){
				result = rset.getInt("COUNT");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return result;
	}

	
	public int pwCheck(Connection con, String userId, String userPwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*)COUNT FROM USERS WHERE USER_ID=? AND USER_PWD=?";
	
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
						
			rset = pstmt.executeQuery();
			if(rset.next()){
				result = rset.getInt("COUNT");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int nickNameCheck(Connection con, String userName) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*)COUNT FROM USERS WHERE NICKNAME=?";
	
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userName);
						
			rset = pstmt.executeQuery();
			if(rset.next()){
				result = rset.getInt("COUNT");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public Member selectRow(Connection con, String userId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM USERS WHERE USER_ID = ?";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			if(rset.next()){
				member = new Member();
				member.setUserId(rset.getString("USER_ID"));
				member.setUserPwd(rset.getString("USER_PWD"));
				member.setNickName(rset.getString("NICKNAME"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return member;
	}
}









