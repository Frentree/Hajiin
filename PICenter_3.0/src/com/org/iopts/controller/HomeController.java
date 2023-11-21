package com.org.iopts.controller;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.group.service.GroupService;
import com.org.iopts.service.Pi_AgentService;
import com.org.iopts.service.Pi_DashService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */

@Controller
@Configuration
@PropertySource("classpath:/property/config.properties")
public class HomeController {

	private static Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;

	@Value("${recon.api.version}")
	private String api_ver;

	@Inject
	private Pi_UserService service;

	@Inject
	private Pi_TargetService targetservice;

	@Inject
	private Pi_AgentService agetnservice;

	@Inject
	private Pi_DashService dashservice;
	
	@Inject
	private GroupService groupservice;

	@RequestMapping(value = { "/" }, method = {RequestMethod.GET, RequestMethod.POST})
	public String home(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		
//		return "main";
		return "main";
	}

	@RequestMapping(value = { "/mailImg" }, method = {RequestMethod.GET, RequestMethod.POST})
	public String mailImg(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		logger.info("/mailImg");
		
		return "mailImg";
	}
	
	@RequestMapping(value = { "/sso_link" }, method = {RequestMethod.GET, RequestMethod.POST})
	public String sso_link(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		logger.info("/sso_link");
		
		
		String userid = request.getParameter("userid");
		
		model.addAttribute("userid", userid);
		return "sso_link";
	}


	@RequestMapping(value = { "/main" }, method = RequestMethod.GET)
	public String main(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
//		return "main";
		return "main";
	}

	// uri.equals("/pie") || uri.equals("/skt_approval") ||
	// uri.equals("/skt_contact_list")
	// 송명수씨 작업 내역
	@RequestMapping(value = { "/main1" }, method = RequestMethod.GET)
	public String home1(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "main1";
	}

	@RequestMapping(value = { "/main2" }, method = RequestMethod.GET)
	public String home2(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "main2";
	}

	@RequestMapping(value = { "/main3" }, method = RequestMethod.GET)
	public String home3(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "main3";
	}

	@RequestMapping(value = { "/pie" }, method = RequestMethod.GET)
	public String pie(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "pie";
	}

	@RequestMapping(value = { "/skt_approval" }, method = RequestMethod.GET)
	public String skt_approval(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		return "skt_approval";
	}

	@RequestMapping(value = { "/skt_contact_list" }, method = RequestMethod.GET)
	public String skt_contact_list(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		return "skt_contact_list";
	}

	@RequestMapping(value = { "/demo" }, method = RequestMethod.GET)
	public String demo(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "demo";
	}
	
	@RequestMapping(value = { "/faq" }, method = RequestMethod.GET)
	public String faq(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response)
			throws Exception {
		return "faq/faq";
	}

	/**
	 * 여기 다가 입력된 pi_user 테이블에 user_id 확인해서 등록된 사용자가 아니면 로그인 안되게 해 주세요. 로그인이 성공하면
	 * pi_userlog 테이블에 이력 쌓아 주세요. job_info 칼럼에 : LOGIN(SUCCESS), LOGIN(FAIL)
	 */
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> login(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("/login");

		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>();
		try {
			memberMap = service.selectMember(request);
			String result = memberMap.get("resultCode").toString();
			memberMap.put("resultCode", result);
			memberMap.put("resultMessage", memberMap.get("resultMessage"));
		} catch (Exception e) {
			memberMap.put("resultCode", -100);
			e.printStackTrace();
		}
		Map<String, Object> noticeMap = service.selectNotice();
		model.addAttribute("noticeMap", noticeMap);
		model.addAttribute("user_grade", memberMap.get("user_grade"));

		return memberMap;
	}
	
	@RequestMapping(value = "/changeUser", method = { RequestMethod.POST,  RequestMethod.GET })
	public @ResponseBody Map<String, Object> changeUser(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("/changeUser");

		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>();
		try {
			memberMap = service.changeUser(request);
			String result = memberMap.get("resultCode").toString();
			memberMap.put("resultCode", result);
			memberMap.put("resultMessage", memberMap.get("resultMessage"));
		} catch (Exception e) {
			memberMap.put("resultCode", -100);
			e.printStackTrace();
		}
		Map<String, Object> noticeMap = service.selectNotice();
		model.addAttribute("noticeMap", noticeMap);
		model.addAttribute("memberInfo", memberMap.get("member"));
		model.addAttribute("user_grade", memberMap.get("user_grade"));

		return memberMap;
	}
	
