package store.model.service;

import java.util.ArrayList;
import store.model.dao.StoreDao;
import store.model.vo.SearchStore;
import java.sql.*;
import static common.JDBCTemplate.*;

public class StoreService {
	public StoreService(){}

	public ArrayList<SearchStore> searchStoreInfo(String[] ctg, String[] areas, int limit, int currentPage, String sort) {
		ArrayList<SearchStore> list = null;
		Connection con = getConnection();
		list = new StoreDao().searchStoreInfo(con, ctg, areas, limit, currentPage, sort);
		close(con);
		return list;
	}

	public int getListCount(String[] categorys, String[] areas) {
		Connection con = getConnection();
		int listCount = new StoreDao().getListCount(con, categorys, areas);
		close(con);
		return listCount;
	}
}
