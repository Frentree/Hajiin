package com.org.iopts.faq.service.impl;

import java.io.Reader;
import java.net.ProtocolException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.org.iopts.faq.dao.FAQDAO;
import com.org.iopts.faq.service.FAQService;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
@Transactional
public class FAQServiceImpl implements FAQService{

	private static Logger logger = LoggerFactory.getLogger(FAQServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private FAQDAO FAQDAO;

	@Override
	public List<Map<String, Object>> faqList(HttpServletRequest request) {
		return FAQDAO.faqList();
	}

	@Override
	public List<Map<String, Object>> faqSearchList(HttpServletRequest request) {
		
		logger.info("faqSearchList service");
		
		logger.info("title :: " + request.getParameter("title"));
		logger.info("titcont :: " + request.getParameter("titcont"));
		logger.info("writer :: " + request.getParameter("writer"));
		logger.info("fromDate :: " + request.getParameter("fromDate"));
		logger.info("toDate :: " + request.getParameter("toDate"));
		logger.info("regdateChk :: " + request.getParameter("regdateChk"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("title", request.getParameter("title"));
			map.put("titcont", request.getParameter("titcont"));
			map.put("writer", request.getParameter("writer"));
			map.put("fromDate", request.getParameter("fromDate"));
			map.put("toDate", request.getParameter("toDate"));
			map.put("regdateChk", request.getParameter("regdateChk"));
			logger.info("map :: " + map);
			resultList = FAQDAO.getStatusList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}

	// FAQ 등록
	@Override
	public void faqInsert(HttpServletRequest request) {
		
		String userNo = request.getParameter("user_no");
		String faq_title = request.getParameter("faq_title");
		String faq_con = request.getParameter("faq_con");

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("faq_title", faq_title);
		input.put("faq_con", faq_con);
		
		logger.info("input >> " + input);
		
		FAQDAO.faqInsert(input);
	}
	
	// FAQ 수정
	@Override
	public void faqUpdate(HttpServletRequest request) {
		
		String userNo = request.getParameter("user_no");
		String faq_title = request.getParameter("faq_title");
		String faq_con = request.getParameter("faq_con");
		String faq_id = request.getParameter("faq_id");

		Map<String, Object> update = new HashMap<String, Object>();
		update.put("userNo", userNo);
		update.put("faq_title", faq_title);
		update.put("faq_con", faq_con);
		update.put("faq_id", faq_id);
		
		logger.info("update >> " + update);
		
		FAQDAO.faqUpdate(update);
		
	}

	// FAQ 삭제
	@Override
	public void faqDelete(HttpServletRequest request)  {
		
		String userNo = request.getParameter("user_no");
		String faq_id = request.getParameter("faq_id");
		String userGrade =  SessionUtil.getSession("memberSession", "USER_GRADE");

		Map<String, Object> delete = new HashMap<String, Object>();
		delete.put("userNo", userNo);
		delete.put("faq_id", faq_id);
		delete.put("userGrade", userGrade);
		
		logger.info("delete >> " + delete);
		
		FAQDAO.faqDeleteReply(delete);
		FAQDAO.faqDelete(delete);		
		
	}
	
	// ------------ 댓글 영역
	
	@Override
	public List<Map<String, Object>> selectList(HttpServletRequest request) {
		
		logger.info("selectList service");
		
		logger.info("faq_no :: " + request.getParameter("faq_no"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		List<Map<String, Object>> resultList2 = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			Map<String, Object> map2 = new HashMap<>();
			map.put("faq_no", request.getParameter("faq_no"));
			logger.info("map :: " + map);
			resultList = FAQDAO.selectList(map);
			
			for (Map<String, Object> replyMap : resultList) {
				map2 = new HashMap<>();
				
				String reply_con = replyMap.get("REPLY_CON").toString();
					   reply_con = replaceParameter(reply_con);
					   
				map2.put("REPLY_NO", replyMap.get("REPLY_NO").toString());
				map2.put("REPLY_CON", reply_con);
				map2.put("CREATE_DT", replyMap.get("CREATE_DT").toString());
				map2.put("USER_NO", replyMap.get("USER_NO").toString());
				map2.put("USER_NAME", replyMap.get("USER_NAME").toString());
				
				resultList2.add(map2);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList2;
	}
	
	@Override
	@Transactional
	public void insertReply(HttpServletRequest request) throws Exception {

		String user_no = request.getParameter("user_no");
		String faq_no = request.getParameter("faq_no");
		String reply_con = request.getParameter("reply_con");
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		input.put("user_no", user_no);
		input.put("faq_no", faq_no);
		input.put("reply_con", reply_con);
		
		FAQDAO.insertReply(input);
	}

	@Override
	public void updateReply(HttpServletRequest request) throws Exception {
		String reply_no = request.getParameter("reply_no");
		String reply_con = request.getParameter("reply_con");
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		input.put("reply_no", reply_no);
		input.put("reply_con", reply_con);
		
		FAQDAO.updateReply(input);
		
	}

	@Override
	public void deleteReply(HttpServletRequest request) throws Exception {
		String reply_no = request.getParameter("reply_no");
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		input.put("reply_no", reply_no);
		
		FAQDAO.deleteReply(input);
		
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
