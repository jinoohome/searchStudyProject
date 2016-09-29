package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String userId = request.getParameter("main_loginUserId");
		String userPwd = request.getParameter("main_loginUserPwd");
		
		System.out.println(userId + ", " + userPwd);
		
		Member member = new MemberService().loginCheck(userId, userPwd);
	
		if(member != null){  //로그인 성공시
			response.setContentType("text/xml; charset=UTF-8");
			HttpSession session = request.getSession(); 
			System.out.println("session id : " + session.getId());
			session.setAttribute("member", member);
			response.sendRedirect("index.jsp");
		}else{
			//response.sendRedirect("member/memberError.jsp");
			RequestDispatcher rd = 
					request.getRequestDispatcher("member/memberError.jsp");
			request.setAttribute("code", "login");
			rd.forward(request, response);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);		
	}

}












