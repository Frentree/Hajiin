package com.org.iopts.report.controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.common.usermodel.HyperlinkType;
import org.apache.poi.hssf.usermodel.HSSFCreationHelper;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Hyperlink;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.report.service.piSummaryService;
import com.org.iopts.report.vo.ReportChunk;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/report")
@Configuration
@PropertySource("classpath:/property/config.properties")
public class piSummaryController {

	private static Logger log = LoggerFactory.getLogger(piSummaryController.class);

	@Inject
	private Pi_UserService userService;

	@Inject
	private piSummaryService service;
	
	@Value("${recon.id}")
    	private String recon_id;

	 @Value("${recon.api.version}")
	 	private String recon_version;

	@Value("${excel.url}")
 		private String excel_url;
 
	 @Value("${excel.url2}")
	 	private String excel_url2;
	 
	 @Value("${excel.file.path}")
		private String excel_path;
	 
	 @Value("${excel.count}")
		private int excel_CNT;

	
	/*
	 * 
	 */
	@RequestMapping(value = "/pi_report_summary", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_search_list (Model model) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportAppr");

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);		
		
		// OFFICE 정보 가져오기 (조회조건 팀명 구성용)
//		List<Map<String, Object>> accountOfficeList = userService.selectAccountOfficeList();
//		model.addAttribute("accountOfficeList", accountOfficeList);
		
		// 정탐/오탐 처리 flag 가져오기 (조회조건 처리구분 구성용)
		List<HashMap<String, Object>> dataProcessingFlagList = service.searchDataProcessingFlag();
		model.addAttribute("dataProcessingFlagList", dataProcessingFlagList);
		
