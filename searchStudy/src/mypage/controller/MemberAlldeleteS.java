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
 * Servlet implementation class MemberAlldeleteS
 */
@WebServlet("/malldel")
public class MemberAlldeleteS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberAlldeleteS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//user all delete
				System.out.println("다수 삭제 시작");
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				
				String[] userIDs = request.getParameterValues("userids_del");
				
				System.out.println("aauserIDs   " + userIDs);
				int result = new MemberService().memberAllDelete(userIDs);
				
				if(result > 0){
					System.out.println("삭제 성공");
					response.sendRedirect("mmanagement");
				}else{
					//response.sendRedirect("member/memberError.jsp");
					RequestDispatcher error = request.getRequestDispatcher("mypage/mypageError.jsp");
					request.setAttribute("code", "mAlldel");
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
