package mypage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import mypage.model.service.MemberService;

/**
 * Servlet implementation class MemberManagement
 */
@WebServlet("/mmanagement")
public class MemberManagementS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberManagementS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 관리 페이지  조회
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//페이지 수 처리용 변수 
		int currentPage = 1;
		int limit = 10;	//한 페이지에 10개씩 출력
		
		//전달받은 페이지 값 추출
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		//전체 목록 갯수와 목록 전체를 리턴받음
		MemberService ms = new MemberService();
		try{
			int listCount = ms.getUserListCount();
	        ArrayList<Member> list = ms.selectUserList(currentPage, limit);
	        
	      	RequestDispatcher view = null;
		

			//총 페이지수 계산 : 목록이 최소 1개일 때, 1 page 로 처리하기 위해 0.9 더함
			int maxPage = (int)((double)listCount / limit + 0.9);
			//현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21, .....)
			int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
			//현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30, .....)
			int endPage = startPage + limit - 1;
			if(maxPage < endPage)
				endPage = maxPage;
		
			//뷰 선택하고, 값 담아서 넘김
			view = request.getRequestDispatcher("mypage/usersManagement.jsp");
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);	//현재 페이지
			request.setAttribute("maxPage", maxPage); //최대 페이지 수
			request.setAttribute("startPage", startPage); //현재 페이지에 표시할 첫 페이지값
			request.setAttribute("endPage", endPage);  //현재 페이지에 표시할 끝 페이지 값
			request.setAttribute("listCount", listCount); //총 글 수
			view.forward(request, response);			
		} catch (Exception e) {
			System.out.println("에러발생");
			RequestDispatcher error = request.getRequestDispatcher("view/board/boardError.jsp");
			request.setAttribute("message", e.getMessage());
			error.forward(request, response);
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
