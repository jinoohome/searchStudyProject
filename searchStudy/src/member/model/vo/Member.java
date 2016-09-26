package member.model.vo;

import java.sql.Date;

public class Member implements java.io.Serializable {
	//Field
	private String userId;
	private String userPwd;
	private String nickName;
	private Date enrollDate;
	public Member() {}
	
	public Member(String userId, String userPwd, String nickName) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.nickName = nickName;
	}

	public Member(String userId, String userPwd, String nickName, Date enrollDate) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.nickName = nickName;
		this.enrollDate = enrollDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString() {
		return userId + ", " + userPwd + ", " + nickName+" "+enrollDate;
	}
	
}
