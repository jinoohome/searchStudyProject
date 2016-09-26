package mypage.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import mypage.model.dao.StoreDao;
import mypage.model.vo.SearchStore;

public class StoreService {


	public ArrayList<SearchStore> selectBookmark(String userid) {
		//user Bookmark
		Connection con = getConnection();
		System.out.println("서비스 실행");
		String[] bookmarks = new StoreDao().selectBookmark(con, userid);	
		System.out.println("스토어 확인 실행");
		
		ArrayList<SearchStore> list = new ArrayList<SearchStore>();
		for(int i = 0; i < bookmarks.length; i++){
			if(bookmarks[i] != null){
			  	SearchStore ss= new StoreDao().selectMyStore(con, bookmarks[i]);
			  	list.add(ss);
			}
		}
		
		close(con);
		return list;
	}
	
}
