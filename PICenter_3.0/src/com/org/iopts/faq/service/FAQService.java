package com.org.iopts.faq.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface FAQService {

	List<Map<String, Object>> faqList(HttpServletRequest request);

	List<Map<String, Object>> faqSearchList(HttpServletRequest request);
	
	public void faqInsert(HttpServletRequest request);
	
	public void faqUpdate(HttpServletRequest request);

	public void faqDelete(HttpServletRequest request);

	// 댓글
	List<Map<String, Object>> selectList(HttpServletRequest request);

	public void insertReply(HttpServletRequest request) throws Exception;

	public void updateReply(HttpServletRequest request) throws Exception;
	
	public void deleteReply(HttpServletRequest request) throws Exception;

	

	
	


}
