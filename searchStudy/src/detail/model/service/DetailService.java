package detail.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import detail.model.dao.DetailDao;
import detail.model.vo.Image;
import detail.model.vo.Store;

public class DetailService {

	public DetailService() {
	}

	public Store selectRow(String storeId) {
		Connection con = getConnection();
		Store store = new DetailDao().selectRow(con, storeId);
		return store;
	}

	public Image selectPhoto(String storeId) {
		Connection con = getConnection();
		Image image = new DetailDao().selectPhoto(con, storeId);
		return image;
	}

	public int insertNewStore(Store nstore) {
		// TODO Auto-generated method stub
			
		Connection con = getConnection();
		int result = new DetailDao().insertNewStore(con, nstore);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int delectStore(String storeId) {
		// TODO Auto-generated method stub
		Connection con = getConnection();
		
		int result = new DetailDao().deleteStore(con, storeId);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public Store selectMap(String storeId) {
		// TODO Auto-generated method stub
		Connection con = getConnection();
		Store store= new DetailDao().selectMap(con, storeId);
		return store;
	}

	public int updateStore(Store store) {
		// TODO Auto-generated method stub
		Connection con = getConnection();
		int result = new DetailDao().updateStore(con, store);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	

}