	@RequestMapping(value = "/accountMemberSSO", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> accountMemberSSO(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/accountMemberSSO");
		
		Map<String, Object> memberMap = new HashMap<String, Object>();
		try {
			memberMap = service.accountMemberSSO(request);

			String result = memberMap.get("resultCode").toString();
			
			memberMap.put("resultCode", result);
			memberMap.put("resultMessage", memberMap.get("resultMessage"));
		} catch (Exception e) {
			memberMap.put("resultCode", -100);
			e.printStackTrace();
		}
		model.addAttribute("user_grade", memberMap.get("user_grade"));
		
		return memberMap;
	}

	@RequestMapping(value = "/session_quit", method = { RequestMethod.GET, RequestMethod.POST })
	public String sessionQuit(Model model, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		return "session_quit";
	}
	
	@RequestMapping(value = "/submitSmsLogin", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> submitSmsLogin(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/submitSmsLogin");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.submitSmsLogin(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -100);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		model.addAttribute("memberInfo", memberMap.get("member"));
		model.addAttribute("user_grade", memberMap.get("user_grade"));
		
		return memberMap;
	}
	
	@RequestMapping(value = "/loginsms", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> loginSMS(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/loginsms");
		
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.authSMS(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		

		return memberMap;
	}
	
	
	// 초기화 인증번호 발송
	@RequestMapping(value = "/resetnum", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> resetNum(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/resetnum");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>();
		
		try {
			memberMap = service.resetNum(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}

		return memberMap;
	}
	
	// 비밀번호 초기화
	@RequestMapping(value = "/resetPwd", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> resetPwd(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/resetPwd");
		
		Map<String, Object> memberMap = new HashMap<String, Object>();
		
		try {
			memberMap = service.resetPwd(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}

		return memberMap;
	}
	
	// 초기화 비밀번호 변경
	@RequestMapping(value = "/changeResetPwd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeResetPwd(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = service.changeResetPwd(request);
		} catch (Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}

		//model.addAttribute("memberInfo", resultMap.get("member"));

		return resultMap;
	}
	
	// 비밀번호 초기화 취소 
	@RequestMapping(value = "/reset_sms_code", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reset_sms_code(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {
		logger.info("reset_sms_code");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = service.reset_sms_code(request);
		} catch (Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}

		return resultMap;
	}
	
	@RequestMapping(value = "/sms_login", method = {RequestMethod.GET, RequestMethod.POST})
	public String smsLogin(Model model, HttpSession session) 
	{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		try {
			List<Map<String, Object>> userGroupList = targetservice.selectUserGroupList(map);
			model.addAttribute("userGroupList", userGroupList);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return "sms_login";
	}
	
	@RequestMapping(value = "/sms_login_resend", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> smsLoginResend(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/sms_login_resend");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.authSMSResend(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -100);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		

		return memberMap;
	}
	@RequestMapping(value = "/sms_login_cancel", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> smsLoginCancel(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/sms_login_cancel");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.authSMSCancel(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -100);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}

		return memberMap;
	}
	
	@RequestMapping(value = "/NCLoginTestENC", method = {RequestMethod.GET, RequestMethod.POST})
	public String NCLoginTestENC(Model model, HttpSession session) 
	{
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		return "NCLoginTestENC";
	}

	@RequestMapping(value = "/NCLoginTestEndVerify", method = RequestMethod.POST)
	public String NCLoginTestEndVerify(Model model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("ticket", request.getParameter("ticket"));
		model.addAttribute("ssoid", request.getParameter("ssoid"));

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		return "NCLoginTestEndVerify";
	}

	@RequestMapping(value = "/changeAuthCharacter", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeAuthCharacter(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = service.changeAuthCharacter(request);
		} catch (Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}

		model.addAttribute("memberInfo", resultMap.get("member"));

		return resultMap;
	}
	
	@RequestMapping(value = "/loginSSO", method = { RequestMethod.POST,  RequestMethod.GET })
	public @ResponseBody Map<String, Object> loginSSO(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("/loginSSO");

		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>();
		try {
			memberMap = service.selectSSOMember(request);
			/*
			 * EmailVO p=new EmailVO(1); p.setSendder("sender.."); p.setReciver("receiver");
			 * 
			 * NhEmailUtil e=new NhEmailUtil("e:/temp/email/",p); e.sendEmail();
			 */
			String result = memberMap.get("resultCode").toString();
			/*if(!"0".equals(result)) {
				memberMap.put("resultCode", -1);
			}*/
			memberMap.put("resultCode", result);
			memberMap.put("resultMessage", memberMap.get("resultMessage"));
		} catch (Exception e) {
			memberMap.put("resultCode", -100);
			//memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		Map<String, Object> noticeMap = service.selectNotice();
		model.addAttribute("noticeMap", noticeMap);
		model.addAttribute("memberInfo", memberMap.get("member"));
		model.addAttribute("user_grade", memberMap.get("user_grade"));

		return memberMap;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> logout(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {

		service.logout(request);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "Log-Out");

		return resultMap;
	}

	@RequestMapping(value = "/piboard", method = RequestMethod.GET)
	public String main(Locale locale, Model model, HttpServletRequest request) throws Exception {

		logger.info("Start piboard");
		logger.info("dash_menu");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		
		
		try {
			String userGroupList = groupservice.selectUserListGroup(map, request);
			model.addAttribute("userGroupList", userGroupList);
			
			JSONArray deptList = groupservice.selectDashDeptList(map, request);
			model.addAttribute("deptList", deptList);
			
			List<Map<String, Object>> noticeList = targetservice.selectNoticeList(map);
			model.addAttribute("noticeList", noticeList);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		
		return "dashboard/dash_main_PIC";
	}

	@RequestMapping(value = "/piboard_skt", method = RequestMethod.GET)
	public String piboard_skt(Locale locale, Model model) throws Exception {

		logger.info("Start piboard_skt");

		logger.info("dash_menu");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");

		List<Map<String, Object>> groupList = targetservice.selectGroupList(map);
		model.addAttribute("groupList", groupList);

		List<Map<String, Object>> noGroupList = targetservice.getTargetList(map);
		logger.info("noGroupSize :: " + noGroupList.size());
		model.addAttribute("noGroupSize", noGroupList.size());

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

//		return "dashboard/dash_main";
		return "dashboard/dash_main_sktPIC";
	}
	
	@RequestMapping(value = "/picenter_manager", method = RequestMethod.GET)
	public String main_skt_manager(Locale locale, Model model, HttpServletRequest request) throws Exception {

		logger.info("Start piboard_skt_manager");
		logger.info("dash_menu");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		
		
		try {
			String userGroupList = groupservice.selectUserGroupList(map, request);
			model.addAttribute("userGroupList", userGroupList);
			
			List<Map<String, Object>> noticeList = targetservice.selectNoticeList(map);
			model.addAttribute("noticeList", noticeList);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		
		return "dashboard/dash_main_PIC_manager";
	}
	
	@RequestMapping(value = "/picenter_server", method = RequestMethod.GET)
	public String main_skt_server(Locale locale, Model model, HttpServletRequest request) throws Exception {

		logger.info("Start piboard_skt_server");
		logger.info("dash_menu");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		
		
		try {
			String userGroupList = groupservice.selectUserGroupList(map, request);
			model.addAttribute("userGroupList", userGroupList);
			
			/*JSONArray server_dept = groupservice.selectDashSeverDept(map, request);
			model.addAttribute("serverDept", server_dept);
			
			JSONArray pc_dept = groupservice.selectDashPCDept(map, request);
			model.addAttribute("pcDept", pc_dept);*/
			
			List<Map<String, Object>> noticeList = targetservice.selectNoticeList(map);
			model.addAttribute("noticeList", noticeList);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		
		return "dashboard/dash_main_PIC_server";
	}
	
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header(Locale locale, Model model) throws Exception {

		logger.info("header");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "header";
	}

	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public String footer(Locale locale, Model model) throws Exception {

		logger.info("footer");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "footer";
	}

	@RequestMapping(value = "/dash_main", method = RequestMethod.GET)
	public String dash_main(Locale locale, Model model) throws Exception {

		logger.info("dash_main");
		List<Map<String, Object>> targetList = targetservice.selectTargetManagement();
		List<Pi_AgentVO> dashList = null;

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();

		String target_id = request.getParameter("target_id"); // jsp의 자바스크립트를 통해 받아온 호스트 이름
		logger.info("dash_main_target : " + target_id);

		if (targetList != null && targetList.size() != 0) {
			if (target_id != null) {
				dashList = agetnservice.dashAgent_Info(target_id); // 값을 받으면 DB에 호스트 결과를 받아 옴
				model.addAttribute("target_id", target_id);
			} else {
				dashList = agetnservice.dashAgent_Info((String) targetList.get(0).get("TARGET_ID")); // 메뉴에서 클릭시 맨처음
																										// 타겟리스트의 에이전트
																										// 내용을 받아옴
				model.addAttribute("target_id", (String) targetList.get(0).get("TARGET_ID"));
			}
			model.addAttribute("targetList", targetList);
			if (dashList != null) {
				model.addAttribute("agentList", dashList);
			}
		}

		return "dashboard/dash_main";
	}

	@RequestMapping(value = "/selectWebLink", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectWebLink(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) {
		logger.info("selectWebLink");
		Map<String, Object> webLink = new HashMap<>();
		try {
			webLink = dashservice.selectWebLink();
			return webLink;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			webLink.put("failed", "0");
			return webLink;
		}

	}

	@RequestMapping(value = "/pi_targetInfo", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> pi_targetInfo(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_targetInfo");
		Map<String, Object> targetInfo = dashservice.selectDashInfo(request, api_ver);

		return targetInfo;
	}

	@RequestMapping(value = "/pi_datatype", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> pi_datatype(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_datatype");
		List<Map<String, Object>> datatypeList = dashservice.selectDatatype(request);

		//List<Map<String,Object>> datatypeList = dashservice.selectDatatype(request);
		logger.info(datatypeList.toString());
		return datatypeList;
	}

	@RequestMapping(value = "/pi_datatypes", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> pi_datatypes(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_datatypes");
		Map<String, Object> datatypesList = dashservice.selectDatatypes(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_datatype_manager", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> pi_datatype_manager(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_datatype_manager");
		List<Map<String, Object>> datatypeList = dashservice.selectDatatypeManager(request);

		//List<Map<String,Object>> datatypeList = dashservice.selectDatatype(request);
		logger.info(datatypeList.toString());
		return datatypeList;
	}

	@RequestMapping(value = "/pi_systemcurrent", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrent(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent");
		List<Object> datatypesList = dashservice.selectSystemCurrent(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_systemcurrent_pc", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrentPC(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent_pc");
		List<Object> datatypesList = dashservice.selectSystemCurrentPC(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_systemcurrent_manager", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrentManager(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent_manager");
		List<Object> datatypesList = dashservice.selectSystemCurrentManager(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_systemcurrent_service", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrentService(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent_service");
		List<Object> datatypesList = dashservice.selectSystemCurrentService(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_pathcurrent", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectPathCurrent(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_pathcurrent");
		List<Object> datatypesList = dashservice.selectPathCurrent(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_server_excelDownload", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectServerExcelDownload(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_server_excelDownload");
		List<Object> datatypesList = dashservice.selectServerExcelDownload(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_server_excelDownloadList", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectServerExcelDownloadList(@RequestParam(value="targetList[]") List<String> targetList,
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_server_excelDownloadList");
		List<Object> selectServerExcelDownloadList = dashservice.selectServerExcelDownloadList(request, targetList);
		return selectServerExcelDownloadList;
	}
	
	@RequestMapping(value = "/pi_pc_excelDownload", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectPCExcelDownload(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_pc_excelDownload");
		List<Object> datatypesList = dashservice.selectPCExcelDownload(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_pc_excelDownloadList", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectPCExcelDownloadList(@RequestParam(value="targetList[]") List<String> targetList,
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_pc_excelDownloadList");
		List<Object> selectPCExcelDownloadList = dashservice.selectPCExcelDownloadList(request, targetList);
		return selectPCExcelDownloadList;
	}

	@RequestMapping(value = "/selectJumpUpHost", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectJumpUpHost(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectJumpUpHost");
		List<Object> datatypesList = dashservice.selectJumpUpHost(request);
		return datatypesList;
	}

	@RequestMapping(value = "/selectlastScanDate", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectlastScanDate(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) {
		logger.info("selectlastScanDate");
		Map<String, Object> scanDate = dashservice.selectlastScanDate(request);

		return scanDate;
	}
	

	@RequestMapping(value = { "/ReconTest", "/ReconTest" }, method = RequestMethod.GET)
	public String ReconTest(Locale locale, Model model) throws Exception {

		ReconUtil reconUtil = new ReconUtil();
		/**
		 * 데이터를 가져오는 로직과 파싱 , insert 로직은 srviceImpl로 옮기시는 것이 좋습니다.
		 */
		/*
		 * // 1. ‘https://172.30.1.58:8339/beta/groups/all’ // doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/groups/all", "GET", null); //
		 * logger.info("/beta/groups/all :" + doc.toString());
		 * 
		 * // 2. ‘/beta/agents’ doc = reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/agents", "GET", null); logger.info("/beta/agents :" +
		 * doc.toString());
		 * 
		 * // 3. ‘/beta/targets/619591177460534829/matchobjects’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/targets/619591177460534829/matchobjects", "GET", null);
		 * logger.info("/beta/target/[target_id]/matchsobject :" + doc.toString());
		 * 
		 * // 4. ‘/beta/schedules’ doc = reconUtil.getServerData(recon_id,
		 * recon_password, recon_url+"/beta/schedules", "GET", null);
		 * logger.info("/beta/schedules :" + doc.toString());
		 * 
		 * // 5. ‘/beta/schedules?completed=true’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/schedules?completed=true", "GET", null);
		 * logger.info("/beta/schedules?completed= true :" + doc.toString());
		 * 
		 * // 6. ‘/beta/datatypes/profiles’ doc = reconUtil.getServerData(recon_id,
		 * recon_password, recon_url+"/beta/datatypes/profiles", "GET", null);
		 * logger.info("/beta/datatypes/profiles :" + doc.toString());
		 * 
		 * // 7. ‘/beta/datatypes/profiles?details=true’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/datatypes/profiles?details=true", "GET", null);
		 * logger.info("/beta/datatypes/profiles?details=true :" + doc.toString());
		 * 
		 * // 8. ‘/beta/targets/619591177460534829/matchobjects/13127129315531939159’
		 * doc = reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/targets/619591177460534829/matchobjects/1", "GET", null);
		 * logger.
		 * info("/beta/targets/619591177460534829/matchobjects/13127129315531939159 :" +
		 * doc.toString());
		 */

//		9.	‘/beta/schedules’  : Data 입력 Post로 전송 해야함.
		// 여기서 부터는 Recon server에 데이터 넣는 테스트 -> 스케줄 추가 등록
		// JSON Data 만들기
		JSONObject jsonMain = new JSONObject();
		JSONObject jsonpause = new JSONObject();
		JSONObject jsonTarget = new JSONObject();
		JSONObject jsonLocations = new JSONObject();

		jsonLocations.put("id", "8987302884414283716");
		jsonLocations.put("subpath", "string");
		jsonTarget.put("id", "548122207921155732");
		jsonTarget.put("locations", jsonLocations);

		jsonpause.put("days", 2);
		jsonpause.put("start", 66600);
		jsonpause.put("end", 34200);

		jsonMain.put("label", "aaa");
		jsonMain.put("targets", jsonTarget);

		String[] profiles = { "16966619905757791327" };

		jsonMain.put("profiles", profiles);
		jsonMain.put("start", "2019-03-05 18:00");
		jsonMain.put("timezone", "Default");
		jsonMain.put("repeat_days", 14);
		jsonMain.put("repeat_months", 0);
		jsonMain.put("cpu", "low");
		jsonMain.put("throughput", 0);
		jsonMain.put("memory", 0);
		jsonMain.put("capture", false);
		jsonMain.put("trace", true);
		jsonMain.put("pause", jsonpause);

		// Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id,
		// recon_password, recon_url + "/beta/schedules", "POST", jsonMain.toString());
		Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id, recon_password,
				recon_url + "/" + api_ver + "/schedules", "POST", jsonMain.toString());

		int resultCode = (Integer) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			// Recon Server Data 오류 인 경우
			logger.info("Recon Server Error == " + resultCode + " : " + resultMessage);
		}

		// 여기서 부터는 Recon server에서 데이터 받는 테스트
		// httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url +
		// "/beta/groups/all", "GET", null);
		httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/groups/all",
				"GET", null);
		resultCode = (Integer) httpsResponse.get("HttpsResponseCode");
		resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			// Recon Server Data 오류 인 경우
			logger.info("Recon Server Error == " + resultCode + " : " + resultMessage);
		}

		Document doc = (Document) httpsResponse.get("HttpsResponseData");

		List<Pi_TargetVO> list = new ArrayList<Pi_TargetVO>();
		// Find Group id ==> 4493621271884028236
		NodeList nodeList = doc.getElementsByTagName("group");
		Node node = nodeList.item(0);
		Element element = (Element) node.getChildNodes();
		String GroupID = element.getElementsByTagName("id").item(0).getTextContent();
		logger.info("GroupID :" + GroupID);

		nodeList = doc.getElementsByTagName("targets");
		logger.info(" " + nodeList.getLength());
		for (int i = 0; i < nodeList.getLength(); i++) {
			node = nodeList.item(i);

			if (node.getNodeType() == Node.ELEMENT_NODE) {
				element = (Element) node.getChildNodes();
				logger.info("Current Element :" + node.getNodeName());
				String TargetID = element.getElementsByTagName("id").item(0).getTextContent();
				String TargetName = element.getElementsByTagName("name").item(0).getTextContent();
				String TargetComments = element.getElementsByTagName("comments").item(0).getTextContent();
				String TargetSearchTime = element.getElementsByTagName("search_time").item(0).getTextContent();
				String TargetSearchStatus = element.getElementsByTagName("search_status").item(0).getTextContent();
				String TargetPlatform = element.getElementsByTagName("platform").item(0).getTextContent();

				NodeList nodeListError = element.getElementsByTagName("errors");
				Node nodeError = nodeListError.item(0);
				Element elementError = (Element) nodeError.getChildNodes();
				String notice = elementError.getElementsByTagName("notice").item(0).getTextContent();
				String error = elementError.getElementsByTagName("error").item(0).getTextContent();
				String critical = elementError.getElementsByTagName("critical").item(0).getTextContent();

				NodeList nodeListMatches = element.getElementsByTagName("matches");
				Node nodeMatches = nodeListMatches.item(0);
				Element elementMatches = (Element) nodeMatches.getChildNodes();
				String test = elementMatches.getElementsByTagName("test").item(0).getTextContent();
				String match = elementMatches.getElementsByTagName("match").item(0).getTextContent();
				String prohibited = elementMatches.getElementsByTagName("prohibited").item(0).getTextContent();

				Pi_TargetVO vo = new Pi_TargetVO();
				// Target 기본정보
				vo.setGroup_id(GroupID);
				vo.setTarget_id(TargetID);
				vo.setComments(TargetComments);
				vo.setSearch_status(TargetSearchStatus);
				vo.setName(TargetName);
				vo.setPlatform(TargetPlatform);
				// Target-Error 기본정보
				vo.setCritical(critical);
				vo.setError(error);
				vo.setNotice(notice);

				vo.setTest(test);
				vo.setProhibited(prohibited);
				vo.setMatchcnt(match);

				list.add(vo);
			}
		}

		logger.info("Before Insert");
		int ret = 0;
		try {
			ret = targetservice.insertTarget(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			logger.info("ERROR ========================================");
			logger.info(e.getMessage());
			ret = -999;
		}

		logger.info("targetservice.insertTarget == " + ret);
		return null;
	}

	@RequestMapping(value = "/selectNotAction_group", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectNotAction_group(HttpSession session, HttpServletRequest request,
			Model model, HttpServletResponse response) throws Exception {
		logger.info("selectNotAction_group");
		List<Object> datatypesList = dashservice.selectNotAction_group(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_dataDetectionList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataDetectionList(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataDetectionList");
		Map<String, Object> dashDataDetectionList = dashservice.selectDashDataDetectionList(request);
		return dashDataDetectionList;
	}
	
	@RequestMapping(value = "/dash_dataDetectionServerList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataDetectionServerList(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataDetectionServerList");
		Map<String, Object> dashDataDetectionList = dashservice.selectDashDataDetectionServerList(request);
		return dashDataDetectionList;
	}
	
	@RequestMapping(value = "/dash_dataDetectionPCList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataDetectionPCList(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataDetectionPCList");
		Map<String, Object> dashDataDetectionList = dashservice.selectDashDataDetectionPCList(request);
		return dashDataDetectionList;
	}
	
	@RequestMapping(value = "/dash_dataCompleteList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataCompleteList(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataCompleteList");
		Map<String, Object> dashDataCompleteList = dashservice.selectDashDataCompleteList(request);
		return dashDataCompleteList;
	}
	
	@RequestMapping(value = "/dash_dataDetectionItemList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataDetectionItemList(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataDetectionItemList");
		Map<String, Object> dashDataDetectionItemList = dashservice.selectDashDataDetectionItemList(request);
		return dashDataDetectionItemList;
	}
	
	@RequestMapping(value = "/dash_personal_server_detectionItemList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashPersonalServerDetectionItemList(@RequestParam(value="targetList[]") List<String> targetList,
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalServerDetectionItemList");
		Map<String, Object> DashPersonalServerDetectionItemList = dashservice.selectDashPersonalServerDetectionItemList(request, targetList);
		return DashPersonalServerDetectionItemList;
	}
	
	@RequestMapping(value = "/dash_personal_server_complete", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashPersonalServerComplete(@RequestParam(value="targetList[]") List<String> targetList,
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalServerComplete");
		Map<String, Object> DashPersonalServerComplete = dashservice.selectDashPersonalServerComplete(request, targetList);
		return DashPersonalServerComplete;
	}
	
	@RequestMapping(value = "/dash_dataRank", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashDataRank(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectDashDataRank");
		List<Object> datatypesList = dashservice.selectDashDataRank(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_server_rank", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashPersonalServerRank( 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("dash_personal_server_rank");
		List<String> targetList = new ArrayList<>();
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashPersonalServerRank(request, targetList);
		targetList.clear();
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_pc_rank", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashPersonalPCRank( 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("dash_personal_pc_rank");
		List<String> targetList = new ArrayList<>();
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashPersonalPCRank(request, targetList);
		targetList.clear();
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_manager_rank", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashPersonalManagerRank(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalManagerRank");
		List<Object> datatypesList = dashservice.selectDashPersonalManagerRank(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_dataImple", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashDataImple(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataImple");
		List<Object> datatypesList = dashservice.selectDashDataImple(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_dataImple_manager", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashDataImpleManager(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataImpleManager");
		List<Object> datatypesList = dashservice.selectDashDataImpleManager(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_server_imple", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashPersonalServerImple(HttpSession session, HttpServletRequest request, 
			Model model, HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalServerImple");
		
		List<String> targetList = new ArrayList<>();
		List<Map<String, Object>> datatypesList = dashservice.selectDashPersonalServerImple(request, targetList);
		targetList.clear();
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_server", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashDataPersonalServer(HttpServletRequest request, Model model) throws Exception{
		logger.info("selectDashDataPersonalServer");
		
		List<Map<String, Object>> dashDataPersonalServer = new ArrayList<>();
		
		dashDataPersonalServer = dashservice.selectDashDataPersonalServer(request);
		
		return dashDataPersonalServer;
	}
	
	@RequestMapping(value = "/dash_personal_PC", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashDataPersonalPC(HttpServletRequest request, Model model) throws Exception{
		logger.info("selectDashDataPersonalPC");
		
		List<Map<String, Object>> dashDataPersonalPC = new ArrayList<>();
		
		dashDataPersonalPC = dashservice.selectDashDataPersonalPC(request);
		
		return dashDataPersonalPC;
	}
	
	@RequestMapping(value = "/dash_personal_server_count", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataPersonalServerCount(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataPersonalServerCount");
		Map<String, Object> dashDataPersonalServerCount = dashservice.selectDashDataPersonalServerCount(request);
		return dashDataPersonalServerCount;
	}
	
	@RequestMapping(value = "/dash_personal_server_circle", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashDataPersonalServerCircle(@RequestParam(value="targetList[]") List<String> targetList, 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataPersonalServerCircle");
		
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashDataPersonalServerCircle(request, targetList);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_server_pc", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashDataPersonalPCCircle(@RequestParam(value="targetList[]") List<String> targetList, 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashDataPersonalPCCircle");
		
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashDataPersonalPCCircle(request, targetList);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_dataTodoList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataTodoList(HttpSession session, HttpServletRequest request, Model model,
		HttpServletResponse response) throws Exception {
		logger.info("selectDashDataTodoList");
		Map<String, Object> dashDatatypes = dashservice.selectDashDataTodoList(request);
		return dashDatatypes;
	}
	
	@RequestMapping(value = "/dash_dataTodoApproval", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataTodoApproval(HttpSession session, HttpServletRequest request, Model model,
		HttpServletResponse response) throws Exception {
		logger.info("selectDashDataTodoApproval");
		Map<String, Object> dashDatatypes = dashservice.selectDashDataTodoApproval(request);
		return dashDatatypes;
	}
	
	@RequestMapping(value = "/dash_dataTodoSchedule", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> selectDashDataTodoSchedule(HttpSession session, HttpServletRequest request, Model model,
		HttpServletResponse response) throws Exception {
		logger.info("selectDashDataTodoSchedule");
		Map<String, Object> dashDatatypes = dashservice.selectDashDataTodoSchedule(request);
		return dashDatatypes;
	}
	
	@RequestMapping(value = "/approvalTest", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> approvalTest(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("approvalTest");
		
		
		Map<String, Object> dashDatatypes = dashservice.approvalTest(request);
		return dashDatatypes;
	}
	
	@RequestMapping(value = "/dash_PC_jstree_popup", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashPCJstreePopup(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashPCJstreePopup");
		List<Object> dashDatatypes = dashservice.selectDashPCJstreePopup(request);
		return dashDatatypes;
	}
	
	@RequestMapping(value = "/sessionUpdate", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> sessionCheck(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("sessionUpdate");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultCode", -1);
		map.put("resultMessage", "세션 연장");
		
		return map;
	}
	
	// 관리자 dashboard pc progress
	@RequestMapping(value = "/pi_systemcurrent_progress_pc", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrentProgressPC(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent_progress_pc");
		List<Object> datatypesList = dashservice.selectSystemCurrentProgressPC(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/pi_systemcurrent_progress_oneDrive", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectSystemCurrentProgressOneDrive(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent_progress_oneDrive");
		List<Object> datatypesList = dashservice.selectSystemCurrentProgressOneDrive(request);
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_progress_pc", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashPersonalProgressPc(@RequestParam(value="targetList[]") List<String> targetList, 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalProgressPc");
		
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashPersonalProgressPc(request, targetList);
		
		return datatypesList;
	}
	
	@RequestMapping(value = "/dash_personal_progress_oneDrive", method = { RequestMethod.POST })
	public @ResponseBody List<Map<String, Object>> selectDashPersonalProgressOneDrive(@RequestParam(value="targetList[]") List<String> targetList, 
			HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDashPersonalProgressOneDrive");
		
		logger.info("targetList >> " + targetList);
		
		List<Map<String, Object>> datatypesList = dashservice.selectDashPersonalProgressOneDrive(request, targetList);
		
		return datatypesList;
	}
	
	@RequestMapping(value = "/lockMemberRequest", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> lockMemberRequest(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/lockMemberRequest");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.lockMemberRequest(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}

		return memberMap;
	}
	
	@RequestMapping(value = "/unlockMemberRequest", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> unlockMemberRequest(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/unlockMemberRequest");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.unlockMemberRequest(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return memberMap;
	}
	
	@RequestMapping(value = "/unlockMemberRequestManager", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> unlockMemberRequestManager(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/unlockMemberRequestManager");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.unlockMemberRequest(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -4);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return memberMap;
	}
	
}