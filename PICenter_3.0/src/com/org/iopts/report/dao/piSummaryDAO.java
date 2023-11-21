package com.org.iopts.report.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public interface piSummaryDAO {

	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> searchSummaryRegDateList(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> searchPCSummaryList(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> searchPCSummaryRegDateList(HashMap<String, Object> params) throws SQLException;
	
	/**
	 * 정탐/오탐 처리 flag 조회
	 * @return
	 * @throws SQLException
	 */
	public List<HashMap<String, Object>> searchDataProcessingFlag() throws SQLException;
	
	public List<HashMap<String, Object>> getMonthlyReport(String yyyymm) throws SQLException;

	public List<Map<String, Object>> selectPersonNotCom() throws SQLException;
	
	public List<Map<String, Object>> selectTeamNotCom() throws SQLException;

	public List<Map<String, Object>> selectOwnerList(Map<String, Object> map) throws SQLException;

	
	// 엑셀 다운로드 
	public List<Map<String, Object>> getGroupID(HashMap<String, Object> groupMap) throws SQLException;
	
	public List<Map<String, Object>> getTargetByNode(Map<String, Object> daoMap) throws SQLException;
	
	public Map<String, Object> getInfoId(Map<String, Object> resultMap) throws SQLException;
	
	public Map<String, Object> getsubpathTotal(Map<String, Object> resultMap) throws SQLException;
	
	public List<Map<String, Object>> getMngrUser(Map<String, Object> daoMap) throws SQLException;

	public List<Map<String, Object>> getDetailReportServers(HashMap<String, Object> params);
	
	
}