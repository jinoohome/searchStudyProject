package review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import review.model.service.ReviewService;
import review.model.vo.Review;
import review.model.vo.ReviewImage;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/rupdate")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int listNo = Integer.parseInt(request.getParameter("listNo"));
		System.out.println("ajax를 통해 들어옴 : listNo : " + listNo);
		Review review = new ReviewService().selectReview(listNo);
		ReviewImage reviewImage = new ReviewService().selectRImage(listNo);
		System.out.println(reviewImage.getOriginPhoto1());
		System.out.println(reviewImage.getRenamePhoto1());
		System.out.println(reviewImage.getOriginPhoto2());
		System.out.println(reviewImage.getRenamePhoto2());
		
		JSONObject r = new JSONObject();
		r.put("listNo", Integer.valueOf(review.getListNo()));
		r.put("storeId", review.getStoreId());
		r.put("nickName", URLEncoder.encode(review.getNickName(), "utf-8"));
		r.put("enrollDate", review.getEnrollDate().toString());
		r.put("score", review.getScore());
		r.put("contents", review.getContents());
		
		//해당하는 리뷰 클릭을 누르면...
		if(reviewImage.getOriginPhoto1() != null){
			r.put("renamePhoto1", URLEncoder.encode(reviewImage.getRenamePhoto1(), "utf-8"));
			
			if(reviewImage.getOriginPhoto2() != null){
				r.put("renamePhoto2", URLEncoder.encode(reviewImage.getRenamePhoto2(), "utf-8"));
				
				if(reviewImage.getOriginPhoto3() != null){
					r.put("renamePhoto3", URLEncoder.encode(reviewImage.getRenamePhoto3(), "utf-8"));
					
					if(reviewImage.getOriginPhoto4() != null){
						r.put("renamePhoto4", URLEncoder.encode(reviewImage.getRenamePhoto4(), "utf-8"));
						
						if(reviewImage.getOriginPhoto5() != null){
							r.put("renamePhoto5", URLEncoder.encode(reviewImage.getRenamePhoto5(), "utf-8"));
							
						}
					}
				}
			}
		}
		
		
		response.setContentType("application/json: charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(r.toJSONString());
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
