package com.org.iopts.service;

import java.io.IOException;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

// import org.apache.http.ParseException;
import org.apache.ibatis.io.Resources;
import org.jdom2.Document;
import org.jdom2.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.org.iopts.cbh.scbh000001.SCBH000001;
import com.org.iopts.cbh.scbh000001.vo.GetSmsInfoVo;
import com.org.iopts.csp.comm.Config;
import com.org.iopts.csp.comm.CspUtil;
import com.org.iopts.csp.comm.vo.HeaderVo;
import com.org.iopts.csp.comm.vo.ResultVo;
import com.org.iopts.dao.Pi_ScanDAO;
import com.org.iopts.dao.Pi_TargetDAO;
import com.org.iopts.dao.Pi_UserDAO;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_UserServiceImpl implements Pi_UserService {

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Value("${ldapUrl}")
	private String ldapUrl;

	private static Logger logger = LoggerFactory.getLogger(Pi_UserServiceImpl.class);

	@Inject
	private Pi_UserDAO dao;
	
	@Inject
	private Pi_ScanDAO scanDao;
	
	@Inject
	private Pi_TargetDAO targetDao;
	

	private	String	URL	= Config.domain + "/rest/SCBH000001/" + Config.apiKey;


	@Override
	public Map<String, Object> selectMember(HttpServletRequest request) throws Exception {

		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String password = request.getParameter("password");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("password", password);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "Log-In Success");
		userLog.put("logFlag", "0");
		
		Map<String, Object> requestMap = new HashMap<String, Object>();

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectMember(searchMap);
		Map<String, String> uptMap = new HashMap<>();
		
		
		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", user_no + "는 존재하지 않는 ID 입니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertLog(userLog);
			return resultMap;
		}
		// 계정이 잠긴 경우
		if(memberMap.get("LOCK_ACCOUNT").equals("Y")) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "비밀번호 5회 오류로 인해 10분간 사용하실수 없습니다.");
			return resultMap;	
		}
		
		// 비밀번호가 틀린 경우
		if (!(memberMap.get("PASSWORD").equals("Y"))) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "아이디/패스워드가 존재하지 않습니다. 다시 확인 해주세요.");

			userLog.put("job_info", "Log-In Fail(Invalid Password)");
			dao.insertLog(userLog);
			
			int failed_count = (Integer.parseInt(memberMap.get("FAILED_COUNT").toString())+1);
			if(failed_count < 5) {
				uptMap.put("userNo", user_no);
				uptMap.put("failed_count", String.valueOf(failed_count));
				uptMap.put("lockYn", "N");
			} else {
				uptMap.put("userNo", user_no);
				uptMap.put("failed_count", "0");
				uptMap.put("lockYn", "Y");
			}
			
			logger.info("password error count :: " + failed_count);
			logger.info("lock account :: " + dao.updateFailedCount(uptMap));
			return resultMap;			
		}
		
		Date logindate = (Date) memberMap.get("LOGINDATE");
		Date toDay =  new Date(); // 오늘날짜
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertLog(userLog);
		
		uptMap.put("userNo", user_no);
		uptMap.put("failed_count", "0");
		uptMap.put("lockYn", "N");
		logger.info("lock account :: " + dao.updateFailedCount(uptMap));
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);
		
		// 사용자 세션 등록
		SessionUtil.setSession("memberSession", memberMap);
		
		setHeader(memberMap);

		return resultMap;
	}
	
	@Override
	public Map<String, Object> changeUser(HttpServletRequest request) throws Exception 
	{
		// Session clear
		String previous_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", previous_user_no + " > " + user_no + "(사용자 변경)");
		userLog.put("logFlag", "0");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.changeUser(searchMap);
		logger.info(""+memberMap);
		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", user_no + "는 존재하지 않는 ID 입니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertLog(userLog);
			return resultMap;
		}

		/*Date logindate = (Date) memberMap.get("LOGINDATE");
		Date toDay =  new Date(); // 오늘날짜
		int request_status = (Integer)memberMap.get("LOCK_STATUS");
		
		if(request_status == 2) {
			resultMap.put("resultCode", -9);
			resultMap.put("resultMessage", "장기 미 사용으로 자동 잠금 처리 해제가 완료되지 않은 계정입니다.");
			return resultMap;
		}
		
		if(logindate != null && logindate.before(toDay)) {
			resultMap.put("resultCode", -8);
			resultMap.put("resultMessage", "장기 미 사용하여 자동 잠금처리 되었습니다. \n관리자한테 요청해주세요.");
			dao.updateLockMember(searchMap);
			return resultMap;
		}else {
			dao.updatemember(searchMap);
		}*/
		
		// ip 체크
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		if ((memberMap.get("USER_GRADE").equals("9"))) {

			String accessIP = (String) memberMap.get("ACCESS_IP");
			
			if(accessIP.equals("")) {
				//resultMap.put("resultCode", -3);
				resultMap.put("resultCode", -2);
				resultMap.put("resultMessage", "최고관리자의 접근IP가 없습니다.");
				
				userLog.put("job_info", "Log-In Fail(Access IP is Null)");
				dao.insertLog(userLog);
				return resultMap;			
			}

			String[] accessIPs = accessIP.split(",");

		} else {
			Date startDay = (Date) memberMap.get("STARTDATE"); // 해당 유저의 계정만료일
			Date endDay = (Date) memberMap.get("ENDDATE"); // 해당 유저의 계정만료일
			Date today =  new Date(); // 오늘날짜
			
			if(startDay == null || endDay == null ) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 사용기간이 설정 되어있지 않습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(startDay) < 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 시작일이 되지 않아 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(endDay) > 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 만료일이 지나 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
		}
		
		// 관리자/일반사용자 분리
