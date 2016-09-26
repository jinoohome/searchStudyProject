package mypage.model.vo;


public class Member {

	private String userId;
	private String userPass;
	private String nickName;
	private String enrollDate;
	
	public Member() {}

	public Member(String userId, String userPass, String nickName, String enrollDate) {
		super();
		this.userId = userId;
		this.userPass = userPass;
		this.nickName = nickName;
		this.enrollDate = enrollDate;
	}

	public Member(String userid, String password) {
		super();
		this.userId = userId;
		this.userPass = userPass;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(String enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString(){
		return userId +", "+ userId +", "+ nickName  +", "+  enrollDate;
		
	}
}
 