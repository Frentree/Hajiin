package com.org.iopts.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.service.Pi_UserService;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/user")
public class UserController {

	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private Pi_UserService service;
	
	@RequestMapping(value = "/pi_user_main", method = RequestMethod.GET)
	public String pi_user_main(Locale locale, Model model) throws Exception {

		logger.info("pi_user_main");
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "userMain");
		
		String accessIP = service.selectAccessIP();
		model.addAttribute("accessIP", accessIP);
		
		List<Map<String, Object>> teamMap = service.selectTeamCode();
		model.addAttribute("teamMap", teamMap);
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String fromDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, +1);	     
	    String toDate = fm.format(cal.getTime());

		model.addAttribute("fromDate", fromDate);
		model.addAttribute("toDate", toDate);
		
		return "user/pi_user_main";
	}
	
	@RequestMapping(value = "/pi_user_lockdown", method = RequestMethod.GET)
	public String pi_user_lockdown(Locale locale, Model model) throws Exception {

		logger.info("pi_user_lockdown");
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "userMain");
		
		String accessIP = service.selectAccessIP();
		model.addAttribute("accessIP", accessIP);
		
		List<Map<String, Object>> teamMap = service.selectTeamCode();
		model.addAttribute("teamMap", teamMap);
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String fromDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, +1);	     
	    String toDate = fm.format(cal.getTime());

		model.addAttribute("fromDate", fromDate);
		model.addAttribute("toDate", toDate);
		
		return "user/pi_user_lockdown";
	}

	@RequestMapping(value = "/pi_userlog_main", method = RequestMethod.GET)
	public String pi_userlog(Locale locale, Model model) throws Exception {

		logger.info("pi_userlog_main");
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "userLog");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String toDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String fromDate = fm.format(cal.getTime());

		model.addAttribute("fromDate", fromDate);
		model.addAttribute("toDate", toDate);
		
		List<Map<String, Object>> log_flag_list = new ArrayList<Map<String,Object>>();
		log_flag_list = service.getLogFlagList();
		model.addAttribute("log_flag_list", log_flag_list);
		
		return "user/pi_userlog_main";
	}
	
	@RequestMapping(value = "/pi_notice_main", method = RequestMethod.GET)
	public String pi_user_notice(Locale locale, Model model) throws Exception {
		logger.info("pi_notice_main");
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		noticeMap = service.selectNotice();
		model.addAttribute("Notice", noticeMap);
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "noticeMain");
		return "user/pi_notice_main";
	}
	
	// 공지사항 목록 조회
	@RequestMapping(value = "/noticeList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> noticeList(HttpServletRequest request, Model model){
		logger.info("noticeList");
		
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.noticeList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 공지사항 검색 조회
	@RequestMapping(value = "/noticeSearchList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> noticeSearchList(HttpServletRequest request, Model model){
		logger.info("noticeSearchList");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = service.noticeSearchList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	// 공지사항 등록
	@RequestMapping(value="/noticeInsert", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> noticeInsert(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("noticeInsert");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.noticeInsert(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
	// 공지사항 수정
	@RequestMapping(value="/noticeUpdate", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> noticeUpdate(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("noticeUpdate");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.noticeUpdate(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	// 공지사항 수정
	@RequestMapping(value="/noticeDelete", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> noticeDelete(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("noticeDelete");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.noticeDelete(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/pi_license_main", method = RequestMethod.GET)
	public String pi_license_main(Locale locale, Model model) throws Exception {
		logger.info("pi_license_main");
		
		Map<String, Object> resultMap = new HashMap<>();
//		resultMap = service.getLicenseDetail();
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "licenseMain");
		/*model.addAttribute("resultCode", resultMap.get("resultCode").toString());
		
		if("00".equals(resultMap.get("resultCode").toString())) {
			model.addAttribute("company", resultMap.get("company"));
			model.addAttribute("expire", resultMap.get("expire"));
			model.addAttribute("summaryList", resultMap.get("summaryList"));
			model.addAttribute("targetList", resultMap.get("targetList"));
		}*/
		return "user/pi_license_main";
	}
	
	@RequestMapping(value="/getLicenseDetail", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> getLicenseDetail(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getLicenseDetail");
		
//		logger.info("ap_num : " + request.getParameter("ap_num"));
		Map<String, Object> resultMap = service.getLicenseDetail(request);
		
		return resultMap;
    }
	
	@RequestMapping(value="/changeNotice", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> changeNotice(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeNotice");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.changeNotice(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
	@RequestMapping(value="/pi_userlog_list", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_userlog_list(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_userlog_list");
		List<Map<String, Object>> userlogList = service.selectUserLogList(request);
		
		return userlogList;
    }
	
	@RequestMapping(value = "/changeAccessIP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeAccessIP(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.changeAccessIP(request);
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}

		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
	}

	@RequestMapping(value="/selectManagerList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("selectManagerList");
		List<Map<String, Object>> userlogList = service.selectManagerList(request);
		
		return userlogList;
    }
	
	@RequestMapping(value="/selectLockManagerList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectLockManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		logger.info("selectLockManagerList");
		List<Map<String, Object>> userlogList = service.selectLockManagerList(request);
		
		return userlogList;
	}

	@RequestMapping(value="/selectTeamMember", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTeamMember(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("selectTeamMember");
		List<Map<String, Object>> teamMemberList = service.selectTeamMember(request);
		
		return teamMemberList;
    }
	
	@RequestMapping(value="/createTeam", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> createTeam(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeManagerList");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.createTeam(request);	
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

	@RequestMapping(value="/changeManagerList", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> changeManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeManagerList");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.changeManagerList(request);	
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
	
	@RequestMapping(value="/changeUserData", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> changeUserData(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeUserData");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.changeUserData(request);	
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
	
	// 사용자 비밀번호 초기화
	@RequestMapping(value="/managerResetPwd", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> managerResetPwd(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("managerResetPwd");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			resultMap =  service.managerResetPwd(request);	
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}
		
		map.put("resultCode", resultMap.get("resultCode"));
		map.put("resultMessage", resultMap.get("resultMessage"));
		return map;
	}
	
	@RequestMapping(value="/userDelete", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> userDelete(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("userDelete");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.userDelete(request);	
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
	
	
	

	@RequestMapping(value="/chkDuplicateUserNo", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> chkDuplicateUserNo(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("chkDuplicateUserNo");
		Map<String, Object> dupUserNo = service.chkDuplicateUserNo(request);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		map.put("UserMap", dupUserNo);
		
		return map;
    }

	@RequestMapping(value="/createUser", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> createUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("createUser");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.createUser(request);	
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
	
	@RequestMapping(value="/unlockAccount", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> unlockAccount(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("unlockAccount");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.unlockAccount(request);	
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
	
	@RequestMapping(value = "/pi_download_main", method = RequestMethod.GET)
	public String pi_user_download(Locale locale, Model model) throws Exception {
		logger.info("pi_download_main");
		Map<String, Object> downloadMap = new HashMap<String, Object>();
		downloadMap = service.selectDownload();
		model.addAttribute("Notice", downloadMap);
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "downloadMap");
		return "user/pi_download_main";
	}
	
	@RequestMapping(value = "/downloadList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> downloadList(HttpServletRequest request, Model model){
		logger.info("downloadList");
		
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.downloadList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/downloadSearchList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> downloadSearchList(HttpServletRequest request, Model model){
		logger.info("downloadSearchList");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = service.downloadSearchList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	@RequestMapping(value="/downloadInsert", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> downloadInsert(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("downloadInsert");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.downloadInsert(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
	@RequestMapping(value="/downloadUpdate", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> downloadUpdate(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("downloadUpdate");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.downloadUpdate(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@RequestMapping(value="/downloadDelete", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> downloadDelete(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("downloadDelete");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.downloadDelete(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}

	// 사용자 정보 수정(개인)
	@RequestMapping(value="/userSetting", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> userSetting(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("userSetting");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.changeUserSettingData(request);	
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
	
	// 사용자 등록 직급 조회
	@RequestMapping(value = "/selectMemberTeam", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectMemberTeam(HttpServletRequest request, Model model){
		logger.info("selectMemberTeam");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = service.selectMemberTeam(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	// PC 중간관리자 검색
	@RequestMapping(value = "/selectPCAdmin", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectPCAdmin(HttpServletRequest request, Model model){
		logger.info("selectPCAdmin");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		try {
			resultList = service.selectPCAdmin(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
		
	}
	
	@RequestMapping(value="/SMSFlag", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> selectSMSFlag() throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String result = service.selectSMSFlag();
			map.put("result", result);
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
	
	@RequestMapping(value="/updateSMSFlag", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> updateSMSFlag(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.updateSMSFlag(request);
			String result = service.selectSMSFlag();
			logger.info("result >> " + result);
			if(result.equals("Y")) {
				resultMap.put("resultCode", 0);
				resultMap.put("resultMessage", "SMS인증이 활성화 되었습니다.");
			}else if(result.equals("N")) {
				resultMap.put("resultCode", 1);
				resultMap.put("resultMessage", "SMS인증이 비활성화 되었습니다.");
			}
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/pi_interlock", method = RequestMethod.GET)
	public String pi_interlock(Locale locale, Model model) throws Exception {
		
		List<Map<Object, Object>> setMap = service.selectSetting();
		model.addAttribute("setMap", setMap);
		
		return "user/pi_interlock";
	}
	
}
