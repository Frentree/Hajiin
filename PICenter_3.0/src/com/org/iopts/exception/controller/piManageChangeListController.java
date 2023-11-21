package com.org.iopts.exception.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.org.iopts.detection.controller.piChangeController;
import com.org.iopts.exception.service.piManageChangeListService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/manageChange")
public class piManageChangeListController {

	private static Logger log = LoggerFactory.getLogger(piChangeController.class);

	@Inject
	private piManageChangeListService service;
	
	@RequestMapping(value = "/pi_manage_change_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_manage_change_list (Model model) throws Exception 
	{
		log.info("관리자화면 - 결재 관리 - 담당자 변경 리스트");
		
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "approvalManage");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "/manage/pi_manage_change_list";		
	}

	@RequestMapping(value="/selectChangeList", method={RequestMethod.POST})
	@ResponseBody
    public List<HashMap<String, Object>> selectChangeList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectChangeList(params);
		
		return searchList;
	}
}
