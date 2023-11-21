package com.org.iopts.search.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SearchService {

	Map<String, Object> insertProfile(HttpServletRequest request) throws Exception;

	List<Map<String, Object>> getProfile(HttpServletRequest request) throws Exception;

	Map<String, Object> updateProfile(HttpServletRequest request) throws Exception;

	Map<String, Object> deleteProfile(HttpServletRequest request) throws Exception;

	List<Map<String, Object>> getPolicy(HttpServletRequest request) throws Exception;

	Map<String, Object> deletePolicy(HttpServletRequest request) throws Exception;

	Map<String, Object> modifyPolicy(HttpServletRequest request) throws Exception;

	Map<String, Object> insertPolicy(HttpServletRequest request) throws Exception;

	List<Map<String, Object>> getStatusList(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> getUserList(HttpServletRequest request) throws Exception;

	Map<String, Object> registSchedule(HttpServletRequest request, String api_ver) throws Exception;
	
	Map<String, Object> registPCSchedule(HttpServletRequest request, String api_ver) throws Exception;
	
	List<Map<String, Object>> registScheduleGroup(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> registScheduleTargets(HttpServletRequest request) throws Exception;
	
	Map<String, Object> changeSchedule(HttpServletRequest request, String api_ver) throws Exception;
	
	Map<String, Object> changeScheduleAll(List<String> taskList, HttpServletRequest request, String api_ver) throws Exception;
	
	Map<String, Object> completedSchedule(HttpServletRequest request) throws Exception;

	List<Map<String, Object>> selectScanDataTypes(HttpServletRequest request) throws Exception;
	
	Map<String, Object> selectSKTScanDataTypes(HttpServletRequest request) throws Exception;
	
	Map<String, Object> confirmApply(HttpServletRequest request, String api_ver) throws Exception;
	
	Map<String, Object> updateSchedule(HttpServletRequest request) throws Exception;
	
	void updateReconSchedule(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> selectNetHost(HttpServletRequest request) throws Exception;
	
	Map<String, Object> getScanDetails(HttpServletRequest request, String api_ver) throws Exception;
	
	Map<String, Object> insertNetPolicy(HttpServletRequest request) throws Exception;
	
	Map<String, Object> insertOneDrivePolicy(HttpServletRequest request) throws Exception;
	
	Map<String, Object> updateNetPolicy(HttpServletRequest request) throws Exception;
	
	Map<String, Object> updateOneDrivePolicy(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> selectPCPolicy(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> selectPCPolicyTime(HttpServletRequest request) throws Exception;
	
	void deletePCPolicy(HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> selectPCSearchStatus(HttpServletRequest request) throws Exception;

	Map<String, Object> selectUserSearchCount(HttpServletRequest request) throws Exception;

	List<Map<String, Object>> netList(HttpServletRequest request);

	Map<String, Object> insertNetIp(HttpServletRequest request) throws Exception;
	
	Map<String, Object> updateNetIp(HttpServletRequest request) throws Exception;
	
	void deleteNetIp(HttpServletRequest request) throws Exception;

	int insertNetListIp(HashMap<String, Object> params, HttpServletRequest request) throws Exception;

	Map<String, Object> insertNetList(HashMap<String, Object> params, HttpServletRequest request) throws Exception;

	int insertFilterList(HashMap<String, Object> params, HttpServletRequest request) throws Exception;

	

}
