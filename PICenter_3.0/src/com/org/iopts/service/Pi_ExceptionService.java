package com.org.iopts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface Pi_ExceptionService {

	
	public List<Map<String, Object>> selectFindSubpath(HttpServletRequest request) throws Exception;
	
	public void registException(HttpServletRequest request) throws Exception;
	
	public void deleteException(HttpServletRequest request) throws Exception;

	public void registDeletion(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> getMatchObjects(HttpServletRequest request, String api_ver) throws Exception;
	
	public List<Map<String, Object>> selectExceptionList(HttpServletRequest request) throws Exception;	
	
	public List<Map<String, Object>> selectExceptionApprList(HttpServletRequest request) throws Exception;	
	
	public List<Map<String, Object>> selectDeletionList(HttpServletRequest request) throws Exception;
	
	public void deleteDeletion(HttpServletRequest request) throws Exception;

	public void registExceptionAppr(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectDownloadList(HashMap<String, Object> params, HashMap<String, Object> targetInfo) throws Exception;
}
