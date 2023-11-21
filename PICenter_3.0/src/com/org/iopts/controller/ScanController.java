package com.org.iopts.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.service.Pi_ScanService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONObject;


/**
 * Handles requests for the application home page.
 */

@Controller
@PropertySource("classpath:/property/config.properties")
@Configuration
@RequestMapping(value = "/scan", method = {RequestMethod.POST,RequestMethod.GET})
public class ScanController {

	private static Logger logger = LoggerFactory.getLogger(ScanController.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;

	@Inject
	private Pi_ScanService scheduleservice;
	
	@Inject
	private Pi_TargetService targetservice;

	@RequestMapping(value = "/pi_scan_main", method = RequestMethod.GET)
	public String pi_scan_main(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_main");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String curDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String befDate = fm.format(cal.getTime());

		model.addAttribute("befDate", befDate);
		model.addAttribute("curDate", curDate);

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		return "scan/pi_scan_main";
	}

	@RequestMapping(value="/pi_scan_rescan", method={RequestMethod.POST})
	public String pi_scan_rescan(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_rescan");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		return "scan/pi_scan_rescan";
    }
	
	@RequestMapping(value="/pi_scan_status", method={RequestMethod.POST})
	public String pi_scan_status(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_status");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "status");
		
		return "scan/pi_scan_status";
    }
	
	@RequestMapping(value="/pi_scan_history", method={RequestMethod.POST})
	public String pi_scan_history(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_scan_history");
		
		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		model.addAttribute("targetList", targetList);
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "history");
		
		return "scan/pi_scan_history";
    }
	
	@RequestMapping(value="/pi_scan_schedule", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_scan_schedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_scan_schedule");
		
		List<Map<String, Object>> schedulList = scheduleservice.selectSchedules(request);
		
		return schedulList;
    }
	
	@RequestMapping(value="/changeSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> changeSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeSchedule");
		
		Map<String, Object> schedulList = new HashMap<String, Object>();
		try {
			schedulList = scheduleservice.changeSchedule(request, recon_id, recon_password, recon_url, api_ver);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			schedulList.put("resultCode", -1);
			schedulList.put("resultMessage", e.getMessage());
		}
		
