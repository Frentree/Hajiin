package com.org.iopts.popup.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PopupService {

	List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectNoGroupList() throws Exception;

	List<Map<String, Object>> getTargetList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> getUserTargetList(Map<String, Object> map) throws Exception;

	// 공지사항 상세 보기
	Map<String, Object> noticeDetail(int id) throws Exception;

	// faq 상세보기
	Map<String, Object> faqDetail(int id) throws Exception;
	
	Map<String, Object> downloadDetail(int id) throws Exception;
	
	List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception;
	
	
	Map<String, Object> updateTargetUser(Map<String, Object> map) throws Exception;

	Map<String, Object> updateTargetUserlog(Map<String, Object> map);
	
	Map<String, Object> updatePCTargetUser(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectNetPolicy(HttpServletRequest request) throws Exception;
}
