package mypage.controller;

import java.io.IOException;
import java.sql.Date;
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
 * Servlet implementation class MemberSearchEnroll_dateS
 */
@WebServlet("/searchenroll_date")
public class MemberSearchEnroll_dateS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSearchEnroll_dateS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 가입 날짜
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				Date startDate = Date.valueOf(request.getParameter("start"));
				Date endDate = Date.valueOf(request.getParameter("end"));
				
				ArrayList<Member> list = new MemberService().selectDate(startDate, endDate);
				
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
