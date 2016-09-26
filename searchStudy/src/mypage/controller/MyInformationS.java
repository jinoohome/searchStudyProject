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
 * Servlet implementation class MemberDelete
 */
@WebServlet("/myinfo")
public class MyInformationS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInformationS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 비밀번호 변경
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("비밀번호 사용");
		//아이디 입력하기!!
		String userid = request.getParameter("userid");
		String password = request.getParameter("mypage_infoUserPwd");
		System.out.println(userid +", " + password);
		int result = new MemberService().Userinfo(userid, password);
		System.out.println("result" + result);
		if(result > 0){
			//내 정보보기 기능으로 연결함
			System.out.println("성공");
			response.sendRedirect("mypage/myinfo.jsp");
		}else{
			System.out.println("실패");
			RequestDispatcher error = request.getRequestDispatcher("mypage/mypageError.jsp");
			request.setAttribute("code", "myinfo");
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