		return schedulList;
    }

	@RequestMapping(value="/viewSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> viewSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("viewSchedule");
		
		Map<String, Object> schedulList = scheduleservice.viewSchedule(request, recon_id, recon_password, recon_url, api_ver);
		
		return schedulList;
    }
	
	/*
	// schedule 등록 화면 호출
	@RequestMapping(value = "/pi_scan_regist", method = RequestMethod.GET)
	public String pi_scan_regist(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_regist");

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);
		

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String today = fm.format(cal.getTime());

		model.addAttribute("today", today);
		
		return "scan/pi_scan_regist";
	}
	*/
	
	// schedule 등록 화면 호출
	@RequestMapping(value = "/pi_scan_regist", method = RequestMethod.GET)
	public String pi_scan_regist(HttpServletRequest request, Locale locale, Model model) throws Exception {
		logger.info("pi_scan_regist");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);
		
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> groupList = scheduleservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		map.put("aut", "manager");
		map.put("noGroup", "Y");
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList(map);
		model.addAttribute("noGroupSize", locationList.size());
		
		logger.info("locationList.size() :: " + locationList.size());
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String today = fm.format(cal.getTime());
		
		model.addAttribute("today", today);
		
		return "scan/pi_scan_regist";
	}
	
	@RequestMapping(value="/pi_scan_modify", method={RequestMethod.POST})
	public String pi_scan_modify(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_scan_modify");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		model.addAttribute("idx",      request.getParameter("idx"));
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);

		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeListMod(request);
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_scan_modify";
    }
	
	@RequestMapping(value = "/pi_datatype_profile", method = RequestMethod.GET)
	public String pi_datatype_profile(Locale locale, Model model) throws Exception {
		logger.info("pi_datatype_profile");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String curDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String befDate = fm.format(cal.getTime());

		model.addAttribute("befDate", befDate);
		model.addAttribute("curDate", curDate);

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "dataTypeProfile");
		
		return "scan/pi_datatype_profile";
	}
	
	@RequestMapping(value="/pi_datatype_insert", method={RequestMethod.POST})
	public String pi_datatype_insert(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_datatype_insert");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "dataTypeProfile");
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_datatype_insert";
    }
	
	@RequestMapping(value="/pi_datatype_modify", method={RequestMethod.POST})
	public String pi_datatype_modify(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_datatype_modify");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "dataTypeProfile");
		
		String datatypeID = (String) request.getParameter("datatype_id");
		
		model.addAttribute("datatypeID", datatypeID);

		return "scan/pi_datatype_modify";
    }

	/*@RequestMapping(value="/pi_policy_insert", method={RequestMethod.POST})
	public String pi_policy_insert(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_policy_insert");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_policy_insert";
    }*/
	
	@RequestMapping(value="/pi_policy_insert", method={RequestMethod.POST})
	public String pi_policy_insert2(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_policy_insert");
		
		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		/*List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);*/
		
		return "scan/pi_policy_insert";
	}
	
	@RequestMapping(value="/pi_policy_insert_user", method={RequestMethod.POST})
	public String pi_policy_insert_user(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_policy_insert_user");
		
		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);
		
		return "scan/pi_policy_insert_user";
	}
	
	@RequestMapping(value="/registSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("registSchedule");
		
		Map<String, Object> schedulList = scheduleservice.registSchedule(request, api_ver);
		
//		logger.info(request.getParameter("scheduleArr"));
		return schedulList;
    }

	@RequestMapping(value="/getProfileDetail", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> getProfileDetail(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getProfileDetail");
		
		Map<String, Object> schedulList = scheduleservice.getProfileDetail(request, recon_id, recon_password, recon_url, api_ver);
		
		return schedulList;
    }
	
	/**
	 * 스캔 히스토리 화면에서 데이터 불러오는 로직
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewScanHistory", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> viewScanHistory(HttpServletRequest request, Model model) {
		logger.info("viewScanHistory");
		
		List<Map<String, Object>> historyList = scheduleservice.viewScanHistory(request);
		logger.info("historyList chk : " + historyList);
		model.addAttribute("historyList", historyList);
		return historyList;
	}
	
	/**
	 * 재검색 정책 화면에서 데이터 불러오는 로직
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewScanPolicy", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> viewScanPolicy(HttpServletRequest request){
		logger.info("viewScanPolicy");
		
		List<Map<String, Object>> policyList = scheduleservice.viewScanPolicy(request);
		
		return policyList;
	}
	
	/**
	 * scan policy 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/registPolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> registPolicy(HttpServletRequest request, Model model){
		logger.info("registPolicy");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.registPolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
			
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/updatePolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updatePolicy(HttpServletRequest request, Model model){
		logger.info("registPolicy");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.updatePolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
			
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/getProfile", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getProfile(HttpServletRequest request, Model model){
		logger.info("getProfile");
		
		List<Map<String, Object>> resultMap;
		resultMap = scheduleservice.getProfile(request);
		
		
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/insertProfile", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertProfile(HttpServletRequest request, Model model){
		logger.info("insertProfile");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = scheduleservice.insertProfile(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/insertPolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertPolicy(HttpServletRequest request, Model model){
		logger.info("insertPolicy");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = scheduleservice.insertPolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateProfile(HttpServletRequest request, Model model){
		logger.info("insertProfile");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = scheduleservice.updateProfile(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/deleteProfile", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteProfile(HttpServletRequest request, Model model){
		logger.info("insertProfile");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.deleteProfile(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "CLEAR");
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/updateDefaultPolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateDefaultPolicy(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.resetDefaultPolicy(request);
			scheduleservice.updateDefaultPolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
			
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
	}
	
	@RequestMapping(value = "/getScanSchedule", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getScanSchedule(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			resultMap = this.scheduleservice.getScanSchedule(request);
		} catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		}
		return resultMap;
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/manageSchedule", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> manageSchedule(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			resultMap = this.scheduleservice.manageSchedule(request);
					
		} catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/deleteSchedule", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteSchedule(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			
			resultMap = this.scheduleservice.deleteSchedule(request);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/executeChecked", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> executeChecked(@RequestBody JSONObject data, HttpServletRequest request){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
			resultMap = this.scheduleservice.executeChecked(data, request);
			
		} catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@RequestMapping(value="/getDetails", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> getDetails(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getDetails");
		
		Map<String, Object> schedulList = scheduleservice.getDetails(request);
		
		return schedulList;
    }
	
	@RequestMapping(value = "/pi_scan_main_user", method = RequestMethod.GET)
	public String pi_scan_main_user(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_main");
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String curDate = fm.format(cal.getTime());
		
		cal.setTime(new Date());
		cal.add(Calendar.MONTH, -1);	     
		String befDate = fm.format(cal.getTime());
		
		model.addAttribute("befDate", befDate);
		model.addAttribute("curDate", curDate);
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		return "scan/pi_scan_main_user";
	}
	
	@RequestMapping(value="/pi_scan_rescan_user", method={RequestMethod.POST})
	public String pi_scan_rescan_user(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_rescan");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		return "scan/pi_scan_rescan_user";
	}
	/*
	@RequestMapping(value = "/pi_scan_regist_user", method = RequestMethod.GET)
	public String pi_scan_regist_user(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_regist");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);
		
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String today = fm.format(cal.getTime());
		
		model.addAttribute("today", today);
		
		return "scan/pi_scan_regist_user";
	}*/
	
	@RequestMapping(value = "/pi_scan_regist_user", method = RequestMethod.GET)
	public String pi_scan_regist_user(HttpServletRequest request, Locale locale, Model model) throws Exception {
		logger.info("pi_scan_regist_user");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
//		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
//		model.addAttribute("datatypeList", datatypeList);
		
		Map<String, Object> map = new HashMap<>();
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		map.put("user_no", user_no);
		
		List<Map<String, Object>> groupList = scheduleservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);
		
		map.put("noGroup", "Y");
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList(map);
		model.addAttribute("noGroupSize", locationList.size());
		
		logger.info("locationList.size() :: " + locationList.size());
		
		logger.info(request.getRequestURI());
		logger.info(request.getRequestURL().toString());
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String today = fm.format(cal.getTime());
		
		model.addAttribute("today", today);
		
		return "scan/pi_scan_regist_user";
	}
	
	@RequestMapping(value="/registSchedule_user", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registSchedule_user(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("registSchedule_user");
		
		Map<String, Object> schedulList = scheduleservice.registSchedule(request, this.api_ver);
		
		return schedulList;
    }

	@RequestMapping(value="/pi_scan_modify_user", method={RequestMethod.POST})
	public String pi_scan_modify_user(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_scan_modify_user");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		model.addAttribute("idx",      request.getParameter("idx"));
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);

		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeListMod(request);
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_scan_modify_user";
    }
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/selectLocationList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectLocationList(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			
			String group_id = request.getParameter("group_id");
			String aut = request.getParameter("aut");
			Map<String, Object> map = new HashMap<>();
			if("noGroup".equals(group_id)) {
				map.put("noGroup", "Y");
			}else {
				map.put("group_id", group_id);
			}
			
			map.put("aut", aut);
//			if(aut != null && "manager".equals(aut)) {
//			}
			
			List<Map<String, Object>> locationList  = scheduleservice.selectLocationList(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultData", locationList);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value = "/searchLocationList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchLocationList(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			
			String host = request.getParameter("host");
			logger.info("host :: " + host);
			Map<String, Object> map = new HashMap<>();
			map.put("host", host);
			
			logger.info(map.toString());
			
			List<Map<String, Object>> locationList  = scheduleservice.selectLocationList(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultData", locationList);
			
		} catch (Exception e){
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} finally {
			return resultMap;
		}
		
	}
	
	@RequestMapping(value = "/pi_manage_policy", method = RequestMethod.GET)
	public String pi_manage_policy(Locale locale, Model model) throws Exception {
		logger.info("pi_manage_policy");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String curDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String befDate = fm.format(cal.getTime());

		model.addAttribute("befDate", befDate);
		model.addAttribute("curDate", curDate);

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "managePolicy");
		
		return "scan/pi_manage_policy";
	}
	
	@RequestMapping(value="/getApList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> getApList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getApList");
		
		List<Map<String, Object>> resultList = scheduleservice.getApList(request);
		
		return resultList;
    }
	
	@RequestMapping(value="/getPolicyByApno", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> getPolicyByApno(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getPolicyByApno");
		
		Map<String, Object> schedulList = scheduleservice.getPolicyByApno(request);
		
		return schedulList;
	}
	
	@RequestMapping(value="/getScanDetails", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> getScanDetails(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getScanDetails");
		
		Map<String, Object> schedulList = scheduleservice.getScanDetails(request, recon_id, recon_password, recon_url);
		
		return schedulList;
    }
}
