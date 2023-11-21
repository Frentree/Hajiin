package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_AgentVO;

public interface Pi_DashService {
	
	public List<Pi_AgentVO> selectDashMenu() throws Exception;
	
	public Map<String, Object> selectDashInfo(HttpServletRequest request, String recon_id) throws Exception;
	
	public List<Map<String,Object>> selectDatatype(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDatatypes(HttpServletRequest request) throws Exception;
	
	public List<Map<String,Object>> selectDatatypeManager(HttpServletRequest request) throws Exception;

	public List<Object> selectSystemCurrent(HttpServletRequest request);
	
	public List<Object> selectSystemCurrentPC(HttpServletRequest request);
	
	public List<Object> selectSystemCurrentManager(HttpServletRequest request);
	
	public List<Object> selectSystemCurrentService(HttpServletRequest request);
	
	public List<Object> selectServerExcelDownload(HttpServletRequest request);
	
	public List<Object> selectServerExcelDownloadList(HttpServletRequest request, List<String> targetList) throws Exception;
	
	public List<Object> selectPCExcelDownload(HttpServletRequest request);
	
	public List<Object> selectPCExcelDownloadList(HttpServletRequest request, List<String> targetList) throws Exception;
	
	public List<Object> selectPathCurrent(HttpServletRequest request);

	public List<Object> selectJumpUpHost(HttpServletRequest request);

	public Map<String, Object> selectlastScanDate(HttpServletRequest request);
	
	public Map<String, Object> selectWebLink() throws Exception;

	public List<Object> selectNotAction_group(HttpServletRequest request);
	
	public Map<String, Object> selectDashDataDetectionList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataDetectionServerList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataDetectionPCList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataCompleteList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataDetectionItemList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashPersonalServerDetectionItemList(HttpServletRequest request, List<String> targetList) throws Exception;
	
	public Map<String, Object> selectDashPersonalServerComplete(HttpServletRequest request, List<String> targetList) throws Exception;
	
	public List<Object> selectDashDataRank(HttpServletRequest request);
	
	public List<Map<String, Object>> selectDashPersonalServerRank(HttpServletRequest request, List<String> targetList);
	
	public List<Map<String, Object>> selectDashPersonalPCRank(HttpServletRequest request, List<String> targetList);
	
	public List<Object> selectDashPersonalManagerRank(HttpServletRequest request);
	
	public List<Object> selectDashDataImple(HttpServletRequest request);
	
	public List<Object> selectDashDataImpleManager(HttpServletRequest request);
	
	public List<Map<String, Object>> selectDashPersonalServerImple(HttpServletRequest request, List<String> targetList) throws Exception;
	
	public List<Map<String, Object>> selectDashDataPersonalServer(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectDashDataPersonalPC(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataPersonalServerCount(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectDashDataPersonalServerCircle(HttpServletRequest request, List<String> targetList);
	
	public List<Map<String, Object>> selectDashDataPersonalPCCircle(HttpServletRequest request, List<String> targetList);
	
	public Map<String, Object> selectDashDataTodoList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataTodoApproval(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDashDataTodoSchedule(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> approvalTest(HttpServletRequest request) throws Exception;
	
	public List<Object> selectDashPCJstreePopup(HttpServletRequest request) throws Exception;

	// 관리자 dashboard pc progress
	public List<Object> selectSystemCurrentProgressPC(HttpServletRequest request);
	
	public List<Map<String, Object>> selectDashPersonalProgressPc(HttpServletRequest request, List<String> targetList);

	public List<Object> selectSystemCurrentProgressOneDrive(HttpServletRequest request);

	public List<Map<String, Object>> selectDashPersonalProgressOneDrive(HttpServletRequest request, List<String> targetList);

	

}
