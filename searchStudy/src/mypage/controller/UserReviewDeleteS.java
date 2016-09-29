package mypage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import review.model.service.ReviewService;

/**
 * Servlet implementation class UserReviewDeleteS
 */
@WebServlet("/urdel")
public class UserReviewDeleteS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserReviewDeleteS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String listNo = request.getParameter("listNo");
		
		int result = new ReviewService().DeleteReview(listNo);
		
		 String nickname = request.getParameter("nickname");
		 int currentPage = Integer.parseInt(request.getParameter("page"));
		 System.out.println("돌려보낼것 : " +nickname +", " +currentPage);
		RequestDispatcher view = null;
		if(result > 0){
			response.sendRedirect("ureview?nickname=" + nickname +"&page="+ currentPage);
		}else{
			view = request.getRequestDispatcher("review/reviewError.jsp");
			request.setAttribute("code", "rdelete");
			view.forward(request, response);
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
