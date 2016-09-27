package review.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Review implements Serializable {
	
	//Field
	private int listNo;	//리뷰 글 번호
	private String storeId; //상점 아이디
	private String nickName; //닉네임
	private Date enrollDate; //등록날짜
	private double score;		//점수
	private String contents; //내용
	
	
	//Constructor
	public Review(){}
	
	public Review(String storeId, double score, String contents) {
		super();
		this.storeId = storeId;
		this.score = score;
		this.contents = contents;
	}

	public Review(String storeId, String nickName, double score, String contents) {
		super();
		this.storeId = storeId;
		this.nickName = nickName;
		this.score = score;
		this.contents = contents;
	}

	public Review(int listNo, String storeId, String nickName, Date enrollDate, double score, String contents) {
		super();
		this.listNo = listNo;
		this.storeId = storeId;
		this.nickName = nickName;
		this.enrollDate = enrollDate;
		this.score = score;
		this.contents = contents;
	}
	
	
	//Method
	
	@Override
	public String toString(){
		return listNo + ", " + storeId + ", " + nickName + ", " + enrollDate + ", " + score + ", " + contents; 
	}

	public int getListNo() {
		return listNo;
	}

	public void setListNo(int listNo) {
		this.listNo = listNo;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
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

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
	
}
