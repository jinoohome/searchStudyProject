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
 * Servlet implementation class MyreviewModifyUpdateS
 */
@WebServlet("/myreviewupdateQ")
public class MyreviewModifyUpdateS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyreviewModifyUpdateS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 리뷰 수정
				System.out.println("수정시작!!!!!");
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				String nickname = request.getParameter("nickname");
				String page = request.getParameter("page");
				
				Double updatescore = Double.parseDouble(request.getParameter("updatescore"));
				int listno = Integer.parseInt(request.getParameter("listno"));
				String contents = request.getParameter("contents");
				
				int result = new ReviewService().updateReview(listno, updatescore, contents);
				System.out.println("result : " + result);
				
				RequestDispatcher view = null;
				if(result > 0){
					response.sendRedirect("mreview?nickname=" +nickname +"&page=" + page);
				}else{
					view = request.getRequestDispatcher("mypage/mypageError.jsp");
					request.setAttribute("code", "nupdate");
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
