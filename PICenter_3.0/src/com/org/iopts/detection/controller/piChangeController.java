package com.org.iopts.detection.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.detection.service.piChangeService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/change")
public class piChangeController {

	private static Logger log = LoggerFactory.getLogger(piChangeController.class);

	@Inject
	private piChangeService service;

	/*
	 * 담당자 변경 리스트
	 */
	@RequestMapping(value = "/pi_change_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_change_list (Model model) throws Exception 
	{
		log.info("사용자화면 - 결재 관리 - 담당자 변경 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "/detection/pi_change_list";		
	}
	
	/*
	 * 담당자 변경 리스트
	 */
	@RequestMapping(value = "/pi_path_change_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_path_change_list (Model model) throws Exception 
	{
		log.info("사용자화면 - 결재 관리 - 담당자 경로 변경 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "/detection/pi_path_change_list";		
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
	
	@RequestMapping(value="/selectPathChangeList", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> selectPathChangeList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		List<HashMap<String, Object>> searchList = service.selectPathChangeList(params);
		
		return searchList;
	}

	// 결재 관리 - 담당자 변경 리스트 - 결재
	@RequestMapping(value="/updateChangeApproval", method={RequestMethod.POST})
	@ResponseBody
    public Map<String, Object> updateChangeApproval(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("updateChangeApproval 시작");

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			service.updateChangeApproval(params);
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
			
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		log.info("map : " + map);
		return map;
    }
	
	// 결재 관리 - 경로담당자 변경 리스트 - 결재
	@RequestMapping(value="/updatePathChangeApproval", method={RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> updatePathChangeApproval(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("updatePathChangeApproval 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			service.updatePathChangeApproval(params);
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
		
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		log.info("map : " + map);
		return map;
	}
}