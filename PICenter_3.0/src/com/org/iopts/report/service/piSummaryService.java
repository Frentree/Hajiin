package com.org.iopts.report.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface piSummaryService {
	
	// 정탐/오탐 리스트 조회
	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws Exception;
	
	/**
	 * 정탐/오탐 처리 flag 조회
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, Object>> searchDataProcessingFlag() throws Exception;

	public List<HashMap<String, Object>> getMonthlyReport(HashMap<String, Object> params) throws Exception;

	public List<Map<String, Object>> selectPersonNotCom() throws Exception;

	public List<Map<String, Object>> selectTeamNotCom() throws Exception;

	public List<Map<String, Object>> selectOwnerList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getExcelDownCNT(HashMap<String, Object> params) throws Exception;

	public Map<String, Object> reportDetailData(HttpServletRequest request, HashMap<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> reportTargetList(HttpServletRequest request, HashMap<String, Object> params) throws Exception;
}