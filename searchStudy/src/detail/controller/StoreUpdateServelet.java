package detail.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import detail.model.service.DetailService;
import detail.model.vo.Store;

/**
 * Servlet implementation class StoreUpdateServelet
 */
@WebServlet("/StoreUpdate")
public class StoreUpdateServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreUpdateServelet() {
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
		
		int sizeLimit = 1024 * 1024 * 10;
		String savePath = "C:\\Users\\JH\\Dropbox\\workspace_easyStudy\\easyStudy_2\\web\\uploadfiles";
		
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", 
				new DefaultFileRenamePolicy());
		
		String storeId = multi.getParameter("storeId");
		String storeName = multi.getParameter("name");
		String categoryId = multi.getParameter("group");
		String localCode = multi.getParameter("local");
		String address = multi.getParameter("address");
		String homepage = multi.getParameter("site");
		String tell = multi.getParameter("tell");
		String price = multi.getParameter("price");
		String weekDayTime = multi.getParameter("daytime");
		String weekEndTime = multi.getParameter("endtime");
		String etc = multi.getParameter("etc");
		
		Store store = new Store(storeId,storeName,categoryId,localCode,address, homepage,
				tell,price,weekDayTime,weekEndTime, etc);

		int result = new DetailService().updateStore(store);
		System.out.println(result);
		if(result > 0){
			response.sendRedirect("DView?storeId="+storeId);
		}else{
			RequestDispatcher view = request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "StoreUpdate");
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
