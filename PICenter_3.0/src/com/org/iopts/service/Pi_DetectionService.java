package com.org.iopts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface Pi_DetectionService {

	public List<Map<String, Object>> selectFindSubpath(HttpServletRequest request);
	
	public List<Map<String, Object>> selectTeamMember(HttpServletRequest request);
	
	
	
	//public void registProcessGroup(HttpServletRequest request) throws Exception;
	public Map<String, Object> registProcessGroup(HttpServletRequest request) throws Exception;
	
	//public void registProcess(HttpServletRequest request) throws Exception;
	public void registProcess(HttpServletRequest request, Map<String, Object> GroupMap) throws Exception;
	
	public void registProcessCharge(HttpServletRequest request);
	
	
	//public void registPathExceptionGroup(HttpServletRequest request);
	public void registPathException(HttpServletRequest request);
	
	public void registPathExceptionCharge(HttpServletRequest request);
	
	
	public void registChange(HttpServletRequest request);
	
	
	
	public List<Map<String, Object>> selectProcessPath(HttpServletRequest request);
	
	//public List<Map<String, Object>> selectProcessGroupPath(HttpServletRequest request);
	public List<Map<String, Object>> selectProcessGroupPath(HashMap<String, Object> params);
	
	public List<Map<String, Object>> searchProcessList(HttpServletRequest request);

	public List<Map<String, Object>> searchApprovalListData(HttpServletRequest request);
	
	
	public Map<String, Object> selectExeptionName(HttpServletRequest request);
	
	public List<Map<String, Object>> selectExeptionPath(HttpServletRequest request);
	
	public List<Map<String, Object>> selectExceptionList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> exceptionApprovalListData(HttpServletRequest request) throws Exception;
	
	
	
	public List<Map<String, Object>> selectChangeList(HttpServletRequest request);

	public Map<String, Object> selectDocuNum(HttpServletRequest request);

	public void approvalPlus(HttpServletRequest request);

	public void updateProcessStatus(HttpServletRequest request);
	
	public void updateExcepStatus(HttpServletRequest request);

	public void updateExcepApproval(HttpServletRequest request);

	public void updateProcessApproval(HttpServletRequest request);

	public void updateChangeApproval(HttpServletRequest request);

}
