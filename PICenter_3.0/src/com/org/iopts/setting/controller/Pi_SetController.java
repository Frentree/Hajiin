package com.org.iopts.setting.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.setting.service.Pi_SetService;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/setting")
public class Pi_SetController {

	private static Logger logger = LoggerFactory.getLogger(Pi_SetController.class);
	
	@Inject
	private Pi_SetService service;
	
	@RequestMapping(value = "/pi_interlock", method = RequestMethod.GET)
	public String pi_interlock(Locale locale, Model model) throws Exception {
		
		List<Map<Object, Object>> setMap = service.selectSetting();
		model.addAttribute("setMap", setMap);
		
		return "user/pi_interlock";
	}
	
	// 공지사항 목록 조회
	@RequestMapping(value = "/patternList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> patternList(HttpServletRequest request, Model model){
		logger.info("patternList");
		
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.patternList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
}
