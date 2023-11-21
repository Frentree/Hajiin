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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.group.service.GroupService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/target")
public class TargetController {

	private static Logger logger = LoggerFactory.getLogger(TargetController.class);
	
	@Inject
	private Pi_TargetService targetservice;
	
	@Inject
	private GroupService groupService;
//	@RequestMapping(value = "/pi_target_mngr2", method = RequestMethod.GET)
//	public String pi_target_mngr2(Locale locale, Model model) throws Exception {
//		
//		logger.info("pi_target_mngr");
//		
//		model.addAttribute("menuKey", "targetMenu");
//		model.addAttribute("menuItem", "targetMgr");		
//		
//		return "target/pi_target_mngr2";
//	}

	@RequestMapping(value = "/pi_target_mngr", method = RequestMethod.GET)
	public String pi_target_mngr(Locale locale, Model model, HttpServletRequest request) throws Exception {
		String user_grade = "0";
		logger.info("pi_target_mngr");
		
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetMgr");
		
		Map<String, Object> map = new HashMap<>();
		/*map.put("noGroup", "Y");
		
		List<Map<String, Object>> groupList = targetservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		List<Map<String, Object>> userGroupList = targetservice.selectUserGroupList(map);
		model.addAttribute("userGroupList", userGroupList);
		
		List<Map<String, Object>> noticeList = targetservice.selectNoticeList(map);
		model.addAttribute("noticeList", noticeList);

		List<Map<String, Object>> noGroupList = targetservice.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());*/
		
		try {
			//JSONArray targetGroup = groupService.selectTomsGroup(map, request);
			String userGroupList = groupService.selectUserGroupList(map, request);
			
			user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
			
			model.addAttribute("userGroupList", userGroupList);
			model.addAttribute("userGrade", user_grade);
		}catch (Exception e) {
			// TODO: handle exception
		}
		 
		return "target/pi_target_mngr";
	}
//	
//	@RequestMapping(value = "/pi_target_assign", method = RequestMethod.GET)
//	public String pi_target_assign(Locale locale, Model model) throws Exception {
//		
//		logger.info("pi_target_assign");
//		model.addAttribute("menuKey", "targetMenu");
//		model.addAttribute("menuItem", "targetAssign");		
//		
//		return "target/pi_target_assign";
//	}

	@RequestMapping(value = "/pi_target_assign", method = RequestMethod.GET)
	public String pi_target_assign(Locale locale, Model model) throws Exception {

		logger.info("pi_target_assign");
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetAssign");		
		
		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		
		List<Map<String, Object>> groupList = targetservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		List<Map<String, Object>> noGroupList = targetservice.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());

