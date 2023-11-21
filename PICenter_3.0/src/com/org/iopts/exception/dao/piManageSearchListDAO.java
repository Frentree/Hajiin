package com.org.iopts.exception.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface piManageSearchListDAO {
	
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params) throws SQLException;
	
}
