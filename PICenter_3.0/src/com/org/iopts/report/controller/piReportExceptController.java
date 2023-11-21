package com.org.iopts.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.report.service.piReportExceptService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/report")
@Configuration
@PropertySource("classpath:/property/config.properties")
public class piReportExceptController {

	private static Logger log = LoggerFactory.getLogger(piReportExceptController.class);

	@Inject
	private Pi_UserService userService;

	@Inject
	private piReportExceptService service;

	/*
	 * 정탐/오탐 리스트
	 */
	@RequestMapping(value = "/pi_report_exception", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_report_exception (Model model) throws Exception 
	{
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportAppr");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	

		return "/report/pi_report_exception";		
	}

	// 정탐/오탐 리스트
	@RequestMapping(value="/searchExceptionList", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchExceptionList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.searchExceptionList(params);

		return searchList;
	}
}