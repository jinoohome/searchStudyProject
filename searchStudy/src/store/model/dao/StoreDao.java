package store.model.dao;

import java.sql.*;
import java.util.ArrayList;

import store.model.vo.SearchStore;
import static common.JDBCTemplate.*;

public class StoreDao {
	public StoreDao(){}

	public ArrayList<SearchStore> searchStoreInfo(Connection con, String[] ctg, String[] areas, int limit, int currentPage, String sort) {
		ArrayList<SearchStore> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from (select rownum rnum, STORE_ID, STORE_NAME, CATEGORY_ID, "
				+ "CATEGORY_NAME, LOCAL_CODE, LOCAL_NAME, PRICE, HOMEPAGE, PHOTO_N1, AVG "
				+ "from(select * from search_store where local_code in(?,?,?) and category_id in(?,?,?,?) "
				+ "order by count asc)) where rnum>=? and rnum <=?";
		
		if(sort.equals("avg_grade")){
			query = "select * from (select rownum rnum, STORE_ID, STORE_NAME, CATEGORY_ID, "
					+ "CATEGORY_NAME, LOCAL_CODE, LOCAL_NAME, PRICE, HOMEPAGE, PHOTO_N1, AVG "
					+ "from(select * from search_store where local_code in(?,?,?) and category_id in(?,?,?,?) "
					+ "order by AVG asc)) where rnum>=? and rnum <=?";
		}
		
		int startRow = (currentPage - 1) * 9 + 1; // 읽기 시작할 row 번호.
		int endRow = startRow + limit - 1; // 읽을 마지막 row 번호.
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, areas[0]);
			pstmt.setString(2, areas[1]);
			pstmt.setString(3, areas[2]);
			pstmt.setString(4, ctg[0]);
			pstmt.setString(5, ctg[1]);
			pstmt.setString(6, ctg[2]);
			pstmt.setString(7, ctg[3]);
			pstmt.setInt(8, startRow);
			pstmt.setInt(9, endRow);
			
			rset = pstmt.executeQuery();
			
			boolean flag =true;
			while(rset.next()){
				if(flag==true){
					list = new ArrayList<SearchStore>();
					flag=false;
				}
				
				SearchStore st = new SearchStore();
				st.setStoreId(rset.getString("store_id"));
				st.setStoreName(rset.getString("store_name"));
				st.setLocalName(rset.getString("local_name"));
				st.setCategoryName(rset.getString("category_name"));
				st.setScore(rset.getInt("avg"));
				st.setPrice(rset.getString("price"));
				st.setHomepage(rset.getString("homepage"));
				st.setImgRoute(rset.getString("photo_n1"));
				
				list.add(st);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getListCount(Connection con, String[] categorys, String[] areas) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from (select * from search_store where local_code in(?,?,?) and category_id in(?,?,?,?))";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, areas[0]);
			pstmt.setString(2, areas[1]);
			pstmt.setString(3, areas[2]);
			pstmt.setString(4, categorys[0]);
			pstmt.setString(5, categorys[1]);
			pstmt.setString(6, categorys[2]);
			pstmt.setString(7, categorys[3]);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1); // select 한 첫번째 항목값
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}
}
