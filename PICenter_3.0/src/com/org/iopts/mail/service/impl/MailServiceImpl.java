package com.org.iopts.mail.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.ParseException;
import org.jdom2.Document;
import org.jdom2.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.org.iopts.cbh.scbh000001.vo.GetSmsInfoVo;
import com.org.iopts.csp.comm.Config;
import com.org.iopts.csp.comm.CspUtil;
import com.org.iopts.csp.comm.vo.HeaderVo;
import com.org.iopts.csp.comm.vo.ResultVo;
import com.org.iopts.mail.dao.MailDAO;
import com.org.iopts.mail.service.MailService;
import com.org.iopts.mail.vo.MailVo;
import com.org.iopts.mail.vo.UserVo;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;

@Service
@Transactional
public class MailServiceImpl implements MailService {

	private static Logger logger = LoggerFactory.getLogger(MailServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;

	@Value("${recon.api.version}")
	private String api_ver;
	
	@Value("${recon.AppConfig}")
	private static String appConfig;

	@Inject
	private MailDAO dao;
	
	/*CBH 메일 전송*/
	private	String URL	= Config.domain + "/rest/SCBH000005/" + Config.apiKey;
	private static String title = "";
	private static String content = "";
	/*private static String sendmail = "";*/
	private static String sendmail = Config.sendmail;
	private static String receivermail = "";
	
	private static String[][] paramLt	= {{"SENDEREMAIL",sendmail},{"RECEIVEREMAIL", receivermail},{"SUBJECT", title},{"CONTENT",content}};
	
	
	@Override
	public Map<String, Object> serverGroupMailContent(HttpServletRequest request) throws Exception {
		int mailType = Integer.parseInt(request.getParameter("mailType"));
		Map<String, Object> userMap = new HashMap<>();
		/*List<MailVo> mailList = dao.selectDate();*/
		
		 String SK_title_con = "";
		 String mailFlag = "";
		 if(mailType == 1) {
			 title = "[PIMC] 서버 내 개인정보 검색 실행요청";
			 mailFlag = "mail1";
			 /*SK_title_con= "<p>아래와 같이 개인정보 검출관리 대상 시스템 정보를 안내 드리오니 담당자께서는 </p>\r\n" + 
							"<p>아래 링크에 접속하셔서 검색일정 수립 및 검색작업을 수행해 주시기 바랍니다.</p>\r\n" + 
							"<p>담당자 변경등 정보수정이 필요하신 경우 개인정보 검출관리 센터 내의</p>\r\n" + 
							"<p>[대상관리 -&gt; 대상조회 및 현행화] 메뉴를 활용하여 변경사항을 등록해 주시기 바랍니다.</p>";*/
			 SK_title_con = dao.selectTemplate(mailFlag);
			 
		}else if(mailType == 2) {
			 title = "[PIMC] 서버 내 개인정보 검색 사전준비 요청";
			 mailFlag = "mail2";
			 /*SK_title_con =  "<p>아래와 같이 개인정보 검출관리 대상 시스템 정보를 안내 드리오니 방화벽 신청,</p>\r\n" + 
							 "<p>에이전트 설치 및 담당자 현행화 업무를 수행하여 주시기 바랍니다.</p>";*/
			 /*SK_title_con =  "<p>아래와 같이 "+mailList.get(0).getDate()+" 전자 개인정보 검출관리 시행안내드리오니</p>\r\n" + 
					 "<p>담당자께서는 아래 링크에 접속하여셔서 검출 일정 수립 및 검출 작업을 수행해 주시기 바랍니다.</p>\r\n" + 
					 "<p>담당자 변경 등 정보 수정이 필요하신 경우 개인정보 검출관리센터 내의</p>\r\n" + 
					 "<p>[대상관리 &gt; 담당자 관리] 메뉴를 활용하여 변경사항을 등록해 주시기 바랍니다.</p>";*/
			 SK_title_con = dao.selectTemplate(mailFlag);
		}
		
		
		userMap.put("SK_title_con", SK_title_con);
		userMap.put("title", title);
		return userMap;
	}
	@Override
	public Map<String, List<String>> serverGroupMail(HttpServletRequest request) throws Exception {
		String assetnosch = request.getParameter("assetnosch");
		String detailCon = request.getParameter("detailCon");
		String mailTitle = request.getParameter("mailTitle");
		String mailType = request.getParameter("mailType");
		String receiveUser = request.getParameter("receiveUser");
		
		Map<String, Object> map = new HashMap<>();
		List<MailVo> mailList = new ArrayList<>();
		Map<String, Object> userMap = new HashMap<>();
		List<UserVo> selectUserList = new ArrayList<>();
		
		JSONArray assetnoschJArr = JSONArray.fromObject(assetnosch);
		map.put("assetnosch", assetnoschJArr);
		mailList = dao.serverGroupMail(map);
		
		Map<String, List<String>> userList = new HashMap<String, List<String>>();
		Map<String, List<String>> userList1 = new HashMap<String, List<String>>();
		Map<String, List<String>> userList2 = new HashMap<String, List<String>>();
	    for (MailVo vo : mailList) {
	    	
	    	// 인프라 담당자
	    	if(vo.getBpinfrauser_mail() != null && receiveUser.contains("I")) {
	    		if (!userList.containsKey(vo.getBpinfrauser()) ) {
	    			userList.put(vo.getBpinfrauser(), new ArrayList<String>());
	    			userList1.put(vo.getBpinfrauser(), new ArrayList<String>());
	    			userList2.put(vo.getBpinfrauser(), new ArrayList<String>());
	    		}
	    		userList.get(vo.getBpinfrauser()).add(vo.getHostnm());
	    		userList1.get(vo.getBpinfrauser()).add(vo.getService_nm());
	    		userList2.get(vo.getBpinfrauser()).add(vo.getAgent_connected_ip());
	    	}
	   
	    	// 서비스 담당자
	    	if(vo.getBpappuser_mail() != null && receiveUser.contains("S")) {
	    		if (!userList.containsKey(vo.getBpappuserid())  ) {
	    			userList.put(vo.getBpappuserid(), new ArrayList<String>());
	    			userList1.put(vo.getBpappuserid(), new ArrayList<String>());
	    			userList2.put(vo.getBpappuserid(), new ArrayList<String>());
	    		}
	    		userList.get(vo.getBpappuserid()).add(vo.getHostnm());
	    		userList1.get(vo.getBpappuserid()).add(vo.getService_nm());
	    		userList2.get(vo.getBpappuserid()).add(vo.getAgent_connected_ip());
	    	}
	    	
	    	// 서비스 관리자
	        if(vo.getSktinfrauser_mail() != null && receiveUser.contains("M")) {
	        	if (!userList.containsKey(vo.getSktinfrauserid()) ) {
	        		userList.put(vo.getSktinfrauserid(), new ArrayList<String>());
	        		userList1.put(vo.getSktinfrauserid(), new ArrayList<String>());
	        		userList2.put(vo.getSktinfrauserid(), new ArrayList<String>());
	        	}
	        	userList.get(vo.getSktinfrauserid()).add(vo.getHostnm());
	        	userList1.get(vo.getSktinfrauserid()).add(vo.getService_nm());
	        	userList2.get(vo.getSktinfrauserid()).add(vo.getAgent_connected_ip());
	        }
	    }
	    
	    for(String key : userList.keySet()) {
	    	userMap.put("user_no", key);
	    	selectUserList = dao.selectUserList(userMap);
	    	
		    for(String userKey : userList.keySet()) {
		    	content = "";
				receivermail = selectUserList.get(0).getUser_email();
				String _url = "https://pimc.sktelecom.com";
				String _url2 = "https://t-secu.sktelecom.com";
				
				
				String _type = "";
				String url_list = "";
				
				String SK_title_con = detailCon;
				String email = "pimc@sktelecom.com";
				String number = "02-6400-8842";
				title = mailTitle;
				
				if(mailType.equals("1")){ // 검색 요청
					_type = "검색 대상";
					
					url_list += "<tr style=\"height: 40px;\">\r\n" + 
								"<td style=\"padding-left: 30px; height: 10px; width: 0px;\">&nbsp;</td>\r\n" + 
								"<td style=\"height: 10px; width: 590px;\">&nbsp;</td>\r\n" + 
								"</tr>\r\n" + 
								"<tr style=\"height: 42px;\">\r\n" + 
								"<td style=\"padding-left: 30px; height: 42px; width: 0px;\">&nbsp;</td>\r\n" + 
								"<td style=\"height: 42px; font-size: 13px; color: #999999; font-weight: bold; line-height: 13px; width: 590px;\">검색 일정 수립</td>\r\n" + 
								"</tr>\r\n" + 
								"<tr style=\"height: 40px;\">\r\n" + 
								"<td style=\"padding-left: 30px; height: 40px width: 0px;\">&nbsp;</td>\r\n" + 
								"<td style=\"height: 40px width: 590px;\">\r\n" + 
								"<p style=\"margin: 5px 0 0 0;\"><span style=\"background-color:#e6e6e6; font-size: 13px; font-weight: bold;\">개인정보검출관리센터(PIMC)바로가기(<a href=\"https://pimc.sktelecom.com/search/search_regist\" target=\"_blank\">"+_url+"</a>)</span></p>\r\n" + 
								"<p style=\"margin: 0px;\"><span style=\"font-size:13px; font-weight: bold; color:#999;\">(메뉴이동 : 검색관리 -&gt; 검색실행)</span></p>"+
								"</td>\r\n" + 
								"</tr>";
					
				}else if(mailType.equals("2")){ // 시행 안내
					_type = "검색 대상";
					
					url_list += "<tr style=\"height: 10px;\">\r\n" + 
								"<td style=\"padding-left: 30px; height: 10px; width: 0px;\">&nbsp;</td>\r\n" + 
								"<td style=\"height: 10px; width: 590px;\">&nbsp;</td>\r\n" + 
								"</tr>\r\n" + 
								"<tr style=\"height: 40px;\">\r\n" + 
								"<td style=\"padding-left: 30px; height: 40px; width: 0px;\">&nbsp;</td>\r\n" + 
								"<td style=\"height: 40px; width: 590px;\">\r\n" + 
								"<p><span style=\"font-size:13px; font-weight: bold;\">방화벽 신청 - 정보보안포탈(<a href=\""+_url2+"\">"+_url2+"</a>)</span> <br>\r\n" + 
								"<span style=\"font-size:13px; font-weight: bold;\">에이전트 설치 - PIMC(<a href=\"https://pimc.sktelecom.com/user/pi_download_main\"  target=\"_blank\">https://pimc.sktelecom.com</a>)</span> <br>\r\n" + 
								"<span style=\"font-size:13px;color:#999;font-weight:700;\">(메뉴이동 : 커뮤니티 -&gt; 프로그램 다운로드)</span><br>\r\n" + 
								"<span style=\"font-size:13px; font-weight: bold;\">담당자 현행화 - PIMC(<a href=\"https://pimc.sktelecom.com/target/pi_target_mngr\"  target=\"_blank\">https://pimc.sktelecom.com</a>)</span> <br>\r\n" + 
								"<span style=\"font-size:13px;color:#999;font-weight:700;\">(메뉴이동 : 대상관리 -&gt; 대상조회 및 현행화)</span><br>\r\n" + 
								"<span style=\"font-size:13px; font-weight: bold;\">검색 실행 - PIMC(<a href=\"https://pimc.sktelecom.com/search/search_regist\"  target=\"_blank\">https://pimc.sktelecom.com</a>)</span> <br>\r\n" + 
								"<span style=\"font-size:13px;color:#999;font-weight:700;\">(메뉴이동 : 검색관리 -&gt; 검색실행)</span><br>\r\n" + 
								"<span style=\"font-size:13px; font-weight: bold;\">결재 - PIMC(<a href=\"https://pimc.sktelecom.com/approval/pi_search_approval_list\"  target=\"_blank\">https://pimc.sktelecom.com</a>)</span><br>\r\n" + 
								"<span style=\"font-size:13px;color:#999;font-weight:700;\">(메뉴이동 : 결과관리 -&gt; 결재 진행현황)</span></p>							</td>\r\n" + 
								"</tr>" ;
				}
				
			
	
				String send_user_name = selectUserList.get(0).getUser_name();
				String send_user_sosok = selectUserList.get(0).getSosok();
				
				String detailContent = "";
				
				if(userKey.equals(selectUserList.get(0).getUser_no())) {
					for(int j=0 ; j < userList.get(userKey).size() ; j++) {
						
						String server_nm = "";
						String ip = "";
						
						if(userList1.get(userKey).get(j) =="" || userList1.get(userKey).get(j) == null) {
							server_nm = "-";
						}else {
							server_nm = userList1.get(userKey).get(j);
						}
						if(userList2.get(userKey).get(j) =="" || userList2.get(userKey).get(j) == null) {
							ip = "없음";
						}else {
							ip = userList2.get(userKey).get(j);
						}
						
						
						
						
						if(j != 0) {
							if(!userList.get(userKey).get(j).equals(userList.get(userKey).get(j-1)) ) {
								detailContent += "<tr><td style=\"width: 30%; border: 1px solid #cccccc;\">"+userList.get(userKey).get(j)+"</td>";
								detailContent += "<td style=\"width: 30%; border: 1px solid #cccccc;\">"+server_nm+"</td>";
								detailContent += "<td style=\"width: 30%; border: 1px solid #cccccc;\">"+ip+"</td></tr>";
							}
						}else {
							detailContent += "<tr><td style=\"width: 30%; border: 1px solid #cccccc;\">"+userList.get(userKey).get(j)+"</td>";
							detailContent += "<td style=\"width: 30%; border: 1px solid #cccccc;\">"+server_nm+"</td>";
							detailContent += "<td style=\"width: 30%; border: 1px solid #cccccc;\">"+ip+"</td> </tr>";
						}
					}
				
				
				content += "<body style=\"font-family:'Noto Sans KR',sans-serif;padding:0;margin:0;\"> \n" +
						"<table style=\"border: 1px solid #ccc;\" border=\"0\" width=\"700\" cellspacing=\"0\" align=\"center\"> \n" +
						"	<tbody> \n" +
						"		<tr> \n" +
						"			<td align=\"center\"> \n" +
						"			<table style=\"border-bottom: 2px solid #000;\" border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\"> \n" +
						"				<tbody> \n" +
						"					<tr> \n" +
						"						<td><img src=\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_title_1.png\" width=\"620\" height=\"91\" /></td> \n" +
						"					</tr> \n" +
						"				</tbody> \n" +
						"			</table> \n" +
						"			<table border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\"> \n" +
						"				<tbody> \n" +
						"					<tr> \n" +
						"						<td style=\"height: 90px;\" align=\"center\" valign=\"bottom\"><img src =\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_icon_2.png\" style=\"vertical-align: bottom;\" width=\"59\" height=\"60\" /></td> \n" +
						"					</tr> \n" +
						"					<tr> \n" +
						"						<td style=\"font-size: 13px; color: #999; font-weight: bold; height: 22px; letter-spacing: -0.7px; line-height: 13px;\" align=\"center\" valign=\"bottom\">개인정보 검출관리센터(PIMC)에서 발송되는 안내 메일입니다.</td> \n" +
						"					</tr>\n" + 
						"					<tr> \n" +
						"						<td style=\"height: 28px;\">&nbsp;</td>\r\n" + 
						"					</tr>\r\n" + 
						"				</tbody>\r\n" + 
						"			</table>\r\n" + 
						//본문상단 <!-- 본문정보영역 -->" 
						"			<table style=\"border: 1px solid #cccccc; padding-top: 30px; height: 239px;\" border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"				<tbody>\r\n" + 
						"					<tr style=\"height: 84px;\">\r\n" + 
						"						<td style=\"padding-left: 30px; height: 84px; width: 0px;\">&nbsp;</td>\r\n" + 
						"						<td style=\"font-size: 13px; font-weight: bold; height: 84px; letter-spacing: -0.5px; width: 590px;\">\r\n" + 
						"						<table style=\"height: 16px; padding-top: 13px;\" border=\"0\" width=\"590\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"								<tbody>\r\n" + 
						"									<tr> \r\n" + 
						"										<td align=\"left\" width=\"45\" style=\"font-size:13px;color:#999;font-weight:700;line-height:15px;\">수신자</td>\r\n" + 
						"										<td style=\"font-size: 13px; color: #222222; font-weight: bold; height: 16px; width: 586px;\" align=\"left\">"+send_user_name+"</td>\r\n" + 
						"									</tr>\r\n" + 
						"								</tbody>\r\n" + 
						"							</table>\r\n" + 
						"							<table style=\"padding-top: 10px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"								<tbody>\r\n" + 
						"									<tr>\r\n" + 
						"										<td style=\"font-size: 13px; color: #999; font-weight: bold; line-height: 15px;\" align=\"left\" width=\"60\">소속부서</td>\r\n" + 
						"										<td style=\"font-size: 13px; color: #222; font-weight: bold;\" width=\"575\">"+send_user_sosok+"</td>\r\n" + 
						"									</tr>\r\n" + 
						"								</tbody>\r\n" + 
						"							</table>\r\n" + 
						"							<div style=\"line-height: 15px; padding-top: 15px;\">							\r\n" + 
						"								<p>정보보호담당 IT보안팀에서 안내 드립니다.</p> <br>							\r\n" + 
						"								<p style=\"white-space: pre-wrap;\">개인정보보호법 및 그룹 자경단 개인정보관리실태 점검 기준에 따라 당사 운용 서버 내 불필요하게 \r\n" + 
						"								<br>저장된 개인정보 파일에 대한 정기 검출 및 삭제/보호 조치 작업을 진행 중에 있습니다.</p>\r\n" + 
						"								\r\n" + 
						"								<!-- 보안 담당자 입력 부분 -->\r\n" + 
						"								<p style=\"white-space: pre-wrap; margin-top: 30px;\">"+SK_title_con+"</p> <br>\r\n" +
						"								<p><span style=\"font-size:13px; font-weight: bold;\">기타 문의사항은 본 메일에 회신 또는 아래 문의처로 연락주시기 바랍니다.</span></p>\r\n" + 
						"								<p><span style=\"font-size:13px; font-weight: bold;\">-관련 문의처: IT보안 운영실("+number+", "+email+")</span></p>" +
						"								<!-- <br><p><span style=\"background-color:#e6e6e6;\">개인정보 검출관리 센터(PIMC) 바로가기(<a href=\"https://pimc.sktelecom.com\">"+_url+"</a>)</span><p><br>							<p>기타 문의사항은 본 메일에 회신 또는 아래 문의처로 연락주시기 바랍니다.</p> -->\r\n" + 
						"							<p>&nbsp;</p>						</div>\r\n" + 
						"						</td>\r\n" + 
						"					</tr>\r\n" + 
						"					<tr>\r\n" + 
						"					<td style=\"padding-left:30;\"></td>\r\n" + 
						"						<tr style=\"height: 42px;\">\r\n" + 
						"							<td style=\"padding-left: 30px; height: 42px; width: 0px;\">&nbsp;</td>\r\n" + 
						"							<td style=\"height: 42px; font-size: 13px; color: #999999; font-weight: bold; line-height: 13px; width: 590px;\">"+_type+"</td>\r\n" + 
						"						</tr>\r\n" + 
						"						<tr style=\"height: 22px;\">\r\n" + 
						"							<td style=\"padding-left: 30px; height: 22px; width: 0px;\">&nbsp;</td>\r\n" + 
						"							<td style=\"height: 22px; width: 590px;\">\r\n" + 
						"								<table border=\"0\" width=\"550\" cellspacing=\"0\" cellpadding=\"0\" style=\"text-align: center; font-size: 12px; height: 50px; border-collapse: collapse;\">\r\n" + 
						"									<tbody >\r\n" + 
						"										<tr>\r\n" + 
						"											<td style=\"font-weight: bold; width: 30%; border: 1px solid #cccccc;\">호스트명</td>\r\n" + 
						"											<td style=\"font-weight: bold; width: 30%; border: 1px solid #cccccc;\">서비스명</td>\r\n" + 
						"											<td style=\"font-weight: bold; width: 30%; border: 1px solid #cccccc;\">IP</td>\r\n" + 
						"										</tr>\r\n" + 
																		detailContent+
						"										<!-- <tr>\r\n" + 
						"											<td valign=\"bottom\" style=\"font-size: 13px; font-weight: bold;\">LOCALHOST<br>								</td>\r\n" + 
						"										</tr> -->\r\n" + 
						"									</tbody>\r\n" + 
						"								</table>\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
													url_list + 
						"						<tr style=\"height: 10px;\">\r\n" + 
						"							<td style=\"padding-left: 30px; height: 10px; width: 0px;\">&nbsp;</td>\r\n" + 
						"							<td style=\"height: 10px; width: 590px;\">&nbsp;</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"				<table border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"height: 52px;\">&nbsp;</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"				<table style=\"border-top: 1px solid #ccc;\" border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td bgcolor=\"#e6e6e6\" height=\"86\">\r\n" + 
						"								<table>\r\n" + 
						"									<tbody>\r\n" + 
						"										<tr>\r\n" + 
						"											<td style=\"padding-left: 40px;\" width=\"110\"><img src=\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_footer%20logo.png\" width=\"82\" height=\"32\" /></td>\r\n" + 
						"											<td style=\" letter-spacing: -0.7px; font-size: 13px; color: #000000; font-weight: bold;\" align=\"center\" height=\"42\" width=\"390\">Personal Information Management Center</td>\r\n" + 
						"											<!--<td style=\"font-size: 13px; color: #FF5000; font-weight: bold;\" align=\"center\" height=\"42\" width=\"390\">Personal Information Management Center</td> -->\r\n" + 
						"										</tr>\r\n" + 
						"									</tbody>\r\n" + 
						"								</table>\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"				<table border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</td>\r\n" + 
						"		</tr>\r\n" + 
						"	</tbody>\r\n" + 
						"</table>\r\n" + 
						"</body>";
				

			    String [][] paramLt = {{"SENDEREMAIL",sendmail},{"RECEIVEREMAIL", receivermail},{"SUBJECT", mailTitle},{"CONTENT",content}};
			    getVo(paramLt);
			    
			    /*logger.info("content >>>>> " + content);*/
				}
		    }
	    }
	    
		return userList;
	}   
	
	@Override
	public List<UserVo> approvalSendMail(HashMap<String, Object> params) throws Exception {
		
		logger.info("params >>>>> " + params);
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_name = SessionUtil.getSession("memberSession", "USER_NAME");
		String team_name = SessionUtil.getSession("memberSession", "TEAM_NAME");
		params.put("user_no", user_no);
		
		List<UserVo> selectSendUserList = new ArrayList<>();
		List<UserVo> selectUserList = new ArrayList<>();
		
		selectSendUserList = dao.selectUserList(params);
		selectUserList = dao.selectSendUserList(params);
		
		if(selectUserList.get(0).getUser_email() != null) {
			content = "";
			receivermail = selectUserList.get(0).getUser_email();
			/*String _tnetproxy_url = "http://tnetproxy.sktelecom.com:8081/proxy/notes_redirect.jsp?RequestURL=http://hqappr.netswork.co.kr/sktaprv/approval.nsf/fssplitmainframe?readform&frame=fsleft_3&db=approval&ele=ing?openview&Start=1&Count=18";
			String _tnetproxy_url_ = "http://tnetproxy.sktelecom.com";*/
			String _edms_url = "http://tnet.sktelecom.com/SmartTalk/Main/Pages/Main.aspx";
			String _url = "https://pimc.sktelecom.com";
			String _type = "조치계획 ";
			String _type2 = "요청 의견 ";
			String email = "pimc@sktelecom.com";
			String number = "02-6400-8842";
			String SK_title_con1 =  "<p>개인정보보호법 및 그룹 자경단 개인정보관리실태 점검 기준에 따라 당사 운용 서버 </p>\r\n" + 
									"<p>내 불필요하게 저장된 개인정보 파일에 대한 정기 검출 및 삭제/보호 조치 작업을 </p>\r\n" + 
									"<p> 진행 중에 있습니다.</p>\r\n";
			
			String SK_title_con2 =  "<p>금번 개인정보 검출 작업 결과에 대한 서비스 담당자의 조치계획이 전자 결재 문서로 </p>\r\n" + 
									"<p>생성되었습니다. 아래 링크로 접속하신 후에 상세 내용 검토 및 소속 부서장의 승인이</p>\r\n" + 
									"<p>완료될 수 있도록 조치해 주시기 바랍니다.</p> <br>\r\n" + 
									"<p><span style=\"font-size:13px; font-weight: bold;\">기타 문의사항은 본 메일에 회신 또는 아래 문의처로 연락주시기 바랍니다. <br></span><p>\r\n" + 
									"<p><span style=\"font-size:13px; font-weight: bold;\">-관련 문의처: IT보안 운영실("+number+", "+email+")</span><p>" ;
			String SK_title_note =  selectUserList.get(0).getComment();
			String send_user_name = selectUserList.get(0).getUser_name();
			String send_user_sosok = selectUserList.get(0).getSosok();
			String detailContent = "";
			int detailConCount = 0 ;
			title = "[PIMC] 서버 내 개인정보 검출결과 조치계획 확인요청";
			
			if(selectUserList.size() < 4) {
				for(UserVo ao : selectUserList) {
					detailContent += "<tr><td valign=\"bottom\" style=\"font-size: 13px; font-weight: bold;\">" + ao.getDetail_con() + "</td><tr>\r\n";
					detailContent += "<tr><td valign=\"bottom\" style=\"font-size: 13px;\"> &nbsp;&nbsp; > " + ao.getNotePad() + "</td><tr>\r\n";
				}
			}else {
				for(int i=0 ; i < selectUserList.size() ; i++) {
					if(i < 3) {
						detailContent += "<tr><td valign=\"bottom\" style=\"font-size: 13px; font-weight: bold;\">" + selectUserList.get(i).getDetail_con() + "</td><tr>\r\n";
						detailContent += "<tr><td valign=\"bottom\" style=\"font-size: 13px;\"> &nbsp;&nbsp; > " + selectUserList.get(i).getNotePad() + "</td><tr>\r\n";
					}else {
						detailConCount++;
					}
				}
				detailContent += "<tr><td>&nbsp;</td></tr>\r\n";
				detailContent += "<tr><td style=\"font-size: 13px; font-weight: bold;\">+외 "+detailConCount+"건</td></tr>\r\n";
			}
			
			content += "<body style=\"font-family:'Noto Sans KR',sans-serif;padding:0;margin:0;\"> \r\n" + 
					"<table style=\"border: 1px solid #ccc;\" border=\"0\" width=\"700\" cellspacing=\"0\" align=\"center\"> \r\n" + 
					"	<tbody> \r\n" + 
					"		<tr> \r\n" + 
					"			<td align=\"center\"> \r\n" + 
					"			<table style=\"border-bottom: 2px solid #000;\" border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\"> \r\n" + 
					"				<tbody> \r\n" + 
					"					<tr> \r\n" + 
					"						<td><img src=\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_title_1.png\" width=\"620\" height=\"91\" /></td> \r\n" + 
					"					</tr> \r\n" + 
					"				</tbody> \r\n" + 
					"			</table> \r\n" + 
					"			<table border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\"> \r\n" + 
					"				<tbody> \r\n" + 
					"					<tr> \r\n" + 
					"						<td style=\"height: 90px;\" align=\"center\" valign=\"bottom\"><img src =\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_icon_2.png\" style=\"vertical-align: bottom;\" width=\"59\" height=\"60\" /></td> \r\n" + 
					"					</tr> \r\n" + 
					"					<tr> \r\n" + 
					"						<td style=\"font-size: 13px; color: #999; font-weight: bold; height: 22px; letter-spacing: -0.7px; line-height: 13px;\" align=\"center\" valign=\"bottom\">개인정보 검출관리센터(PIMC)에서 발송되는 안내 메일입니다.</td> \r\n" + 
					"					</tr>\r\n" + 
					"					<tr> \r\n" + 
					"						<td style=\"height: 28px;\">&nbsp;</td>\r\n" + 
					"					</tr>\r\n" + 
					"				</tbody>\r\n" + 
					"			</table>\r\n" + 
					"			<table style=\"border: 1px solid #cccccc; padding-top: 30px; height: 239px;\" border=\"0\" width=\"620\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"				<tbody>\r\n" + 
					"					<tr style=\"height: 84px;\">\r\n" + 
					"						<td style=\"padding-left: 30px; height: 84px; width: 0px;\">&nbsp;</td>\r\n" + 
					"						<td style=\"font-size: 13px; font-weight: bold; height: 84px; letter-spacing: -0.5px; width: 590px;\">\r\n" + 
					"							<div style=\"line-height: 15px;\">							\r\n" + 
					"							<p>정보보호담당 IT보안팀에서 안내 드립니다.</p> <br>							\r\n" + 
					"							<p style=\"white-space: pre-wrap;\">"+SK_title_con1 + 
					"							</p>							\r\n" + 
					"							<p style=\"white-space: pre-wrap; margin-top: 30px;\">"+SK_title_con2 + 
					"							</p><br>\r\n" + 
					"							<p>\r\n" + 
					"								<span style=\"background-color:#e6e6e6;\">전자결재 시스템(EDMS) 바로가기(<a href=\""+_edms_url+"\" target=\"_blank\">"+_edms_url+"</a>)</span>\r\n" + 
					"							</p>							\r\n" + 
					"							<p>&nbsp;</p>						\r\n" + 
					"							</div>\r\n" + 
					"						</td>\r\n" + 
					"					</tr>\r\n" + 
					"					<tr style=\"height: 51px;\">\r\n" + 
					"						<td style=\"padding-left: 30px; height: 51px; width: 0px;\">&nbsp;</td>\r\n" + 
					"						<td style=\"height: 51px; width: 590px;\">\r\n" + 
					"							<table style=\"height: 16px;\" border=\"0\" width=\"590\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"								<tbody>\r\n" + 
					"									<tr> \r\n" + 
					"										<td align=\"left\" width=\"120\" style=\"font-size:13px;color:#999;font-weight:700;line-height:15px;\">조지계획 등록자</td>\r\n" + 
					"										<td style=\"font-size: 13px; color: #222222; font-weight: bold; height: 16px; width: 586px;\" align=\"left\">"+user_name+"</td>\r\n" + 
					"									</tr>\r\n" + 
					"								</tbody>\r\n" + 
					"							</table>\r\n" + 
					"							<table style=\"padding-top: 10px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"								<tbody>\r\n" + 
					"									<tr>\r\n" + 
					"										<td style=\"font-size: 13px; color: #999; font-weight: bold; line-height: 15px;\" align=\"left\" width=\"60\">소속부서</td>\r\n" + 
					"										<td style=\"font-size: 13px; color: #222; font-weight: bold;\" width=\"575\">"+team_name+"</td>\r\n" + 
					"									</tr>\r\n" + 
					"								</tbody>\r\n" + 
					"							</table>\r\n" + 
					"						</td>\r\n" + 
					"					</tr>\r\n" + 
					"					<tr>\r\n" + 
					"						<td style=\"padding-left:30;\"></td>\r\n" + 
					"						<td style=\"height:20px;\"></td>\r\n" + 
					"						<tr style=\"height: 42px;\">\r\n" + 
					"							<td style=\"padding-left: 30px; height: 42px; width: 0px;\">&nbsp;</td>\r\n" + 
					"							<td style=\"height: 42px; font-size: 13px; color: #999999; font-weight: bold; line-height: 13px; width: 590px;\">"+_type+"</td>\r\n" + 
					"						</tr>\r\n" + 
					"						<tr style=\"height: 22px;\">\r\n" + 
					"							<td style=\"padding-left: 30px; height: 22px; width: 0px;\">&nbsp;</td>\r\n" + 
					"							<td style=\"height: 22px; width: 590px;\">\r\n" + 
					"								<table border=\"0\" width=\"590\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"									<tbody>\r\n" + detailContent + 
					"									</tbody>\r\n" + 
					"								</table>\r\n" + 
					"							</td>\r\n" + 
					"						</tr>\r\n" + 
					"						<tr style=\"height: 30px;\">\r\n" + 
					"							<td style=\"padding-left: 30px; height: 30px; width: 0px;\">&nbsp;</td>\r\n" + 
					"							<td style=\"height: 30px; width: 590px;\">&nbsp;</td>\r\n" + 
					"						</tr>\r\n" + 
					"					</tbody>\r\n" + 
					"				</table>\r\n" + 
					"				<table border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"					<tbody>\r\n" + 
					"						<tr>\r\n" + 
					"							<td style=\"height: 80px;\">&nbsp;</td>\r\n" + 
					"						</tr>\r\n" + 
					"					</tbody>\r\n" + 
					"				</table>\r\n" + 
					"				<table style=\"border-top: 1px solid #ccc;\" border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"					<tbody>\r\n" + 
					"						<tr>\r\n" + 
					"							<td bgcolor=\"#e6e6e6\" height=\"86\">\r\n" + 
					"								<table>\r\n" + 
					"									<tbody>\r\n" + 
					"										<tr>\r\n" + 
					"											<td style=\"padding-left: 40px;\" width=\"110\"><img src=\"https://pimc.sktelecom.com/resources/assets/images/SKT_mail_footer%20logo.png\" width=\"82\" height=\"32\" /></td>\r\n" + 
				"												<td style=\"letter-spacing: -0.7px; font-size: 13px; color: #000000; font-weight: bold;\" align=\"center\" height=\"42\" width=\"390\">Personal Information Management Center</td>\r\n" + 
					"										<!-- <td style=\"font-size: 13px; color: #FF5000; font-weight: bold;\" align=\"center\" height=\"42\" width=\"390\">Personal Information Management Center</td> -->\r\n" + 
					"										</tr>\r\n" + 
					"									</tbody>\r\n" + 
					"								</table>\r\n" + 
					"							</td>\r\n" + 
					"						</tr>\r\n" + 
					"					</tbody>\r\n" + 
					"				</table>\r\n" + 
					"				<table border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">\r\n" + 
					"					<tbody>\r\n" + 
					"						<tr>\r\n" + 
					"						</tr>\r\n" + 
					"					</tbody>\r\n" + 
					"				</table>\r\n" + 
					"			</td>\r\n" + 
					"		</tr>\r\n" + 
					"	</tbody>\r\n" + 
					"</table>\r\n" + 
					"</body>";
			
			String [][] paramLt = {{"SENDEREMAIL",sendmail},{"RECEIVEREMAIL", receivermail},{"SUBJECT", title},{"CONTENT",content}};
			getVo(paramLt);
	    	
			/*logger.info("content >>>>> " + content);*/
			
		}else {
		}
		
		return selectUserList;
	}
	
	@Override
	public Map<String, Object> templateInsert(HttpServletRequest request) throws Exception {
		String template_con = request.getParameter("template_con");
		int mailType = Integer.parseInt(request.getParameter("mailType"));
		
		String name = "";
		if(mailType == 1) {
			name = "mail1";
		}else {
			name = "mail2";
		}
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("template_con", template_con);
		input.put("name", name);
		
		logger.info("input >> " + input);
		dao.templateUpdate(input);
		dao.templateInsert(input);
		
		return input;
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


		// XML 문자열 데이터
//		@Test
		public void getXmlData() {
			try {
				int timeout = 5000;
				System.out.println(CspUtil.GET(URL, paramLt, timeout).getRtnText());
			} catch (ParseException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// Value Object형 데이터
//		@Test
		public void getVo(String[][] paramLt) {
			int timeout = 5000;
			System.out.println(getVoData(URL, paramLt, "POST", timeout));
		}

		// JSON형 데이터
//		@Test
		public void getJSONData() {
			Gson gson = new Gson();
			int timeout = 5000;
			System.out.println(gson.toJson(getVoData(URL, paramLt, "POST", timeout)).toString() );
		}
}
