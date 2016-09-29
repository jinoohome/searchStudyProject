package detail.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import detail.model.service.DetailService;
import detail.model.vo.Image;
import detail.model.vo.Service;
import detail.model.vo.Store;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/storeAdd")
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
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		if(!isMultipart){
			RequestDispatcher errorPage = request.getRequestDispatcher("notice/noticeError.jsp");
			request.setAttribute("code", "nomulti");
			errorPage.forward(request, response);
		}
		
		String savePath = "C:\\Users\\JH\\Dropbox\\workspace_easyStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\searchStudy\\images";
		
		ArrayList<String> renameFileNames = new ArrayList<String>();

		MultipartRequest multi = new MultipartRequest(request, 
				savePath, sizeLimit, "utf-8", 
				new DefaultFileRenamePolicy());
		
		int storeInsert = 0;
		int imageInsert = 0;
		int serviceInsert = 0;
		
		/*Store Save List*/
		String storeName = multi.getParameter("name");
		System.out.println("sotreName : "+storeName);
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

		Store nstore = new Store(storeName,categoryId,localCode,address, homepage,
				tell,price,weekDayTime,weekEndTime, etc);
		storeInsert = new DetailService().insertNewStore(nstore);
		String storeId = new DetailService().selectStoreId();

		/* image Save List*/
		Enumeration<String> files = multi.getFileNames();
		while(files.hasMoreElements()){
		//for(int i = 0; files.hasMoreElements(); i++){
			String name = files.nextElement();
			String originalFileName = multi.getFilesystemName(name);
			if(originalFileName != null){
				renameFileNames.add(originalFileName);
			}
		}
		
		
		if(storeInsert > 0){
		if(renameFileNames.size() > 0){
			Collections.reverse(renameFileNames);
		
			//바꿀 파일명 만들기
			int index = 1;
			System.out.println("index : " + index);
			
			for(int i = 0; i < renameFileNames.size(); i++){
				if(renameFileNames != null){
					StringBuilder sb = new StringBuilder();
					System.out.println("renameFileNames.get(i) : " + renameFileNames.get(i));
					
					String renameFileName = sb.append(storeId  + "_" + String.valueOf(index) + "."
								+ renameFileNames.get(i).substring(renameFileNames.get(i).lastIndexOf(".") + 1)).toString();
					
					renameFileNames.add(renameFileName);
					
					File saveFile = new File(localCode + "\\" + renameFileNames.get(i));
					File newFile = new File(localCode + "\\" + renameFileNames.get(i));
					if(!saveFile.renameTo(newFile)){
						int read = 0;
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
					index++;
				}
			}
		}

		
		Image nimage = new Image(storeId, renameFileNames.get(1),renameFileNames.get(2),
				renameFileNames.get(3),renameFileNames.get(4),renameFileNames.get(5));
		
		imageInsert = new DetailService().insertNewImage(nimage);
		
		}
		
		/*Service Save List*/
		String laptop = multi.getParameter("laptop");
		System.out.println("laptop : "+laptop);
		String beam = multi.getParameter("beam");
		System.out.println("beam : "+beam);
		String wifi = multi.getParameter("wifi");
		System.out.println("wifi : "+wifi);
		String board = multi.getParameter("board");
		System.out.println("board : "+board);
		
		if(storeInsert > 0){
			Service nservice = new Service(storeId, laptop, beam, wifi,board);
			serviceInsert = new DetailService().insertService(nservice);
		}
		
		if(storeInsert > 0){
			response.sendRedirect("/easyStudy/DView?storeId="+storeId+"&score=3");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("detail/AdminError.jsp");
			request.setAttribute("code", "StoreAdd");
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
