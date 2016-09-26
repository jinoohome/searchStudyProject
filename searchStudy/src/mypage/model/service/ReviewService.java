package mypage.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import mypage.model.dao.ReviewDao;
import mypage.model.vo.ReviewImage;

public class ReviewService {

	public ArrayList<ReviewImage> selectMyRImage(int listNo) {
		Connection con = getConnection();
		ArrayList<ReviewImage> listRImage = new ReviewDao().selectRImage(con, listNo);
		close(con);
		return listRImage;
	}

}
