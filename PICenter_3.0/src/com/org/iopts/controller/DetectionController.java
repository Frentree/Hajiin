package com.org.iopts.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.org.iopts.service.Pi_DetectionService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/detection_old")
public class DetectionController {
	 
	private static Logger log = LoggerFactory.getLogger(DetectionController.class);
	
	@Inject
	private Pi_TargetService targetservice;

	@Inject
	private Pi_UserService userService;
	
	@Inject
	private Pi_DetectionService detectionservice;
	
	@RequestMapping(value = "/pi_detection_regist", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_detection_regist (Locale locale, HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("사용자화면 - 메인 - 검출리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "detectionRegist");
		
		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		model.addAttribute("targetList", targetList);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		log.info("mamber : " + member);
		
		return "/detection_old/pi_detection_regist";
	}
	
	@RequestMapping(value = "/pi_search_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_search_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("사용자화면 - 결재 관리 - 정탐/오탐 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	
	
		return "/detection_old/pi_search_list";		
	}
	
	@RequestMapping(value = "/pi_search_approval_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_search_approval_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		log.info("사용자화면 - 결재 관리 - 정탐/오탐 결재 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "/detection_old/pi_search_approval_list";		
	}
	
	@RequestMapping(value = "/pi_exception_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_exception_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("사용자화면 - 결재 관리 - 경로 예외 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	
		
		return "/detection_old/pi_exception_list";		
	}
	
	@RequestMapping(value = "/pi_exception_approval_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_exception_approval_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("사용자화면 - 결재 관리 - 경로 예외 결재 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);
		model.addAttribute("user_grade", teamManager.get("user_grade"));
				
		return "/detection_old/pi_exception_approval_list";		
	}
	
	@RequestMapping(value = "/pi_change_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_change_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		log.info("사용자화면 - 결재 관리 - 담당자 변경 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "/detection_old/pi_change_list";		
	}
	
	@RequestMapping(value = "/pi_server_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_server_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		log.info("사용자화면 - 서버 리스트  - 서버 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "serverList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "/detection_old/pi_server_list";		
	}
	
	@RequestMapping(value = "/pi_test", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_test (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		log.info("사용자화면 - 서버 리스트  - 서버 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "serverList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "/detection_old/pi_server_list";		
	}
	
	// 결재자 선택 - user_grade 0 이상
	@RequestMapping(value="/selectTeamMember", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTeamMember(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		log.info("selectTeamMember");
		List<Map<String, Object>> teamMemberList = detectionservice.selectTeamMember(request);
		
		return teamMemberList;
    }
	
	// 문서 번호 불러오기
	@RequestMapping(value="/selectDocuNum", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> selectDocuNum(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		Map<String, Object> docuNum = detectionservice.selectDocuNum(request);
		model.addAttribute("docuNum", docuNum);
		return docuNum;
    }
	
	// 검출리스트 - 경로예외 - 저장
	@RequestMapping(value="/registPathException", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registPathException(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("검출리스트 - 경로예외 추가");
		
		Map<String, Object> regExcepMap = new HashMap<String, Object>();
		
		try {
			//detectionservice.registPathExceptionGroup(request);
			detectionservice.registPathException(request);
		}
		catch (Exception e) {
			regExcepMap.put("resultCode", -1);
			regExcepMap.put("resultMessage", e.getMessage());
			return regExcepMap;
		}
			
		regExcepMap.put("resultCode", 0);
		regExcepMap.put("resultMessage", "SUCCESS");
		detectionservice.approvalPlus(request);
		log.info("map : " + regExcepMap);
		
		return regExcepMap;
    }
	
	// 결재관리  - 경로예외 리스트 - 결재 요청
	@RequestMapping(value="/registPathExceptionCharge", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registPathExceptionCharge(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("결재관리  - 경로예외 리스트 - 결재 요청");
		
		Map<String, Object> regExcepMap = new HashMap<String, Object>();
		
		try {
			log.info("registPathExceptionCharge 전");
			detectionservice.registPathExceptionCharge(request);
			detectionservice.updateExcepStatus(request);
		}
		catch (Exception e) {
			regExcepMap.put("resultCode", -1);
			regExcepMap.put("resultMessage", e.getMessage());
			return regExcepMap;
		}
		
		regExcepMap.put("resultCode", 0);
		regExcepMap.put("resultMessage", "SUCCESS");
		detectionservice.approvalPlus(request);
		log.info("map : " + regExcepMap);
		
		return regExcepMap;
    }
	
	// 결재관리 - 경로예외 결재 리스트 - 결재
	@RequestMapping(value="/updateExcepApproval", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> updateExcepApproval(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("updateExcepApproval 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			detectionservice.updateExcepApproval(request);
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
	
	// 검출 리스트 - 처리 팝업 데이터만 가져옴
	@RequestMapping(value = "/pi_scan_history", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_scan_history (Model model) {
		log.info("pi_scan_history");
		
				
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "/detection_old/pi_scan_history";		
	}
	
	// 검출리스트 - 처리 - 저장
	@RequestMapping(value="/registProcess", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registProcess(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("registProcess 시작");
		
		Map<String, Object> GroupMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			GroupMap = detectionservice.registProcessGroup(request);
			detectionservice.registProcess(request, GroupMap);
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
			
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		detectionservice.approvalPlus(request);
		log.info("map : " + map);
		return map;
    }
	
	// 결재 관리 - 정탐/오탐 리스트 - 결재 요청
	@RequestMapping(value="/registProcessCharge", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registProcessCharge(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("registProcessCharge 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			detectionservice.registProcessCharge(request);
			detectionservice.updateProcessStatus(request);
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
			
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		detectionservice.approvalPlus(request);
		log.info("map : " + map);
		return map;
    }
	
	// 결재관리 - 정탐/오탐 결재 리스트 - 결재
	@RequestMapping(value="/updateProcessApproval", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> updateProcessApproval(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("updateProcessApproval 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			detectionservice.updateProcessApproval(request);
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
	
	// 검출 리스트 - 경로변경
	@RequestMapping(value="/registChange", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registChange(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("registChange 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			detectionservice.registChange(request);
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
			
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		detectionservice.approvalPlus(request);
		return map;
    }
	
	// 사용자용 화면 - 검출리스트
	@RequestMapping(value="/selectFindSubpath", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectFindSubpath(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("selectFindSubpath");

		List<Map<String, Object>> findSubpathList = detectionservice.selectFindSubpath(request);

		return findSubpathList;
    }
	
	// 정탐/오탐 리스트
	@RequestMapping(value="/searchProcessList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> searchProcessList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		List<Map<String, Object>> searchList = detectionservice.searchProcessList(request);
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return searchList;
	}
	
	@RequestMapping(value="/selectProcessPath", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectProcessPath(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		log.info("selectProcessPath");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		List<Map<String, Object>> searchList = detectionservice.selectProcessPath(request);
		model.addAttribute("searchList", searchList);
		
		return searchList;
    }
	
	
    //public @ResponseBody List<Map<String, Object>> selectProcessGroupPath(HttpSession session, HttpServletRequest request, Model model) throws Exception {
	@RequestMapping(value="/selectProcessGroupPath", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectProcessGroupPath(HttpSession session, HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> params) throws Exception {
		log.info("selectProcessGroupPath");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		// - nohAdd
		String charge_id = (String)params.get("CHARGE_ID_LIST");
		List<String> charge_id_list = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id,",");
			while(st.hasMoreTokens()) {
				charge_id_list.add(st.nextToken());
			}
		}
		params.put("charge_id_list", charge_id_list);
		params.put("user_no", member.get("USER_NO"));
		params.put("user_grade", member.get("USER_GRADE"));
		List<Map<String, Object>> searchList = detectionservice.selectProcessGroupPath(params);
		// - nohAdd
		
		
		//List<Map<String, Object>> searchList = detectionservice.selectProcessGroupPath(request);
		model.addAttribute("searchList", searchList);
		
		return searchList;
    }
	
	@RequestMapping(value="/selectExeptionPath", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectExeptionPath(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		log.info("selectExeptionPath");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		List<Map<String, Object>> searchList = detectionservice.selectExeptionPath(request);
		model.addAttribute("searchList", searchList);
		
		return searchList;
    }
	
	@RequestMapping(value="/selectExeptionName", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> selectExeptionName(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		log.info("selectExeptionName");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> searchNameList = detectionservice.selectExeptionName(request);
		model.addAttribute("searchList", searchNameList);
		
		return searchNameList;
    }
	
	@RequestMapping(value="/selectExceptionList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectExceptionList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("selectExceptionList");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		List<Map<String, Object>> searchList = detectionservice.selectExceptionList(request);
		
		return searchList;
    }
	
	@RequestMapping(value="/selectChangeList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectChangeList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("selectChangeList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		List<Map<String, Object>> searchList = detectionservice.selectChangeList(request);
		
		return searchList;
	}
	
	// 결재 관리 - 담당자 변경 리스트 - 결재
	@RequestMapping(value="/updateChangeApproval", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> updateChangeApproval(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		log.info("updateChangeApproval 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			detectionservice.updateChangeApproval(request);
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
	
	// 정탐/오탐 결재 리스트
	@RequestMapping(value="/searchApprovalListData", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> searchApprovalListData(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

	Map<String, Object> member = SessionUtil.getSession("memberSession");
	model.addAttribute("memberInfo", member);

	List<Map<String, Object>> searchList = detectionservice.searchApprovalListData(request);

	return searchList;
	}


	// 경로 예외 결재 리스트
	@RequestMapping(value="/exceptionApprovalListData", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> exceptionApprovalListData(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

	Map<String, Object> member = SessionUtil.getSession("memberSession");
	model.addAttribute("memberInfo", member);
	model.addAttribute("memberInfo", member.get("user_grade"));
	
	List<Map<String, Object>> searchList = detectionservice.exceptionApprovalListData(request);

	return searchList;
	}
	
	@RequestMapping(value = "/header2", method = RequestMethod.GET)
	public String header2(Locale locale, Model model) throws Exception {

		log.info("header");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "header2";
	}

	@RequestMapping(value = "/footer2", method = RequestMethod.GET)
	public String footer2(Locale locale, Model model) throws Exception {

		log.info("footer");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "footer2";
	}
	
	
}
