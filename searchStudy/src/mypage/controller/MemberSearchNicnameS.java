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
import member.model.vo.Member;

/**
 * Servlet implementation class MemberSearchNicname
 */
@WebServlet("/searchnickname")
public class MemberSearchNicnameS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSearchNicnameS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Nicname 검색
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				
				String nickname = request.getParameter("nickname");
				ArrayList<Member> list = new MemberService().selectUserNicname(nickname);
				
				RequestDispatcher view = null;
				
					view = request.getRequestDispatcher("mypage/usersManagement.jsp");
					request.setAttribute("list", list);
					view.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
