package review.model.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import review.model.dao.ReviewDao;
import review.model.vo.Review;
import review.model.vo.ReviewImage;

import static common.JDBCTemplate.*;

public class ReviewService {

	public ArrayList<Review> selectReview(String storeId, Review review){
		Connection con = getConnection();
		ArrayList<Review> list = new ReviewDao().selectReview(con, storeId, review);
		close(con);
		return list;
	}

	public int addReview(Review review) {
		Connection con = getConnection();
		int result = new ReviewDao().addReview(con, review);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public ArrayList<Review> selectReview(String storeId) {
		Connection con = getConnection();
		ArrayList<Review> list = new ReviewDao().selectReview(con, storeId);
		close(con);
		return list;
	}

	public int selectListNo(String nickName) {
		Connection con = getConnection();
		int listNo = new ReviewDao().selectListNo(con, nickName);
		close(con);
		return listNo;
	}

	public int addReviewImage(ReviewImage reviewimage) {
		Connection con = getConnection();
		int result = new ReviewDao().addReviewImage(con, reviewimage);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public ArrayList<ReviewImage> selectRImage(String storeId) {
		Connection con = getConnection();
		ArrayList<ReviewImage> listRImage = new ReviewDao().selectRImage(con, storeId);
		close(con);
		return listRImage;
	}

	public int DeleteReview(String listNo) {
		Connection con = getConnection();
		int result = new ReviewDao().DeleteReview(con, listNo);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public int UpdateReview(int listNo) {
		Connection con = getConnection();
		int result = new ReviewDao().UpdateReview(con, listNo);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return 0;
	}

	public int getListCount(String storeId) {
		Connection con = getConnection();
		int listRCount = new ReviewDao().getListCount(con, storeId);
		close(con);
		return listRCount;
	}
	
	public ArrayList<Review> searchReviewInfo(String storeId, int limit, int currentPage) {
		Connection con = getConnection();
		ArrayList<Review> reviewPageList = new ReviewDao().searchReviewInfo(con, storeId, limit, currentPage);
		close(con);
		return reviewPageList;
	}

	public ArrayList<ReviewImage> searchReviewImageInfo(String storeId, int limit, int currentPage) {
		Connection con = getConnection();
		ArrayList<ReviewImage> reviewImagePageList = new ReviewDao().searchReviewImageInfo(con, storeId, limit, currentPage);
		close(con);
		return reviewImagePageList;
	}

	public Review selectReview(int listNo) {
		Connection con = getConnection();
		Review review = new ReviewDao().selectReview(con, listNo);
		close(con);
		return review;
	}

	public ReviewImage selectRImage(int listNo) {
		Connection con = getConnection();
		ReviewImage reviewImage = new ReviewDao().selectRImage(con, listNo);
		close(con);
		return reviewImage;
	}

	public int updateReview(int listno, Double score, String contents) {
		Connection con = getConnection();
		int result = new ReviewDao().updateReview(con, listno, score, contents);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	
	
	

}
