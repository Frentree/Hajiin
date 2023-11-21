package com.org.iopts.service; 

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_TargetVO;

import net.sf.json.JSONArray;

public interface Pi_TargetService {
	
	public List<Map<String, Object>> selectTarget() throws Exception;
	
	public List<Map<String, Object>> selectTargetManagement() throws Exception;
	
	public List<Map<String, Object>> selectTargetList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectTargetUser(HttpServletRequest request) throws Exception;	

	public void registTargetUser(HttpServletRequest request) throws Exception;
	
	// Targets Insert
	int insertTarget(List<Pi_TargetVO> list) throws Exception;
	
	public List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectServerList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectTargetUserList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectServerFileTopN(HttpServletRequest request);

	public List<Map<String, Object>> selectAdminServerFileTopN(HttpServletRequest request);	
	
	// 타켓 담당자 엑셀 업로드 
	Map<String,Object> targetManagerUpload(HttpServletRequest request);
	
	
	/**
	 * DMZ List 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDmzList(HashMap<String, Object> params, HttpServletRequest request) throws Exception;
	
	/**
	 * DMZ Info Save
	 * @param params
	 * @throws Exception
	 */
	public void saveDmzInfo(HashMap<String, Object> params) throws Exception;
	
	/**
	 * DMZ List Delete
	 * @param params
	 * @throws Exception
	 */
	public void deleteDmzList(HashMap<String, Object> params) throws Exception;

	public HashMap<String, Object> selectTargetById(HashMap<String, Object> params) throws Exception;

	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectUserGroupList(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> getTargetList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	public Map<String, Object> getGroupDetails(Map<String, Object> map) throws Exception;

	public void updateGroupDetails(Map<String, Object> map) throws Exception;

	public void addNewGroup(HttpServletRequest request, Map<String, Object> map) throws Exception;

	public void deleteGroup(HttpServletRequest request, Map<String, Object> map) throws Exception;

	public void deleteGroupIdx_target(HttpServletRequest request, Map<String, Object> map) throws Exception;

	public void pushTargetToGroup(HttpServletRequest request, Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectServerTargetUser(HttpServletRequest request);
	
	public List<Map<String, Object>> selectPCTargetUserName(HttpServletRequest request);
	
	public List<Map<String, Object>> selectPCTargetUser(HttpServletRequest request);
	
	public List<Map<String, Object>> selectPCTargetUserData(HttpServletRequest request);

	public List<Map<String, Object>> searchServerTargetUser(HttpServletRequest request);
	
	public List<Map<String, Object>> searchPCTargetUser(HttpServletRequest request);

	public List<Map<String, Object>> getExceptionList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> exceptionSearchList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectSKTManagerList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectAddSKTManagerList(HttpServletRequest request) throws Exception;
	
	Map<String, Object> insertSKTManager(Map<String, Object> map) throws Exception;
	
	Map<String, Object> deleteSKTManager(Map<String, Object> map) throws Exception;
	
	Map<String, Object> updateSKTManagerGrade(Map<String, Object> map) throws Exception;
	
	Map<String, Object> insertSKTManagerList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectPcManagerList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectVersionList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> apServerList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectMngrList(HttpServletRequest request);
	
	public List<Map<String, Object>> selectInaccessibleList(HttpServletRequest request) throws Exception;
	
	public void updateChkStatus(HashMap<String, Object> params) throws Exception;
}
