package com.org.iopts.popup.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.supercsv.cellprocessor.ParseInt;

import com.org.iopts.group.service.GroupService;
import com.org.iopts.popup.service.PopupService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
 
/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/popup")
public class PopupController {

	private static Logger logger = LoggerFactory.getLogger(PopupController.class);
	
	@Inject
	private PopupService service;
	
	@Inject
	private Pi_TargetService targetservice;
	
	@Inject
	private GroupService groupService;
	
	
	
	@RequestMapping(value = "/lowPath", method = {RequestMethod.GET})
	public String lowPath_get(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("lowPath");
		logger.info("hash_id :: " + request.getParameter("hash_id"));
		logger.info("tid :: " + request.getParameter("tid"));
		logger.info("ap_no :: " + request.getParameter("ap_no"));
		
//		model.addAttribute("id", request.getParameter("hash_id"));
//		model.addAttribute("ap_no", request.getParameter("ap_no"));
		
		return "popup/lowPath";
	}
	
	@RequestMapping(value = "/lowPath", method = {RequestMethod.POST})
	public String lowPath(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.info("lowPath");
		logger.info("hash_id :: " + request.getParameter("hash_id"));
		logger.info("tid :: " + request.getParameter("tid"));
		logger.info("ap_no :: " + request.getParameter("ap_no"));
		
		Map<String, Object> map = new HashMap<>();
		
		model.addAttribute("subPath", groupService.selectSubPath(map, request));
		
		return "popup/lowPath";
	}
	
	/*@RequestMapping(value = "/detectionDetail", method = {})
	public String detectionDetail_get(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("detectionDetail  1");
		logger.info("hash_id :: " + request.getParameter("id"));
		logger.info("ap_no :: " + request.getParameter("ap_no"));
		
//		model.addAttribute("id", request.getParameter("id"));
//		model.addAttribute("ap_no", request.getParameter("ap_no"));
		
		return "popup/detectionDetail";
	}*/
	
	@RequestMapping(value = "/detectionDetail", method = {RequestMethod.GET,RequestMethod.POST})
	public String detectionDetail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("detectionDetail");
		logger.info("hash_id :: " + request.getParameter("id"));
		logger.info("tid :: " + request.getParameter("tid"));
		logger.info("ap_no :: " + request.getParameter("ap_no"));
		
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("tid", request.getParameter("tid"));
		model.addAttribute("ap_no", request.getParameter("ap_no"));
		
