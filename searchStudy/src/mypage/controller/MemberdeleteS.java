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
 * Servlet implementation class Memberdelete
 */
@WebServlet("/mdelete")
public class MemberdeleteS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberdeleteS() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// User delete
		
		System.out.println("삭제 서블릿 실행");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String userId = request.getParameter("userid");
		System.out.println("삭제 아이디 : " + userId);
		
		String[] userInfo = request.getParameter("userid").split(",");
		
		System.out.println("userInfo" + userInfo[0] + ",  " + userInfo[1]);
		
		int result = new MemberService().memberDelete(userInfo[0]);

		if (result > 0) {
			if (userInfo[1].equals("admin")) {
				System.out.println("탈퇴처리 완료");
				response.sendRedirect("mmanagement");
			} else {
				System.out.println("탈퇴 성공 로그아웃 시키기");
				//임시 확인용
				response.sendRedirect("mmanagement");
//				response.sendRedirect("logout");
			}

		} else {
			RequestDispatcher error = request.getRequestDispatcher("mypage/mypageError.jsp");
			request.setAttribute("code", "mdel");
			error.forward(request, response);
		}
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