//		if ((memberMap.get("USER_GRADE").equals("0"))) {
//			resultMap.put("user_grade", );
//		}
		
		// 계정 만료일이 지난 경우
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertLog(userLog);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);

		// 사용자 세션 등록
		SessionUtil.closeSession("memberSession");
		SessionUtil.setSession("memberSession", memberMap);
		
		setHeader(memberMap);

		return resultMap;
	}
	
	@Override
	public Map<String, Object> accountMemberSSO(HttpServletRequest request) throws Exception {
		
		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectMember(searchMap);
		
		String user_grade = (String) memberMap.get("USER_GRADE");
		
		Date logindate = (Date) memberMap.get("LOGINDATE");
		Date toDay =  new Date(); // 오늘날짜
		int request_status = (Integer)memberMap.get("LOCK_STATUS");
		
		if (!(memberMap.get("USER_GRADE").equals("9"))) {
			if(request_status == 2) {
				resultMap.put("resultCode", -9);
				resultMap.put("resultMessage", "잠금 해제가 완료되지 않은 계정입니다.");
				return resultMap;
			}
			
			if(logindate != null && logindate.before(toDay)) {
				resultMap.put("resultCode", -8);
				resultMap.put("resultMessage", "장기 미 사용하여 자동 잠금처리 되었습니다. \n관리자한테 요청해주세요.");
				
				dao.updateLockMember(searchMap);
				
				return resultMap;
			}else {
				dao.updatemember(searchMap);
			}
		}
		return resultMap;
	}

	private void setHeader(Map<String, Object> memberMap) {
		List<Map<String, Object>> headerList = new ArrayList<>();
		
		headerList = dao.setHeader(memberMap);
		
		SessionUtil.setSession("headerList", headerList);
		
		Map<String, Object> pageData = dao.setPageData(memberMap);
		
		logger.info("pageData :: " + pageData.toString());
		logger.info("main :: " + pageData.get("MAIN"));
		String mainYn = pageData.get("MAIN").toString();
		SessionUtil.setSession("mainYn", mainYn);
		if ("Y".equals(mainYn)) {
			SessionUtil.setSession("defaultPage", "/piboard");
		} else {
			SessionUtil.setSession("defaultPage", pageData.get("URL").toString());
		}
	}

	@Override
	public Map<String, Object> selectSSOMember(HttpServletRequest request) throws Exception 
	{
		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "Log-In Success");
		userLog.put("logFlag", "0");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectSSOMember(searchMap);
		logger.info(""+memberMap);
		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", user_no + "는 존재하지 않는 ID 입니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertLog(userLog);
			return resultMap;
		}

		/*Date logindate = (Date) memberMap.get("LOGINDATE");
		Date toDay =  new Date(); // 오늘날짜
		int request_status = (Integer)memberMap.get("LOCK_STATUS");
		
		if(request_status == 2) {
			resultMap.put("resultCode", -9);
			resultMap.put("resultMessage", "장기 미 사용으로 자동 잠금 처리 해제가 완료되지 않은 계정입니다.");
			return resultMap;
		}
		
		if(logindate != null && logindate.before(toDay)) {
			resultMap.put("resultCode", -8);
			resultMap.put("resultMessage", "장기 미 사용하여 자동 잠금처리 되었습니다. \n관리자한테 요청해주세요.");
			dao.updateLockMember(searchMap);
			return resultMap;
		}else {
			dao.updatemember(searchMap);
		}*/
		
		// ip 체크
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		if ((memberMap.get("USER_GRADE").equals("9"))) {

			String accessIP = (String) memberMap.get("ACCESS_IP");
			
			if(accessIP.equals("")) {
				//resultMap.put("resultCode", -3);
				resultMap.put("resultCode", -2);
				resultMap.put("resultMessage", "최고관리자의 접근IP가 없습니다.");
				
				userLog.put("job_info", "Log-In Fail(Access IP is Null)");
				dao.insertLog(userLog);
				return resultMap;			
			}

			String[] accessIPs = accessIP.split(",");
			if (!Arrays.asList(accessIPs).contains(clientIP)) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "등록되지 않은 최고관리자 접근IP입니다.");
				userLog.put("job_info", "Log-In Fail(Access IP is Invalid)");
				dao.insertLog(userLog);
				return resultMap;			
			}

		} else {
			Date startDay = (Date) memberMap.get("STARTDATE"); // 해당 유저의 계정만료일
			Date endDay = (Date) memberMap.get("ENDDATE"); // 해당 유저의 계정만료일
			Date today =  new Date(); // 오늘날짜
			
			if(startDay == null || endDay == null ) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 사용기간이 설정 되어있지 않습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(startDay) < 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 시작일이 되지 않아 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(endDay) > 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 만료일이 지나 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
		}
		
		// 관리자/일반사용자 분리