		// 연도 구하기
		List<String> yearList = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR)-9;
		for(int i=0; i<10; i++) {
			yearList.add((year+i)+"");
		}
		model.addAttribute("monthly_year", yearList);
		model.addAttribute("monthly_month", (calendar.get(Calendar.MONTH)+1)+"");
		
		//return "/report/pi_report_summary";
		return "/report/pi_report_summary_skt";
	}
	
	@RequestMapping(value = "/pi_report_summary3", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_search_list2 (Model model) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportAppr");
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);		
		
		// OFFICE 정보 가져오기 (조회조건 팀명 구성용)
		List<Map<String, Object>> accountOfficeList = userService.selectAccountOfficeList();
		model.addAttribute("accountOfficeList", accountOfficeList);
		
		// 정탐/오탐 처리 flag 가져오기 (조회조건 처리구분 구성용)
		List<HashMap<String, Object>> dataProcessingFlagList = service.searchDataProcessingFlag();
		model.addAttribute("dataProcessingFlagList", dataProcessingFlagList);
		
		// 연도 구하기
		List<String> yearList = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR)-9;
		for(int i=0; i<10; i++) {
			yearList.add((year+i)+"");
		}
		model.addAttribute("monthly_year", yearList);
		model.addAttribute("monthly_month", (calendar.get(Calendar.MONTH)+1)+"");
		
		return "/report/pi_report_summary";		
	}
	
	@RequestMapping(value = "/pi_report_manager", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_report_manager (Model model) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportMana");

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);		
		
		// OFFICE 정보 가져오기 (조회조건 팀명 구성용)
		List<Map<String, Object>> accountOfficeList = userService.selectAccountOfficeList();
		model.addAttribute("accountOfficeList", accountOfficeList);
		
		// 정탐/오탐 처리 flag 가져오기 (조회조건 처리구분 구성용)
		List<HashMap<String, Object>> dataProcessingFlagList = service.searchDataProcessingFlag();
		model.addAttribute("dataProcessingFlagList", dataProcessingFlagList);
		
		// 연도 구하기
		List<String> yearList = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR)-9;
		for(int i=0; i<10; i++) {
			yearList.add((year+i)+"");
		}
		model.addAttribute("monthly_year", yearList);
		model.addAttribute("monthly_month", (calendar.get(Calendar.MONTH)+1)+"");
		
		//return "/report/pi_report_manager";		
		return "/report/pi_report_manager";		
	}
	
	@RequestMapping(value = "/pi_report_manager2", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_report_manager2 (Model model) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportMana");

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);		
		
		// OFFICE 정보 가져오기 (조회조건 팀명 구성용)
		List<Map<String, Object>> accountOfficeList = userService.selectAccountOfficeList();
		model.addAttribute("accountOfficeList", accountOfficeList);
		
		// 정탐/오탐 처리 flag 가져오기 (조회조건 처리구분 구성용)
		List<HashMap<String, Object>> dataProcessingFlagList = service.searchDataProcessingFlag();
		model.addAttribute("dataProcessingFlagList", dataProcessingFlagList);
		
		// 연도 구하기
		List<String> yearList = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR)-9;
		for(int i=0; i<10; i++) {
			yearList.add((year+i)+"");
		}
		model.addAttribute("monthly_year", yearList);
		model.addAttribute("monthly_month", (calendar.get(Calendar.MONTH)+1)+"");
		
		return "/report/pi_report_manager";		
	}

	// 
	@RequestMapping(value="/searchSummaryList", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchSummaryList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		params.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));			// 사용자
		
		List<HashMap<String, Object>> searchList = service.searchSummaryList(params);

		return searchList;
	}
	
	// select download data
	@RequestMapping(value="/getMonthlyReport", method= {RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> getMonthlyReport(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("getDownloadData START");
		
		List<HashMap<String, Object>> reportList = service.getMonthlyReport(params);
		
		return reportList;
	}
	
	@RequestMapping(value="/personNotCom", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> personNotCom(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			log.info("personNotCom");
			
//			resultList = service.selectPersonNotCom();

			List<Map<String, Object>> test = service.selectPersonNotCom();
			for(int i=0; i<test.size(); i++) {
				Map<String, Object> map = test.get(i);
				map.put("NOTCOMCNT", new Random().nextInt(10));
				resultList.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*Map<String, Object> datatypesList = dashservice.selectDatatypes(request);
		return datatypesList;*/
		return resultList;
    }
	
	@RequestMapping(value="/teamNotCom", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> teamNotCom(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			log.info("teamNotCom");
			
			//resultList = service.selectTeamNotCom();
			
			List<Map<String, Object>> test = service.selectTeamNotCom();
			for(int i=0; i<test.size(); i++) {
				Map<String, Object> map = test.get(i);
				map.put("NOTCOMCNT", 10-i);
				resultList.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	@RequestMapping(value="/selectOwnerList", method={RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> selectOwnerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			log.info("selectOwnerList");
			
			log.info(request.getParameter("target"));
			
			Map<String, Object> map = new HashMap<>();
			map.put("target_id", request.getParameter("target"));
			resultList = service.selectOwnerList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	// 엑셀 다운로드 
	@RequestMapping(value="/getExcelDownCNT", method= {RequestMethod.POST})
	public @ResponseBody Map<String, Object> getExcelDownCNT(@RequestBody HashMap<String, Object> params, HttpServletRequest request) throws Exception 
	{
		log.info("getExcelDownCNT START");
		log.info("Tid" + params.get("tid").toString());
		Map<String, Object> report = new HashMap<>();
		
		try {
			report = service.getExcelDownCNT(params);
		} catch (Exception e) {
			// TODO: handle exception
		}
		// 항목 조회
		// List<Map<String, Object>> resultList = service.selectReportTargetList(params, request);
		
		return report;
	}
	
	// kb 엑셀 다운로드(상세)
		@RequestMapping(value = "/excelDown", method= {RequestMethod.POST})
		@SuppressWarnings("finally")
		public @ResponseBody void excelDown(HttpServletResponse response, HttpServletRequest request) throws Exception {
			
			int count = 0;
			String fileName = request.getParameter("detailFileName");
			
			log.info("Export File Name " + fileName);
			
			StringBuffer sb = new StringBuffer();
			FileReader fileReader = null;
			// 입력 버퍼 생성
			BufferedReader bufferedReader = null;
			
			try {
				fileReader = new FileReader(fileName);
				bufferedReader = new BufferedReader(fileReader);
				String line = "";
				while((line = bufferedReader.readLine()) != null ){ // 파일 내 문자열을 1줄씩 읽기 while
					sb.append(line);
				}
				
				//.readLine()은 끝에 개행문자를 읽지 않는다.            
				bufferedReader.close();
				
			} catch (IOException e) {
				log.error(e.toString());
			}
			
			log.info("Detail Data >>> " + (sb.toString() != null && !sb.toString().equals("") ));
			
			if(sb.toString().equals("") || sb == null) {
				response.setContentType("text/html; charset=UTF-8");
	    		PrintWriter out = response.getWriter();

	    		out.println("<script language='javascript'>");
	    		out.println("alert('데이터가 없습니다')");
	    		out.println("history.back(-1)");
	    		out.println("</script>");

	    		out.flush();
			}
			
			// 항목 조회
			/*List<Map<String, Object>> resultList = service.selectReportTargetList(request);*/
			
			List<Map<String, Object>> resultList = JSONArray.fromObject(sb.toString());
			List<Map<String, Object>> chunkResultMap = new ArrayList<>();
			List<Map<String, Object>> matchResultMap = new ArrayList<>();
			List<Map<String, Object>> metasResultMap = new ArrayList<>();
					
			try {
				// 워크북 생성
			    Workbook wb = new HSSFWorkbook();
			    Sheet sheet = wb.createSheet("server");
			    Row row = null;
			    Cell cell = null;
			    int rowNo = 0;
		    
			    // 테이블 헤더용 스타일
			    CellStyle headStyle = wb.createCellStyle();
			    Font headerFont = wb.createFont();
			    
			    // 헤더 테두리 생성
			 /*   headStyle.setBorderTop(BorderStyle.THIN);
			    headStyle.setBorderBottom(BorderStyle.THIN);
			    headStyle.setBorderLeft(BorderStyle.THIN);
			    headStyle.setBorderRight(BorderStyle.THIN);*/
			    
			    headStyle.setFillForegroundColor(IndexedColors.CORAL.getIndex());
			    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			    
			    // 데이터는 가운데 정렬합니다.
			    headStyle.setAlignment(HorizontalAlignment.CENTER);
			    headerFont.setBold(true);
			    headStyle.setFont(headerFont);

			    // 데이터용 경계 스타일 테두리만 지정
			    CellStyle bodyStyle = wb.createCellStyle();
			    CellStyle bodyStyle2 = wb.createCellStyle();
			    
			  /*  bodyStyle.setBorderTop(BorderStyle.THIN);
			    bodyStyle.setBorderBottom(BorderStyle.THIN);
			    bodyStyle.setBorderLeft(BorderStyle.THIN);
			    bodyStyle.setBorderRight(BorderStyle.THIN);*/
			    
			    bodyStyle.setWrapText(true); // 줄바꿈
			    bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 상하 가운데 정렬
			    
			    bodyStyle2.setWrapText(true); // 줄바꿈
			    bodyStyle2.setVerticalAlignment(VerticalAlignment.CENTER); // 상하 가운데 정렬
			    bodyStyle2.setAlignment(HorizontalAlignment.CENTER); //  좌우 가운데 정렬
			    
			    HSSFFont fontRed = (HSSFFont) sheet.getWorkbook().createFont();
		        fontRed.setColor(Font.COLOR_RED);
		        fontRed.setBold(true);
		        
		        HSSFFont fontBlue = (HSSFFont) sheet.getWorkbook().createFont();
		        fontBlue.setColor(IndexedColors.BLUE.getIndex());
		        fontBlue.setBold(true);
		        
		        HSSFFont fontBlack = (HSSFFont) sheet.getWorkbook().createFont();
		        fontBlack.setColor(Font.COLOR_NORMAL);
		        
		        HSSFFont fontBoldBlack = (HSSFFont) sheet.getWorkbook().createFont();
		        fontBoldBlack.setColor(Font.COLOR_NORMAL);
		        fontBoldBlack.setBold(true);
		        
			    // 헤더 생성
			    row = sheet.createRow(rowNo++);
			    cell = row.createCell(0); cell.setCellStyle(headStyle); cell.setCellValue("호스트"); 
			    cell = row.createCell(1); cell.setCellStyle(headStyle); cell.setCellValue("IP"); 
			    cell = row.createCell(2); cell.setCellStyle(headStyle); cell.setCellValue("연결상테"); 
			    cell = row.createCell(3); cell.setCellStyle(headStyle); cell.setCellValue(" "); 
			    cell = row.createCell(4); cell.setCellStyle(headStyle); cell.setCellValue("위치"); 
			    cell = row.createCell(5); cell.setCellStyle(headStyle); cell.setCellValue("검출내역"); 
			    cell = row.createCell(6); cell.setCellStyle(headStyle); cell.setCellValue("파일소유자"); 
			    cell = row.createCell(7); cell.setCellStyle(headStyle); cell.setCellValue("파일수정일"); 
			    cell = row.createCell(8); cell.setCellStyle(headStyle); cell.setCellValue("업무당당자(정)"); 
			    cell = row.createCell(9); cell.setCellStyle(headStyle); cell.setCellValue("업무당당자(부)"); 
			    cell = row.createCell(10); cell.setCellStyle(headStyle); cell.setCellValue("검출수"); 
			    cell = row.createCell(11); cell.setCellStyle(headStyle); cell.setCellValue("주민번호"); 
			    cell = row.createCell(12); cell.setCellStyle(headStyle); cell.setCellValue("주민번호패턴"); 
			    cell = row.createCell(13); cell.setCellStyle(headStyle); cell.setCellValue("외국인번호"); 
			    cell = row.createCell(14); cell.setCellStyle(headStyle); cell.setCellValue("외국인번호패턴"); 
			    cell = row.createCell(15); cell.setCellStyle(headStyle); cell.setCellValue("여권번호"); 
			    cell = row.createCell(16); cell.setCellStyle(headStyle); cell.setCellValue("여권번호패턴"); 
			    cell = row.createCell(17); cell.setCellStyle(headStyle); cell.setCellValue("운전번호"); 
			    cell = row.createCell(18); cell.setCellStyle(headStyle); cell.setCellValue("운전번호패턴"); 
			    cell = row.createCell(19); cell.setCellStyle(headStyle); cell.setCellValue("계좌번호"); 
			    cell = row.createCell(20); cell.setCellStyle(headStyle); cell.setCellValue("계좌번호패턴"); 
			    cell = row.createCell(21); cell.setCellStyle(headStyle); cell.setCellValue("카드번호"); 
			    cell = row.createCell(22); cell.setCellStyle(headStyle); cell.setCellValue("카드번호패턴"); 
			    cell = row.createCell(23); cell.setCellStyle(headStyle); cell.setCellValue("이메일");
			    cell = row.createCell(24); cell.setCellStyle(headStyle); cell.setCellValue("이메일패턴");
			    cell = row.createCell(25); cell.setCellStyle(headStyle); cell.setCellValue("휴대폰"); 
			    cell = row.createCell(26); cell.setCellStyle(headStyle); cell.setCellValue("휴대폰패턴"); 
			    cell = row.createCell(27); cell.setCellStyle(headStyle); cell.setCellValue("비고"); 
			   
	    		// metaData 저장
	    		String con_Data = "";
	    		int totalChunkLength = 0;
	    		
			    if(resultList != null) {
			    	for(int i=0 ; i < resultList.size() ; i++) {
					    // 색칠할 위치 저장
			    		List<ReportChunk> chunkList = new ArrayList<>();
			    		
			    		String chk = (String)resultList.get(i).get("CHK");
			    		
			    		boolean infoIDNull = false;
			    		if(chk.equals(">"))  infoIDNull = true; // 하위경로 존재 O
						else infoIDNull = false; // 하위경로 존재 X
			    		
			    		chunkResultMap = new ArrayList<>();
			    		matchResultMap = new ArrayList<>();
			    		metasResultMap = new ArrayList<>();
			    		String result = "";
			    		
			    		List<String> con = new ArrayList<>();
			    		List<String> match_con = new ArrayList<>();
			    		List<String> match_length = new ArrayList<>();
			    		List<String> match_offset = new ArrayList<>();
			    		List<String> chunks_offset = new ArrayList<>();
			    		List<String> chunks_length = new ArrayList<>();
			    		
			    		String modifiedDT = (String)resultList.get(i).get("Modified_Date");
			    		int Month = 0;
			    		// 색칠할 length & offset
			    		
			    		if(modifiedDT != null) {
			    			
			    			if(modifiedDT.toUpperCase().equals("JAN")) {
			    				Month = 1;
			    			}else if(modifiedDT.toUpperCase().equals("FEB")) {
			    				Month = 2;
			    			}else if(modifiedDT.toUpperCase().equals("MAR")) {
			    				Month = 3;
			    			}else if(modifiedDT.toUpperCase().equals("APR")) {
			    				Month = 4;
			    			}else if(modifiedDT.toUpperCase().equals("MAY")) {
			    				Month = 5;
			    			}else if(modifiedDT.toUpperCase().equals("JUN")) {
			    				Month = 6;
			    			}else if(modifiedDT.toUpperCase().equals("JUL")) {
			    				Month = 7;
			    			}else if(modifiedDT.toUpperCase().equals("AUG")) {
			    				Month = 8;
			    			}else if(modifiedDT.toUpperCase().equals("SEP")) {
			    				Month = 9;
			    			}else if(modifiedDT.toUpperCase().equals("OCT")) {
			    				Month = 10;
			    			}else if(modifiedDT.toUpperCase().equals("NOV")) {
			    				Month = 11;
			    			}else {
			    				Month = 12;
			    			}
			    			String day =  modifiedDT.substring(5, 7);
			    			String year =  modifiedDT.substring(8, 12);
			    			String time =  modifiedDT.substring(13);
			    			
			    			modifiedDT = year + "-" +Month + "-" + day + " " + time;
			    		}else {
			    			modifiedDT = "0000-00-00 00:00";
			    		}
			    		
			    		matchResultMap =  (List<Map<String, Object>>) resultList.get(i).get("matchResultList");
			    		chunkResultMap=  (List<Map<String, Object>>) resultList.get(i).get("chunksResultList");
			    		metasResultMap =  (List<Map<String, Object>>) resultList.get(i).get("metasResultList");

			    		// 해당 match 데이터 위치를 저장함
			    		int save_meta_index = 0;
			    		// 다음 데이터 Content 초기화
			    		con_Data = "";
			    		// 전체 Length를 저장함
	    				int memory_index = 0;
	    				int data_index = -1;
	    				String data_type = "";
	    				String memory_DataTypeCon = "";
	    				totalChunkLength = 0;
	    				
	    				String type1_con = ""; // 주민번호
			    		String type2_con = ""; // 외국인번호
			    		String type3_con = ""; // 여권번호
			    		String type4_con = ""; // 운전번호
			    		String type5_con = ""; // 계좌번호
			    		String type6_con = ""; // 카드번호
			    		String type7_con = ""; // 이메일
			    		String type8_con = ""; // 휴대폰번호
			    		
			    		int type1_chk = 0; 	// 주민번호
			    		int type2_chk = 0; 	// 외국인번호
			    		int type3_chk = 0; 	// 여권번호
			    		int type4_chk = 0; 	// 운전번호
			    		int type5_chk = 0; 	// 계좌번호
			    		int type6_chk = 0; 	// 카드번호
			    		int type7_chk = 0; 	// 이메일
			    		int type8_chk = 0; 	// 휴대폰번호
	    				
	    				//log.info("chunkResultMap.size() >>>>> " + chunkResultMap.size());
			    		int cnt = 0;
		    			for(int chunk_index=0 ; chunk_index < chunkResultMap.size() ; chunk_index++) {
		    				int chunkOffset = Integer.parseInt((String)chunkResultMap.get(chunk_index).get("chunks_offset"));
		    				int chunkLength = Integer.parseInt((String)chunkResultMap.get(chunk_index).get("chunks_length"));  // 검출된 데이터 길이
		    				String chunkData = chunkResultMap.get(chunk_index).get("chunks_CON").toString();
		    				totalChunkLength = totalChunkLength +chunkLength;
		    				
		    				String replaceConLine = chunkData.replaceAll("\\r\\n", "\n");
		    				if(cnt == 0) {
		    					con_Data += replaceConLine;
		    				}else if(cnt < 6) {
		    					con_Data += ", \n"+replaceConLine ;
		    				}
		    				++cnt;

		    				//int length_cnt = 0;
		    				
		    				for(int meta_index = save_meta_index; meta_index < matchResultMap.size(); meta_index++) {
		    					int contentOffset =  Integer.parseInt((String)matchResultMap.get(meta_index).get("match_offset"));
		    					int conLength = Integer.parseInt((String)matchResultMap.get(meta_index).get("match_length")); 
		    					String conData = (String)matchResultMap.get(meta_index).get("match_CON"); 
		    					String conDataType = (String)matchResultMap.get(meta_index).get("match_Type"); 
		    					String replaceConData = "";
			    				if(conDataType.toUpperCase().contains("SOUTH KOREAN RRN")) {
			    					// 뒤에 4자리 마스킹
			    					replaceConData = conData.replaceAll(".{4}$", "####");
			    					if(type1_chk == 6) {
			    						type1_con += "...";
			    					}else if(type1_con.equals("")) {
			    						type1_con += replaceConData;
			    					}else if(type1_chk < 6) {
			    						type1_con += " , \n"+replaceConData;
			    					}
			    					++type1_chk;
			    				}else if(conDataType.toUpperCase().contains("SOUTH KOREAN FOREIGNER NUMBER")) {
			    					// 뒤에 6자리 마스킹
			    					replaceConData = conData.replaceAll(".{6}$", "######");
			    					if(type2_chk == 6) {
			    						type2_con += "...";
			    					}else if(type2_con.equals("")) {
			    						type2_con += replaceConData;
			    					}else if(type2_chk < 6) {
			    						type2_con += " , \n"+replaceConData;
			    					}
			    					++type2_chk;
			    				}else if(conDataType.toUpperCase().contains("SOUTH KOREAN PASSPORT")) {
			    					// 뒤에 4자리 마스킹
			    					replaceConData = conData.replaceAll(".{4}$", "####");
			    					if(type3_chk == 6) {
			    						type3_con += "...";
			    					}else if(type3_con.equals("")) {
			    						type3_con += replaceConData;
			    					}else if(type3_chk < 6) {
			    						type3_con += " , \n"+replaceConData;
			    					}
			    					++type3_chk;
			    				}else if(conDataType.toUpperCase().contains("SOUTH KOREAN DRIVER LICENSE NUMBER")) {
			    					// 뒤에 6자리 마스킹
			    					replaceConData = conData.replaceAll(".{6}$", "######");
			    					if(type4_chk == 6) {
			    						type4_con += "...";
			    					}else if(type4_con.equals("")) {
			    						type4_con += replaceConData;
			    					}else if(type4_chk < 6) {
			    						type4_con += " , \n"+replaceConData;
			    					}
			    					++type4_chk;
			    				}else if(conDataType.toUpperCase().contains("ACCOUNT NUMBER")) {
			    					// 뒤에 6자리 마스킹
			    					replaceConData = conData.replaceAll(".{6}$", "######");
			    					if(type5_chk == 6) {
			    						type5_con += "...";
			    					}else if(type5_con.equals("")) {
			    						type5_con += replaceConData;
			    					}else if(type5_chk < 6) {
			    						type5_con += " , \n"+replaceConData;
			    					}
			    					++type5_chk;
			    				}else if(conDataType.toUpperCase().contains("EMAIL")) {
			    					// 앞 2자리 제외하고 @ 앞 까지
			    					replaceConData = conData.replaceAll("(?<=.{3}).(?=.*@)", "#");
			    					if(type7_chk == 6) {
			    						type7_con += "...";
			    					}else if(type7_con.equals("")) {
			    						type7_con += replaceConData;
			    					}else if(type7_chk < 6) {
			    						type7_con += " , \n"+replaceConData;
			    					}
			    					++type7_chk;
			    				}else if(conDataType.toUpperCase().contains("SOUTH KOREAN MOBILE PHONE NUMBER")) {
			    					// 뒤에 4자리 마스킹
			    					replaceConData = conData.replaceAll(".{4}$", "####");
			    					if(type8_chk == 6) {
			    						type8_con += "...";
			    					}else if(type8_con.equals("")) {
			    						type8_con += replaceConData;
			    					}else if(type8_chk < 6) {
			    						type8_con += " , \n"+replaceConData;
			    					}
			    					++type8_chk;
			    				}else if(conDataType.toUpperCase().contains("VISA") || conDataType.toUpperCase().contains("MAESTRO") || conDataType.toUpperCase().contains("PRIVATE LABEL CARD") || conDataType.toUpperCase().contains("DINERS CLUB") || conDataType.toUpperCase().contains("JCB") ||
			    						conDataType.toUpperCase().contains("LASER") || conDataType.toUpperCase().contains("CHINA UNION PAY") || conDataType.toUpperCase().contains("DISCOVER") || conDataType.toUpperCase().contains("TROY") || conDataType.toUpperCase().contains("MASTERCARD") || conDataType.toUpperCase().contains("AMERICAN EXPRESS")) {
			    					
			    					replaceConData = conData;
			    					if(type6_chk == 6) {
			    						type6_con += "...";
			    					}else if(type6_con.equals("")) {
			    						type6_con += conData;
			    					}else if(type6_chk < 6) {
			    						type6_con += " , \n"+conData;
			    					}
			    					++type6_chk;
			    				}
			    				
			    				
			    				con_Data = con_Data.replace(conData, replaceConData);
			    				
		    					// 해당 chunk Content 안에 데이터가 있는지 확인
		    					boolean isMeta = (chunkOffset <= contentOffset) && (contentOffset <= (chunkOffset + chunkLength));
		    				
		    					// Content Data 안에 색칠할 위치 
		    					if(isMeta) {
		    						data_index = con_Data.indexOf(replaceConData, memory_index);
		    						//log.info("data_index ::: " + data_index + ",  memory_index ::: " + memory_index + ", data_type :: " + data_type);
		    						
		    						if(data_index == -1) {
			    						continue; 
		    						}
		    						
		    						//log.info("Data Coloring :: " + meta_index);
		    						ReportChunk rc = new ReportChunk();
		    						
		    						rc.setOffset(data_index);
		    						rc.setLength(conLength);
		    						rc.setMatchCon(replaceConData);

		    						chunkList.add(rc);
		    						
		    						// 개인정보 유형이 같을 경우 다음 행부터 비교
		    						if(data_type.equals(conDataType)) memory_index = (data_index + conLength);
		    						
		    						// 중복 데이터를 위한 데이터 결과 비교 후 개인정보 유형 저장
		    						if(!memory_DataTypeCon.equals(replaceConData)) data_type = conDataType;
		    						
		    						memory_DataTypeCon = replaceConData;
		    						
		    					} else {
		    						// 해당 매치가 아닌경우 다음 chunk Con에서 아닌 부분부터 시작하기 위함
		    						save_meta_index = meta_index;
		    						break;
		    					}
		    				}
		    			}
			    		
			    		int type1 = 0; 	// 주민번호
			    		int type2 = 0; 	// 외국인번호
			    		int type3 = 0; 	// 여권번호
			    		int type4 = 0; 	// 운전번호
			    		int type5 = 0; 	// 계좌번호
			    		int type6 = 0; 	// 카드번호
			    		int type7 = 0; 	// 이메일
			    		int type8 = 0; 	// 휴대폰번호
			    		int type_total = 0; 	// 합계
			    		
			    		if(infoIDNull) { // 하위경로가 있는 경우
			    			type1 = Integer.parseInt(resultList.get(i).get("TYPE1").toString());
			    			type2 = Integer.parseInt(resultList.get(i).get("TYPE2").toString());
			    			type3 = Integer.parseInt(resultList.get(i).get("TYPE3").toString());
			    			type4 = Integer.parseInt(resultList.get(i).get("TYPE4").toString());
			    			type5 = Integer.parseInt(resultList.get(i).get("TYPE5").toString());
			    			type6 = Integer.parseInt(resultList.get(i).get("TYPE6").toString());
			    			type7 = Integer.parseInt(resultList.get(i).get("TYPE7").toString());
			    			type8 = Integer.parseInt(resultList.get(i).get("TYPE8").toString());
			    			
			    			type_total = Integer.parseInt(resultList.get(i).get("TYPE").toString());
			    			
			    		}else { // 하위경로가 없는 경우
			    			
				    		type_total = 0; 	
				    		
			    			for(int j=0 ; j < metasResultMap.size() ; j++) {
			    				String type = (String)metasResultMap.get(j).get("metas_type");
			    				
			    				if(type.toUpperCase().contains("SOUTH KOREAN RRN")) {
			    					type1 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type1;
			    				}else if(type.toUpperCase().contains("SOUTH KOREAN FOREIGNER NUMBER")) {
			    					type2 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type2;
			    				}else if(type.toUpperCase().contains("SOUTH KOREAN PASSPORT")) {
			    					type3 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type3;
			    				}else if(type.toUpperCase().contains("SOUTH KOREAN DRIVER LICENSE NUMBER")) {
			    					type4 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type4;
			    				}else if(type.toUpperCase().contains("ACCOUNT NUMBER")) {
			    					type5 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type5;
			    				}else if(type.toUpperCase().contains("EMAIL")) {
			    					type7 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type7;
			    				}else if(type.toUpperCase().contains("SOUTH KOREAN MOBILE PHONE NUMBER")) {
			    					type8 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type8;
			    				}else if(type.toUpperCase().contains("VISA") || type.toUpperCase().contains("MAESTRO") || type.toUpperCase().contains("PRIVATE LABEL CARD") || type.toUpperCase().contains("DINERS CLUB") || type.toUpperCase().contains("JCB") ||
			    						type.toUpperCase().contains("LASER") || type.toUpperCase().contains("CHINA UNION PAY") || type.toUpperCase().contains("DISCOVER") || type.toUpperCase().contains("TROY") || type.toUpperCase().contains("MASTERCARD") || type.toUpperCase().contains("AMERICAN EXPRESS")) {
			    					type6 = Integer.parseInt((String)metasResultMap.get(j).get("metas_val")); type_total += type6;
			    				}
			    			}
			    			
			    		}

			    		String PIC_url = "";
			    		
			    		if(infoIDNull) {
			    			PIC_url = excel_url+"/popup/lowPath?tid="+(String)resultList.get(i).get("target_id") + "&hash_id="+(String)resultList.get(i).get("hash_id");
			    		}else {
			    			PIC_url = excel_url+"/popup/detectionDetail?tid="+(String)resultList.get(i).get("target_id") + "&fid="+(String)resultList.get(i).get("fid");
			    		}
			    		
			    		CreationHelper createHelper = wb.getCreationHelper();
			    		HSSFCreationHelper createHelper2 = (HSSFCreationHelper)wb.getCreationHelper();
			    		
			    	    Hyperlink link = wb.getCreationHelper().createHyperlink(HyperlinkType.URL);
			    	    
			    	    link.setAddress(PIC_url);
			    	    
			    	    int resultChk = 0;
			    		
			    		row = sheet.createRow(rowNo++);
			    		row.setHeight((short)500);
			    		
			    		cell = row.createCell(0); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("host_name")); // 호스트
			    		sheet.setColumnWidth((short)0, (short)5000); // 가로 길이 지정
			    		
			    		cell = row.createCell(1); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("agent_ip")); // IP
			    		sheet.setColumnWidth((short)1, (short)4200); // 가로 길이 지정
			    		
			    		cell = row.createCell(2); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("agent_connected")); // IP 연결 상태
			    		sheet.setColumnWidth((short)2, (short)4200); // 가로 길이 지정
			    		
			    		cell = row.createCell(3); cell.setCellStyle(bodyStyle2); cell.setCellValue(chk); // fid
			    		sheet.setColumnWidth((short)3, (short)1000); // 가로 길이 지정
			    		
			    		cell = row.createCell(4); cell.setCellStyle(bodyStyle); cell.setCellValue((String)resultList.get(i).get("path")); // 위치(경로)
			    		sheet.setColumnWidth((short)4, (short)8000); // 가로 길이 지정
			    		
			    		cell = row.createCell(6); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("owner")); // 파일 소유자
			    		sheet.setColumnWidth((short)6, (short)3500); // 가로 길이 지정
			    		
			    		cell = row.createCell(7); cell.setCellStyle(bodyStyle2); cell.setCellValue(modifiedDT); // 파일 수정일
			    		sheet.setColumnWidth((short)7, (short)5000); // 가로 길이 지정
			    		
			    		cell = row.createCell(8); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("service_mngr")); // 업무담당자(정)
			    		sheet.setColumnWidth((short)8, (short)4000); // 가로 길이 지정
			    		cell = row.createCell(9); cell.setCellStyle(bodyStyle2); cell.setCellValue((String)resultList.get(i).get("service_mngr2")); // 업무담당자(부)
			    		sheet.setColumnWidth((short)9, (short)4000); // 가로 길이 지정
			    		
			    		cell = row.createCell(10); cell.setCellStyle(bodyStyle2); cell.setCellValue(type_total); // 검출 수
			    		sheet.setColumnWidth((short)10, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(11); cell.setCellStyle(bodyStyle2); cell.setCellValue(type1); // 주민번호
			    		sheet.setColumnWidth((short)11, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(12); cell.setCellStyle(bodyStyle2); cell.setCellValue(type1_con); // 주민번호(검출 데이터)
			    		sheet.setColumnWidth((short)12, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(13); cell.setCellStyle(bodyStyle2); cell.setCellValue(type2); // 외국인 번호
			    		sheet.setColumnWidth((short)13, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(14); cell.setCellStyle(bodyStyle2); cell.setCellValue(type2_con); // 외국인 번호(검출 데이터)
			    		sheet.setColumnWidth((short)14, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(15); cell.setCellStyle(bodyStyle2); cell.setCellValue(type3); // 여권 번호
			    		sheet.setColumnWidth((short)15, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(16); cell.setCellStyle(bodyStyle2); cell.setCellValue(type3_con); // 여권 번호(검출 데이터)
			    		sheet.setColumnWidth((short)16, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(17); cell.setCellStyle(bodyStyle2); cell.setCellValue(type4); // 운전 번호
			    		sheet.setColumnWidth((short)17, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(18); cell.setCellStyle(bodyStyle2); cell.setCellValue(type4_con); // 운전 번호(검출 데이터)
			    		sheet.setColumnWidth((short)18, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(19); cell.setCellStyle(bodyStyle2); cell.setCellValue(type5); // 계좌 번호
			    		sheet.setColumnWidth((short)19, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(20); cell.setCellStyle(bodyStyle2); cell.setCellValue(type5_con); // 계좌 번호(검출 데이터)
			    		sheet.setColumnWidth((short)20, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(21); cell.setCellStyle(bodyStyle2); cell.setCellValue(type6); // 카드 번호
			    		sheet.setColumnWidth((short)21, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(22); cell.setCellStyle(bodyStyle2); cell.setCellValue(type6_con); // 카드 번호(검출 데이터)
			    		sheet.setColumnWidth((short)22, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(23); cell.setCellStyle(bodyStyle2); cell.setCellValue(type7); // 이메일
			    		sheet.setColumnWidth((short)23, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(24); cell.setCellStyle(bodyStyle2); cell.setCellValue(type7_con); // 이메일(검출 데이터)
			    		sheet.setColumnWidth((short)24, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(25); cell.setCellStyle(bodyStyle2); cell.setCellValue(type8); // 휴대폰
			    		sheet.setColumnWidth((short)25, (short)2500); // 가로 길이 지정
			    		cell = row.createCell(26); cell.setCellStyle(bodyStyle2); cell.setCellValue(type8_con); // 휴대폰(검출 데이터)
			    		sheet.setColumnWidth((short)26, (short)5000); // 가로 길이 지정
			    		cell = row.createCell(27); cell.setCellStyle(bodyStyle); cell.setCellValue(""); // 비고
			    		sheet.setColumnWidth((short)27, (short)2000); // 가로 길이 지정
			    		
			    		cell = row.createCell(5); /*cell.setCellStyle(bodyStyle); cell.setCellValue(con);*/
			    		sheet.setColumnWidth((short)5, (short)9000); // 가로 길이 지정 
			    		
			    		if(con_Data.length() > 32767) {
			    			con_Data = con_Data.toString().substring(0, 32760) + " ...";
			    		}
			    		
			    		int size = 0;
			    		
			    		if(chunkResultMap != null && chunkResultMap.size() > 0) {
			    			for(int c=0; c < chunkResultMap.size() ; c++) {
			    				int chunkOffset = Integer.parseInt((String)chunkResultMap.get(c).get("chunks_offset"));
			    				int chunkLength = Integer.parseInt((String)chunkResultMap.get(c).get("chunks_length"));  // 검출된 데이터 길이
			    				for(int j=0; j < matchResultMap.size() ; j++) {
			    					
			    					int contentOffset =  Integer.parseInt((String)matchResultMap.get(j).get("match_offset"));
			    					int conLength = Integer.parseInt((String)matchResultMap.get(j).get("match_length"));

		    						boolean matchCNT = (chunkOffset <= contentOffset) && contentOffset <= (contentOffset + chunkLength);
			    					
			    					if(matchCNT) {
			    							
			    						if(excel_CNT != 0 && matchResultMap.size() > excel_CNT && excel_CNT-1 == j) {
			    							if(j==c){
			    								con_Data = con_Data.substring(0, (size+contentOffset-chunkOffset)+conLength);
			    							}else {
			    								con_Data = con_Data.substring(0, (contentOffset-chunkOffset)+conLength);
			    							}
			    						}
			    						if(j==c && excel_CNT-1 != j){
			    							size += conLength+3;
			    						}
			    						
			    					}
			    				}
			    			}
			    		}else {
			    			con_Data = "too many sub path … ";
			    		}
			    		
			    		HSSFRichTextString rich = new HSSFRichTextString(con_Data);
			    		bodyStyle.setWrapText(true);
			    		
			    		int length = 0;
			    		
			    		try {
			    			if(chunkResultMap != null && chunkResultMap.size() > 0) {
				    			List<String> result_content = new ArrayList<>(chunkResultMap.size());
				    			
				    			// log.info("chunkResultMap.size() >>>> " + chunkResultMap.size());
				    			int data_set = 0;
				    			
				    			for(int chunk = 0; chunk < chunkList.size(); chunk++) {
				    				// excel 글자 제한
				    				if(chunkList.get(chunk).getOffset()+chunkList.get(chunk).getLength() > 32767) {
				    					break;
				    				}
				    				/*rich.applyFont(chunkList.get(chunk).getOffset(), 500, fontRed);*/
				    				rich.applyFont(chunkList.get(chunk).getOffset(), chunkList.get(chunk).getOffset()+chunkList.get(chunk).getLength(), fontRed);
				    			}
				    		}else {
				    			rich.applyFont(0, con_Data.length(), fontBoldBlack); 
				    		}
						} catch (Exception e) {
							log.info("red font error_"+(String)resultList.get(i).get("host_name")+" >>> " + PIC_url );
						}
			    		cell.setCellStyle(bodyStyle);
			    		cell.setCellValue(rich);
			    	}
			    	
			    }
			    // body 생성
			    
			    Calendar cal = new GregorianCalendar(Locale.KOREA);
			    SimpleDateFormat fm = new SimpleDateFormat("yyyyMMddHHmm");
			    String toDate = fm.format(cal.getTime());

		        // 포맷 적용하기
			    // 컨텐츠 타입과 파일명 지정
			    response.setContentType("ms-vnd/excel");
			    response.setHeader("Content-Disposition", "attachment;filename=server_result_detail_"+recon_id+"_"+toDate+".xls");

			    // 엑셀 출력
			    wb.write(response.getOutputStream());
			    wb.close();
			}catch (IOException e) {
				log.info("Detail Excel Export Error :::");
				e.printStackTrace();
			}catch (Exception e) {
				log.info("Detail Excel Export Error2 :::");
				e.printStackTrace();
			}
			
		    
		}
		
		
		// 상세 보고서
	@RequestMapping(value="/reportDetailData", method={RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> reportDetailData(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response, @RequestBody HashMap<String, Object> params) throws Exception {
		log.info("reportDetailData");
		
		Map<String, Object> map = new HashMap<>();
		try {
			
			map = service.reportDetailData(request, params);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return map;
	}	
	
	@RequestMapping(value="/reportTargetList", method={RequestMethod.POST})
	@ResponseBody 
	public Map<String, Object> reportTargetList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response, @RequestBody HashMap<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		try {
			log.info("reportTargetList");
			
			result = service.reportTargetList(request, params);
			
			map.put("resultCode", 200);
			map.put("resultData", result);
			
			//map = service.reportData(params);
		} catch (Exception e) {
			map.put("resultCode", -1);
			e.printStackTrace();
		}
		return map;
	}
	
}