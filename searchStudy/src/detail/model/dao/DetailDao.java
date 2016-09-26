package detail.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import detail.model.vo.Image;
import detail.model.vo.Store;

public class DetailDao {
	public DetailDao() {
	}


	public Store selectRow(Connection con, String storeId) {
		Store store = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "SELECT * FROM STORE	WHERE STORE_ID = ?";

		try {

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				store = new Store();

				store.setStoreId(rset.getString("STORE_ID"));
				store.setStoreName(rset.getString("STORE_NAME"));
				store.setCategoryId(rset.getString("CATEGORY_ID"));
				store.setLocalCode(rset.getString("LOCAL_CODE"));
				store.setAddress(rset.getString("ADDRESS"));
				store.setHomepage(rset.getString("HOMEPAGE"));
				store.setTell(rset.getString("TELL"));
				store.setPrice(rset.getString("PRICE"));
				store.setWeekDayTime(rset.getString("WEEKDAY_TIME"));
				store.setWeekEndTime(rset.getString("WEEKEND_TIME"));
				store.setEtc(rset.getString("ETC"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//			System.out.println(store.toString());
		return store;
	}


	public Image selectPhoto(Connection con, String storeId) {
		Image image = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "SELECT * FROM STORE_IMAGE WHERE STORE_ID = ?";

		try {

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				image = new Image();
				image.setPhoto1(rset.getString("PHOTO_N1"));
				image.setPhoto2(rset.getString("PHOTO_N2"));
				image.setPhoto3(rset.getString("PHOTO_N3"));
				image.setPhoto4(rset.getString("PHOTO_N4"));
				image.setPhoto5(rset.getString("PHOTO_N5"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return image;
	}


	public int insertNewStore(Connection con, Store nstore) {
		// TODO Auto-generated method stub
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into STORE (STORE_ID,STORE_NAME, " + 
				"CATEGORY_ID, LOCAL_CODE, ADDRESS, " + 
				"HOMEPAGE, TELL, PRICE,WEEKDAY_TIME,WEEKEND_TIME,ETC) "
				+ "values ('ST'||LPAD(store_seq.nextval,4,0), ?, ?, ?,?,?,?,?,?,?,?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nstore.getStoreName());
			pstmt.setString(2, nstore.getCategoryId());
			pstmt.setString(3, nstore.getLocalCode());
			pstmt.setString(4, nstore.getAddress());
			pstmt.setString(5, nstore.getHomepage());
			pstmt.setString(6, nstore.getTell());
			pstmt.setString(7, nstore.getPrice());
			pstmt.setString(8, nstore.getWeekDayTime());
			pstmt.setString(9, nstore.getWeekEndTime());
			pstmt.setString(10, nstore.getEtc());

			
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}


	public int deleteStore(Connection con, String storeId) {
		// TODO Auto-generated method stub
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from store where STORE_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}


	public Store selectMap(Connection con, String storeId) {
		// TODO Auto-generated method stub
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		String query = "delete from store where STORE_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, storeId);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return null;
		
	//	return result;
	}


	public int updateStore(Connection con, Store store) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE STORE SET STORE_NAME=? , CATEGORY_ID = ?, "
				+ "LOCAL_CODE = ? , ADDRESS = ?,"
				+ "HOMEPAGE = ? , TELL = ?,"
				+ "PRICE = ? , WEEKDAY_TIME = ?,"
				+ "WEEKEND_TIME = ? , ETC = ?"
				+ "WHERE STORE_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, store.getStoreName());
			pstmt.setString(2, store.getCategoryId());
			pstmt.setString(3, store.getLocalCode());
			pstmt.setString(4, store.getAddress());
			pstmt.setString(5, store.getHomepage());
			pstmt.setString(6, store.getTell());
			pstmt.setString(7, store.getPrice());
			pstmt.setString(8, store.getWeekDayTime());
			pstmt.setString(9, store.getWeekEndTime());
			pstmt.setString(10, store.getEtc());
			pstmt.setString(11, store.getStoreId());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}


}