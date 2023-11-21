package com.org.iopts.exception.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface piDetectionListDAO {

	public List<HashMap<String, Object>> selectFindSubpath2(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> selectDetectionApprovalList(HashMap<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> getDetectionApprovalList(Map<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> subpathSelect(HashMap<String, Object> params) throws SQLException;

	public List<Map<String, Object>> selectUserTargetList(Map<String, Object> searchMap);

	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params);

	public void registProcessGroup(HashMap<String, Object> params);

	public void registProcess(HashMap<String, Object> params);

	public String selectIdx(Map<String, Object> map);

	public void deleteDataProcessing(Map<String, Object> map);

	public int getCountProcessingGroup(Map<String, Object> map);

	public void deleteDataProcessingGroup(Map<String, Object> map);
	
	public List<HashMap<String, Object>> personalApprovalData(HashMap<String, Object> params) throws SQLException;
	
	public List<Integer> queryCustomDataTypesCnt() throws SQLException;
	
	public List<Map<String, Object>> queryCustomDataTypes() throws SQLException;
	
	public List<Map<String, Object>> queryMatchDetail() throws SQLException;

	public List<Map<String, Object>> queryCustomDataRules() throws SQLException;

}
