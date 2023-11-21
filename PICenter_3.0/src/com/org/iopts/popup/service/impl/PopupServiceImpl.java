package com.org.iopts.popup.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.popup.dao.PopupDAO;
import com.org.iopts.popup.service.PopupService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class PopupServiceImpl implements PopupService {

	private static Logger log = LoggerFactory.getLogger(PopupServiceImpl.class);
	
	@Inject
	private PopupDAO dao;

	@Override
	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception {
		return dao.selectGroupList(map);
	}

	@Override
	public List<Map<String, Object>> selectNoGroupList() throws Exception {
		return dao.selectNoGroupList();
	}

	@Override
	public List<Map<String, Object>> getTargetList(Map<String, Object> map) throws Exception {
		return dao.getTargetList(map);
	}
	
	@Override
	public List<Map<String, Object>> getUserTargetList(Map<String, Object> map) throws Exception {
		return dao.getUserTargetList(map);
	}

	// 공지사항 상세보기
	@Override
	public Map<String, Object> noticeDetail(int map) throws Exception {
		
		Map<String, Object> noticemap = dao.noticeDetail(map);
		String notice_title = noticemap.get("NOTICE_TITLE").toString();
			notice_title = replaceParameter(notice_title);
			notice_title = notice_title.replaceAll("\r\n", "<br>");
		String notice_con = noticemap.get("NOTICE_CON").toString();
			notice_con = replaceParameter(notice_con);
			notice_con = notice_title.replaceAll("\r\n", "<br>");
		
		noticemap.put("NOTICE_CON", notice_con);
		noticemap.put("NOTICE_TITLE", notice_title);
		
		return noticemap;
	}
	
	// faq 상세보기
	@Override
	public Map<String, Object> faqDetail(int map) throws Exception {
		
		Map<String, Object> faqmap = dao.faqDetail(map);
		String faq_title = faqmap.get("FAQ_TITLE").toString();
			faq_title = replaceParameter(faq_title);
			faq_title = faq_title.replaceAll("\r\n", "<br>");
		String faq_con = faqmap.get("FAQ_CONTENT").toString();
			faq_con = replaceParameter(faq_con);
			faq_con = faq_con.replaceAll("\r\n", "<br>");
		
		faqmap.put("FAQ_CONTENT", faq_con);
		faqmap.put("FAQ_TITLE", faq_title);
		
		return faqmap;
	}
	
	@Override
	public Map<String, Object> downloadDetail(int map) throws Exception {
		
		Map<String, Object> downloadmap = dao.downloadDetail(map);
		String faq_title = downloadmap.get("DOWNLOAD_TITLE").toString();
			faq_title = replaceParameter(faq_title);
			faq_title = faq_title.replaceAll("\r\n", "<br>");
		String faq_con = downloadmap.get("DOWNLOAD_CON").toString();
			faq_con = replaceParameter(faq_con);
			faq_con = faq_con.replaceAll("\r\n", "<br>");
		
			downloadmap.put("DOWNLOAD_CON", faq_con);
			downloadmap.put("DOWNLOAD_TITLE", faq_title);
		
		return downloadmap;
	}

	@Override
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectUserList(map);
	}

	@Override
	public Map<String, Object> updateTargetUser(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		// TODO Auto-generated method stub
		try {
			dao.updateTargetUser(map);
		}catch (Exception e) {
			// TODO: handle exception
			resultMap.put("resultCode", -1);
			resultMap.put("resultMeassage", "사용자 지정 실패");
		}
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMeassage", "사용자 지정 성공");
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> updatePCTargetUser(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		// TODO Auto-generated method stub
		try {
			dao.updatePCTargetUser(map);
		}catch (Exception e) {
			// TODO: handle exception
			resultMap.put("resultCode", -1);
			resultMap.put("resultMeassage", "사용자 지정 실패");
		}
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMeassage", "사용자 지정 성공");
		
		return resultMap;
	}

	@Override
	public Map<String, Object> updateTargetUserlog(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			dao.updateTargetUserlog(map);
			
			dao.updateUserGrade(map);
		}catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMeassage", "사용자 지정 실패");
		}
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMeassage", "사용자 지정 성공");
		
		return resultMap;
	}
	
	
	public List<Map<String, Object>> selectNetPolicy(HttpServletRequest request) throws Exception {
		log.info("policyNm :: " + request.getParameter("policyNm"));
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("policyNm", request.getParameter("policyNm"));
			resultList = dao.selectNetPolicy(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
	}

	private String replaceParameter(String param) {
		String result = param;
		if(param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}
	      
	return result;
	}
}
