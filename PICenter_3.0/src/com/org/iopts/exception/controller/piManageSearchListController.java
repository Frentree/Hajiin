package com.org.iopts.exception.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.detection.service.piDetectionService;
import com.org.iopts.exception.service.piManageSearchListService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/manageSearch")
public class piManageSearchListController {

	private static Logger log = LoggerFactory.getLogger(piManageSearchListController.class);
	
	@Autowired Pi_TargetService targetservice;
	@Autowired Pi_UserService userService;
	@Autowired piManageSearchListService service;
	
	@RequestMapping(value = "/pi_manage_search_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_manage_search_list (Model model) throws Exception 
	{
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "approvalManage");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	

		return "/manage/pi_manage_search_list";		
	}
	
	// 정탐/오탐 리스트
	@RequestMapping(value="/searchProcessList", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchProcessList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.searchProcessList(params);

		return searchList;
	}

	@RequestMapping(value="/selectProcessPath", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
    public List<HashMap<String, Object>> selectProcessPath(Model model, @RequestBody HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectProcessPath(params);
		model.addAttribute("searchList", searchList);

		return searchList;
    }
	
	
}
