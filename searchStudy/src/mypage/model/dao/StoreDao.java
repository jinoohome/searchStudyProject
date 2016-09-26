package mypage.model.dao;



import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mypage.model.vo.SearchStore;

public class StoreDao{


	public String[] selectBookmark(Connection con, String userid) {
		// userManagement List 
		System.out.println("dao 실행");
		String[] bookmarks = new String[9];
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		System.out.println("userid" + userid);
		//아이디에 따른 북마크 테이블 조회
		String query = "SELECT * FROM USER_BOOKMARKS WHERE USER_ID = ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);			
			rset = pstmt.executeQuery();
			System.out.println("쿼리 실행");
			
			
			
			if(rset.next() ){
				System.out.println("있습니다.");
				 bookmarks[0] = rset.getString("BOOKMARK_N1");
				 bookmarks[1] = rset.getString("BOOKMARK_N2");
				 bookmarks[2] = rset.getString("BOOKMARK_N3");
				 bookmarks[3] = rset.getString("BOOKMARK_N4");
				 bookmarks[4] = rset.getString("BOOKMARK_N5");
				 bookmarks[5] = rset.getString("BOOKMARK_N6");
				 bookmarks[6] = rset.getString("BOOKMARK_N7");
				 bookmarks[7] = rset.getString("BOOKMARK_N8");
				 bookmarks[8] = rset.getString("BOOKMARK_N9");
			}
			
			for(int i = 0; i <bookmarks.length; i++){
				System.out.println("북마크"+bookmarks[i]);
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return bookmarks;
	}

	public SearchStore selectMyStore(Connection con, String bookmark) {
		// 북마크 내역 확인
		System.out.println("dao 실행 2");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		SearchStore stores = null;
		
		String query = "select * "
						+ " from ( "
									+ " select STORE_ID, STORE_NAME, CATEGORY_ID, CATEGORY_NAME, LOCAL_CODE, "
									+ " LOCAL_NAME, PRICE, HOMEPAGE, PHOTO_N1, AVG "
									+ " from ( select * "
											+ "	 from search_store "
											+ "  where STORE_ID = ? ) ) ";
											 
		 try {
			 pstmt = con.prepareStatement(query);
			 pstmt.setString(1, bookmark);
			 
			 rset = pstmt.executeQuery();
			 
			 System.out.println("쿼리 완료");
			 
				while(rset.next()){
					
					System.out.println("내용출력");
					stores = new SearchStore();
					stores.setStoreId(rset.getString("STORE_ID"));
					stores.setStoreName(rset.getString("store_name"));
					stores.setLocalName(rset.getString("local_name"));
					stores.setCategoryName(rset.getString("category_name"));
					stores.setScore(rset.getInt("avg"));
					stores.setPrice(rset.getString("price"));
					stores.setHomepage(rset.getString("homepage"));
					stores.setImgRoute(rset.getString("photo_n1"));
					
				}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		
		return stores;
	}




	
	
	
}
