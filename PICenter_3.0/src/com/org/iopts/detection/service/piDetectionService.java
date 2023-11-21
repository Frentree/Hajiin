package com.org.iopts.detection.service;

import java.util.HashMap;
import java.util.List;

public interface piDetectionService {

	public List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> select_process_docu_num(HashMap<String, Object> params) throws Exception;

	public HashMap<String, Object> selectExceptionDocuNum(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> selectDMZTime() throws Exception;

	public HashMap<String, Object> registProcessGroup(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> regist_process_group(HashMap<String, Object> params) throws Exception;
	
	public void registProcess(HashMap<String, Object> params, HashMap<String, Object> GroupMap) throws Exception;
	
	public void regist_process(HashMap<String, Object> params, HashMap<String, Object> GroupMap) throws Exception;
	
	public void registPathException(HashMap<String, Object> params) throws Exception;
	
	public void registPathCharge(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectTeamMember(HashMap<String, Object> params) throws Exception;
	
	public void registChange(HashMap<String, Object> params) throws Exception;

	public List<HashMap<String, Object>> selectDownloadList(HashMap<String, Object> params,	HashMap<String, Object> targetInfo) throws Exception;

	
}
