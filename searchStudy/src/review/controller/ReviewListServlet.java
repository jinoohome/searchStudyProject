package review.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;

import review.model.vo.Review;
import review.model.vo.ReviewImage;
import review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewListServlet
 */
@WebServlet("/rlist")
public class ReviewListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8;");
		String storeId = request.getParameter("storeId");
		
		//storeId에 해당하는 리뷰 list 조회
		ArrayList<Review> list = new ReviewService().selectReview(storeId);
		
		//storeId에 해당하는 리뷰이미지 list 조회
		ArrayList<ReviewImage> listRImage = new ReviewService().selectRImage(storeId);
		
		
		//페이지 수 처리용 변수 
		int currentPage = 1;
		int limit = 5;	//한 페이지에 5개씩 출력
		System.out.println("storeId : " + storeId);
		System.out.println("PAGE번호: " + request.getParameter("page"));
		
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
			System.out.println("page가 null이 아니면 currentPage 출력값 : " + currentPage);
			System.out.println("storeId : " + storeId);
		}else{
			System.out.println("page가 null이면 currentPage 출력값 : " + currentPage);
			System.out.println("storeId : " + storeId);
		}
		
		//전체 목록 갯수와 목록 전체를 리턴받음
		//1. 전체리뷰 갯수
		System.out.println("storeId : " + storeId);
		int listRCount = new ReviewService().getListCount(storeId);
		System.out.println("listRCount : " + listRCount);
		//2. rownum으로 해당 페이지 수만큼의 review list 받음
		ArrayList<Review> reviewPageList = new ReviewService().searchReviewInfo(storeId, limit, currentPage);
		ArrayList<ReviewImage> reviewImagePageList = new ReviewService().searchReviewImageInfo(storeId, limit, currentPage);
		System.out.println("rrrrrrrrrrrrrrrrrrrrr : " + reviewImagePageList);
		
		//총 페이지수 계산 : 목록이 최소 1개일 때, 1 page 로 처리하기 위해 0.9 더함
		int maxPage = (int)((double)listRCount / limit + 0.9);
		//현재 페이지에 보여줄 시작 페이지 수 (1, 10, 20, .....)
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		//현재 페이지에 보여줄 마지막 페이지 수 (9, 19, 29, .....)
		int endPage = startPage + limit - 1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		System.out.println("reviewPageList는 null이라고 나오는 이유는?");
		RequestDispatcher view = null;
		//if(list != null){
		if(reviewPageList != null){
			//list값이 있으면 내림차순 정렬
			reviewPageList.sort(new DescReview());
			reviewImagePageList.sort(new DescReview());
			
			view = request.getRequestDispatcher("review/review.jsp");
			request.setAttribute("list", list);
			request.setAttribute("storeId", storeId);
			request.setAttribute("listRImage", listRImage);
			request.setAttribute("currentPage", currentPage);	//현재 페이지
			request.setAttribute("maxPage", maxPage); //최대 페이지 수
			request.setAttribute("startPage", startPage); //현재 페이지에 표시할 첫 페이지값
			request.setAttribute("endPage", endPage);  //현재 페이지에 표시할 끝 페이지 값
			request.setAttribute("listRCount", listRCount); //해당하는 storeId에 대한 총 리뷰 수
			request.setAttribute("reviewPageList", reviewPageList);
			request.setAttribute("reviewImagePageList", reviewImagePageList);
			
			view.forward(request, response);
		}else{
			System.out.println("list가 없습니다.");
			//response.sendRedirect("review/review.jsp");
			view = request.getRequestDispatcher("review/review.jsp");
			request.setAttribute("list", list);
			request.setAttribute("storeId", storeId);
			view.forward(request, response);
		}
		
		/*Review review = (Review)request.getAttribute("review");*/
		System.out.println("///////////////////////////////////////////////ListServlet End///////////////////////////////////////////");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
