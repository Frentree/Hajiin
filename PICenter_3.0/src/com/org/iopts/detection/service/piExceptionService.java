package com.org.iopts.detection.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface piExceptionService {

	public List<HashMap<String, Object>> selectExceptionList(HashMap<String, Object> params) throws Exception;

	public List<HashMap<String, Object>> selectExeptionPath(HashMap<String, Object> params)  throws Exception;

	// 경로 예외 리스트 > 결재 요청 팝업 결재 아이디 Seq 조회
	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws Exception;

	// 경로 예외 결재 리스트에 추가
	public HashMap<String, Object> registPathExceptionCharge(HashMap<String, Object> params) throws Exception;

	// 경로 예외 리스트 정보 수정
	public void updateExcepStatus(HashMap<String, Object> params, HashMap<String, Object> chargeMap) throws Exception;

	public List<HashMap<String, Object>> exceptionApprovalAllListData(HashMap<String, Object> params) throws Exception;

	public List<HashMap<String, Object>> exceptionApprovalListData(HashMap<String, Object> params) throws Exception;

	public List<HashMap<String, Object>> selectExceptionGroupPath(HashMap<String, Object> params) throws Exception;

	public void updateExcepApproval(HashMap<String, Object> params, String recon_id, String recon_password, String recon_url, String api_ver) throws Exception;
	
	public List<HashMap<String, Object>> selectReScanTarget(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> updateReScanGroup(HashMap<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> glovalFilterDetail(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> insertGlovalFilterDetail(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> updateGlovalFilterDetail(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> deleteGlovalFilterDetail(HttpServletRequest request) throws Exception;
}
