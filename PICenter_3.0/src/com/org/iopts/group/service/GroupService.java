package com.org.iopts.group.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.group.vo.GroupTreeServerVo;

import net.sf.json.JSONArray;

public interface GroupService {
	//서버 & PC 전체 데이타
	String selectUserGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	String selectUserListGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	// 예외관리 서버 그룹 데이터
	JSONArray selectExceptionServerList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	// 예와관리 서버 호스트명 데이터
	JSONArray selectExceptionHostList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//서버 그룹 데이터
	String selectServerGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//서버 그룹 데이터
	String selectDeptGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//서버 그룹 데이터
	JSONArray selectDashSeverDept(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//PC 그룹 데이터
	JSONArray selectDashPCDept(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	// 서버 + PC 그룹데이터
	JSONArray selectDashDeptList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//PC 그룹 데이터
	JSONArray selectPCGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;

	//그룹 데이터
	List<Map<String, Object>> selectGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//타겟 그룹 이동
	int moveTargetGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//skt Toms 데이터
	JSONArray selectTomsGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//skt Toms 미그룹데이터
	//JSONArray selectTomsNotGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	JSONArray selectUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;

	//skt 그룹 생성
	JSONArray insertUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//skt 그룹 변경
	int updateUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//skt 그룹 삭제
	String deleteUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//skt 사용자 그룹 서버 저장
	JSONArray insertUserTargets(Map<String, Object> map, HttpServletRequest request) throws Exception;

	// Host 검색 데이터
	String selectUserHostGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;

	//SubPath
	JSONArray selectSubPath(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	// PC 망/그룹/PC 선택
	JSONArray selectNetList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	String userReportGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	String selectUserHostOneDriveList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	String userReportHostList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	String selectPopupServerGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	JSONArray selectLicenseGroup(Map<String, Object> map, HttpServletRequest request) throws Exception;

	// NAS
	JSONArray selectNASList(Map<String, Object> map, HttpServletRequest request) throws Exception;
}