		return "target/pi_target_assign";
	}
	
	@RequestMapping(value = "/pi_target_dmz", method = RequestMethod.GET)
	public String pi_target_dmz(Locale locale, Model model) throws Exception {

		logger.info("pi_target_assign");
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetDmz");		

		return "target/pi_target_dmz";
	}
	
	@RequestMapping(value = "/pi_target_skt_manager", method = RequestMethod.GET)
	public String pi_target_skt_manager(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("pi_target_skt_manager");
		
		return "target/pi_target_skt_manager";
	}
	
	@RequestMapping(value = "/pi_target_pc_mngr", method = RequestMethod.GET)
	public String pi_target_pc_mngr(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		return "target/pi_target_pc_mngr";
	}

	@RequestMapping(value="/pi_target_list", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_target_list(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_target_list");
		
		List<Map<String, Object>> targetList = targetservice.selectTargetList(request);
		
		return targetList;
    }

	@RequestMapping(value="/selectTargetUser", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectTargetUser");
		
		List<Map<String, Object>> targetList = targetservice.selectTargetUser(request);
		
		return targetList;
    }

	@RequestMapping(value="/registTargetUser", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("registTargetUser");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			targetservice.registTargetUser(request);	
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}

		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		return map;
    }

	@RequestMapping(value="/selectUserTargetList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectUserTargetList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		
		return targetList;
    }
	
	@RequestMapping(value="/selectServerList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectServerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectServerList(request);
		
		return targetList;
    }

	@RequestMapping(value="/selectTargetUserList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTargetUserList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectTargetUserList(request);
		
		return targetList;
    }
	
	@RequestMapping(value = "/selectServerFileTopN", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectServerFileTopN(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		List<Map<String, Object>> targeList = targetservice.selectServerFileTopN(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/selectAdminServerFileTopN", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectAdminServerFileTopN(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		List<Map<String, Object>> targeList = targetservice.selectAdminServerFileTopN(request);
		
		return targeList;
	}
	

	@RequestMapping(value = "/selectServerTargetUser", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectServerTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		List<Map<String, Object>> targeList = targetservice.selectServerTargetUser(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/selectPCTargetUserName", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectPCTargetUserName(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		List<Map<String, Object>> targeList = targetservice.selectPCTargetUserName(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/selectPCTargetUser", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectPCTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		List<Map<String, Object>> targeList = targetservice.selectPCTargetUser(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/selectPCTargetUserData", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectPCTargetUserData(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		List<Map<String, Object>> targeList = targetservice.selectPCTargetUserData(request);
		
		return targeList;
	}
	
	// 검색
	@RequestMapping(value = "/searchServerTargetUser", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> searchServerTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		logger.info("searchServerTargetUser");
		
		List<Map<String, Object>> targeList = null;
		try {
			targeList = targetservice.searchServerTargetUser(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		      
		return targeList;
		
	}
	
	@RequestMapping(value = "/searchPCTargetUser", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> searchPCTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		logger.info("searchPCTargetUser");
		
		List<Map<String, Object>> targeList = null;
		try {
			targeList = targetservice.searchPCTargetUser(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		      
		return targeList;
		
	}

	// 견본품 제공 엑셀 Import
	@RequestMapping(value="/targetManagerUpload", method={RequestMethod.POST})
    public @ResponseBody Map<String,Object> targetManagerUpload(HttpSession session, HttpServletRequest request, Model model) {
		logger.info("/targetManagerUpload");

		return targetservice.targetManagerUpload(request);
    }
	
	
	
	/**
	 * DMZ List 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectDmzList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectDmzList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("selectDmzList");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		//params.put("TEST_PARAM1", request.getParameter("TEST_PARAM1"));
		
		List<Map<String, Object>> dmzList = targetservice.selectDmzList(params, request);
		
		return dmzList;
	}
	
	/**
	 * DMZ Info Save
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveDmzInfo", method={RequestMethod.POST})
	public @ResponseBody HashMap<String, Object> saveDmzInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String, Object> params) throws Exception {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			// DMZ Info Save
			targetservice.saveDmzInfo(params);
			
		} catch (Exception e) {
			rtnMap.put("resultCode", -1);		// 저장 실패
			rtnMap.put("resultMessage", e.getMessage());
			return rtnMap;
		}
		
		rtnMap.put("resultCode", 0);		// 저장 성공
		rtnMap.put("resultMessage", "SUCCESS");
		
		return rtnMap;
	}
	
	/**
	 * DMZ List Delete
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteDmzList", method={RequestMethod.POST})
	public @ResponseBody HashMap<String, Object> deleteDmzList(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String, Object> params) throws Exception {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			String dmz_idx = (String)params.get("IDX_List");
			List<String> dmz_idx_list = new ArrayList<String>();
			if(dmz_idx != null && !"".equals(dmz_idx)) {
				StringTokenizer st = new StringTokenizer(dmz_idx,",");
				while(st.hasMoreTokens()) {
					dmz_idx_list.add(st.nextToken());
				}
			}
			params.put("dmz_idx_list", dmz_idx_list);
			
			// DMZ List Delete
			targetservice.deleteDmzList(params);
			
		} catch (Exception e) {
			rtnMap.put("resultCode", -1);		// 저장 실패
			rtnMap.put("resultMessage", e.getMessage());
			return rtnMap;
		}
		
		rtnMap.put("resultCode", 0);		// 저장 성공
		rtnMap.put("resultMessage", "SUCCESS");
		
		return rtnMap;
	}
	

	@RequestMapping(value = "/pi_target_group", method = RequestMethod.GET)
	public String pi_target_group(HttpServletRequest request, Locale locale, Model model) throws Exception {

		logger.info("pi_target_group");
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetGroup");		
		
		Map<String, Object> map = new HashMap<>();
		/*
		List<Map<String, Object>> groupList = targetservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		List<Map<String, Object>> noGroupList = targetservice.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());*/
		
		map.put("noGroup", "N");

		try {
			JSONArray targetGroup = groupService.selectTomsGroup(map, request);
			//JSONArray targetNotGroup = groupService.selectTomsNotGroup(map, request);
			JSONArray userTartgetGroup = groupService.selectUserCreateGroup(map, request);
			model.addAttribute("targetGroup", targetGroup);
			//model.addAttribute("targetNotGroup", targetNotGroup);
			model.addAttribute("targetGroups", groupService.selectGroup(map, request));
			model.addAttribute("creUserGroup", userTartgetGroup);
		}catch (Exception e) {
			logger.error(e.toString());
		}

		return "target/pi_target_group";
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/getGroupDetails", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getGroupDetails(HttpServletRequest request, Model model){
		
		logger.info("getGroupDetails");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String idx = request.getParameter("idx");
			
			Map<String, Object> map = new HashMap<>();
			map.put("idx", idx);
			
			logger.info(map.toString());
			Map<String, Object> targetList  = targetservice.getGroupDetails(map);
			
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
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/updateGroupDetails", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateGroupDetails(HttpServletRequest request, Model model){
		
		logger.info("updateGroupDetails");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String idx = request.getParameter("idx");
			String name = request.getParameter("name");
			String process = request.getParameter("process");
			
			Map<String, Object> map = new HashMap<>();
			map.put("idx", idx);
			if(name != null && !"".equals(name.trim())) {
				map.put("name", name);
			}
			map.put("process", process);
			
			logger.info(map.toString());
			targetservice.updateGroupDetails(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/addNewGroup", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addNewGroup(HttpServletRequest request, Model model){
		
		logger.info("addNewGroup");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String uptidx = request.getParameter("uptidx");
			String name = request.getParameter("name");
			String degree = request.getParameter("degree");
			
			Map<String, Object> map = new HashMap<>();
			map.put("uptidx", uptidx);
			map.put("name", name);
			map.put("degree", degree);
			
			logger.info(map.toString());
			targetservice.addNewGroup(request, map);
			logger.info(map.toString());
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultData", map);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/deleteGroup", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteGroup(HttpServletRequest request, Model model){
		
		logger.info("deleteGroup");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String[] del_id = request.getParameter("del_id").split("\\,");
			
			Map<String, Object> map = new HashMap<>();
			map.put("del_id", del_id);
			
			targetservice.deleteGroup(request, map);
			targetservice.deleteGroupIdx_target(request, map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/pushTargetToGroup", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> pushTargetToGroup(HttpServletRequest request, Model model){
		
		logger.info("pushTargetToGroup");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String[] target_id = request.getParameter("target_id").split("\\,");
			String idx = request.getParameter("idx");
			
			Map<String, Object> map = new HashMap<>();
			map.put("target_id", target_id);
			if(!"noGroup".equals(idx)) {
				map.put("idx", idx);
			}

			logger.info(map.toString());
			targetservice.pushTargetToGroup(request, map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@RequestMapping(value = "/getExceptionList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getExceptionList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)  throws Exception{
		logger.info("getExceptionList ");
		
		List<Map<String, Object>> targeList = targetservice.getExceptionList(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/exceptionSearchList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> exceptionSearchList(HttpServletRequest request, Model model){
		logger.info("exceptionSearchList");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = targetservice.exceptionSearchList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	@RequestMapping(value="/selectSKTManagerList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectSKTManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectSKTManagerList(request);
		
		logger.info("selectSKTManagerList");
		
		return targetList;
    }
	
	@RequestMapping(value="/selectAddSKTManagerList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectAddSKTManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectAddSKTManagerList(request);
		
		logger.info("selectAddSKTManagerList");
		
		return targetList;
    }
	
	@RequestMapping(value = "/insertSKTManager", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertSKTManager(HttpServletRequest request, Model model){
		
		logger.info("insertSKTManager");
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		String USER_NO = request.getParameter("USER_NO");
		String USER_NAME = request.getParameter("USER_NAME");
		String INSA_CODE = request.getParameter("INSA_CODE");
		String TEAM_NAME = request.getParameter("TEAM_NAME");
		
		map.put("USER_NO", USER_NO);
		map.put("USER_NAME", USER_NAME);
		map.put("INSA_CODE", INSA_CODE);
		map.put("TEAM_NAME", TEAM_NAME);
		
		try {
			resultMap = targetservice.insertSKTManager(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
			
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/deleteSKTManager", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteSKTManager(HttpServletRequest request, Model model){
		
		logger.info("deleteSKTManager");
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		String USER_NO = request.getParameter("USER_NO");
		String INSA_CODE = request.getParameter("INSA_CODE");
		
		map.put("USER_NO", USER_NO);
		map.put("INSA_CODE", INSA_CODE);
		
		try {
			resultMap = targetservice.deleteSKTManager(map);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
			
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/insertSKTManagerList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertSKTManagerList(HttpServletRequest request, Model model){
	  
		logger.info("insertSKTManagerList");
	  
		Map<String, Object> resultMap = new HashMap<>();
	  
		try {
			resultMap = targetservice.insertSKTManagerList(request);
		} catch (Exception e){
			logger.error("error >> " + e.toString());
		} finally {
    
		}
	  
	  return resultMap;
	}
	
	@RequestMapping(value="/selectPcManagerList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectPcManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectPcManagerList");
		List<Map<String, Object>> targetList = targetservice.selectPcManagerList(request);
		
		return targetList;
	}

	@RequestMapping(value="/selectVersionList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectVersionList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectVersionList");
		List<Map<String, Object>> targetList = targetservice.selectVersionList(request);
		
		return targetList;
	}
	
	
	@RequestMapping(value = "/pi_global_filters", method = RequestMethod.GET)
	public String pi_global_flters(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_global_filters");
		
		List<Map<String, Object>> apServerList = new ArrayList<>();

		try {
			apServerList = targetservice.apServerList(request);
			
			model.addAttribute("apServerList", apServerList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "target/pi_global_filters";
	}
	
	// 라이선스
	@RequestMapping(value = "/pi_license", method = RequestMethod.GET)
	public String pi_license(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("pi_license");
		
		Map<String, Object> map = new HashMap<>();
		
		model.addAttribute("menuKey", "licenseMenu");
		model.addAttribute("menuItem", "licenseAssign");		
		
		JSONArray groupList = groupService.selectLicenseGroup(map, request); 
		model.addAttribute("licenseList", groupList); 
		
		return "target/pi_license";
	}
	
	@RequestMapping(value = "/selectMngrList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectMngrList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("selectMngrList");
		
		List<Map<String, Object>> targeList = null;
		try {
			targeList = targetservice.selectMngrList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return targeList;
		
	}
	
	@RequestMapping(value = "/pi_inaccess_list", method = RequestMethod.GET)
	public String pi_inaccess_list(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		return "target/pi_inaccess_list";
	}
	
	@RequestMapping(value="/selectInaccessibleList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectInaccessibleList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectInaccessibleList(request);
		
		logger.info("selectInaccessibleList");
		
		return targetList;
    }
	
	@RequestMapping(value="/updateInaccess", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> updateChkStatus(@RequestBody HashMap<String, Object> params)throws Exception {
		logger.info("updateChkStatus");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			targetservice.updateChkStatus(params);
		} catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
		
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		return map;
	}
}
