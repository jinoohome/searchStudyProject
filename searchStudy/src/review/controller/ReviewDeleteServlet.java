package review.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewDeleteServlet
 */
@WebServlet("/rdelete")
public class ReviewDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDeleteServlet() {
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
		String storeId = request.getParameter("storeId");
		Double score = Double.parseDouble(request.getParameter("score"));
		System.out.println("삭제 서블릿" + score);
		System.out.println("삭제 서블릿에서 받아준 storeId : " + storeId);
		int result = new ReviewService().DeleteReview(listNo);
		
		RequestDispatcher view = null;
		if(result > 0){
			response.sendRedirect("DView?storeId=" + storeId+"&score="+score);
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
