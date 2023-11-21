package com.org.iopts.detection.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface piApprovalService {

	// 정탐/오탐 리스트 조회
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 리스트 > 결재자 지정 조회 
	public List<HashMap<String, Object>> selectTeamMember(HttpServletRequest request)  throws Exception;
	
	// 기안자 검색
	public List<HashMap<String, Object>> searchTeamMember(HttpServletRequest request) throws Exception;

	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params)  throws Exception;
	
	// 정탐/오탐 리스트 > 결재 요청 팝업 결재 아이디 Seq 조회
	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트에 추가
	public HashMap<String, Object> registProcessCharge(HashMap<String, Object> params) throws Exception;

	HashMap<String, Object> registProcessCharge2(HashMap<String, Object> params) throws Exception;
	
	// 정탐/오탐 리스트 정보 수정
	public void updateProcessStatus(HashMap<String, Object> params, Map<String, Object> chargeMap) throws Exception;

	// 결재 카운드 수정
	public void approvalPlus(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트
	public List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트
	public List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트 - 조회
	public List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트 - 결재
	public void updateProcessApproval(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트 - 결재
	public void updateProcessApprovalAdminTwo(HashMap<String, Object> params) throws Exception;

	// 정탐/오탐 결재 리스트 - 재검색 스캔정보
	public List<HashMap<String, Object>> selectScanPolicy() throws Exception;

	// 정탐/오탐 결재 리스트 - 재검색 선택 Target 정보
	public List<HashMap<String, Object>> selectReScanTarget(HashMap<String, Object> params) throws Exception;

	// 결재 요청전 항목 삭제
	public void deleteItem(HashMap<String, Object> params) throws Exception;



}