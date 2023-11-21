package com.org.iopts.faq.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.org.iopts.faq.service.FAQService;
import com.org.iopts.util.SessionUtil;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/faq")
public class FAQController {

	private static Logger logger = LoggerFactory.getLogger(FAQController.class);
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private FAQService faqService;
	
	@RequestMapping(value = "/faqList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> faqList(HttpServletRequest request, Model model){
		logger.info("faqList");
		
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = faqService.faqList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/faqSearchList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> faqSearchList(HttpServletRequest request, Model model){
		logger.info("faqSearchList");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = faqService.faqSearchList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	// FAQ 등록
	@RequestMapping(value="/faqInsert", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> faqInsert(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("faqInsert");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			faqService.faqInsert(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
	// FAQ 수정
	@RequestMapping(value="/faqUpdate", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> faqUpdate(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("faqUpdate");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			faqService.faqUpdate(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	// FAQ 수정
	@RequestMapping(value="/faqDelete", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> faqDelete(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("faqDelete");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			faqService.faqDelete(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	
	// -------------------------------- 댓글 영역
	
	@RequestMapping(value="/list", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public @ResponseBody String selectList(HttpServletRequest request, Model model){
		logger.info("list");
		
		List<Map<String, Object>> rList = new ArrayList<>();
		
		rList = faqService.selectList(request);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm").create();
		
		return gson.toJson(rList);
	}
	
	
	@RequestMapping(value="/insertReply", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> insertReply(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("insertReply");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			faqService.insertReply(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
	// 댓글 수정
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateReply(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("updateReply");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			faqService.updateReply(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
		
	}
	
	// 댓글 삭제
	@RequestMapping(value="deleteReply", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> deleteReply(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("deleteReply");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			faqService.deleteReply(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
}
