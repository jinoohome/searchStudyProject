package review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import review.model.vo.Review;
import review.model.vo.ReviewImage;
import review.model.service.ReviewService;
/**
 * Servlet implementation class ReviewAddServlet
 */
@WebServlet("/radd")
public class ReviewAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewAddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("///////////////////////////////////////////////AddServlet Start///////////////////////////////////////////");
		//전송 파일에 용량 제한을 두고 싶으면 정함 : 10 메가바이트로 할 경우
		int sizeLimit = 1024 * 1024 * 10;
		
		//전송 방식에 multipart 설정을 했는지 검사
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(!isMultipart){
			RequestDispatcher errorPage = request.getRequestDispatcher("notice/noticeError.jsp");
			request.setAttribute("code", "nomulti");
			errorPage.forward(request, response);
		}
		
		//업로드된 파일의 저장 위치 지정
		//1. 웹 컨테이너 내에 저장 위치를 지정할 경우
		//String savePath = request.getSession().getServletContext().getRealPath("/uploadFiles/");
		//2. 임의로 파일 저장 폴더를 만들고, 위치를 지정할 경우
		String savePath = "C:\\Users\\JH\\Dropbox\\workspace_easyStudy\\searchStudyProject\\searchStudy\\web\\uploadFiles";
		
		//전송받을 파일명 저장용 변수
		//String originalFileName1 = null;
		ArrayList<String> originalFileNames = new ArrayList<String>();
		
		//실제 저장할 때 사용할 파일명 저장용 변수
		//String renameFileName1 = null;
		ArrayList<String> renameFileNames = new ArrayList<String>();

		//업로드한 날짜와 시간을 파일명으로 사용할 경우
		//시스템으로부터 현재 날짜와 시간 정보를 얻어옴
		long currentTime = System.currentTimeMillis();
		
		//파일명으로 사용할 날짜/시간에 대한 포맷 설정
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		
		String storeId = multi.getParameter("storeId");
		String nickName = "easyStudy";
		//String nickName = "CandyCrushSoda";
		
		
		
		//리뷰저장 버튼 눌렀을 때
		double score = Double.parseDouble(multi.getParameter("star-input"));
		String contents = multi.getParameter("review_text");
		
		Review review = new Review(storeId, nickName, score, contents);
		
		int result = new ReviewService().addReview(review);
		
		//nickname을 통해 가장 최근에 등록한 review의 listNo 반환
		int listNo = 0;
		if(result > 0){
			listNo = new ReviewService().selectListNo(nickName);
		}
		System.out.println("listNo : " + listNo);
		
		
		//////////////////////////////////////////////////
		Enumeration<String> files = multi.getFileNames();
		
		while(files.hasMoreElements()){
		//for(int i = 0; files.hasMoreElements(); i++){
			String name = files.nextElement();
			String originalFileName = multi.getFilesystemName(name);
			if(originalFileName != null){
				originalFileNames.add(originalFileName);
			}
		}
		if(originalFileNames.size() > 0){
			Collections.reverse(originalFileNames);
		
			//바꿀 파일명 만들기
			int index = 1;
			System.out.println("index : " + index);
			
			for(int i = 0; i < originalFileNames.size(); i++){
				System.out.println("자.... 리네임을 시작합니다. 먼저!!!!!!!!! originalFileNames.size() : " + originalFileNames.size());
				if(originalFileNames != null){
					StringBuilder sb = new StringBuilder();
					System.out.println("originalFileNames.get(i) : " + originalFileNames.get(i));
					
					String renameFileName = sb.append(storeId + "_review_" + listNo + "_" + String.valueOf(index) + "."
								+ originalFileNames.get(i).substring(originalFileNames.get(i).lastIndexOf(".") + 1)).toString();
					System.out.println("*************************** after *****************************************");
					System.out.println("리네임!!!!!!!!!!!!!:" + renameFileName);
					
					renameFileNames.add(renameFileName);
					
					File saveFile = new File(savePath + "\\" + originalFileNames.get(i));
					File newFile = new File(savePath + "\\" + renameFileNames.get(i));
					//java.lang.IndexOutOfBoundsException: Index: 3, Size: 1
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
					index++;
				}
			}
		}
		
		//listNo를 가지고 ReviewImage 를 추가함
		
		int result2 = 0;
		ReviewImage reviewimage = null;
		System.out.println("아무것도 안들어간 originalFileNames ArrayList의 size : " + originalFileNames.size() + "\nrenameFileNames ArrayList의 size : " + renameFileNames.size());
		
		
		//System.out.println("1111111111111111111 : "+ renameFileNames.get(1));
		if(originalFileNames.size() == 0){
			reviewimage = new ReviewImage(listNo);
		}else if(originalFileNames.size() == 1){ // 사진 1장 업로드
			reviewimage = new ReviewImage(listNo, originalFileNames.get(0), renameFileNames.get(0));
		}else if(originalFileNames.size() == 2){ // 사진 2장 업로드
			System.out.println("dddddddddddddddddddddddddddddddd");
			reviewimage = new ReviewImage(listNo, originalFileNames.get(0), renameFileNames.get(0), 
					originalFileNames.get(1), renameFileNames.get(1));
			System.out.println("111111111111111111: " +reviewimage.toString());
		}else if(originalFileNames.size() == 3){ // 사진 3장 업로드
			reviewimage = new ReviewImage(listNo, originalFileNames.get(0), renameFileNames.get(0), 
					originalFileNames.get(1), renameFileNames.get(1), 
					originalFileNames.get(2), renameFileNames.get(2));
		}else if(originalFileNames.size() == 4){ // 사진 4장 업로드
			reviewimage = new ReviewImage(listNo, originalFileNames.get(0), renameFileNames.get(0), 
					originalFileNames.get(1), renameFileNames.get(1), 
					originalFileNames.get(2), renameFileNames.get(2), 
					originalFileNames.get(3), renameFileNames.get(3));
		}else if(originalFileNames.size() == 5){ // 사진 5장 업로드
			reviewimage = new ReviewImage(listNo, originalFileNames.get(0), renameFileNames.get(0), 
					originalFileNames.get(1), renameFileNames.get(1), 
					originalFileNames.get(2), renameFileNames.get(2), 
					originalFileNames.get(3), renameFileNames.get(3), 
					originalFileNames.get(4), renameFileNames.get(4));
		}
		result2 = new ReviewService().addReviewImage(reviewimage);
		
		
		//reivew 등록 성공&실패시 , reviewImage 등록 성공&실패시
		RequestDispatcher view = null;
		if(result > 0){
			response.sendRedirect("DView?storeId=" + storeId);
		}else{
			view = request.getRequestDispatcher("review/reviewError.jsp");
			request.setAttribute("code", "radd");
			view.forward(request, response);
		}
		
		///////////////////////////////////출력값 확인//////////////////////////////////////
		//Review
		System.out.println("AddServlet storeId : " + storeId);
		//System.out.println("AddServlet review listNo : " + reviewimage.getListNo());
		System.out.println("AddServlet score : " + score + "점");
		
		//ReviewImage
		for(int i = 0; i < originalFileNames.size(); i++)
			System.out.println("AddServlet originalFileName" + (i + 1) + " : " + originalFileNames.get(i));
		for(int i = 0; i < renameFileNames.size(); i++)
			System.out.println("AddServlet renameFileName" + (i + 1) + " : " + renameFileNames.get(i));
		///////////////////////////////////////////////////////////////////////////////
		System.out.println("///////////////////////////////////////////////AddServlet End///////////////////////////////////////////");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