//		if ((memberMap.get("USER_GRADE").equals("0"))) {
//			resultMap.put("user_grade", );
//		}
		
		// 계정 만료일이 지난 경우
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertLog(userLog);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);

		// 사용자 세션 등록
		SessionUtil.setSession("memberSession", memberMap);
		
		setHeader(memberMap);

		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectTeamMember(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		
		return dao.selectTeamMember(searchMap);
	}
	
	@Override
	public Map<String, Object> selectTeamManager() throws Exception {

		String boss_name = SessionUtil.getSession("memberSession", "USER_NO");
		
		return dao.selectTeamManager(boss_name);
	}
	
	@Override
	@Transactional
	public Map<String, Object> changeAuthCharacter(HttpServletRequest request) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ServletUtil servletUtil = new ServletUtil(request);
		
		String oldPassword = request.getParameter("oldPassword");
		String newPasswd = request.getParameter("newPasswd");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("oldPassword", oldPassword);
		searchMap.put("newPasswd", newPasswd);
		
		int ret = dao.changeAuthCharacter(searchMap);

		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "PASSWORD CHANGE");		
		userLog.put("user_ip", servletUtil.getIp());
		userLog.put("logFlag", "6");

		if (ret == 1) {
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "비밀번호가 변경되었습니다.");
			userLog.put("job_info", "Password Change Success");
			
			dao.insertLog(userLog);
		}
		else {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "현재 비밀번호가 다릅니다.");
			userLog.put("job_info", "Password Change Fail");
			
			dao.insertLog(userLog);
		}
		
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> selectUserLogList(HttpServletRequest request) throws Exception {

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String userNo = request.getParameter("userNo");
		String userName = request.getParameter("userName");
		String userIP = request.getParameter("userIP");
		String logFlag = request.getParameter("logFlag");
		
		Map<String, Object> search = new HashMap<String, Object>();
		search.put("userNo", userNo);
		search.put("userName", userName);
		search.put("userIP", userIP);
		search.put("fromDate", fromDate);
		search.put("toDate", toDate);
		search.put("logFlag", logFlag);

		return dao.selectUserLogList(search);
	}

	@Override
	@Transactional
	public void insertMemberLog(Map<String, Object> userLog) throws Exception {
		
		dao.insertLog(userLog);
	}
	
	@Override
	public String selectAccessIP() throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String accessIP = dao.selectAccessIP(user_no);

		return accessIP;
	}
	
	@Override
	public Map<String, Object> selectNotice() throws Exception {

		return dao.selectNotice();
	}
	
	// 공지사항 목록 조회
	@Override
	public List<Map<String, Object>> noticeList(HttpServletRequest request) {
		return dao.noticeList();
	}

	// 공지사항 검색 목록 조회
	@Override
	public List<Map<String, Object>> noticeSearchList(HttpServletRequest request) {
		logger.info("noticeSearchList service");
		
		logger.info("title :: " + request.getParameter("title"));
		logger.info("titcont :: " + request.getParameter("titcont"));
		logger.info("writer :: " + request.getParameter("writer"));
		logger.info("fromDate :: " + request.getParameter("fromDate"));
		logger.info("toDate :: " + request.getParameter("toDate"));
		logger.info("regdateChk :: " + request.getParameter("regdateChk"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("title", request.getParameter("title"));
			map.put("titcont", request.getParameter("titcont"));
			map.put("writer", request.getParameter("writer"));
			map.put("fromDate", request.getParameter("fromDate"));
			map.put("toDate", request.getParameter("toDate"));
			map.put("regdateChk", request.getParameter("regdateChk"));
			logger.info("map :: " + map);
			resultList = dao.getStatusList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	// 공지사항 등록
	@Override
	public void noticeInsert(HttpServletRequest request) throws Exception {
		String userNo = request.getParameter("user_no");
		String noticeTitle = request.getParameter("notice_title");
		String noticeCon = request.getParameter("notice_con");
		String notice_file_id = request.getParameter("file_number");
		String CHK = request.getParameter("notice_chk"); 

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("noticeTitle", noticeTitle);
		input.put("noticeCon", noticeCon);
		input.put("notice_file_id", notice_file_id);
		input.put("CHK", CHK);
		
		logger.info("input >> " + input);
		
		dao.noticeInsert(input);
	}
	
	// 공지사항 수정
	@Override
	public void noticeUpdate(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("user_no");
		String noticeTitle = request.getParameter("notice_title");
		String noticeCon = request.getParameter("notice_con");
		String IDX = request.getParameter("notice_id");
		String CHK = request.getParameter("notice_chk");
		String file_number = request.getParameter("file_number");
		
		
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("userNo", userNo);
		update.put("noticeTitle", noticeTitle);
		update.put("noticeCon", noticeCon);
		update.put("IDX", IDX);
		update.put("CHK", CHK);
		update.put("file_number", file_number);
		
		logger.info("update >> " + update);
		
		dao.noticeUpdate(update);
		
		
	}

	// 공지사항 삭제
	@Override
	public void noticeDelete(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("user_no");
		String IDX = request.getParameter("notice_id");

		Map<String, Object> delete = new HashMap<String, Object>();
		delete.put("userNo", userNo);
		delete.put("IDX", IDX);
		
		logger.info("delete >> " + delete);
		
		dao.noticeDelete(delete);		
		
	}
	
	@Transactional
	public void changeNotice(HttpServletRequest request) throws Exception {

		String userNo = SessionUtil.getSession("memberSession", "USER_NO");
		String noticeTitle = request.getParameter("notice_title");
		String noticeCon = request.getParameter("notice_con");
		String noticeChk = request.getParameter("rbChk");

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("noticeTitle", noticeTitle);
		input.put("noticeCon", noticeCon);
		input.put("noticeChk", noticeChk);
		
		dao.changeNotice(input);
	}
	
	@Override
	public Map<String, Object> selectDownload() throws Exception {

		return dao.selectDownload();
	}
	
	@Override
	public List<Map<String, Object>> downloadList(HttpServletRequest request) {
		return dao.downloadList();
	}

	@Override
	public List<Map<String, Object>> downloadSearchList(HttpServletRequest request) {
		logger.info("downloadSearchList service");
		
		logger.info("title :: " + request.getParameter("title"));
		logger.info("titcont :: " + request.getParameter("titcont"));
		logger.info("writer :: " + request.getParameter("writer"));
		logger.info("fromDate :: " + request.getParameter("fromDate"));
		logger.info("toDate :: " + request.getParameter("toDate"));
		logger.info("regdateChk :: " + request.getParameter("regdateChk"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("title", request.getParameter("title"));
			map.put("titcont", request.getParameter("titcont"));
			map.put("writer", request.getParameter("writer"));
			map.put("fromDate", request.getParameter("fromDate"));
			map.put("toDate", request.getParameter("toDate"));
			map.put("regdateChk", request.getParameter("regdateChk"));
			logger.info("map :: " + map);
			resultList = dao.getStatusDownloadList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	@Override
	public void downloadInsert(HttpServletRequest request) throws Exception {
		String userNo = request.getParameter("user_no");
		String downloadTitle = request.getParameter("download_title");
		String downloadCon = request.getParameter("download_con");
		String download_file_id = request.getParameter("download_number");

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("downloadTitle", downloadTitle);
		input.put("downloadCon", downloadCon);
		input.put("download_file_id", download_file_id);
		
		logger.info("input >> " + input);
		
		dao.downloadInsert(input);
	}
	
	@Override
	public void downloadUpdate(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("user_no");
		String downloadTitle = request.getParameter("download_title");
		String downloadCon = request.getParameter("download_con");
		String IDX = request.getParameter("download_id");
		String file_number = request.getParameter("file_number");
		
		
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("userNo", userNo);
		update.put("downloadTitle", downloadTitle);
		update.put("downloadCon", downloadCon);
		update.put("IDX", IDX);
		update.put("file_number", file_number);
		
		logger.info("update >> " + update);
		
		dao.downloadUpdate(update);
		
	}

	@Override
	public void downloadDelete(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("user_no");
		String IDX = request.getParameter("download_id");

		Map<String, Object> delete = new HashMap<String, Object>();
		delete.put("userNo", userNo);
		delete.put("IDX", IDX);
		
		logger.info("delete >> " + delete);
		
		dao.downloadDelete(delete);		
		
	}
	
	@Override
	@Transactional
	public void changeAccessIP(HttpServletRequest request) throws Exception {

		String accessIP = request.getParameter("accessIP");
		String userNo = SessionUtil.getSession("memberSession", "USER_NO");

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("accessIP", accessIP);
		
		dao.changeAccessIP(input);
		
		// User Log 남기기
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", userNo);
		userLog.put("menu_name", "MANAGE ACCESS IP");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "접근 ip 변경");
		
		dao.insertLog(userLog);
	}

	@Override
	@Transactional
	public void logout(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(true); 
		if (session.getAttribute("memberSession") != null ) {
			// User Log 남기기 (session이 살아있는 경우)
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			
			Map<String, Object> userLog = new HashMap<String, Object>();
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "LOGOUT");		
			userLog.put("user_ip", clientIP);
			userLog.put("job_info", "Log-Out");
			userLog.put("logFlag", "0");
			
			SessionUtil.closeSession("memberSession");
			
			dao.insertLog(userLog);
		}
	}
	
	@Override
	public List<Map<String, Object>> selectManagerList(HttpServletRequest request) throws Exception {
		
		return dao.selectManagerList();
	}

	@Override
	@Transactional
	public void changeManagerList(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		String userList = request.getParameter("userList");
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();

		JSONArray userArray = JSONArray.fromObject(userList);

		if (userArray.size() != 0) {
			for (int i = 0; i < userArray.size(); i++) {
				JSONObject userMap = (JSONObject) userArray.get(i);
				String userNo = userMap.getString("userNo");
				int userGrade = Integer.parseInt(userMap.getString("userGrade"));
				String userNm = userMap.getString("userNm");
				
				map.put("userNo", userNo);		
				map.put("userGrade", userGrade);				
				dao.changeManagerList(map);
				
				userLog.put("user_no", user_no);
				userLog.put("menu_name", "CHANGE USER DATA");		
				userLog.put("user_ip", clientIP);
				userLog.put("logFlag", "6");
				
				String grade = (userGrade == 0) ? "일반사용자" : (userGrade == 1) ? "구성원(SKT정직원)" : (userGrade == 2) ? "중간관리자(검색)" : (userGrade == 3) ? "중간관리자(조회)" : 
					(userGrade == 4) ? "인프라 담당자" : (userGrade == 5) ? "서비스담당자" : (userGrade == 6) ? "서비스관리자" : (userGrade == 7) ? "직책자" : "보안관리자";
				
				userLog.put("job_info", "사용자 권한 변경 - "+userNm+" (" + userNo + ") ("+grade+")");
			
				dao.insertLog(userLog);
			}
		}
	}
	
	@Override
	@Transactional
	public void changeUserData(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String userNo = request.getParameter("userNo");
		String userNm = request.getParameter("userNm");
		//String userPwd = request.getParameter("userPwd");
		String changePhoneNM = request.getParameter("changePhoneNM");
		String accountToDate = request.getParameter("accountToDate");
		String changeEmail = request.getParameter("changeEmail");
		String accountFormDate = request.getParameter("accountFormDate");
		String popupChangeAccessIP = request.getParameter("popupChangeAccessIP");
		String lock_email = request.getParameter("lock_email");
		
		map.put("userNo", userNo);
		map.put("userNm", userNm);
		//map.put("userPwd", userPwd);
		map.put("changeEmail", changeEmail);
		map.put("changePhoneNM", changePhoneNM);
		map.put("accountToDate", accountToDate);
		map.put("accountFormDate", accountFormDate);
		map.put("popupChangeAccessIP", popupChangeAccessIP);
		map.put("lock_email", lock_email);
		
		dao.changeUserDate(map);
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "CHANGE USER DATA");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "사용자 정보 변경 - " + userNo);
		
		dao.insertLog(userLog);
		
	}
	
	// 관리자가 사용자 비밀번호 초기화
	@Override
	public Map<String, Object> managerResetPwd(HttpServletRequest request) throws Exception {
		// Session clear
		String user_phone = request.getParameter("user_phone");
		String user_no = request.getParameter("user_no");
		String user_name = request.getParameter("user_name");
		
		Map<String, Object> resultList = new HashMap<String, Object>();
		
		// 영문 + 숫자 랜덤 생성 (8자리)
		String rndPwd = "";
		for (int i = 0; i < 8; i++) {
			int rndVal = (int) (Math.random() * 62);
			if (rndVal < 10) {
				rndPwd += rndVal;
			} else if (rndVal > 35) {
				rndPwd += (char) (rndVal + 61);
			} else {
				rndPwd += (char) (rndVal + 55);
			}
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("user_no", user_no);
		resultMap.put("user_phone", user_phone);
		resultMap.put("password", rndPwd);
		
		/*// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("user_ip", clientIP);
		userLog.put("ManagerChangePwd", "0");*/
		
		logger.info("rndPwd ========> " + rndPwd);
		
		if (!user_phone.equals("")) {
			
			logger.info("" + !user_phone.equals(""));
			logger.info("rndPwd >> " + rndPwd);

			/*String title = "[PIMC] 비밀번호 초기화" + "[초기화 비밀번호 : " + rndPwd + "]";*/
			String title = "[PIMC] "+user_name+"("+user_no+")님의 패스워드가 다음과 같이 초기화 되었습니다. ["+rndPwd+"]";

			String phone = user_phone.replaceAll("-", "");
			
			if(!phone.substring(0,3).equals("010")) {
				resultList.put("resultMessage", "해당 전화번호로 문자 발송이 불가합니다.");
				resultList.put("resultCode", -10);
				
				return resultList;
			}
			
			dao.resetPwd(resultMap);
			
			String[][] paramLt =
			{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
			getVo(paramLt);
			
		}else {
			resultList.put("resultMessage", "사용자의 모바일 전화가 등록되어있지 않습니다. 관리자에게 문의해주세요.");
			resultList.put("resultCode", -10);
			
			return resultList;
		}
		resultList.put("resultMessage", "SUCCESS");
		resultList.put("resultCode", 0);
		
		return resultList;
	}

	@Override
	@Transactional
	public void userDelete(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String userNo = request.getParameter("userNo");
		map.put("userNo", userNo);
		
		dao.userDelete(map);
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "DELETE USER");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "사용자 삭제 - " + userNo);
		
		dao.insertLog(userLog);
	}
	
	@Override
	public void createTeam(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String teamName = request.getParameter("teamName");
		String teamCode = request.getParameter("teamCode");
		
		map.put("teamName", teamName);
		map.put("teamCode", teamCode);
		dao.createTeam(map);
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "CREATE TEAM");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "팀 생성 - " + teamName);
		
		dao.insertLog(userLog);
	}
	
	@Override
	public List<Map<String, Object>> selectTeamCode() throws Exception {
		
		return dao.selectTeamCode();
	}
	
	@Override
	public Map<String, Object> chkDuplicateUserNo(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("userNo");
		
		return dao.chkDuplicateUserNo(userNo);
	}

	@Override
	@Transactional
	public void createUser(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		String userNo = request.getParameter("userNo");
		String password = request.getParameter("password");
		String jikwee = request.getParameter("jikwee");
		String team = request.getParameter("team");
		String jikguk = request.getParameter("jikguk");
		String userName = request.getParameter("userName");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		
		map.put("userNo", userNo);
		map.put("userName", userName);
		map.put("password", password);
		map.put("jikwee", jikwee);
		map.put("jikguk", jikguk);
		map.put("team", team);
		map.put("grade", "0");
		map.put("startDate", startDate);
		map.put("endDate", endDate);

		map.put("userEmail", userEmail);
		map.put("userPhone", userPhone);
		
		dao.createUser(map);
		/*dao.createAccountInfo(map);*/
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "CREATE USER");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "사용자 등록 - " + userName);
		
		dao.insertLog(userLog);
	}
	
	@Override
	public List<Map<String, Object>> selectAccountOfficeList() throws Exception {
		return dao.selectAccountOfficeList();
	}

	@Override
	public void unlockAccount(HttpServletRequest request) {
		Map<String, String> uptMap = new HashMap<String, String>();
		String userNo = request.getParameter("userNo");
		uptMap.put("userNo", userNo);
		uptMap.put("failed_count", "0");
		uptMap.put("lockYn", "N");
		logger.info("lock account :: " + uptMap.toString());
		logger.info("lock account :: " + dao.updateFailedCount(uptMap));
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "UNLOCK USER");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "사용자 잠금 해제 - " + userNo);
		
		try {
			dao.insertLog(userLog);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Map<String, Object> getLicenseDetail() throws Exception {
		
		logger.info("getLicenseDetail START");
		Map<String, Object> resultMap = new HashMap<>();
		try {
			
			int ap_no = 0;
			
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			String requestUrl = recon_url + "/"+api_ver+"/licenses" ;
			Map<String, Object> connectionData = new HashMap<>();
			connectionData = connectRecon(requestUrl, this.recon_id, this.recon_password, "GET", "");
			
			String company = "";
			String expire = "";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			JsonParser parser = new JsonParser();
			JsonObject obj = (JsonObject) parser.parse(connectionData.get("resultData").toString());
			
			company = obj.get("company").toString().replace("\"", "");
			Long linuxTm = Long.parseLong(obj.get("expires").toString().replaceAll("\"", ""));
			Date date = new Date();
			date.setTime(linuxTm*1000);
			expire = sdf.format(date);
			
			resultMap.put("company", company);
			resultMap.put("expire", expire);
			
			logger.info("company ::: " + company);
			logger.info("expire ::: " + expire);
			
			Map<String, Object> dbMap = new HashMap<>();
			dbMap.put("ap_no", 0);
			List<Map<String, String>> targetList = new ArrayList<Map<String,String>>();
			List<Map<String, Object>> dbTargetList = targetDao.selectAllUseTarget(dbMap);
			
			for(Map<String, Object> dbTarget : dbTargetList) {
				Map<String, String> map = new HashMap<>();
				map.put("name", dbTarget.get("NAME").toString());
				map.put("type", "할당되지 않음");
				targetList.add(map);
			}
			
			JsonArray targetsArray = new JsonArray();
			if(obj.has("targets")) {
				targetsArray = (JsonArray) parser.parse(obj.get("targets").toString().replaceAll("\"", ""));
				for(int i=0; i<targetsArray.size(); i++) {
					JsonObject targetObj = (JsonObject) parser.parse(targetsArray.get(i).toString().replaceAll("\"", ""));
					String name = targetObj.get("name").toString().replace("\"", "");
					String type = targetObj.get("type").toString().replace("\"", "");
					for(int index=0; index<targetList.size(); index++) {
						if(name.equals(targetList.get(index).get("name"))) {
							targetList.get(index).put("type", type);
							break;
						}
					}
				}
			}
			
			List<Map<String, String>> summaryList = new ArrayList<>();
			
			JsonArray summaryArray = (JsonArray) parser.parse(obj.get("summary").toString());
			for(int i=0; i<2; i++) {
				Map<String, String> summary = new HashMap<>();
				if(i == 0) {
					summary.put("type", "Master Server");
					summary.put("total", "1/1");
				} else {
					summary.put("type", "Server");
					for(int index=0; index<summaryArray.size(); index++) {
						JsonObject summaryObj = (JsonObject) parser.parse(summaryArray.get(index).toString());
						String type = summaryObj.get("type").toString().replace("\"", "");
						if("server".equals(type)) {
							summary.put("current", targetsArray.size()+"");
							summary.put("total", dbTargetList.size()+"");
						}
					}
				}
				summaryList.add(summary);
				
			}
			
			resultMap.put("resultCode", "00");
			resultMap.put("resultMsg", "success");
			resultMap.put("summaryList", summaryList);
			resultMap.put("targetList", targetList);
		} catch (Exception e) {
			resultMap.put("resultCode", "99");
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> getLicenseDetail(HttpServletRequest request) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<>();
		int ap_no = Integer.parseInt(request.getParameter("ap_num"));
		
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
		String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
		String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
		
		try {
			String requestUrl = recon_url + "/"+api_ver+"/licenses" ;
			logger.info("requestUrl :: " + requestUrl);
			Map<String, Object> connectionData = new HashMap<>();
			connectionData = connectRecon(requestUrl, recon_id, recon_password, "GET", "");
			
			String company = "";
			String expire = "";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			JsonParser parser = new JsonParser();
			JsonObject obj = (JsonObject) parser.parse(connectionData.get("resultData").toString());
			
			company = obj.get("company").toString().replace("\"", "");
			Long linuxTm = Long.parseLong(obj.get("expires").toString().replaceAll("\"", ""));
			Date date = new Date();
			date.setTime(linuxTm*1000);
			expire = sdf.format(date);
			
			resultMap.put("company", company);
			resultMap.put("expire", expire);
			
			logger.info("company ::: " + company);
			logger.info("expire ::: " + expire);
			
			Map<String, Object> dbMap = new HashMap<>();
			dbMap.put("ap_no", ap_no);
			
			List<Map<String, String>> targetList = new ArrayList<Map<String,String>>();
			List<Map<String, Object>> dbTargetList = targetDao.selectAllUseTarget(dbMap);
			
			
			for(Map<String, Object> dbTarget : dbTargetList) {
				Map<String, String> map = new HashMap<>();
				map.put("name", dbTarget.get("NAME").toString());
				map.put("type", "할당되지 않음");
				targetList.add(map);
			}
			
			JsonArray targetsArray = new JsonArray();
			if(obj.has("targets")) {
				targetsArray = (JsonArray) parser.parse(obj.get("targets").toString().replaceAll("\"", ""));
				for(int i=0; i<targetsArray.size(); i++) {
					JsonObject targetObj = (JsonObject) parser.parse(targetsArray.get(i).toString().replaceAll("\"", ""));
					String name = targetObj.get("name").toString().replace("\"", "");
					String type = targetObj.get("type").toString().replace("\"", "");
					for(int index=0; index<targetList.size(); index++) {
						if(name.equals(targetList.get(index).get("name"))) {
							targetList.get(index).put("type", type);
							break;
						}
					}
				}
			}
			
			List<Map<String, String>> summaryList = new ArrayList<>();
			
			JsonArray summaryArray = (JsonArray) parser.parse(obj.get("summary").toString());
			for(int i=0; i<2; i++) {
				Map<String, String> summary = new HashMap<>();
				if(i == 0) {
					summary.put("type", "Master Server");
					summary.put("total", "1/1");
				} else {
					summary.put("type", "Server");
					for(int index=0; index<summaryArray.size(); index++) {
						JsonObject summaryObj = (JsonObject) parser.parse(summaryArray.get(index).toString());
						String type = summaryObj.get("type").toString().replace("\"", "");
						if("server".equals(type)) {
							summary.put("current", targetsArray.size()+"");
							summary.put("total", dbTargetList.size()+"");
						}
					}
				}
				summaryList.add(summary);
				
			}
			
			resultMap.put("resultCode", "00");
			resultMap.put("resultMsg", "success");
			resultMap.put("summaryList", summaryList);
			resultMap.put("targetList", targetList);
			resultMap.put("dbTargetList", dbTargetList);
		} catch (Exception e) {
			resultMap.put("resultCode", "99");
			e.printStackTrace();
		}
//		logger.info("["+ap_no+"]"+resultMap.toString());
		return resultMap;
	}
	
	
	public Map<String, Object> connectRecon(String requestUrl, String recon_id, String recon_password, String method, String requestData) {
		Map<String, Object> resultMap = new HashMap<>();
		
		ReconUtil reconUtil = new ReconUtil();
		
		String dtm = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		try {
			
			Map<String, String> conHistMap = new HashMap<>();
			String seq = String.format("%03d", scanDao.getConnectHistSeq());
			
			conHistMap.put("id", dtm+seq);
			conHistMap.put("recon_id", this.recon_id);
			conHistMap.put("url", requestUrl);
			conHistMap.put("method", method);
			conHistMap.put("req_data", requestData);
			
			logger.info(conHistMap.toString());
			if(scanDao.insConnectHist(conHistMap) > 0) {
				
				Map<String, Object> reconResultMap = reconUtil.getServerData(recon_id, recon_password, requestUrl, method, requestData);
				conHistMap.put("rsp_cd", reconResultMap.get("HttpsResponseCode").toString());
				conHistMap.put("rsp_msg", reconResultMap.get("HttpsResponseMessage").toString());
				
				logger.info("UPDATE DB Schedule result : " + scanDao.uptConnectHist(conHistMap));
				
				logger.info("Get License information result Code : " + reconResultMap.get("HttpsResponseCode"));
				logger.info("Get License information result Message : " + reconResultMap.get("HttpsResponseMessage"));
				logger.info("Get License information result ResponseData : " + reconResultMap.get("HttpsResponseData"));
				
				resultMap.put("resultCode", reconResultMap.get("HttpsResponseCode"));
				resultMap.put("resultMsg", reconResultMap.get("HttpsResponseMessage"));
				resultMap.put("resultData", reconResultMap.get("HttpsResponseData"));
				
			}
		} catch (Exception e) {
			resultMap.put("resultCode", "99");
			resultMap.put("resultMsg", "connection error");
			resultMap.put("resultData", e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}
	

	@Override
	public List<Map<String, Object>> getLogFlagList() throws Exception {
		return dao.getLogFlagList();
	}
	

	@Override
	public Map<String, Object> authSMS(HttpServletRequest request) throws Exception {

		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String password = request.getParameter("password");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("password", password);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "SMS Log-In");
		userLog.put("logFlag", "0");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectMember(searchMap);
		Map<String, Object> resultList = new HashMap<String, Object>();
		Map<String, String> uptMap = new HashMap<>();
		
		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "로그인에 실패하였습니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertLog(userLog);
			return resultMap;
		}
		
		// 비밀번호가 틀린 경우
		if (!(memberMap.get("PASSWORD").equals("Y"))) {
			resultMap.put("resultCode", -2);
			resultMap.put("resultMessage", "로그인에 실패하였습니다.");

			userLog.put("job_info", "Log-In Fail(Invalid Password)");
			dao.insertLog(userLog);
			
			int failed_count = (Integer.parseInt(memberMap.get("FAILED_COUNT").toString())+1);
			if(failed_count < 5) {
				uptMap.put("userNo", user_no);
				uptMap.put("failed_count", String.valueOf(failed_count));
				uptMap.put("lockYn", "N");
			} else {
				resultMap.put("resultMessage", "비밀번호 5회 오류도 10분간 사용하실수 없습니다.");
				uptMap.put("userNo", user_no);
				uptMap.put("failed_count", "0");
				uptMap.put("lockYn", "Y");
			}
			
			logger.info("password error count :: " + failed_count);
			logger.info("lock account :: " + dao.updateFailedCount(uptMap));
			return resultMap;			
		}
		
		int user_grade = Integer.parseInt((String) memberMap.get("USER_GRADE"));
        
        // 사용자가 관리자인 경우
        if(user_grade == 9) {
            resultMap.put("resultCode", -9);
            resultMap.put("resultMessage", "관리자는 APPM 에서 인증하며, SMS 인증 적용 대상이 아닙니다.");
            return resultMap;
        }

		// ip 체크
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		
		String user_phone = (String) memberMap.get("USER_PHONE");
		logger.info("USER PHONE >>>>> " + user_phone);
		if(user_phone != null) {
			if(!user_phone.equals("")) {
				logger.info(""+!user_phone.equals(""));
				String smsCode = numberGen(6, 1);
				searchMap.put("smsCode", smsCode);
				
				String userName = (String) memberMap.get("USER_NAME");
				String userNo = (String) memberMap.get("USER_NO");
				
				/*String title = "[PIMC] 사용자 로그인" + "[인증번호 : " + smsCode + "]";*/
				String title = "[PIMC] "+userName+"("+userNo+")님의 사용자 로그인 인증번호는 ["+smsCode+"] 입니다.";
				
				String phone = user_phone.replaceAll("-", "");
				
				if(!phone.substring(0,3).equals("010")) {
					resultMap.put("resultMessage", "해당 전화번호로 문자 발송이 불가합니다.\n관리자에게 문의해주세요.");
					resultMap.put("resultCode", -10);
					return resultMap;
				}
				
				String[][] paramLt	= {{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE", title},{"PHONE",phone}};
				getVo(paramLt);
				
				dao.updateSMSCode(searchMap);
			} else {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "사용자의 모바일 전화가 등록되어있지 않습니다. 관리자에게 문의해주세요");
				resultMap.put("member", memberMap);
				
				return resultMap;
			}
			
		} else {
			resultMap.put("resultCode", -4);
			resultMap.put("resultMessage", "사용자의 모바일 전화가 등록되어있지 않습니다. 관리자에게 문의해주세요");
			resultMap.put("member", memberMap);
			
			return resultMap;
		}
			
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SMS 인증진행");
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);
		
		//SessionUtil.setSession("memberSession", memberMap);

		return resultMap;
	}
	
	// 초기화 인증번호 전송
	@Override
	public Map<String, Object> resetNum(HttpServletRequest request) throws Exception {
		
		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String user_name = request.getParameter("user_name");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("user_name", user_name);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "SMS Log-In");
		userLog.put("logFlag", "0");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectMemberNum(searchMap);
		
		if(memberMap == null) {
			resultMap.put("resultCode", -4);
			resultMap.put("resultMessage", "일치하는 회원 정보가 없습니다. 다시 확인해주세요.");
			resultMap.put("member", memberMap);
			
			return resultMap;
		}
		
		String user_phone = (String) memberMap.get("USER_PHONE");
		logger.info("USER PHONE >>>>> " + user_phone);
		
		if (!user_phone.equals("")) {
			logger.info("" + !user_phone.equals(""));
			String smsCode = numberGen(6, 1);
			searchMap.put("smsCode", smsCode);

			/*String title = "[PIMC] 비밀번호 초기화" + "[인증번호 : " + smsCode + "]";*/
			String title = "[PIMC] "+user_name+"("+user_no+")님의 패스워드 초기화 인증번호는 ["+smsCode+"] 입니다.";

			String phone = user_phone.replaceAll("-", "");
			
			if(!phone.substring(0,3).equals("010")) {
				resultMap.put("resultMessage", "해당 전화번호로 문자 발송이 불가합니다.\n관리자에게 문의해주세요.");
				resultMap.put("resultCode", -10);
				
				return resultMap;
			}
			
			String[][] paramLt =
			{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
			getVo(paramLt);

			dao.updateSMSCode(searchMap);
		} else {
			resultMap.put("resultCode", -4);
			resultMap.put("resultMessage", "사용자의 모바일 전화가 등록되어있지 않습니다. 관리자에게 문의해주세요");
			resultMap.put("member", memberMap);

			return resultMap;
		}
			
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SMS 인증진행");
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);
		
		//SessionUtil.setSession("memberSession", memberMap);

		return resultMap;
	}
	
    // 비밀번호 초기화 취소
    @Override
    public Map<String, Object> reset_sms_code(HttpServletRequest request) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        ServletUtil servletUtil = new ServletUtil(request);
        
        String user_no = request.getParameter("user_no");
        String user_name = request.getParameter("user_name");
        
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("user_no", user_no);
        searchMap.put("user_name", user_name);
        
        dao.reset_sms_code(searchMap);

        return resultMap;
    }
	
	// 비밀번호 초기화 + 문자전송
	@Override
	public Map<String, Object> resetPwd(HttpServletRequest request) throws Exception {
		
		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String sms_code = request.getParameter("sms_code");
		String user_name = request.getParameter("user_name");

		// 영문 + 숫자 랜덤 생성 (8자리)
		String rndPwd = "";
		for (int i = 0; i < 8; i++) {
			int rndVal = (int) (Math.random() * 62);
			if (rndVal < 10) {
				rndPwd += rndVal;
			} else if (rndVal > 35) {
				rndPwd += (char) (rndVal + 61);
			} else {
				rndPwd += (char) (rndVal + 55);
			}
		}


		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("sms_code", sms_code);
		searchMap.put("user_name", user_name);
		searchMap.put("password", rndPwd);
		
		logger.info("sms_code ========> " + sms_code);
		logger.info("buf ========> " + rndPwd);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "0");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.updateUserPwd(searchMap);
		
		logger.info("memeber ========> " + memberMap);

		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "인증번호가 틀렸습니다.");
			
			dao.insertLog(userLog);
			return resultMap;
		} else {
			
			Map<String, Object> resetPwd = dao.selectMemberNum(searchMap);
			
			String user = (String) resetPwd.get("USER_NO");
			String user_phone = (String) resetPwd.get("USER_PHONE");
			
			logger.info("user_phone >> " + user_phone);
			
			if (!user_phone.equals("")) {
				logger.info("" + !user_phone.equals(""));
				logger.info("rndPwd >> " + rndPwd);

				/*String title = "[PIMC] 비밀번호 초기화" + "[초기화 비밀번호 : " + rndPwd + "]";|*/
				String title = "[PIMC] "+user_name+"("+user_no+")님의 패스워드가 다음과 같이 초기화 되었습니다. ["+rndPwd+"]";
				
				String phone = user_phone.replaceAll("-", "");
				
				if(!phone.substring(0,3).equals("010")) {
					resultMap.put("resultMessage", "해당 전화번호로 문자 발송이 불가합니다.\n관리자에게 문의해주세요.");
					resultMap.put("resultCode", -10);
					
					return resultMap;
				}

				dao.resetPwd(searchMap);
				
				String[][] paramLt =
				{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
				getVo(paramLt);
				
			}      
			resultMap.put("resultMessage", "SUCCESS");
			resultMap.put("resultCode", 0);
		}
		
		return resultMap;
	}
	
	
	@Override
	public Map<String, Object> changeResetPwd(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ServletUtil servletUtil = new ServletUtil(request);
		
		String oldPassword = request.getParameter("oldPassword");
		String newPasswd = request.getParameter("newPasswd");
		String user_no = request.getParameter("user_no");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("oldPassword", oldPassword);
		searchMap.put("newPasswd", newPasswd);
		
		int ret = dao.changeResetPwd(searchMap);

		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "PASSWORD CHANGE");		
		userLog.put("user_ip", servletUtil.getIp());
		userLog.put("logFlag", "6");

		if (ret == 1) {
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "비밀번호가 변경되었습니다. 다시 로그인 해주세요");
			userLog.put("job_info", "Password Change Success");
			
			dao.insertLog(userLog);
		}
		else {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "현재 비밀번호가 다릅니다.");
			userLog.put("job_info", "Password Change Fail");
			
			dao.insertLog(userLog);
		}
		SessionUtil.closeSession("memberSession");
		return resultMap;
	}

	/**
     * 전달된 파라미터에 맞게 난수를 생성한다
     * @param len : 생성할 난수의 길이
     * @param dupCd : 중복 허용 여부 (1: 중복허용, 2:중복제거)
     * 
     * Created by 닢향
     * http://niphyang.tistory.com
     */
    public String numberGen(int len, int dupCd) {
        
        Random rand = new Random();
        String numStr = ""; //난수가 저장될 변수
        
        for(int i=0;i<len;i++) {
            
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            
            if(dupCd==1) {
                //중복 허용시 numStr에 append
                numStr += ran;
            }else if(dupCd==2) {
                //중복을 허용하지 않을시 중복된 값이 있는지 검사한다
                if(!numStr.contains(ran)) {
                    //중복된 값이 없으면 numStr에 append
                    numStr += ran;
                }else {
                    //생성된 난수가 중복되면 루틴을 다시 실행한다
                    i-=1;
                }
            }
        }
        return numStr;
    }
    
    @Override
	public Map<String, Object> submitSmsLogin(HttpServletRequest request) throws Exception {

		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String sms_code = request.getParameter("sms_code");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("sms_code", sms_code);
		
		logger.info("sms_code ========> " + sms_code);

		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "Log-In Success");
		userLog.put("logFlag", "0");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectSmsMember(searchMap);
		Map<String, String> uptMap = new HashMap<>();
		
		logger.info("memeber ========> " + memberMap);

		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "인증번호가 틀렸습니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertLog(userLog);
			return resultMap;
		} else {
			
			searchMap.put("smsCode", null);
			dao.updateSMSCode(searchMap);
		}
		// 계정이 잠긴 경우
		if(memberMap.get("LOCK_ACCOUNT").equals("Y")) {
			resultMap.put("resultCode", -2);
			resultMap.put("resultMessage", "비밀번호 5회 오류도 10분간 사용하실수 없습니다.\n관리자한테 요청해주세요.");
			return resultMap;	
		}

		// ip 체크
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		if ((memberMap.get("USER_GRADE").equals("9"))) {

			String accessIP = (String) memberMap.get("ACCESS_IP");
			
			if(accessIP.equals("")) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "최고관리자의 접근IP가 없습니다.");
				
				userLog.put("job_info", "Log-In Fail(Access IP is Null)");
				dao.insertLog(userLog);
				return resultMap;			
			}

			String[] accessIPs = accessIP.split(",");
			if (!Arrays.asList(accessIPs).contains(clientIP)) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "등록되지 않은 최고관리자 접근IP입니다.");
				userLog.put("job_info", "Log-In Fail(Access IP is Invalid)");
				dao.insertLog(userLog);
				return resultMap;			
			}

		} else {
			Date startDay = (Date) memberMap.get("STARTDATE"); // 해당 유저의 계정만료일
			Date endDay = (Date) memberMap.get("ENDDATE"); // 해당 유저의 계정만료일
			Date today =  new Date(); // 오늘날짜
			
			if(startDay == null || endDay == null ) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 사용기간이 설정 되어있지 않습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(startDay) < 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 시작일이 되지 않아 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
			if (today.compareTo(endDay) > 0) {
				resultMap.put("resultCode", -4);
				resultMap.put("resultMessage", "계정 만료일이 지나 로그인 할 수 없습니다.");

				userLog.put("job_info", "Log-In Fail(Expirated Date)");
				dao.insertLog(userLog);
				return resultMap;
			}
			
		}
		
		// 관리자/일반사용자 분리
