package mypage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mypage.model.service.MemberService;

/**
 * Servlet implementation class MyBookmarkInsertS
 */
@WebServlet("/mbookmarkins")
public class MyBookmarkInsertS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBookmarkInsertS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 마이페이지 추가(update)
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String storeid = request.getParameter("storeid");
		String userid = request.getParameter("userid");
		
		//우선 자리 있는지 몇번째 자리인지 확인하기
		int where = new MemberService().bookmarkwhere(userid);
		
		int result = new MemberService().updateBookmark(storeid, where, userid);
		
		if(result > 0){
			//성공시 어디로 보낼까?
			response.sendRedirect("/easyStudy/nlist");
		}else{
			//실패시 어디로 보낼까?
			RequestDispatcher view = request.getRequestDispatcher("membe/noticeError.jsp");
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
