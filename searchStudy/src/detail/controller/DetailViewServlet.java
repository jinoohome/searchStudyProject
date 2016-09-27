package detail.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import detail.model.service.DetailService;
import detail.model.vo.Image;
import detail.model.vo.Store;
import review.controller.DescReview;
import review.model.service.ReviewService;
import review.model.vo.Review;
import review.model.vo.ReviewImage;

/**
 * Servlet implementation class DetailView
 */
@WebServlet("/DView")
public class DetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String storeId = request.getParameter("storeId");
		String score = request.getParameter("score");
		Store store = new DetailService().selectRow(storeId);
		Image image = new DetailService().selectPhoto(storeId);
		
		//storeId에 해당하는 리뷰 list 조회
		ArrayList<Review> list = new ReviewService().selectReview(storeId);
		
		//storeId에 해당하는 리뷰이미지 list 조회
		ArrayList<ReviewImage> listRImage = new ReviewService().selectRImage(storeId);
		RequestDispatcher view = null;
		
		//페이지 수 처리용 변수 
			int currentPage = 1;
			int limit = 5;	//한 페이지에 5개씩 출력
			
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
			int listRCount = new ReviewService().getListCount(storeId);
			//2. rownum으로 해당 페이지 수만큼의 review list 받음
			ArrayList<Review> reviewPageList = new ReviewService().searchReviewInfo(storeId, limit, currentPage);
			ArrayList<ReviewImage> reviewImagePageList = new ReviewService().searchReviewImageInfo(storeId, limit, currentPage);
			
			//총 페이지수 계산 : 목록이 최소 1개일 때, 1 page 로 처리하기 위해 0.9 더함
			int maxPage = (int)((double)listRCount / limit + 0.9);
			//현재 페이지에 보여줄 시작 페이지 수 (1, 10, 20, .....)
			int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
			//현재 페이지에 보여줄 마지막 페이지 수 (9, 19, 29, .....)
			int endPage = startPage + limit - 1;
			if(maxPage < endPage)
				endPage = maxPage;
			
		
		if(store !=null){
			view = request.getRequestDispatcher("detail/StoreDetailView.jsp");
			reviewPageList.sort(new DescReview());
			reviewImagePageList.sort(new DescReview());
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
			request.setAttribute("store", store);
			request.setAttribute("image", image);
			request.setAttribute("score", score);
			view.forward(request, response);
		}else{
			System.out.println("실패");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
