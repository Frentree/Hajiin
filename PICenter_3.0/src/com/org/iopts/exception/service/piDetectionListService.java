package com.org.iopts.exception.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface piDetectionListService {

	List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws SQLException;
	
	List<HashMap<String, Object>> selectDetectionApprovalList(HashMap<String, Object> params) throws SQLException;
	
	List<Map<String, Object>> getDetectionApprovalList(HttpServletRequest request) throws Exception;
	
	List<HashMap<String, Object>> subpathSelect(HashMap<String, Object> params) throws SQLException;

	List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception;

	HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) throws Exception;

	HashMap<String, Object> registProcessGroup(HashMap<String, Object> params) throws Exception;

	void registProcess(HashMap<String, Object> params, HashMap<String, Object> groupMap) throws Exception;

	void cancelApproval(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> personalApprovalData(HashMap<String, Object> params) throws Exception;

	public List<Map<String, Object>> queryCustomDataTypes() throws Exception;
	
	public List<Map<String, Object>> queryMatchDetail() throws Exception;

}
