package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_Scan_HostVO;
import com.org.iopts.dto.Pi_ScheduleVO;

import net.sf.json.JSONObject;

public interface Pi_ScanService {
	
	public List<Map<String, Object>> selectSchedules(HttpServletRequest request) throws Exception;
	
	public List<Pi_ScheduleVO> selectSchedule(String schedule_status) throws Exception;

	public Map<String, Object> changeSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url, String api_ver) throws Exception;

	public Map<String, Object> viewSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url, String api_ver) throws Exception;
	
	public List<Pi_Scan_HostVO> selectScanHost() throws Exception;
	
	public List<Map<String, Object>> selectLocationList() throws Exception;
	
	public List<Map<String, Object>> selectDatatypeList() throws Exception;
	
	public List<Map<String, Object>> selectDatatypeListMod(HttpServletRequest request) throws Exception;

	public Map<String, Object> registSchedule(HttpServletRequest request, String api_ver) throws Exception;

	public Map<String, Object> getProfileDetail(HttpServletRequest request, String recon_id, String recon_password, String recon_url, String api_ver) throws Exception;

	public List<Map<String, Object>> viewScanHistory(HttpServletRequest request);

	public List<Map<String, Object>> viewScanPolicy(HttpServletRequest request);

	public Map<String, Object> registPolicy(HttpServletRequest request) throws Exception;
	
	public void updatePolicy(HttpServletRequest request);
	
	public List<Map<String, Object>> getProfile(HttpServletRequest request);
	
	public Map<String, Object> insertProfile(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> updateProfile(HttpServletRequest request) throws Exception;
	
	public void deleteProfile(HttpServletRequest request) throws Exception;

	public void resetDefaultPolicy(HttpServletRequest request);

	public void updateDefaultPolicy(HttpServletRequest request);

	public Map<String, Object> manageSchedule(HttpServletRequest request);

	public Map<String, Object> getScanSchedule(HttpServletRequest request);

	public Map<String, Object> executeChecked(JSONObject data, HttpServletRequest request);

	public Map<String, Object> deleteSchedule(HttpServletRequest request);

	public Map<String, Object> getDetails(HttpServletRequest request) throws Exception;

	public Map<String, Object> registSchedule_user(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectLocationList(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> getApList(HttpServletRequest request) throws Exception;

	public Map<String, Object> getPolicyByApno(HttpServletRequest request) throws Exception;

	public Map<String, Object> insertPolicy(HttpServletRequest request) throws Exception;

	public Map<String, Object> getScanDetails(HttpServletRequest request, String recon_id, String recon_password,String recon_url);

}