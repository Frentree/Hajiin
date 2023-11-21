package com.org.iopts.detection.service.impl;
 
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.gson.JsonParser;
import com.org.iopts.approval.util.DevWsCreateReqApprDocProxy;
import com.org.iopts.approval.util.WsCreateReqApprDocProxy;
import com.org.iopts.dao.Pi_DetectionDAO;
import com.org.iopts.detection.dao.piApprovalDAO;
import com.org.iopts.detection.service.piApprovalService;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("approvalService")
@Transactional
public class piApprovalServiceImple implements piApprovalService {
	
	private static Logger log = LoggerFactory.getLogger(piApprovalServiceImple.class);
	
	@Inject
	private Pi_DetectionDAO detectionDao;

	@Inject
	private piApprovalDAO approvalDao;

	@Override
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		params.put("user_no", user_no);			// 사용자
		params.put("user_grade", user_grade);			// 사용자

		return approvalDao.searchProcessList(params);
	}

	@Override
	public List<HashMap<String, Object>> selectTeamMember(HttpServletRequest request) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		
		return approvalDao.selectTeamMember(searchMap);
	}
	
	// 기안자 검색
	@Override
	public List<HashMap<String, Object>> searchTeamMember(HttpServletRequest request) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		searchMap.put("searchTeamName", request.getParameter("searchTeamName"));
		searchMap.put("searchName", request.getParameter("searchName"));
		
		log.info("searchMap >> " + searchMap);
		
		return approvalDao.searchTeamMember(searchMap);
	}

	@Override
	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		Map<String, Object> memberMap = approvalDao.selectDocuNum(params);
		log.info("selectDocuNum : " + memberMap);

		return memberMap;
		
	}

	@Override
	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		params.put("user_no", user_no);
		params.put("user_grade", user_grade);
		
		List<HashMap<String, Object>> resultMap = approvalDao.selectProcessPath(params);

		return resultMap;
	}

	@Override
	public HashMap<String, Object>  registProcessCharge(HashMap<String, Object> params) throws Exception
	{
		// 전자결재 RETURN 값 파싱
		DocumentBuilderFactory builderFactory = null;
        DocumentBuilder builder = null;
        Document document = null;
        
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		params.put("resultCode", 0);
	
		Map<String, Object> map = approvalDao.selectProcessingSeq(params);
		int index = Integer.parseInt(map.get("ID").toString());
		String approvalID = map.get("ID_LENGTH").toString();
		String user_name = map.get("USER_NAME").toString();
		String regdate = map.get("REGDATE").toString();
		
		//List<String> idxList = (List<String>)params.get("idxList");
		List<HashMap<String, Object>> mapCount = approvalDao.selectApprovalCount(params);
		
		String IFIDVALUE = "PIMC" + regdate + approvalID;
		
		params.put("index", (index+1));
		params.put("IFIDVALUE", IFIDVALUE);
		approvalDao.insertProcessingSeq(params);
		
		// 결재 생성
		approvalDao.registProcessCharge(params);
		String approvalUser = params.get("ok_user_no").toString();
		// String comment = "<pre>&nbsp;&nbsp;- " + params.get("comment").toString() + "</pre>";
		String comment = params.get("comment").toString();
		String approvalNo = params.get("today") + "_" + params.get("user_no")+ "_" + params.get("doc_seq");
		String result = "";
		
		StringBuilder sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		sb.append("<HEAD>");
		sb.append("<CNCODE>SKT</CNCODE>");
		sb.append("<MODULE>wsCreateReqDoc</MODULE>");
		sb.append("<MSGSTR>C</MSGSTR>");
		sb.append("<SYSCODE>PIMC</SYSCODE>");
		sb.append("</HEAD>");
		sb.append("<BODY>");
		sb.append("<IFIDVALUE>" +IFIDVALUE+"</IFIDVALUE>");
		//sb.append("<SUBJECT><![CDATA[[PIMC] 서버 개인정보 검출 결과 조치 계획 승인 요청("+approvalNo+")]]></SUBJECT>");
		// 1.sb.append("<SUBJECT><![CDATA[서버 개인정보 검출 결과 조치 계획 승인 요청("+approvalNo+")]]></SUBJECT>");
		// 2. sb.append("<SUBJECT><![CDATA[[PIMC] 서버 개인정보 검출 결과 조치 계획 승인 요청("+approvalNo+")]]></SUBJECT>");
		// 3. sb.append("<SUBJECT><![CDATA[("+approvalNo+")]]></SUBJECT>");
		// -------------------------------------------- 2022.06.27 수정
		// /*현재*/ sb.append("<SUBJECT><![CDATA[개인정보 검출관리 승인요청서("+approvalNo+")]]></SUBJECT>");
		// /*1안*/ sb.append("<SUBJECT><![CDATA[개인정보 검출관리 승인요청서("+approvalNo+")]]></SUBJECT>");
		// /*2안*/ sb.append("<SUBJECT><![CDATA[[PIMC] 개인정보 검출관리 승인요청서("+approvalNo+")]]></SUBJECT>");
		// /*3안*/ sb.append("<SUBJECT><![CDATA["+approvalNo+"]]></SUBJECT>");
		// /*4안*/ sb.append("<SUBJECT><![CDATA[("+approvalNo+")]]></SUBJECT>");
		// /*5안*/sb.append("<SUBJECT><![CDATA[PIMC 승인요청서("+approvalNo+")]]></SUBJECT>");
		sb.append("<SUBJECT><![CDATA[개인정보 검출관리 승인요청서("+approvalNo+")]]></SUBJECT>");
		sb.append("<USERID>"+approvalUser+"</USERID>");
		sb.append("<FORMCODE>PIMCAprv</FORMCODE>");
		sb.append("<KEYFORMCODE>pim_PIMCAprv</KEYFORMCODE>");
		sb.append("<APPLINEINFO>2,0</APPLINEINFO>");
		sb.append("<APPLINE></APPLINE>");
		sb.append("<APPOPTION>D</APPOPTION>"); 
		sb.append("<NOTIFY>N,N,N,Y</NOTIFY>");
		sb.append("<KEEPFOR>3</KEEPFOR>");	// 보존년한 1 or 3 or 5 or 10 or 0
		sb.append("<SECURITY>GS</SECURITY>");	// 비밀 등급 G: 일반, S: 비밀/관련부서만 열람가능, GS: 비밀/전부서 열람가능, SP: 발/수신 부서장만 열람가능
		//sb.append("<DOCTYPE>[PIMC] 개인정보 검출관리 승인요청서</DOCTYPE>");
		// 1. sb.append("<DOCTYPE>PIMC</DOCTYPE>");
		// 2. sb.append("<DOCTYPE>개인정보 검출관리 승인요청서</DOCTYPE>");
		// 3.sb.append("<DOCTYPE>[PIMC] 개인정보 검출관리 승인요청서</DOCTYPE>");
		// -------------------------------------------- 2022.06.27 수정
		// /*현재*/ sb.append("<DOCTYPE>PIMC</DOCTYPE>");
		// /*1안*/ sb.append("<DOCTYPE>개인정보 검출관리 승인요청서</DOCTYPE>");
		// /*2~4안*/ sb.append("<DOCTYPE>개인정보 검출관리 승인요청서</DOCTYPE>");
		// /*5안*/sb.append("<DOCTYPE>개인정보 검출관리</DOCTYPE>");
		sb.append("<DOCTYPE>PIMC</DOCTYPE>");
		sb.append("<SYSTEMGUBUN>PIMC</SYSTEMGUBUN>");
		sb.append("<FIELDLIST></FIELDLIST>");
		sb.append("<SABUN></SABUN>");
		sb.append("<NAME></NAME>");
		sb.append("<SOSOK></SOSOK>");
		sb.append("</BODY>");
		sb.append("</ROOT>");
		
		StringBuilder body = new StringBuilder();
		
		body.append("<html>");
		body.append("<head>");
		body.append("<style>");
		body.append(".approval { border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".result { text-align: right; border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".font_color { color: blue;}");
		body.append(".font_family {font-size:14px; white-space: pre-wrap;}");
		body.append("</style>");
		body.append("</head>");
		body.append("<body>");
		body.append("<div class='approval_div'>");
		body.append("<br><p>&nbsp;- 개인정보보호법 및 그룹 보안가이드라인 준수를 위해 전사 서버 내 임의 보관/저장된 <br> &nbsp;&nbsp;&nbsp;개인정보를 정기 검출하여 필요한 보호 조치를 수행하고 있습니다.</p>");
		body.append("<p>&nbsp;- 서버 개인정보 검출 과정에서 확인된 파일들에 대해 삭제/암호화/예외처리 적용을  <br> &nbsp;&nbsp;&nbsp;진행하고자 하오니, 상세내용 확인 후 승인하여 주시기 바랍니다.</p>");
		body.append("<b><p>&nbsp;1) 조지계획 등록자</p></b>");
		body.append("<p style='padding-left: 17px;'>- " + user_name +"</p>");/*
		body.append("<b><p>2. 승인요청내역</p></b>");
		body.append("<p>&nbsp;&nbsp;- 개인정보보호법 및 그룹 보안가이드라인 준수를 위해 전사 서버 내 임의<br> 보관/저장된 개인정보를 정기 검출하여 필요한 보호 조치를 수행하고 있습<br>니다.</p>");
		body.append("<p>&nbsp;&nbsp;- 서버 개인정보 검출 과정에서 확인된 파일들에 대해 삭제/암호화/예외처리<br> 적용을 진행하고자 하오니, 상세내용 확인 후 승인하여 주시기 바랍니다.</p>");*/
		body.append("<b><p>&nbsp;2) 조치계획 의견</p></b>");
		body.append("<p style='padding-left: 17px; white-space: pre-wrap; width: 627px;'>- " + comment + "</p>");
		body.append("<b><p>&nbsp;3) 문서번호</p></b>");
		body.append("<p style='padding-left: 17px;'>- " + approvalNo + "</p>");
		body.append("<br>");
		body.append("<b>상세내용 : <a href='https://pimc.sktelecom.com/approval/pi_search_approval_list' target='_blank'><span style='color: #0000FF;'>PIMC 개인정보 검출 결과 상세보기</span></a></b>");
		// body.append("<b>상세내용 : <a href='https://pimc.sktelecom.com/manage/pi_detection_approval_list?idx="+params.get("DATA_PROCESSING_CHARGE_ID")+"' target='_blank'><span style='color: #0000FF;'>PIMC 개인정보 검출 결과 상세보기</span></a></b>");
		body.append("<div style='padding-top:20px;'>");
		body.append("<table style='width: 480px; border: 1px solid #DFDFE6; border-collapse: collapse; font-size:14px; font-family:'Noto Sans KR';'>");
		body.append("<thead><tr><th class='approval'>호스트명</th><th class='approval'>유형</th><th class='approval'>파일수</th></tr></thead>");
		body.append("<tr>");
		/*body.append("<html>");
		body.append("<head>");
		body.append("<style>");
		body.append(".approval { border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".result { text-align: right; border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".approval_div {font-size:14px; font-family:'Noto Sans KR';}");
		body.append("</style>");
		body.append("</head>");
		body.append("<body>");
		body.append("<div class='approval_div'>");
		body.append("<b><p>1. 승인요청자</p></b>");
		body.append("<p>&nbsp;&nbsp;- " + user_name +"</p>");
		body.append("<b><p>2. 승인요청내역</p></b>");
		body.append("<p>&nbsp;&nbsp;- 개인정보보호법 및 그룹 보안가이드라인 준수를 위해 전사 서버 내 임의<br> 보관/저장된 개인정보를 정기 검출하여 필요한 보호 조치를 수행하고 있습<br>니다.</p>");
		body.append("<p>&nbsp;&nbsp;- 서버 개인정보 검출 과정에서 확인된 파일들에 대해 삭제/암호화/예외처리<br> 적용을 진행하고자 하오니, 상세내용 확인 후 승인하여 주시기 바랍니다.</p>");
		body.append("<b><p>3. 기안의견</p></b>");
		body.append(comment);
		body.append("<b><p>4. 문서번호</p></b>");
		body.append("<p>&nbsp;&nbsp;- " + approvalNo + "</p>");
		body.append("<br>");
		body.append("<b>상세내용 : <a href='https://pimc.sktelecom.com/manage/pi_detection_approval_list?idx="+params.get("DATA_PROCESSING_CHARGE_ID")+"' target='_blank'>PIMC 개인정보 검출 결과 상세보기</a></b>");
		body.append("<div style='padding-top:20px;'>");
		body.append("<table style='width: 480px; border: 1px solid #DFDFE6; border-collapse: collapse; font-size:14px; font-family:'Noto Sans KR';'>");
		body.append("<thead><tr><th class='approval'>호스트명</th><th class='approval'>유형</th><th class='approval'>파일수</th></tr></thead>");
		body.append("<tr>");*/
		for(int i = 0; i < mapCount.size(); i++) {
			body.append("<td class='approval'>"+mapCount.get(i).get("NAME")+"</td>");
			body.append("<td class='approval'>"+mapCount.get(i).get("PROCESSING_FLAG_NAME")+"</td>");
			body.append("<td class='result'>"+ mapCount.get(i).get("RESULT_CNT")+"</td></tr>");
			
		}
		body.append("</tr>");
		body.append("</table>");
		body.append("</div>");
		body.append("</div>");
		body.append("</body>");
		body.append("</html>");
		/*
		String body1 = "<html><body>\r\n" + 
				"<b><p>1. 승인요청자</p></b>\r\n" + 
				"<p>&nbsp;&nbsp;- " + user_name +"</p>" +
				"<b><p>2. 승인요청내역</p></b>\r\n" + 
				"<p>&nbsp;&nbsp;- 개인정보보호법 및 그룹 보안가이드라인 준수를 위해 전사 서버 내 임의<br> 보관/저장된 개인정보를 정기 검출하여 필요한 보호 조치를 수행하고 있습<br>니다.</p>\r\n" + 
				"<p>&nbsp;&nbsp;- 서버 개인정보 검출 과정에서 확인된 파일들에 대해 삭제/암호화/예외처리<br> 적용을 진행하고자 하오니, 상세내용 확인 후 승인하여 주시기 바랍니다.</p>\r\n" + 
				"<br>\r\n" + 
				"<b>상세내용 : <a href='https://pimc.sktelecom.com/manage/pi_detection_approval_list?idx="+params.get("DATA_PROCESSING_CHARGE_ID")+"' target='_blank'>PIMC 개인정보 검출 결과 상세보기</a></b>\r\n" + 
				"</body></html>";*/
		
		log.info("SZAPPRINFO >> " + sb.toString());
		log.info("body >> " + body.toString());
		
		try {
			// 전자결재 웹서버 프록시
			//DevWsCreateReqApprDocProxy dev_proxy = new DevWsCreateReqApprDocProxy();
			WsCreateReqApprDocProxy proxy = new WsCreateReqApprDocProxy(); 
			
			result = proxy.WS_APPR_CREATE_DOC(sb.toString(), body.toString(), "");
			
		/*	result = proxy.WS_APPR_CREATE_DOC("<?xml version=\"1.0\" encoding=\"utf-8\" ?>" + 
			        "<ROOT>" + 
			        "    <HEAD>" + 
			        "        <CNCODE>SKT</CNCODE>" + 
			        "        <MODULE>wsCreateReqDoc</MODULE>" + 
			        "        <MSGSTR>C</MSGSTR>" + 
			        "        <SYSCODE>PIMC</SYSCODE>" + 
			        "    </HEAD>" + 
			        "    <BODY>" + 
			        "        <IFIDVALUE>"+ IFIDVALUE +"</IFIDVALUE>" + 
			        "        <SUBJECT><![CDATA[[PIMC] 서버 개인정보 검출 결과 조치 계획 승인 요청]]></SUBJECT>" + 
			        "        <USERID>"+approvalUser+"</USERID>" + 
			        "        <FORMCODE>PIMCAprv</FORMCODE>" + 
			        "        <KEYFORMCODE>pim_PIMCAprv</KEYFORMCODE>" + 
			        "        <APPLINEINFO>2,0</APPLINEINFO>" + 
			        "        <APPLINE></APPLINE>" + 
			        "        <APPOPTION>D</APPOPTION>" + 
			        "        <NOTIFY>N,N,N,Y</NOTIFY>" + 
			        "        <KEEPFOR>1</KEEPFOR>" + 
			        "        <SECURITY>S</SECURITY>" + 
			        "        <DOCTYPE>[PIMC] 개인정보 검출관리 승인요청서</DOCTYPE>" + 
			        "        <SYSTEMGUBUN>PIMC</SYSTEMGUBUN>" + 
			        "        <FIELDLIST></FIELDLIST>" + 
			        "        <SABUN></SABUN>" + 
			        "        <NAME></NAME>" + 
			        "        <SOSOK></SOSOK>" + 
			      "        <SABUN>1107869</SABUN>" + 
			        "        <NAME>나진욱</NAME>" + 
			        "        <SOSOK>정보보호담당</SOSOK>" + 
			        "    </BODY>" + 
			        "</ROOT>", body, "");*/
			
			log.info("result XML " + result.toString());
			InputStream is = new ByteArrayInputStream(result.toString().getBytes());

			// 1. 빌더 팩토리 생성.
	        builderFactory = DocumentBuilderFactory.newInstance();
	        
	        // 2. 빌더 팩토리로부터 빌더 생성
	        builder = builderFactory.newDocumentBuilder();
	        
	        // 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
	        document = builder.parse(is);
	        document.getDocumentElement().normalize();
	     // XML 데이터 중 <person> 태그의 내용을 가져온다.
	        
	        
		}catch (Exception e) {
			params.put("resultCode", -1);
			params.put("resultMsg", "CDTS ADD ERROR");
			approvalDao.deleteProcessCharge(params);
			log.error("CDTS ADD Failed >>> " + e.toString());

			return params;
		}
		
		XPath xpath = XPathFactory.newInstance().newXPath();
		String expression = "/ROOT/BODY";
		// 지정 노드로 부터 노드목록 획득 
		NodeList nl = null; 

		String resultData = "";
		String url = "";
		
		// SKT 전자결재 결과 XML 파싱
		try { 
			nl = (NodeList) xpath.evaluate(expression, document, XPathConstants.NODESET);
			
			NodeList nodeList = nl.item(0).getChildNodes();

			for (int i = 0; i < nodeList.getLength(); i++) {
				Node node = nodeList.item(i);
				
				if (node.getNodeType() == Node.ELEMENT_NODE)
				{ 
					log.info("Element Node Node Name = " + node.getNodeName()); 
					log.info("Element Node Text Content = " + node.getTextContent()); 
					if(node.getNodeName().equals("RESULTCODE")) {
						resultData = node.getTextContent();
					}
					
					if(node.getNodeName().equals("DOCURL")) {
						url = node.getTextContent();
						params.put("url", url);
					}
					
				} 

			}

		} catch (XPathExpressionException e) {
			params.put("resultCode", -1);
			params.put("resultMsg", "전자결재 XML 파싱 오류");
			approvalDao.deleteProcessCharge(params);
			log.info(e.toString()); 

			return params;
		}
		
		// 전자 결재 성공 시
		if("SUCCESS".equals(resultData.toUpperCase())){

			approvalDao.updateProcessCharge(params);

			params.put("resultCode", 220);
			params.put("resultMsg", "전자결재 생성 완료");
			
		} else { // 전자 결재 생성 실패
			params.put("resultCode", -1);
			params.put("resultMsg", "전자결재 생성 실패");

			approvalDao.deleteProcessCharge(params);
			return params;
		}

		
		return params;
	}
	
	@Override
	public HashMap<String, Object>  registProcessCharge2(HashMap<String, Object> params) throws Exception
	{
		// 전자결재 RETURN 값 파싱
		DocumentBuilderFactory builderFactory = null;
		DocumentBuilder builder = null;
		Document document = null;
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);
		
		params.put("resultCode", 0);
		
		Map<String, Object> map = approvalDao.selectProcessingSeq(params);
		int index = Integer.parseInt(map.get("ID").toString());
		String approvalID = map.get("ID_LENGTH").toString();
		String user_name = map.get("USER_NAME").toString();
		String regdate = map.get("REGDATE").toString();
		
		//List<String> idxList = (List<String>)params.get("idxList");
		List<HashMap<String, Object>> mapCount = approvalDao.selectApprovalCount(params);
		
		String IFIDVALUE = "PIMC" + regdate + approvalID;
		
		params.put("index", (index+1));
		params.put("IFIDVALUE", IFIDVALUE);
		approvalDao.insertProcessingSeq(params);
		
		// 결재 생성
		approvalDao.registProcessCharge(params);
		String approvalUser = params.get("ok_user_no").toString();
		// String comment = "<pre>&nbsp;&nbsp;- " + params.get("comment").toString() + "</pre>";
		String comment = params.get("comment").toString();
		String approvalNo = params.get("today") + "_" + params.get("user_no")+ "_" + params.get("doc_seq");
		// String result = "";
		
		StringBuilder sb = new StringBuilder();
		StringBuilder body = new StringBuilder();
		
		body.append("<html>");
		body.append("<head>");
		body.append("<style>");
		body.append(".approval { border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".result { text-align: right; border: 1px solid #DFDFE6; padding: 5px; }");
		body.append(".font_color { color: blue;}");
		body.append(".font_family {font-size:14px; white-space: pre-wrap;}");
		body.append("</style>");
		body.append("</head>");
		body.append("<body>");
		body.append("<div class='approval_div'>");
		body.append("<br><p>&nbsp;- 개인정보보호법 및 그룹 보안가이드라인 준수를 위해 전사 서버 내 임의 보관/저장된 <br> &nbsp;&nbsp;&nbsp;개인정보를 정기 검출하여 필요한 보호 조치를 수행하고 있습니다.</p>");
		body.append("<p>&nbsp;- 서버 개인정보 검출 과정에서 확인된 파일들에 대해 삭제/암호화/예외처리 적용을  <br> &nbsp;&nbsp;&nbsp;진행하고자 하오니, 상세내용 확인 후 승인하여 주시기 바랍니다.</p>");
		body.append("<b><p>&nbsp;1) 조지계획 등록자</p></b>");
		body.append("<p style='padding-left: 17px;'>- " + user_name +"</p>");
		body.append("<b><p>&nbsp;2) 조치계획 의견</p></b>");
		body.append("<p style='padding-left: 17px; white-space: pre-wrap; width: 627px;'>- " + comment + "</p>");
		body.append("<b><p>&nbsp;3) 문서번호</p></b>");
		body.append("<p style='padding-left: 17px;'>- " + approvalNo + "</p>");
		body.append("<br>");
		body.append("<b>상세내용 : <a href='https://pimc.sktelecom.com/approval/pi_search_approval_list' target='_blank'><span style='color: #0000FF;'>PIMC 개인정보 검출 결과 상세보기</span></a></b>");
		body.append("<div style='padding-top:20px;'>");
		body.append("<table style='width: 480px; border: 1px solid #DFDFE6; border-collapse: collapse; font-size:14px; font-family:'Noto Sans KR';'>");
		body.append("<thead><tr><th class='approval'>호스트명</th><th class='approval'>유형</th><th class='approval'>파일수</th></tr></thead>");
		body.append("<tr>");
		for(int i = 0; i < mapCount.size(); i++) {
			body.append("<td class='approval'>"+mapCount.get(i).get("NAME")+"</td>");
			body.append("<td class='approval'>"+mapCount.get(i).get("PROCESSING_FLAG_NAME")+"</td>");
			body.append("<td class='result'>"+ mapCount.get(i).get("RESULT_CNT")+"</td></tr>");
			
		}
		body.append("</tr>");
		body.append("</table>");
		body.append("</div>");
		body.append("</div>");
		body.append("</body>");
		body.append("</html>");
		
		/*JSONObject apprObject = new JSONObject();
		
		apprObject.put("AcceptKey", "UElNQzEwMTQ4MzE0NDA=");
		
		apprObject.put("IFID", IFIDVALUE);
		
		// Info Start
		JSONObject infoObject = new JSONObject();
		infoObject.put("DocTitle", "개인정보 검출관리 승인요청서(" + approvalNo + ")");
		infoObject.put("DraftOption", "T");
		infoObject.put("ArchiveTerm", "3");
		infoObject.put("SecurityLevel", "GS");
		infoObject.put("Body", body.toString());
		// Info End
		// Notify Start
		JSONObject notifyObject = new JSONObject();
		notifyObject.put("Emergency", false);
		notifyObject.put("Mail", true);
		notifyObject.put("Sms", false);
		notifyObject.put("NateonBiz", false);
		// Notify End
		// Line Start
		JSONArray lineArr = new JSONArray();
		JSONObject lineObject = new JSONObject();
		lineObject.put("LineType", "1000");
		lineObject.put("ApvType", "1000");
		lineObject.put("StepOrder", "0001");
		lineObject.put("UserId", approvalUser);
		lineObject.put("DeptId", "00004567");
		lineArr.add(lineObject);
		// Line End
		// Recp Start
		JSONArray recpArr = new JSONArray();
		JSONObject recpObject = new JSONObject();
		recpObject.element("DeptId", "00004567");
		recpArr.add(recpObject);
		// Recp End
		// Ref Start
		JSONArray refArr = new JSONArray();
		JSONObject refObject = new JSONObject();
		refObject.put("DeptId", "");
		refArr.add(refObject);
		// Ref End
		// Attachment Start
		JSONArray attArr = new JSONArray();
		JSONObject attObject = new JSONObject();
		attObject.put("FileId", "");
		attObject.put("FileName", "");
		attObject.put("DownloadUrl", "");
		// Ext Start
		JSONObject extObject = new JSONObject();
		extObject.put("NOTICE", false);
		// Ext End
		apprObject.put("Info", infoObject);
		apprObject.put("Notify", notifyObject);
		apprObject.put("Line", lineArr);
		apprObject.put("Recp", recpArr);
		apprObject.put("Ref", refArr);
		apprObject.put("Attachment", attArr);
		apprObject.put("Ext", extObject);
		
		
		log.info("appr >> " + apprObject.toString());*/
		
		URL url = null;
	    StringBuilder buffer = null;
	    BufferedReader bufferedReader = null;
	    BufferedWriter bufferedWriter = null;
	    HttpURLConnection urlConnection = null;
	    
	    String apiUrl = "http://edms.sktelecom.com/api/Document/Request/PIMC/PIMC001";
	    
	   /* try {
	    	url = new URL(apiUrl);
	        
	        urlConnection = (HttpURLConnection) url.openConnection();
	        
	        urlConnection.setRequestMethod("POST");
	        urlConnection.setConnectTimeout(5000);
	        urlConnection.setReadTimeout(5000);
	        
	        urlConnection.setRequestProperty("Accept", "application/json");
	        urlConnection.setRequestProperty("Content-Type", "application/json; utf-8");
	        
	        urlConnection.setDoInput(true);
	        urlConnection.setDoOutput(true);
	        
	        try(OutputStream os = urlConnection.getOutputStream()) {
	            byte[] input = apprObject.toString().getBytes("utf-8");
	            os.write(input, 0, input.length);			
	        }
	        //bufferedWriter.flush();
	        
	        buffer = new StringBuilder();
	        if(urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) 
	        {
	            bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
	            String readLine = null;
	            while((readLine = bufferedReader.readLine()) != null) 
	            {
	                buffer.append(readLine).append("\n");
	                log.info("readLine >> " + readLine);
	            }
	            bufferedReader.close();
	            
	            
	            buffer.append("\"code\" : \""+urlConnection.getResponseCode()+"\"");
	            buffer.append(", \"message\" : \""+urlConnection.getResponseMessage()+"\"");
	            
	            log.info("TEST >> " + buffer.toString());
	            
	            params.put("buffer", buffer.toString());
	            approvalDao.updateProcessCharge(params);
				
				params.put("resultCode", 220);
				params.put("resultMsg", "전자결재 생성 완료");
	        }
	        else 
	        {
	            buffer.append("\"code\" : \""+urlConnection.getResponseCode()+"\"");
	            buffer.append(", \"message\" : \""+urlConnection.getResponseMessage()+"\"");
	            
	            params.put("resultCode", -1);
				params.put("resultMsg", "전자결재 생성 실패");
				
				log.info("TEST >> " + buffer.toString());
				
				approvalDao.deleteProcessCharge(params);
				return params;
	        }
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
	        try {
	            if (bufferedWriter != null) { bufferedWriter.close(); }
	            if (bufferedReader != null) { bufferedReader.close(); }
	        } catch(Exception ex) { 
	            ex.printStackTrace();
	        }
	    }*/
		
		return params;
	}

	@Override
	public void updateProcessStatus(HashMap<String, Object> params, Map<String, Object> chargeMap) throws Exception
	{
		log.info("updateProcessStatus 로그체크 1");

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> idxList = (List<String>)params.get("idxList");

		/*Object charge_id = chargeMap.get("data_processing_charge_id");
		if(charge_id == null || "".equals(charge_id.toString())) {
			charge_id = approvalDao.selectDataProcessingChargeId(params);
		}*/
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.size(); i++) 
		{
			map.put("idx", idxList.get(i));
			map.put("user_no", user_no);
			map.put("ok_user_no", params.get("ok_user_no"));
			map.put("apprType", params.get("apprType"));
			map.put("data_processing_charge_id", chargeMap.get("DATA_PROCESSING_CHARGE_ID"));
			map.put("data_processing_group_id", params.get("groupId"));
			map.put("comment", params.get("comment"));

			approvalDao.updateProcessingGroupStatus(map);
			approvalDao.updateProcessingStatus(map);
		}
	}
	
	@Override
	public void approvalPlus(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		approvalDao.approvalPlus(params);
	}

	/**
	 * 정탐/오탐 결재 리스트
	 */
	@Override
	public List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);

		return approvalDao.searchApprovalAllListData(params);
	}

	/**
	 * 정탐/오탐 결재 리스트
	 */
	@Override
	public List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);

		return approvalDao.searchApprovalListData(params);
	}

	/**
	 * 정탐/오탐 결재 리스트 - 조회
	 */
	@Override
	public List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		String charge_id = (String)params.get("CHARGE_ID_LIST");
		List<String> charge_id_list = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id,",");
			while(st.hasMoreTokens()) {
				charge_id_list.add(st.nextToken());
			}
		}

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);
		params.put("charge_id_list", charge_id_list);

		return approvalDao.selectProcessGroupPath(params);
	}

	/**
	 * 정탐/오탐 결재 리스트 - 결재
	 */
	@Override
	public void updateProcessApproval(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String charge_id = (String)params.get("chargeIdList");

		List<String> chargeIdList = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id, ",");
			while(st.hasMoreTokens()) {
				chargeIdList.add(st.nextToken());
			}
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> group = null;
		for (int i = 0; i < chargeIdList.size(); i++) 
		{
			map.put("chargeIdList", chargeIdList.get(i));
			map.put("user_no",  user_no);
			map.put("apprType", params.get("apprType"));
			map.put("reason",   params.get("reason"));

			group = approvalDao.selectDataProcessingGroupId(map);

			approvalDao.updateProcessApproval(map);
			for (int j = 0; j < group.size(); j++) {
				map.put("group_id", group.get(j).get("GROUP_ID"));
				approvalDao.updateDataProcessing(map);
			}
		}
		
	}

	/**
	 * 오탐 2차 결재 리스트 - 결재
	 */
	@Override
	public void updateProcessApprovalAdminTwo(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String charge_id = (String)params.get("chargeIdList");
		String excepter = (String)params.get("excepterList");

		List<String> chargeIdList = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id, ",");
			while(st.hasMoreTokens()) {
				chargeIdList.add(st.nextToken());
			}
		}
		
		List<String> excepterList = new ArrayList<>();
		if(excepter != null && !"".equals(excepter)) {
			StringTokenizer st = new StringTokenizer(excepter, ",");
			while(st.hasMoreTokens()) {
				excepterList.add(st.nextToken());
			}
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> group = null;
		for (int i = 0; i < chargeIdList.size(); i++) 
		{
			map.put("chargeIdList", chargeIdList.get(i));
			map.put("apprType", params.get("apprType"));
			map.put("user_no",  user_no);
			map.put("reason",   params.get("reason"));

			group = approvalDao.selectDataProcessingGroupId(map);

			approvalDao.updateProcessApproval(map);
			for (int j = 0; j < group.size(); j++) {
				map.put("group_id", group.get(j).get("GROUP_ID"));
				approvalDao.updateDataProcessing(map);
			}
		}
	}

	/**
	 * 정탐/오탐 결재 리스트 - 재검색 스캔정보
	 */
	@Override
	public List<HashMap<String, Object>> selectScanPolicy() throws Exception
	{
		return approvalDao.selectScanPolicy();
	}

	/**
	 * 정탐/오탐 결재 리스트 - 재검색 선택 Target 정보
	 */
	@Override
	public List<HashMap<String, Object>> selectReScanTarget(HashMap<String, Object> params) throws Exception
	{
		List<String> group_list = (List<String>)params.get("groupList");
		params.put("group_list", group_list);

		return approvalDao.selectReScanTarget(params);
	}

	@Override
	public void deleteItem(HashMap<String, Object> params) throws Exception {
		
		List<String> idxList = (List<String>)params.get("idxList");

		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.size(); i++) 
		{
			map.put("idx", idxList.get(i));
			approvalDao.deleteItem(map);
		}
		
	}

}