//		if ((memberMap.get("USER_GRADE").equals("0"))) {
//			resultMap.put("user_grade", );
//		}
		
		// 계정 만료일이 지난 경우
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertLog(userLog);
		
		uptMap.put("userNo", user_no);
		uptMap.put("failed_count", "0");
		uptMap.put("lockYn", "N");
		logger.info("lock account :: " + dao.updateFailedCount(uptMap));
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		logger.info("resultMap 확인 = "+ resultMap);
		
		// 사용자 세션 등록
		SessionUtil.setSession("memberSession", memberMap);
		
		setHeader(memberMap);

		return resultMap;
	}
    
    @Override
	public Map<String, Object> authSMSResend(HttpServletRequest request) throws Exception {

		
		String user_no = request.getParameter("user_no");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String smsCode = numberGen(6, 1);
		searchMap.put("smsCode", smsCode);
		
		dao.updateSMSCode(searchMap);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SMS 인증번호 재발송");
		logger.info("resultMap 확인 = "+ resultMap);
		
		//SessionUtil.setSession("memberSession", memberMap);

		return resultMap;
	}
    
    @Override
   	public Map<String, Object> authSMSCancel(HttpServletRequest request) throws Exception {

   		
   		String user_no = request.getParameter("user_no");
   		Map<String, Object> searchMap = new HashMap<String, Object>();
   		searchMap.put("user_no", user_no);
   		
   		Map<String, Object> resultMap = new HashMap<String, Object>();
   		
   		searchMap.put("smsCode", null);
   		
   		dao.updateSMSCode(searchMap);
   		
   		resultMap.put("resultCode", 0);
   		resultMap.put("resultMessage", "SMS 인증 취소");
   		logger.info("resultMap 확인 = "+ resultMap);
   		
   		//SessionUtil.setSession("memberSession", memberMap);

   		return resultMap;
   	}
    
	@Override
	public Map<String, Object> sumApproval() throws Exception {
		Map<String, Object> result = new HashMap<>();
		SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, String> map = new HashMap<>();
		map.put("userNo", SessionUtil.getSession("memberSession", "USER_NO"));
		result = dao.sumApproval(map);
		
		return result;
	}
    
 // XML 내부에서 Body 정보를 담아옴 - 서비스별 상의함
 	private Object getBody(HeaderVo hvo, Element body) {
 		GetSmsInfoVo vo = new GetSmsInfoVo();

 		if(body==null) return vo;

 		String[] contLt	= {"RETURN", "UUID"};

 		for(int i=0; i<contLt.length; i++) {
 			CspUtil.setData(vo, hvo, body, contLt[i]);
 		}
 		return vo;
 	}

 	public ResultVo getVoData(String URL, String[][] paramLt, String METHOD, int timeout) {
 		ResultVo	vo = new ResultVo();

 		Document doc = CspUtil.getDocument(URL, paramLt, METHOD, timeout);

 		Element root	= doc.getRootElement();
 		Element head	= root.getChild("HEADER");
 		Element body	= root.getChild("BODY");

 		if(head!=null) {
 			vo.setHEADER(CspUtil.getHeader(head));
 		}

 		if(body!=null) {
 			vo.setBODY(getBody(vo.getHEADER(), body));
 		}

 		return vo;
 	}


 	// Value Object형 데이터