		return "popup/detectionDetail";
	}
	
	// 공지사항 상세 팝업
	@RequestMapping(value = "/noticeDetail", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeDetail(HttpSession session, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String ids = request.getParameter("id");
		int id = 0;
		
		if(ids != null) {
			id = Integer.parseInt(request.getParameter("id"));
		}
			
		logger.info("noticeDetail >>>> " + id);
		
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		try {
			noticeMap = service.noticeDetail(id);
			String file_chk = noticeMap.get("FILE_CHK").toString();
			model.addAttribute("fileChk", file_chk);
			model.addAttribute("memberInfo", session.getAttribute("memberSession"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("noticeMap", noticeMap);
		return "popup/noticeDetail";
	}
	
	// FAQ 상세 팝업
	@RequestMapping(value = "/faqDetail",  method = {RequestMethod.GET, RequestMethod.POST})
	public String faqDetail(HttpSession session, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String ids = request.getParameter("id");
		int id = 0;
		
		if(ids != null) {
			id = Integer.parseInt(request.getParameter("id"));
		}
		
		logger.info("faqDetail >>>> " + id);
		
		Map<String, Object> faqMap = new HashMap<String, Object>();
		try {
			
			faqMap = service.faqDetail(id);
			model.addAttribute("memberInfo", session.getAttribute("memberSession"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("faqMap", faqMap);
		return "popup/faqDetail";
	}
	
	// 다운로드 상세 팝업
	@RequestMapping(value = "/downloadDetail", method = {RequestMethod.GET, RequestMethod.POST})
	public String downoadDetail(HttpSession session, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String ids = request.getParameter("id");
		int id = 0;
		
		if(ids != null) {
			id = Integer.parseInt(request.getParameter("id"));
		}
		
		logger.info("downloadDetail");
		
		Map<String, Object> downloadMap = new HashMap<String, Object>();
		try {
			downloadMap = service.downloadDetail(id);
			String file_chk = downloadMap.get("FILE_CHK").toString();
			model.addAttribute("fileChk", file_chk);
			model.addAttribute("memberInfo", session.getAttribute("memberSession"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("downloadMap", downloadMap);
		return "popup/downloadDetail";
	}
	
	@RequestMapping(value = "/targetList", method = {RequestMethod.GET,RequestMethod.POST})
	public String targetList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*logger.info("targetList");
		String[] referer = request.getHeader("referer").split("\\/");
		String aut = "manage".equals(referer[3])? "manager": "user";
		model.addAttribute("aut", aut);
		
		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		if("manager".equals(aut)) {
			//map.put("group_id", request.getParameter("group_id"));
		}
		if("user".equals(aut)) {
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			map.put("user_no", user_no);
		}
		
		List<Map<String, Object>> groupList = service.selectGroupList(map);
		model.addAttribute("groupList", groupList);*/
		
		
		/*List<Map<String, Object>> noGroupList = service.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());*/
		

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");

		try {
			String userGroupList = groupService.selectUserHostGroupList(map, request);
			model.addAttribute("userGroupList", userGroupList);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "popup/targetList";
	}
	
	@RequestMapping(value = "/exceptionServerList", method = {RequestMethod.GET,RequestMethod.POST})
	public String exceptionServerList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");

		try {
			JSONArray exceptionServerList = groupService.selectExceptionServerList(map, request);
			model.addAttribute("exceptionServerList", exceptionServerList);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "popup/exceptionServerList";
	}
	
	@RequestMapping(value = "/exceptionHostList/{test}", method = {RequestMethod.GET,RequestMethod.POST})
	public String exceptionHostList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("test") String test) throws Exception {
		
		logger.info("test >> " + test);

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		map.put("test", test);

		try {
			JSONArray exceptionHostList = groupService.selectExceptionHostList(map, request);
			model.addAttribute("exceptionHostList", exceptionHostList);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "popup/exceptionHostList";
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/getTargetList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getTargetList(HttpServletRequest request, Model model){
		
		logger.info("getTargetList");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String aut = request.getParameter("aut");
			String host = request.getParameter("host");
			String noGroup = request.getParameter("noGroup");
			
			logger.info("noGroup :: " + noGroup);
			
			Map<String, Object> map = new HashMap<>();
			if("noGroup".equals(noGroup)) {
				map.put("noGroup", "Y");
			} else if("noGroupPC".equals(noGroup)) {
				map.put("noGroup", "P");
			}else {
				if(!"".equals(host) && host != null) {
					map.put("host", host);
				} else {
					map.put("group_id", request.getParameter("group_id"));
				}
			}
			if("manager".equals(aut)) {
				//map.put("group_id", request.getParameter("group_id"));
			}
			if("user".equals(aut)) {
				String user_no = SessionUtil.getSession("memberSession", "USER_NO");
				map.put("user_no", user_no);
			}
			
			logger.info(map.toString());
			List<Map<String, Object>> targetList  = service.getTargetList(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultData", targetList);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@RequestMapping(value = "groupList", method = {RequestMethod.POST})
	public String groupList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("groupList");
		String[] referer = request.getHeader("referer").split("\\/");
		String aut = "manage".equals(referer[3])? "manager": "user";
		model.addAttribute("aut", aut);
		
		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		if("manager".equals(aut)) {
			//map.put("group_id", request.getParameter("group_id"));
		}
		if("user".equals(aut)) {
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			map.put("user_no", user_no);
		}
		
		List<Map<String, Object>> groupList = targetservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		List<Map<String, Object>> userGroupList = targetservice.selectUserGroupList(map);
		model.addAttribute("userGroupList", userGroupList);
		
		List<Map<String, Object>> noticeList = targetservice.selectNoticeList(map);
		model.addAttribute("noticeList", noticeList);

		List<Map<String, Object>> noGroupList = targetservice.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());
		
		return "popup/groupList";
	}
	
	@RequestMapping(value = "netList", method = {RequestMethod.GET, RequestMethod.POST})
	public String netList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("netList");
		String netid = request.getParameter("netid");
		String netType = request.getParameter("netType");
		
		logger.info("netid  >>>> " + netid);
		
		Map<String, Object> map = new HashMap<>();
		map.put("netid", netid);
		
		try {
			JSONArray resultGroup = groupService.selectNetList(map, request);
			model.addAttribute("policyNetList", resultGroup);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		
		model.addAttribute("netid", netid);
		model.addAttribute("netType", netType);
		
		return "popup/netList";
	}
	

	@RequestMapping(value = "policyList", method = {RequestMethod.GET, RequestMethod.POST})
	public String policyList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("policyList");
		
		/*Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		if("manager".equals(aut)) {
		
			//map.put("group_id", request.getParameter("group_id"));
		}
		if("user".equals(aut)) {
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			map.put("user_no", user_no);
		}
		
		List<Map<String, Object>> groupList = service.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		
		List<Map<String, Object>> noGroupList = service.getTargetList(map);
		model.addAttribute("noGroupSize", noGroupList.size());*/
		
		return "popup/policyList";
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/getUserTargetList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getUserTargetList(HttpServletRequest request, Model model){
		
		logger.info("getTargetList");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			Map<String, Object> map = new HashMap<>();
			String groupID = request.getParameter("groupID");
			map.put("groupID", groupID);
			logger.info(map.toString());
			List<Map<String, Object>> targetList  = service.getUserTargetList(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultData", targetList);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@RequestMapping(value = "/userList", method = {RequestMethod.GET, RequestMethod.POST})
	public String userList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("userList");
		/*String[] referer = request.getHeader("referer").split("\\/");
		String aut = "manage".equals(referer[3])? "manager": "user";
		model.addAttribute("aut", aut);*/
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		String info = request.getParameter("info");
		model.addAttribute("memberInfo", member);
		model.addAttribute("info", info);
		
		
		return "popup/userList";
	}
	

	@SuppressWarnings("finally")
	@RequestMapping(value = "/selectUserList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectUserList(HttpServletRequest request, Model model){
		
		logger.info("selectUserList");
		List<Map<String, Object>> resultMap = null;
		Map<String, Object> map = new HashMap<>();
		String user_nm = request.getParameter("user_nm");
		String team_nm = request.getParameter("team_nm");
		
		map.put("userNm", user_nm);
		map.put("teamNm", team_nm);
		
		try {
			resultMap = service.selectUserList(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
			
		}
		
		return resultMap;
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/updateTargetUser", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateTargetUser(HttpServletRequest request, Model model){
		
		logger.info("updateTargetUser");
		
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		String mngr1_no = request.getParameter("mngr1_no");
		String mngr2_no = request.getParameter("mngr2_no");
		String mngr3_no = request.getParameter("mngr3_no");
		String mngr4_no = request.getParameter("mngr4_no");
		String mngr5_no = request.getParameter("mngr5_no");
		String target_id = request.getParameter("target_id");
		String ap_no = request.getParameter("ap_no");
		
		map.put("mngr1_no", mngr1_no);
		map.put("mngr2_no", mngr2_no);
		map.put("mngr3_no", mngr3_no);
		map.put("mngr4_no", mngr4_no);
		map.put("mngr5_no", mngr5_no);
		map.put("target_id", target_id);
		map.put("ap_no", ap_no);
		
		try {
			resultMap = service.updateTargetUser(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
			
		}
		
		return resultMap;
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/updateTargetUserlog", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateTargetUserlog(HttpServletRequest request, Model model){
		
		logger.info("updateTargetUserlog");
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		String target_id = request.getParameter("target_id");
		String ap_no = request.getParameter("ap_no");
		String name = request.getParameter("name");
		int type = Integer.parseInt(request.getParameter("type"));
		
		String user_no = request.getParameter("user_no");
		String user_name = request.getParameter("user_name");
		String update_user_no = request.getParameter("update_user_no");
		String update_user_name = request.getParameter("update_user_name");
		
		int user_grade = Integer.parseInt(request.getParameter("user_grade"));
		
		map.put("target_id", target_id);
		map.put("ap_no", ap_no);
		map.put("name", name);
		map.put("type", type);
		map.put("user_no", user_no);
		map.put("user_name", user_name);
		map.put("update_user_no", update_user_no);
		map.put("update_user_name", update_user_name);
		
		map.put("user_grade", user_grade);
		
		logger.error("map >> " + map);
		
		try {
			resultMap = service.updateTargetUserlog(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		}
		return resultMap;
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/updatePCTargetUser", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updatePCTargetUser(HttpServletRequest request, Model model){
		
		logger.info("updatePCTargetUser");
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		String user_no = request.getParameter("user_no");
		String service_user_no = request.getParameter("service_user_no");
		String target_id = request.getParameter("target_id");
		String ap_no = request.getParameter("ap_no");
		
		map.put("service_user_no", service_user_no);
		map.put("user_no", user_no);
		map.put("target_id", target_id);
		map.put("ap_no", ap_no);
		
		try {
			resultMap = service.updatePCTargetUser(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
			
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/selectNetPolicy", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectNetPolicy(HttpServletRequest request, Model model)  throws Exception{
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = service.selectNetPolicy(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
	};
	
	@RequestMapping(value = "/reportGroupList", method = {RequestMethod.GET,RequestMethod.POST})
	public String reportGroupList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String typeChk = request.getParameter("typeChk");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		map.put("typeChk", typeChk);

		try {
			String userReportGroupList = groupService.userReportGroupList(map, request);
			model.addAttribute("userReportGroupList", userReportGroupList);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "popup/reportGroupList";
	}
	
	@RequestMapping(value = "/reportHostList", method = {RequestMethod.GET,RequestMethod.POST})
	public String reportHostList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String typeChk = request.getParameter("typeChk");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		map.put("typeChk", typeChk);

		try {
			String userReportHostList = groupService.userReportHostList(map, request);
			model.addAttribute("userReportHostList", userReportHostList);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "popup/reportHostList";
	}
	
	
	@RequestMapping(value = "/helpDetail", method = {RequestMethod.GET, RequestMethod.POST})
	public String helpDetail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("helpDetail");
		String id = request.getParameter("id");
		model.addAttribute("id", id);

		return "popup/helpDetail";
	}
	
	@RequestMapping(value = "filterUserList", method = {RequestMethod.GET,RequestMethod.POST})
	public String filterUserList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		String info = request.getParameter("info");
		String ap_no = request.getParameter("apno");
		
		model.addAttribute("info", info);
		
		Map<String, Object> map = new HashMap<>();
		map.put("ap_no", ap_no);
		
		try {
			String serverGroup = groupService.selectPopupServerGroupList(map, request);
			model.addAttribute("serverGroupList", serverGroup);
		}catch (Exception e) {
			// TODO: handle exception
		}

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		return "popup/selectUserGroupList";
	}
	
}
