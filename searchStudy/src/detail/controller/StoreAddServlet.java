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
 * Servlet implementation class AdminServlet
 */
@WebServlet("/StoreAdd")
public class StoreAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreAddServlet() {
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
		String savePath = "C:\\workspace_easyStudy\\easyStudy\\web\\uploadfiles";
		MultipartRequest multi = new MultipartRequest(request, 
				savePath, sizeLimit, "utf-8", 
				new DefaultFileRenamePolicy());
		
		String sotreName = multi.getParameter("name");
		System.out.println("sotreName : "+sotreName);
		String categoryId = multi.getParameter("group");
		System.out.println("categoryId : "+categoryId);
		String localCode = multi.getParameter("local");
		System.out.println("localCode : "+localCode);
		String address = multi.getParameter("address");
		System.out.println("address : "+address);
		String homepage = multi.getParameter("site");
		System.out.println("homepage : "+homepage);
		String tell = multi.getParameter("tell");
		System.out.println("tell : "+tell);
		String price = multi.getParameter("price");
		System.out.println("price : "+price);
		String weekDayTime = multi.getParameter("daytime");
		System.out.println("weekDayTime : "+weekDayTime);
		String weekEndTime = multi.getParameter("endtime");
		System.out.println("weekEndTime : "+weekEndTime);
		String etc = multi.getParameter("etc");
		System.out.println("etc : "+etc);

		
		Store nstore = new Store(sotreName,categoryId,localCode,address, homepage,
				tell,price,weekDayTime,weekEndTime, etc);
		
		
		int result = new DetailService().insertNewStore(nstore);
		if(result > 0){
			response.sendRedirect("main.jsp");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "StoreAdd");
			view.forward(request, response);
		}
	/*	
		int sizeLimit = 1024 * 1024 * 50;
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(!isMultipart){
			RequestDispatcher errorPage = 
					request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "nomulti");
			errorPage.forward(request, response);
		}
		
		//업로드된 파일의 저장 위치 지정
		//1. 웹 컨테이너 내에 저장 위치를 지정할 경우
		String savePath = request.getSession().getServletContext().getRealPath("/images/");
		//2. 임의로 파일 저장 폴더를 만들고, 위치를 지정할 경우
		//String savePath = "C:\\JQuery\\first\\Web\\uploadfiles";
	
		//전송받을 파일명 저장용 변수
		String originalFileName = null;
		//실제 저장할 때 사용할 파일명 저장용 변수
		String renameFileName = null;

		String sotreName = request.getParameter("name");
		String categoryId = request.getParameter("group");
		String localCode = request.getParameter("local");
		String address = request.getParameter("address");
		String homepage = request.getParameter("site");
		String tell = request.getParameter("tell");
		String price = request.getParameter("price");
		String weekDayTime = request.getParameter("daytime");
		String weekEndTime = request.getParameter("endtime");
		String etc = request.getParameter("etc");
		
		//기록 저장된 파일명 바꾸기 : 저장된 파일을 File 객체로 만듦
				File saveFile = new File(savePath + "\\" + originalFileName);
				//만약, 이름바꾸기가 실패했을 경우 직접 강제로 바꿈
				//바꿀 이름에 대한 파일을 만들고, 원본 파일을 복사하고 나서, 원본은 삭제함
				File newFile = new File(savePath + "\\" + renameFileName);
		
		if(!saveFile.renameTo(newFile)){
			//파일 읽기용 변수
			int read = 0;
			//한번에 읽을 크기와 값 담을 배열 지정
			byte[] buf = new byte[1024];
			
			//파일 입력용 스트림
			FileInputStream fin = new FileInputStream(saveFile);
			FileOutputStream fout = new FileOutputStream(newFile);
			
			while((read = fin.read(buf, 0, buf.length)) != -1){
				fout.write(buf);
			}
			
			fin.close();
			fout.close();
			saveFile.delete();  //원본 삭제함
		}
		
		
		Store nstore = new Store(sotreName,categoryId,localCode,address, homepage,
				tell,price,weekDayTime,weekEndTime, etc,originalFileName, 
				savePath + "\\" + renameFileName);

//		int result = new DetailService().insertNewStore(nstore);
		int result =0;
		if(result > 0){
			response.sendRedirect("index.jsp");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "StoreAdd");
			view.forward(request, response);
		}*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