// 	@Test
 	public void getVo(String[][] paramLt) {
 		int timeout = 5000;
 		System.out.println(getVoData(URL, paramLt, "POST", timeout));
 	}

 	
 	@Override
	@Transactional
	public Map<String, Object> changeUserSettingData(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String userNo =  SessionUtil.getSession("memberSession", "USER_NO");
		
		
		SessionUtil.closeSession("memberSession");
		String changeUserSettingNM = request.getParameter("changeUserSettingNM");
		String changeUserSettingPhoneNM = request.getParameter("changeUserSettingPhoneNM");
		String changeUserSettingEmail = request.getParameter("changeUserSettingEmail");
		String changeUserSettingpassword = request.getParameter("changeUserSettingpassword");
		
		map.put("userNo", userNo);
		map.put("changeUserSettingNM", changeUserSettingNM);
		map.put("changeUserSettingPhoneNM", changeUserSettingPhoneNM);
		map.put("changeUserSettingEmail", changeUserSettingEmail);
		map.put("changeUserSettingpassword", changeUserSettingpassword);
		
		dao.changeUserSettingDate(map);
		
		Map<String, Object> memberMap = dao.selectChangeMember(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		/*
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "CHANGE USER DATA");		
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "6");
		
		userLog.put("job_info", "사용자 정보 변경 - " + userNo);
		
		dao.insertLog(userLog);*/
		
		Object str = memberMap.get("USER_GRADE");
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "회원 정보 수정 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		
		SessionUtil.setSession("memberSession", memberMap);
		
		setHeader(memberMap);
		
		return resultMap;
	}
 	
 	@Override
	public List<Map<String, Object>> selectMemberTeam(HttpServletRequest request) throws Exception {
 		return dao.selectMemberTeam();
	}
 	
 	@Override
	public List<Map<String, Object>> selectPCAdmin(HttpServletRequest request) throws Exception {
 		String user_no = request.getParameter("user_no");
 		String[] user_nos = user_no.split(",");
 		Map<String, Object> searchMap = new HashMap<>();
 		
 		searchMap.put("user_no", user_nos);
 		
 		return dao.selectPCAdmin(searchMap);
	}

	@Override
	public Map<String, Object> lockMemberRequest(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String user_no = request.getParameter("user_no");
		int lock_staus = Integer.parseInt(request.getParameter("lock_staus"));
		String unlock_reson = request.getParameter("unlock_reson");
		Map<String, Object> requestMap = new HashMap<String, Object>();
		
		requestMap.put("user_no", user_no);
		requestMap.put("lock_staus", lock_staus);
		requestMap.put("unlock_reson", unlock_reson);
		
		int ret = dao.lockMemberRequest(requestMap);
		Map<String, Object> memberMap = dao.selectAccoutnLockMember(requestMap);
		List<Map<String, String>> adminMap = dao.selectAdminMember(requestMap);
		String phone = "";
		String title = "";
		
		if (ret == 1) {
			
			String user = (String) memberMap.get("USER_NAME");
			
			for (Map<String, String> map : adminMap) {
				
				String user_phone = map.get("USER_PHONE");
				
				phone = user_phone.replaceAll("-", "");
				/*title = "[PIMC] 계정 잠금 해제 신청 \n" + "["+user+"님이 잠금해제를 요청하였습니다.]";*/
				title = "[PIMC] "+user+"("+user_no+")님이 계정잠금 해제를 요청하였습니다.";
				
				if(!phone.substring(0,3).equals("010")) {
					
					logger.info("관리자 전화 번호 오류로 인해 알람 문자 전송되지 않음 : " + map.get("USER_NAME") );
					/*resultMap.put("resultMessage", "해당 전화번호로 문자 발송이 불가합니다.\n관리자에게 문의해주세요.");
					resultMap.put("resultCode", -10);
					
					return resultMap;
					*/
				}else {
					String[][] paramLt =
						{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
					getVo(paramLt);
				}
				
			}
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "계정 해제 신청이 접수되었습니다.");
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> unlockMemberRequest(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String user_no = request.getParameter("user_no");
		String user_name = request.getParameter("user_name");
		String user_phone = request.getParameter("user_phone");
		int lock_staus = Integer.parseInt(request.getParameter("lock_staus"));
		String unlock_reson = request.getParameter("unlock_reson");
		Map<String, Object> requestMap = new HashMap<String, Object>();
		
		String userNo = SessionUtil.getSession("memberSession", "USER_NO");
		String userName = SessionUtil.getSession("memberSession", "USER_NAME");
		
		requestMap.put("user_no", user_no);
		requestMap.put("lock_staus", lock_staus);
		requestMap.put("unlock_reson", unlock_reson);
		requestMap.put("userNo", userNo);
		
		int ret = dao.unlockMemberRequest(requestMap);
		List<Map<String, String>> adminMap = dao.selectAdminMember(requestMap);
		String phone = "";
		String title = "";
		
		if (ret == 1) {
			
			if(lock_staus == 2) {
				resultMap.put("resultCode", 0);
				resultMap.put("resultMessage", " 사용자의 계정 잠금 해제 신청이 등록 되었습니다.");
				
			}else {
				
				if(!user_name.equals(userName)) {
					
					phone = user_phone.replaceAll("-", "");
					/*title = "[PIMC] 계정 잠금 해제 \n" + "["+user_name+"님의 계정 잠금이 해제 되었습니다.]";*/
					title = "[PIMC] "+user_name+"("+user_no+")님의 계정잠금 해제가 정상 처리되었습니다.";
					
					if(!phone.substring(0,3).equals("010")) {
						resultMap.put("resultMessage", "계정잠김은 해제 했으나, 해당 전화번호로 문자 발송이 불가합니다.");
						resultMap.put("resultCode", -10);
						
						logger.info("사용자 전화번호가 지역번호로 등록됨. : 해제 안내 문자 발송 실패_" +user_name + "_" + user_no);
						
					}else {
						String[][] paramLt =
							{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
						getVo(paramLt);
					}
					
					
					
						
				}
				
				String admin_user = userName;
				String user = user_name;
				
				for (Map<String, String> map : adminMap) {
					
					String userPhone = map.get("USER_PHONE");
					
					phone = userPhone.replaceAll("-", "");
					/*title = "[PIMC] 계정 잠금 해제 \n" + "["+admin_user+"님이 "+user+"님의 잠금을 해제 하였습니다.]";*/
					title = "[PIMC] "+user+"("+user_no+")님의 계정잠금 해제가 정상 처리되었습니다.";
					
					if(!phone.substring(0,3).equals("010")) {
						resultMap.put("resultMessage", "계정잠김은 해제 했으나, 해당 전화번호로 문자 발송이 불가합니다.");
						resultMap.put("resultCode", -10);
						
						logger.info("관리자의 전화번호가 지역번호로 등록됨. : 해제 안내 문자 발송 실패_" +map.get("USER_NO"));
						
					}else {
						String[][] paramLt =
							{{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE",title},{"PHONE",phone}}; 
						getVo(paramLt);
					}
					
				}
				
				resultMap.put("resultCode", 0);
				resultMap.put("resultMessage", " 사용자의 계정 잠금 해제가 완료 되었습니다.");
			}
		}
		
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> selectLockManagerList(HttpServletRequest request) throws Exception {
		
		String lock_status = request.getParameter("sch_aut");
		String user_no = request.getParameter("sch_id");
		String user_name = request.getParameter("sch_userName");
		String team_name = request.getParameter("sch_teamName");
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		
		requestMap.put("lock_status", lock_status);
		requestMap.put("user_no", user_no);
		requestMap.put("user_name", user_name);
		requestMap.put("team_name", team_name);
		
		return dao.selectLockManagerList(requestMap);
	}
	
	@Override
	public String selectSMSFlag() throws Exception {

		return dao.selectSMSFlag();
	}
	
	@Override
	public void updateSMSFlag(HttpServletRequest request) throws Exception {
		
		Map<String, Object> update = new HashMap<String, Object>();
		
		dao.updateSMSFlag(update);
		
	}

	@Override
	public List<Map<Object, Object>> selectSetting() throws Exception {
		List<Map<Object, Object>> resultList = dao.selectSetting();
		List<Map<Object, Object>> setting = new ArrayList<>();
		
		for (Map<Object, Object> map : resultList) {
			Map<Object, Object> resultMap = new HashMap<>();
			resultMap.put(map.get("NAME"), map.get("STATUS"));
			resultMap.put("NAME", map.get("DETAIL_NAME"));
			setting.add(resultMap);
		}
		return setting;
	}
}
