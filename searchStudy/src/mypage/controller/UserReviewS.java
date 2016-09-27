package mypage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mypage.model.service.MemberService;
import mypage.model.service.ReviewService;
import mypage.model.vo.Review;
import mypage.model.vo.ReviewImage;

/**
 * Servlet implementation class UserReviewS
 */
@WebServlet("/ureview")
public class UserReviewS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserReviewS() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 유저 쓴 리뷰
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		System.out.println("서블릿 시작 : ");

		// 페이지 수 처리용 변수
		int currentPage = 1;
		int limit = 5; // 한 페이지에 5개씩 출력
		RequestDispatcher view = null;

		String nickname = request.getParameter("nickname");

		// 전달받은 페이지 값 추출
		if (request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));

		// 전체 목록 갯수와 목록 전체를 리턴받음
		
			int listCount = new MemberService().getReviewListCount(nickname);

			System.out.println("listCount : " + listCount);

			ArrayList<Review> list = new MemberService().selectReviewList(nickname, currentPage, limit);

			System.out.println("list" + list);

			// 총 페이지수 계산 : 목록이 최소 1개일 때, 1 page 로 처리하기 위해 0.9 더함
			int maxPage = (int) ((double) listCount / limit + 0.9);
			// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21, .....)
			int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
			// 현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30, .....)
			int endPage = startPage + limit - 1;
			if (maxPage < endPage)
				endPage = maxPage;

			ArrayList<ReviewImage> listRImage = null;
			if(list != null){
			for (int i = 0; i < list.size(); i++) {
				listRImage = new ReviewService().selectMyRImage(list.get(i).getListNo());
			}
			}
			System.out.println("listRImage : " + listRImage);

			view = request.getRequestDispatcher("mypage/userReview.jsp");

			request.setAttribute("list", list);
			request.setAttribute("nickname", nickname);
			request.setAttribute("currentPage", currentPage); // 현재 페이지
			request.setAttribute("maxPage", maxPage); // 최대 페이지 수
			request.setAttribute("startPage", startPage); // 현재 페이지에 표시할 첫 페이지값
			request.setAttribute("endPage", endPage); // 현재 페이지에 표시할 끝 페이지 값
			request.setAttribute("listCount", listCount); // 총 글 수
			request.setAttribute("reviewImagePageList", listRImage);
			view.forward(request, response);

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
