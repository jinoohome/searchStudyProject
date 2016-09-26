package store.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import store.model.service.StoreService;
import store.model.vo.SearchStore;

import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class StoreSearchServlet
 */
@WebServlet("/search.store")
public class StoreSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public StoreSearchServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//메뉴바에서 받아오는 정보
		String[] category = request.getParameterValues("category");
		String[] area= request.getParameterValues("area");
		
		String categorys[] = {"none","none","none","none"};
		String areas[] = {"none","none","none"};
		
		//contents에서 검색되는 정보
		String gn = request.getParameter("gn");
		String jl = request.getParameter("jl");
		String sc = request.getParameter("sc");
		
		String room = request.getParameter("room");
		String cafe = request.getParameter("cafe");
		String library = request.getParameter("library");
						
		//검색결과 저장
		String local ="";
		String cate ="";
		
		//페이징하는 곳에서 처음 검색된 정보 받아오기 
		String reCategory = request.getParameter("categorys");
		String reArea= request.getParameter("areas");
		System.out.println(reCategory+" : "+reArea);
		if(reCategory != null || reArea != null){
			category = reCategory.split(",");
			area = reArea.split(",");
		}
		
		
			if(area !=null){
				for(int i=0; i<area.length; i++){
					if(i<area.length-1){
					switch(area[i]){
					case "GN" : local +="강남/"; break;
					case "JL" : local +="종로/"; break;
					case "SC" : local +="신촌/"; break;
					}
					}else{
						switch(area[i]){
						case "GN" : local +="강남"; break;
						case "JL" : local +="종로"; break;
						case "SC" : local +="신촌"; break;

					}
					}
				}
				
				for(int i=0; i<area.length; i++){
					areas[i]= area[i];
				}
				
			}else{
				if(gn != null){
					areas[0]= gn;
					areas[1]= "none";
					areas[2]= "none";
					local = "강남";
				}else if(jl != null){
					areas[0]= jl;
					areas[1]= "none";
					areas[2]= "none";
					local = "종로";
				}else if(sc != null){
					areas[0]= sc;
					areas[1]= "none";
					areas[2]= "none";
					local = "신촌";
				}
				else{
					areas[0] = "GN";
					areas[1] = "JL";
					areas[2] = "SC";
				}
			}
				
				
				
			if(category != null){
				for(int i=0; i<category.length; i++){
					if(i<category.length-1){
					switch(category[i]){
					case "S10" : cate +="도서관/독서실/"; break;
					case "S20" : cate +="스터디룸/"; break;
					case "S30" : cate +="스터디카페/"; break;
					}
					}else{
						switch(category[i]){
						case "S10" : cate +="도서관/독서실"; break;
						case "S20" : cate +="스터디룸"; break;
						case "S30" : cate +="스터디카페"; break;

					}
					}
				}
				for(int i=0; i<category.length; i++){
					categorys[i]= category[i];
				}
				
				for(int i=0; i <categorys.length; i++){
					if(categorys[i].equals("S20") ||categorys[i].equals("S30")){
						categorys[3] = "S40";
					}
				}
			}else{
				if(room != null || cafe !=null || library != null){
					categorys[0] = room;
					categorys[1] = cafe;
					categorys[2] = library;
					if(library != null){
						categorys[3] = "none";
					}else{
						categorys[3]="S40";
					}
				}else{
					categorys[0] = "S10";
					categorys[1] = "S20";
					categorys[2] = "S30";
					categorys[3] = "S40";
				}
			}
			
		//페이지 수 처리용 변수 
		int currentPage = 1;
		int limit = 9;	//한 페이지에 9개씩 출력
		
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		//전체 목록 갯수와 목록 전체를 리턴받음
		StoreService storeS = new StoreService();
		
		int listCount = storeS.getListCount(categorys, areas);
		ArrayList<SearchStore> list = storeS.searchStoreInfo(categorys, areas, limit, currentPage);
		
		//총 페이지수 계산 : 목록이 최소 1개일 때, 1 page 로 처리하기 위해 0.9 더함
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지에 보여줄 시작 페이지 수 (1, 10, 20, .....)
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		//현재 페이지에 보여줄 마지막 페이지 수 (9, 19, 29, .....)
		int endPage = startPage + limit - 1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		
		
		//검색된 단어 페이징 부분에 보내야함...재검색해서 다음 페이지 보여줘야해서
		String cg ="";
		String as ="";
		for(int i=0; i<categorys.length; i++){
			System.out.println("category:"+categorys[i]);
			if(i<categorys.length-1)
				cg += categorys[i]+",";
			else
				cg += categorys[i];
		}
		System.out.println(cg);
	
		for(int i=0; i<areas.length; i++){
			System.out.println("area:"+areas[i]);
			if(i<areas.length-1)
				as += areas[i]+",";
			else
				as += areas[i];
		}
		System.out.println(as);
		
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("search1.jsp");
			request.setAttribute("list", list);
			request.setAttribute("categorys", cg); 
			request.setAttribute("areas", as); 
			request.setAttribute("category", cate); //화면에 결과 보여줄 카테고리 단어
			request.setAttribute("area", local); // 화면에 결과 보여줄 카테고리 단어
			request.setAttribute("currentPage", currentPage);	//현재 페이지
			request.setAttribute("maxPage", maxPage); //최대 페이지 수
			request.setAttribute("startPage", startPage); //현재 페이지에 표시할 첫 페이지값
			request.setAttribute("endPage", endPage);  //현재 페이지에 표시할 끝 페이지 값
			request.setAttribute("listCount", listCount); //총 글 수
			
			view.forward(request, response);
		}else{
			response.sendRedirect("error.html");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
					
	}

}
