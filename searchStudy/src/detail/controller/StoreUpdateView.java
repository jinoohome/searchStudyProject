package detail.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import detail.model.service.DetailService;
import detail.model.vo.Store;

/**
 * Servlet implementation class StoreUpdateView
 */
@WebServlet("/StoreUpdateView")
public class StoreUpdateView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreUpdateView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String storeId = request.getParameter("storeId");
		
		Store store = new DetailService().selectRow(storeId);
		RequestDispatcher view = null;
		if(store != null){
			view = request.getRequestDispatcher("detail/StoreAdmin.jsp");
			request.setAttribute("store", store);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "StoreUpdate");
			request.setAttribute("storeId", storeId);
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
