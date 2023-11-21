package com.org.iopts.faq.dao;

import java.util.List;
import java.util.Map;

public interface FAQDAO {

	List<Map<String, Object>> faqList();

	List<Map<String, Object>> getStatusList(Map<String, Object> map);

	void faqInsert(Map<String, Object> input);
	
	void faqUpdate(Map<String, Object> update);

	void faqDeleteReply(Map<String, Object> delete);
	
	void faqDelete(Map<String, Object> delete);
	
	// 댓글
	List<Map<String, Object>> selectList(Map<String, Object> map);

	void insertReply(Map<String, Object> input);

	void updateReply(Map<String, Object> input);

	void deleteReply(Map<String, Object> input);



	



}
