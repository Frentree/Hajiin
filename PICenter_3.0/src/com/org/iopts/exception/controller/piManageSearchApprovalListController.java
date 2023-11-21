package com.org.iopts.exception.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.exception.service.piManageSearchApprovalListService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/manageSearchApproval")
public class piManageSearchApprovalListController {

	@Inject
	private piManageSearchApprovalListService service;
	
	@RequestMapping(value = "/pi_manage_search_approval_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_manage_search_approval_list (Model model) throws Exception 
	{
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "approvalManage");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		return "/manage/pi_manage_search_approval_list";
	}

	// 정탐/오탐 결재 리스트
	@RequestMapping(value="/searchApprovalListData", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchApprovalListData(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.searchApprovalListData(params);

		return searchList;
	}
	
	// 정탐/오탐 결재 리스트 - 조회
	@RequestMapping(value="/selectProcessGroupPath", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<HashMap<String, Object>> selectProcessGroupPath(Model model, @RequestBody HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectProcessGroupPath(params);
		model.addAttribute("searchList", searchList);

		return searchList;
	}

	// 정탐/오탐 결재 리스트
	@RequestMapping(value="/searchApprovalAllListData", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchApprovalAllListData(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.searchApprovalAllListData(params);

		return searchList;
	}
}
