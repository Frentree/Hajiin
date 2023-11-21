package com.org.iopts.popup.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PopupDAO {

	List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws SQLException;

	List<Map<String, Object>> selectNoGroupList() throws SQLException;

	List<Map<String, Object>> getTargetList(Map<String, Object> map) throws SQLException;

	List<Map<String, Object>> getUserTargetList(Map<String, Object> map) throws SQLException;

	// 공지사항 상세보기
	Map<String, Object> noticeDetail(int map);

	// faq 상세보기
	Map<String, Object> faqDetail(int map);
	
	Map<String, Object> downloadDetail(int map);
	
	List<Map<String, Object>> selectUserList(Map<String, Object> map) throws SQLException;
	
	void updateTargetUser(Map<String, Object> map) throws SQLException;

	void updateTargetUserlog(Map<String, Object> map);
	
	void updatePCTargetUser(Map<String, Object> map) throws SQLException;

	void updateUserGrade(Map<String, Object> map);
	
	List<Map<String, Object>> selectNetPolicy(Map<String, Object> map) throws SQLException;
}
