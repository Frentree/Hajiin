package com.org.iopts.detection.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;

public interface piChangeDAO {

	public List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> selectPathChangeList(HashMap<String, Object> params) throws SQLException;
	
	public void updateChangeApproval(HashMap<String, Object> params) throws SQLException;
	
	public void updatePathChangeApproval(HashMap<String, Object> params) throws SQLException;

	public void updateChangeFind(HashMap<String, Object> params) throws SQLException;
	
	public void insertUpdateTargetUserByChangeApproval(HashMap<String, Object> paramTarget) throws SQLException;
}