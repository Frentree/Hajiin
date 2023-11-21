package com.org.iopts.service; 

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.ibatis.io.Resources;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.xml.sax.SAXException;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.opencsv.CSVReader;
import com.org.iopts.dao.Pi_TargetDAO;
import com.org.iopts.dao.Pi_UserDAO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;
import com.org.iopts.util.DataUtil;
import com.org.iopts.util.ExcelSheetParser;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

//import au.com.bytecode.opencsv.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@PropertySource("classpath:/property/config.properties")

@Service
public class Pi_TargetServiceImpl implements Pi_TargetService {

	private static final Logger logger = LoggerFactory.getLogger(Pi_TargetServiceImpl.class);
	
	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;

	@Resource(name = "Pi_TargetDAO")
	private Pi_TargetDAO dao;

	@Value("${saveAttchPath}")
	private String saveAttchPath;

	@Inject
	private Pi_UserDAO userDao;

	Map<String, Object> readerMap = new HashMap<String, Object>();

	@Override
	public List<Map<String, Object>> selectTargetManagement() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTargetManage();
	}

	@Override
	public List<Map<String, Object>> selectTargetList(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub

		String host = request.getParameter("host");

		return dao.selectTargetList(host);
	}

	@Override
	public List<Map<String, Object>> selectTarget() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTargetManage();
	}

	@Override
	public List<Map<String, Object>> selectTargetUser(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String target = request.getParameter("target");
		String insa_code = SessionUtil.getSession("memberSession", "INSA_CODE");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target", target);
		map.put("insa_code", insa_code);
		map.put("ap_no", request.getParameter("ap_no"));

		return dao.selectTargetUser(map);
	}

	@Override
	@Transactional
	public void registTargetUser(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		String target = request.getParameter("target");
		String userList = request.getParameter("userList");
		String ap_no = request.getParameter("ap_no");

		JSONArray userArray = JSONArray.fromObject(userList);

		HashMap<String, Object> sqlMap = new HashMap<>();
		sqlMap.put("target_id", target);

		Map<String, Object> targetMap = dao.selectTargetById(sqlMap);

		if (userArray.size() != 0) {
			for (int i = 0; i < userArray.size(); i++) {
				JSONObject userMap = (JSONObject) userArray.get(i);
				map.put("target", target);
				map.put("user_no", userMap.getString("userNo"));
				map.put("ap_no", ap_no);
				logger.info("userNo :: " + userMap.getString("userNo"));
				logger.info("userName :: " + userMap.getString("userName"));

				// User Log 남기기
				String user_no = SessionUtil.getSession("memberSession", "USER_NO");
				ServletUtil servletUtil = new ServletUtil(request);
				String clientIP = servletUtil.getIp();
				Map<String, Object> userLog = new HashMap<String, Object>();
				userLog.put("user_no", user_no);
				userLog.put("menu_name", "CHANGE PERSON IN CHARGE");
				userLog.put("user_ip", clientIP);
				userLog.put("logFlag", "4");

				if (userMap.getString("chk").equals("1")) {
					dao.registTargetUser(map);
					userLog.put("job_info",
							"타겟담당자등록 - " + targetMap.get("NAME") + "[" + userMap.getString("userName") + "]");
				} else {
					dao.deleteTargetUser(map);
					userLog.put("job_info",
							"타겟담당자삭제 - " + targetMap.get("NAME") + "[" + userMap.getString("userName") + "]");
				}

				userDao.insertLog(userLog);
			}
		}

	}

	/**
	 * Targets Insert
	 * 
	 * @throws Exception
	 */
	@Override
	@Transactional
	public int insertTarget(List<Pi_TargetVO> list) throws Exception {
		return dao.insertTarget(list);
	}

	@Override
	public List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String host = request.getParameter("host");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();

		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("host", host);
		map = dao.selectUserTargetList(searchMap);
		return map;
	}

	@Override
	public List<Map<String, Object>> selectServerList(HttpServletRequest request) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String host = request.getParameter("host");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();

		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("host", host);
		map = dao.selectServerList(searchMap);
		return map;
	}

	@Override
	public List<Map<String, Object>> selectTargetUserList(HttpServletRequest request) throws Exception {

		String target = request.getParameter("target");

		return dao.selectTargetUserList(target);
	}

	@Override
	public List<Map<String, Object>> selectServerFileTopN(HttpServletRequest request) {
		String target = request.getParameter("target");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id", target);
		searchMap.put("user_no", user_no);

		logger.info(searchMap.toString());
		return dao.selectServerFileTopN(searchMap);
	}

	@Override
	public List<Map<String, Object>> selectAdminServerFileTopN(HttpServletRequest request) {
		String target = request.getParameter("target");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id", target);

		logger.info(searchMap.toString());
		return dao.selectAdminServerFileTopN(searchMap);
	}

	// 견본품제공 엑셀 upload
	public Map<String, Object> targetManagerUpload(HttpServletRequest request) {

		// 엑셀을 읽기 전 전처리. 엑셀의 형식 확인하고 서버에 저장. 공통 아래
		Map<String, Object> resultMap = validUploadFile(request);
		int result = Integer.parseInt((String) resultMap.get("resultCode"));
		if (result != 0) {
			return resultMap;
		}
		// 엑셀을 읽기 전 전처리 end

		// 저장대상 호스트(=서버=target_id)
		String target_id = request.getParameter("target_id").toString();

		File targetFile = new File((String) resultMap.get("FilePath"));

		System.out.println("=====================> " + targetFile.getName());

		String targetType = targetFile.getName().substring(targetFile.getName().lastIndexOf(".") + 1);

		String[][] data = null;

		if (targetType.equals("csv")) { // csv 업로드 data read

			try {

				FileInputStream csvFile = new FileInputStream(targetFile);
				// InputStreamReader readFile = new InputStreamReader(csvFile, "EUC-KR");
				InputStreamReader readFile = new InputStreamReader(csvFile, "UTF-8");
				// 한글처리 Local에선 파일로 읽어도 한글이 잘 나왔는데 서버에 올리니 서버 언어설정 //을 따라가는지 UTF-8 로 변해서 한글이
				// 깨짐... EUC-KR로 고정함.
				CSVReader reader = new CSVReader(readFile);
				CSVReader tmpReader = new CSVReader(new FileReader(targetFile));

				int colCount = tmpReader.readNext().length; // cell의 개수
				List tmpList = tmpReader.readAll(); // row개수를 알기위함
				// colCount보다 먼저 선언하면 readNext를 할수 없다.. 전부 읽어오기 때문인듯..
				int rowCount = tmpList.size() + 1; // row 개수

				if (rowCount <= 2) {
					throw new Exception("Read 할 데이터가 엑셀에 존재하지 않습니다.");
				}

				data = new String[rowCount][colCount];
				int idx = 0;
				String[] nextLine;
				while ((nextLine = reader.readNext()) != null) {
					int i = 0;
					for (String str : nextLine) {
						data[idx][i] = str;
						i++;
					}
					idx++;
				}

			} catch (Exception e) {
				System.out.println("CSVReader error : " + e.getMessage());
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File Format Exception<BR><BR>Csv 내용을 확인하세요");
				return resultMap;
			}

		} else if (targetType.equals("xls")) { // xls 업로드 data read

			/*jxl.Workbook workbook = null;
			jxl.Sheet sheet = null;

			try {
				workbook = jxl.Workbook.getWorkbook(targetFile); // 존재하는 엑셀파일 경로를 지정
				sheet = workbook.getSheet(0); // 첫번째 시트를 지정합니다.
				int rowCount = sheet.getRows(); // 총 로우수를 가져옵니다.
				int colCount = sheet.getColumns(); // 총 열의 수를 가져옵니다.
				if (rowCount <= 2) {
					throw new Exception("Read 할 데이터가 엑셀에 존재하지 않습니다.");
				}
				data = new String[rowCount][colCount];
				// 엑셀데이터를 배열에 저장
				for (int i = 0; i < rowCount; i++) {
					for (int k = 0; k < colCount; k++) {
						jxl.Cell cell = sheet.getCell(k, i); // 해당위치의 셀을 가져오는 부분입니다.
						if (cell == null)
							continue;
						data[i][k] = cell.getContents(); // 가져온 셀의 실제 콘텐츠 즉
						// 데이터(문자열)를 가져오는 부분입니다.
					}
				}

			} catch (Exception e) {
				System.out.println("CSVReader error : " + e.getMessage());
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File Format Exception<BR><BR>Excel(xls) 내용을 확인하세요");
				return resultMap;
			} finally {
				if (workbook != null)
					workbook.close();
			}*/

		} else if (targetType.equals("xlsx")) { // xlsx 업로드 data read

			org.apache.poi.ss.usermodel.Workbook workbook = null;
			org.apache.poi.ss.usermodel.Sheet sheet = null;
			org.apache.poi.ss.usermodel.Row row = null;
			org.apache.poi.ss.usermodel.Cell cell = null;

			try {
				workbook = org.apache.poi.ss.usermodel.WorkbookFactory.create(targetFile);
				org.apache.poi.ss.usermodel.FormulaEvaluator evaluator = workbook.getCreationHelper()
						.createFormulaEvaluator();
				sheet = workbook.getSheetAt(0);
				int rows = sheet.getLastRowNum() + 1;
				int cells = sheet.getRow(0).getLastCellNum();

				if (rows <= 2) {
					throw new Exception("Read 할 데이터가 엑셀에 존재하지 않습니다.");
				}

				data = new String[rows][cells];
				int idx = 0;
				for (Iterator all = sheet.iterator(); all.hasNext();) {
					org.apache.poi.ss.usermodel.Row ds = (org.apache.poi.ss.usermodel.Row) all.next();
					for (int i = 0; i < cells; i++) {
						if (ds.getCell(i) == null) {
							data[idx][i] = "";
						} else {
							cell = ds.getCell(i);
							switch (cell.getCellType()) {
							case 0: // Cell.CELL_TYPE_NUMERIC :
								if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
									data[idx][i] = cell.getDateCellValue().toString();
								} else {
									data[idx][i] = Integer.toString((int) cell.getNumericCellValue());
								}
								break;
							case 1: // Cell.CELL_TYPE_STRING :
								data[idx][i] = cell.getRichStringCellValue().getString();
								break;
							case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_BOOLEAN:
								data[idx][i] = cell.getBooleanCellValue() + "";
								break;
							case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_FORMULA:
								if (evaluator.evaluateFormulaCell(
										cell) == org.apache.poi.ss.usermodel.Cell.CELL_TYPE_NUMERIC) {
									if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
										data[idx][i] = "";
									} else {
										Double value = new Double(cell.getNumericCellValue());
										if ((double) value.longValue() == value.doubleValue()) {
											data[idx][i] = data[idx][i] = Long.toString(value.longValue());
										} else {
											data[idx][i] = data[idx][i] = value.toString();
										}
									}
								} else if (evaluator.evaluateFormulaCell(
										cell) == org.apache.poi.ss.usermodel.Cell.CELL_TYPE_STRING) {
									data[idx][i] = cell.getStringCellValue();
								} else if (evaluator.evaluateFormulaCell(
										cell) == org.apache.poi.ss.usermodel.Cell.CELL_TYPE_BOOLEAN) {
									data[idx][i] = new Boolean(cell.getBooleanCellValue()).toString();
								} else {
									data[idx][i] = cell.toString();
								}
								break;
							default:
							}
						}
					}
					idx++;
				}

			} catch (Exception e) {
				System.out.println("ExcelReadPoi error : " + e.getMessage());
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File Format Exception<BR><BR>Excel(xlsx) 내용을 확인하세요");
				return resultMap;
			}

		} else if (targetType.equals("txt")) { // txt 업로드 data read

			try {

				FileInputStream txtFile = new FileInputStream(targetFile);
				InputStreamReader readFile = new InputStreamReader(txtFile, "UTF-8");
				BufferedReader bufferFile = new BufferedReader(readFile);

				String bufferStr = "";
				String[] splitStr = null;
				int rowCount = 0;
				int row = 0;

				// row,column count
				while ((bufferStr = bufferFile.readLine()) != null) {
					if (bufferStr != null) {
						splitStr = bufferStr.split(",");
						if (splitStr.length == 3) {
							rowCount++;
						}
					}
				}

				// upload data input
				txtFile = new FileInputStream(targetFile);
				readFile = new InputStreamReader(txtFile, "UTF-8");
				bufferFile = new BufferedReader(readFile);
				bufferStr = "";
				splitStr = null;
				data = new String[rowCount][3]; // save data 변수 선언...
				while ((bufferStr = bufferFile.readLine()) != null) {
					if (bufferStr != null) {
						splitStr = bufferStr.split(",");
						if (splitStr.length == 3) {
							data[row][0] = splitStr[0];
							data[row][1] = splitStr[1];
							data[row][2] = splitStr[2];
							row++;
						}
					}
				}

				for (int i = 0; i < rowCount; i++) {
					System.out.println("===> " + data[i][0] + " | " + data[i][1] + " | " + data[i][2]);
				}

				readFile.close();

			} catch (Exception e) {
				System.out.println("TXTReader error : " + e.getMessage());
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File Format Exception<BR><BR>Txt 내용을 확인하세요");
				return resultMap;
			}

		}

		// upload data save
		if (data != null && data.length >= 2) { // data 있는경우

			try {
				// 파일 read 내용으로 select insert
				Map<String, Object> dataMap = null;
				for (int i = 0; i < data.length; i++) {
					dataMap = new HashMap<String, Object>();
					dataMap.put("OFFICE_NM", data[i][0]); // 팀명
					dataMap.put("USER_NAME", data[i][1]); // 성명
					dataMap.put("TARGET_NAME", data[i][2]); // 호스트명

					dao.registTargetUserBySelect(dataMap);

					// User Log 남기기
					String user_no = SessionUtil.getSession("memberSession", "USER_NO");
					ServletUtil servletUtil = new ServletUtil(request);
					String clientIP = servletUtil.getIp();
					Map<String, Object> userLog = new HashMap<String, Object>();
					userLog.put("user_no", user_no);
					userLog.put("menu_name", "CHANGE PERSON IN CHARGE");
					userLog.put("user_ip", clientIP);
					userLog.put("logFlag", "4");

					userLog.put("job_info", "타겟담당자등록 - " + data[i][2] + "[" + data[i][1] + "]");

					userDao.insertLog(userLog);

				}
			} catch (Exception e) {
				System.out.println("uploade file save error : " + e.getMessage());
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File upload save false");
				return resultMap;
			}
		}

		/*
		 * 
		 * // 아래 견본품은 셀에 빈칸 존재시 에러발생. 위에 파일 유형별 구현해둠...
		 * 
		 * //HashMap<String, String> mapHeader = setExcelHeader("supplySample");
		 * ExcelSheetParser.Sender receiver = setReceiver(); ExcelSheetParser
		 * excelSheetParser = new ExcelSheetParser(targetFile, 4, receiver);
		 * 
		 * try { excelSheetParser.excute(); } catch (IOException | OpenXML4JException |
		 * ParserConfigurationException | SAXException e) { // TODO Auto-generated catch
		 * block e.printStackTrace(); }
		 */

		// JSONArray jsonArray = (JSONArray) readerMap.get("list");
		/**
		 * 여기서 jsonArray를 DAO를 태워서 Insert SQL 하면 됨....... 혹시 target 명을 엑셀에 담아주면 그걸 찾는
		 * 로직은 추가 필요
		 */
		/*
		 * for (int i = 0; i < jsonArray.size(); i++) { JSONObject jsonObject =
		 * jsonArray.getJSONObject(i);
		 * 
		 * // 엑셀의 컬럼 수가 네개가 아니면 오류.... if (jsonObject.size() != 4) {
		 * resultMap.put("resultCode", "-5"); resultMap.put("resultMessage",
		 * "File Format Exception<BR><BR>Excel 내용을 확인하세요"); return resultMap; } String
		 * Col1 = jsonObject.getString("1"); String Col2 = jsonObject.getString("2");
		 * String Col3 = jsonObject.getString("3"); String Col4 =
		 * jsonObject.getString("4");
		 * 
		 * logger.info("Col1 : " + Col1 + "Col2 : " + Col2 + "Col3 : " + Col3 +
		 * "Col4 : " + Col4); }
		 * 
		 * logger.info(jsonArray.toString()); resultMap.put("Data", jsonArray);
		 */
		resultMap.put("resultCode", "0");
		resultMap.put("resultMessage", "SUCCESS");

		return resultMap;

	}

	public ExcelSheetParser.Sender setReceiver() {
		ExcelSheetParser.Sender receiver = new ExcelSheetParser.Sender() {
			@Override
			public void onTerminated(JSONArray listData) {
				// setData(listData);

				readerMap.put("list", listData);
			}
		};

		return receiver;
	}

	public Map<String, Object> validUploadFile(HttpServletRequest request) { // excel 헤더 컬럼 담기.

		Map<String, Object> resultMap = new HashMap<String, Object>();

		MultipartHttpServletRequest mpartReq = null;
		mpartReq = (MultipartHttpServletRequest) request;

		Iterator<String> iter = mpartReq.getFileNames();
		MultipartFile mpartFile = null;

		if (!iter.hasNext()) {
			resultMap.put("resultCode", "-9");
			resultMap.put("resultMessage", "File Not Found");
			return resultMap;
		}

		String fileName = iter.next(); // 내용을 가져와서
		if ("".equals(fileName)) {
			resultMap.put("resultCode", "-8");
			resultMap.put("resultMessage", "File Name Not Found");
			return resultMap;
		}

		mpartFile = mpartReq.getFile(fileName);
		String orgFileName = null;
		try {
			orgFileName = new String(mpartFile.getOriginalFilename().getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			resultMap.put("resultCode", "-8");
			resultMap.put("resultMessage", "File Name UnsupportedEncodingException");
			return resultMap;
		}

		// 확장자
		String ext = orgFileName.substring(orgFileName.lastIndexOf('.'));
		// if ((!ext.equalsIgnoreCase(".xls")) && (!ext.equalsIgnoreCase(".xlsx"))){
		// if ((!ext.equalsIgnoreCase(".xls")) && (!ext.equalsIgnoreCase(".xlsx")) &&
		// (!ext.equalsIgnoreCase(".csv"))){
		if (!ext.equalsIgnoreCase(".txt")) {
			// 첨부 파일이 TXT 아니면....
			resultMap.put("resultCode", "-7");
			resultMap.put("resultMessage", "Not TXT File");
			return resultMap;
		}

		String targetFileName = null;
		try {
			targetFileName = DataUtil.makeEncFileName();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put("resultCode", "-6");
			resultMap.put("resultMessage", "File Encription Fail");
			return resultMap;
		}
		targetFileName = targetFileName + ext;
		// String saveAttchPath = "./upload";

		// 디레토리가 없다면 생성
		File saveDir = new File(saveAttchPath);
		if (!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}

		// 설정한 path에 파일저장
		File targetFile = new File(saveAttchPath + File.separator + targetFileName);
		try {
			mpartFile.transferTo(targetFile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put("resultCode", "-5");
			resultMap.put("resultMessage", "File Move Fail");
			return resultMap;
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put("resultCode", "-5");
			resultMap.put("resultMessage", "File Move Fail");
			return resultMap;
		}

		logger.info(saveAttchPath + File.separator + targetFileName);
		resultMap.put("resultCode", "0");
		resultMap.put("FilePath", saveAttchPath + File.separator + targetFileName);
		resultMap.put("resultMessage", "Upload File Valid");
		return resultMap;
	}

	// DMZ List 조회
	@Override
	public List<Map<String, Object>> selectDmzList(HashMap<String, Object> params, HttpServletRequest request)
			throws Exception {
		// SCH_DMZ_IP & SCH_MEMO
		String sch_dmz_ip = request.getParameter("SCH_DMZ_IP");
		String sch_memo = request.getParameter("SCH_MEMO");

		if (sch_dmz_ip != null && !"".equals(sch_dmz_ip)) {
			logger.info("DMZ :: " + sch_dmz_ip);
			params.put("SCH_DMZ_IP", sch_dmz_ip);
		}
		if (sch_memo != null && !"".equals(sch_memo)) {
			logger.info("MEMO :: " + sch_memo);
			params.put("SCH_MEMO", sch_memo);
		}

		return dao.selectDmzList(params);
	}

	// DMZ Info Save
	@Transactional
	public void saveDmzInfo(HashMap<String, Object> params) throws Exception {
		String[] ipArr = ((String) params.get("DMZ_IP")).split("\\.");

		if (ipArr[2].equals("*") && ipArr[3].equals("*")) { // ip C,D Class *.*
			String dmzIpAB = ipArr[0] + "." + ipArr[1] + ".";
			for (int i = 0; i <= 255; i++) {
				System.out.println("===C,D Class==> " + dmzIpAB + i + ".");
				params.put("DMZ_IP", dmzIpAB + i + ".");
				dao.saveDmzInfoAstr(params);
			}
		} else if (ipArr[3].equals("*")) { // ip D Class *
			String dmzIpABC = ipArr[0] + "." + ipArr[1] + "." + ipArr[2] + ".";
			params.put("DMZ_IP", dmzIpABC);
			dao.saveDmzInfoAstr(params);
		} else { // ip 단일 입력 경우
			dao.saveDmzInfo(params);
		}

		System.out.println("종~료");
	}

	// DMZ List Delete
	public void deleteDmzList(HashMap<String, Object> params) throws Exception {
		dao.deleteDmzList(params);
	}

	@Override
	public HashMap<String, Object> selectTargetById(HashMap<String, Object> params) throws Exception {
		return dao.selectTargetById(params);
	}

	@Override
	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception {
		return dao.selectGroupList(map);
	}

	@Override
	public List<Map<String, Object>> selectUserGroupList(Map<String, Object> map) throws Exception {
		return dao.selectUserGroupList(map);
	}

	/*@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		return dao.selectNoticeList(map);
	}
*/
	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> noticeList = dao.selectNoticeList(map);
		List<Map<String, Object>> resultList = new ArrayList<>();	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		for(int i=0 ; i < noticeList.size() ; i++) {
			resultMap = new HashMap<String, Object>();
			String noticeID = noticeList.get(i).get("NOTICE_ID").toString();
			String regdate = noticeList.get(i).get("REGDATE").toString();
			String noticeTitle = noticeList.get(i).get("NOTICE_TITLE").toString();
			noticeTitle = replaceParameter(noticeTitle);
			
			resultMap.put("NOTICE_ID", noticeID);
			resultMap.put("REGDATE", regdate);
			resultMap.put("NOTICE_TITLE", noticeTitle);
			
			resultList.add(resultMap);
		}
		return resultList;
	}
	
	@Override
	public List<Map<String, Object>> getTargetList(Map<String, Object> map) throws Exception {
		return dao.getTargetList(map);
	}

	@Override
	public Map<String, Object> getGroupDetails(Map<String, Object> map) throws Exception {
		return dao.getGroupDetails(map);
	}

	@Override
	public void updateGroupDetails(Map<String, Object> map) throws Exception {
		dao.updateGroupDetails(map);
	}

	@Override
	public void addNewGroup(HttpServletRequest request, Map<String, Object> map) throws Exception {
		dao.addNewGroup(map);

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "ADD TARGET GROUP");
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "5");

		userLog.put("job_info", "그룹등록 - " + map.get("name"));

		userDao.insertLog(userLog);
	}

	@Override
	public void deleteGroup(HttpServletRequest request, Map<String, Object> map) throws Exception {
		dao.deleteGroup(map);

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "DELETE TARGET GROUP");
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "5");

		userLog.put("job_info", "그룹삭제 - " + request.getParameter("name"));

		userDao.insertLog(userLog);
	}

	@Override
	public void deleteGroupIdx_target(HttpServletRequest request, Map<String, Object> map) throws Exception {
		dao.deleteGroupIdx_target(map);
	}

	@Override
	public void pushTargetToGroup(HttpServletRequest request, Map<String, Object> map) throws Exception {
		dao.pushTargetToGroup(map);

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "MANAGE TARGET GROUP");
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "5");

		if (map.get("idx") == null || "".equals(map.get("idx"))) {
			userLog.put("job_info", "그룹 내 타겟 해제 - " + request.getParameter("name"));
		} else {
			userLog.put("job_info", "그룹 내 타겟 추가 - " + request.getParameter("name"));
		}

		userDao.insertLog(userLog);
	}

	// Timestamp time
	private StringBuffer getMenuTreeString(String time) throws Exception {
		StringBuffer menuString = new StringBuffer(2048);
		String[] sel_menu_id = null;
		String menu_id = ""; // 조직코드
		String menu_nm = ""; // 조직명
		String[] menu_type = null; // 조직Type

		long menu_level = 0; // 조직Level이 아닌 조회된 계층의 Level

		int div_cnt = 0; // <div> Tag Count

		String javascript_1 = "";
		String javascript_2 = "";
		String javascript_3 = "expandsub('1'); \r";
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	@Override
	public List<Map<String, Object>> selectServerTargetUser(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String target_id = request.getParameter("target_id");
		String ap_no = request.getParameter("ap_no");
		

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id", target_id);
		searchMap.put("ap_no", ap_no);
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);

		logger.info(searchMap.toString());
		return dao.selectServerTargetUser(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectPCTargetUserName(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String id = request.getParameter("id");
		String parent = request.getParameter("parent");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("id", id);
		searchMap.put("parent", parent);
		
		return dao.selectPCTargetUserName(searchMap);
	}
	@Override
	public List<Map<String, Object>> selectPCTargetUser(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String target_id = request.getParameter("target_id");
		String test = request.getParameter("test");
		String ap_no = request.getParameter("ap_no");
		String id = request.getParameter("id");
		String node = request.getParameter("node");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id", target_id);
		searchMap.put("ap_no", ap_no);
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("node", node);
		searchMap.put("id", id);
		
		logger.info(searchMap.toString());
		return dao.selectPCTargetUser(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectPCTargetUserData(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String id = request.getParameter("id");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("id", id);
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		
		logger.info(searchMap.toString());
		return dao.selectPCTargetUserData(searchMap);
	}

	// 검색
	@Override
	public List<Map<String, Object>> searchServerTargetUser(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String groupNm = request.getParameter("groupNm");
		String hostNm = request.getParameter("hostNm");
		String serviceNm = request.getParameter("serviceNm");
		String userIP = request.getParameter("userIP");
		String infraUser = request.getParameter("infraUser");
		String serviceUser = request.getParameter("serviceUser");
		String serviceManager = request.getParameter("serviceManager");
		String id = request.getParameter("id");
		String name = request.getParameter("name");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("groupNm", groupNm);
		searchMap.put("hostNm", hostNm);
		searchMap.put("serviceNm", serviceNm);
		searchMap.put("userIP", userIP);
		searchMap.put("infraUser", infraUser);
		searchMap.put("serviceUser", serviceUser);
		searchMap.put("serviceManager", serviceManager);
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("id", id);
		searchMap.put("name", name);

		logger.info(searchMap.toString());
		return dao.selectServerTargetUser(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> searchPCTargetUser(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String groupNm = request.getParameter("groupNm");
		String hostNm = request.getParameter("hostNm");
		String serviceNm = request.getParameter("serviceNm");
		String userIP = request.getParameter("userIP");
		String id = request.getParameter("id");
		String target_id = request.getParameter("target_id");
		String name = request.getParameter("name");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("groupNm", groupNm);
		searchMap.put("hostNm", hostNm);
		searchMap.put("serviceNm", serviceNm);
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("userIP", userIP);
		searchMap.put("id", id);
		searchMap.put("target_id", target_id);
		searchMap.put("name", name);

		logger.info(searchMap.toString());
		return dao.selectPCTargetUser(searchMap);
	}

	@Override
	public List<Map<String, Object>> getExceptionList(HttpServletRequest request) throws Exception {
		return dao.getExceptionList();
	}
	
	@Override
	public List<Map<String, Object>> exceptionSearchList(HttpServletRequest request) {
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("net", request.getParameter("net"));
			map.put("group", request.getParameter("group"));
			map.put("host", request.getParameter("host"));
			map.put("service", request.getParameter("service"));
			map.put("req", request.getParameter("req"));
			map.put("reg", request.getParameter("reg"));
			map.put("path", request.getParameter("path"));
			map.put("exception_content", request.getParameter("exception_content"));
			logger.info("map :: " + map);
			resultList = dao.exceptionSearchList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	
	@Override
	public List<Map<String, Object>> selectSKTManagerList(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String user_no = request.getParameter("user_no");
		String user_name = request.getParameter("user_name");
		String team_name = request.getParameter("team_name");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("user_name", user_name);
		map.put("team_name", team_name);

		return dao.selectSKTManagerList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectAddSKTManagerList(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String user_name = request.getParameter("user_name");
		String team_name = request.getParameter("team_name");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_name", user_name);
		map.put("team_name", team_name);

		return dao.selectAddSKTManagerList(map);
	}
	
	@Override
	public Map<String, Object> insertSKTManager(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		// 사용자의 담당팀 중복 체크
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap = dao.selectChkSKTManager(map);
		
		try {
			if ((userMap == null) || (userMap.size() == 0)) {
				// 해당 중간관리자의 담당 그룹 상위 체크 리스트
				List<Map<String, Object>> upGroupList = dao.selectUpGroupUser(map);
				
				// 해당 팀에 소속되어있는 모든 PC 중간관리자 부여
				List<Map<String, Object>> groupUserList = dao.selectGroupUser(map);
				if(upGroupList.size() < 1) {	// 해당 상위 그룹이 없음
					// 해당 중간 관리자의 담당 그룹 하위 체크 리스트
					List<Map<String, Object>> downGroupList = dao.selectDownGroupUser(map);
					Map<String, Object> groupMap = new HashMap<String, Object>();
					
					// 하위 그룹 사용 안함으로 변경
					for(int i=0 ; i < downGroupList.size() ; i++) {
						
						String downInsaCode = downGroupList.get(i).get("ID").toString();
						String downUserNo = downGroupList.get(i).get("USER_NO").toString();
						
						groupMap.put("INSA_CODE", downInsaCode);
	            		groupMap.put("USER_NO", downUserNo);
	            		groupMap.put("ENABLE", "N");
	            		
	            		dao.insertSKTManager(groupMap);
					}
					
					map.put("ENABLE", "Y");
					dao.insertSKTManager(map);
				} else {						// 상위 그룹이 존재
					map.put("ENABLE", "N");
					dao.insertSKTManager(map);
				}
				
				for(int i=0 ; i < groupUserList.size() ; i++) {
					Map<String, Object> groupUserMap = new HashMap<String, Object>();
					
					String groupUserInsaCode = map.get("INSA_CODE").toString();
					String groupUserNo = map.get("USER_NO").toString();
					String ap = groupUserList.get(i).get("AP_NO").toString();
					String target_id = groupUserList.get(i).get("TARGET_ID").toString();
					
					groupUserMap.put("INSA_CODE", groupUserInsaCode);
					groupUserMap.put("USER_NO", groupUserNo);
					groupUserMap.put("AP_NO", ap);
					groupUserMap.put("TARGET_ID", target_id);
					
					dao.insertSKTManagerUser(groupUserMap);
				}
				
				resultMap.put("resultCode", 0);
				resultMap.put("resultMeassage", "중간관리자 지정 성공");
			}else {
				resultMap.put("resultCode", -2);
				resultMap.put("resultMeassage", map.get("USER_NAME").toString() + "님은 이미 " + map.get("TEAM_NAME").toString() + "의 중간관리자 입니다.");
				
			}
			// dao.insertSKTManager(map);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resultMap.put("resultCode", -1);
			resultMap.put("resultMeassage", "중간관리자 지정 실패");
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> deleteSKTManager(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		// TODO Auto-generated method stub
		try {
			dao.deleteSKTManager(map);
			dao.deleteSKTManagerUser(map);
		}catch (Exception e) {
			// TODO: handle exception
			resultMap.put("resultCode", -1);
			resultMap.put("resultMeassage", "중간관리자 삭제 실패");
		}
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMeassage", "중간관리자 삭제 성공");
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> insertSKTManagerList(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		String resulList = request.getParameter("resulList");
		JSONArray jsonarry = JSONArray.fromObject(resulList);
		
		int chk = 0;
		try {
			// resultList를 담을 map
			Map<String, Object> map = new HashMap<String, Object>();
			// 사용자의 담당팀 중복 체크
			Map<String, Object> userMap = new HashMap<String, Object>();
			
			for(int i=0; i < jsonarry.size(); i++) {
				JSONObject jsonObject = (JSONObject) jsonarry.get(i);
				
				String user_no = jsonObject.getString("user_no");
				String insa_code = jsonObject.getString("insa_code");
				
				map.put("USER_NO", user_no);
				map.put("INSA_CODE", insa_code);
				
				userMap = dao.selectChkSKTManager(map);
				
				if ((userMap == null) || (userMap.size() == 0)) {
					// 해당 중간관리자의 담당 그룹 상위 체크 리스트
					List<Map<String, Object>> upGroupList = dao.selectUpGroupUser(map);
					
					// 해당 팀에 소속되어있는 모든 PC 중간관리자 부여
					List<Map<String, Object>> groupUserList = dao.selectGroupUser(map);
					if(upGroupList.size() < 1) {	// 해당 상위 그룹이 없음
						// 해당 중간 관리자의 담당 그룹 하위 체크 리스트
						List<Map<String, Object>> downGroupList = dao.selectDownGroupUser(map);
						Map<String, Object> groupMap = new HashMap<String, Object>();
						
						// 하위 그룹 사용 안함으로 변경
						for(int j=0 ; j < downGroupList.size() ; j++) {
							
							String downInsaCode = downGroupList.get(j).get("ID").toString();
							String downUserNo = downGroupList.get(j).get("USER_NO").toString();
							
							groupMap.put("INSA_CODE", downInsaCode);
		            		groupMap.put("USER_NO", downUserNo);
		            		groupMap.put("ENABLE", "N");
		            		
		            		dao.insertSKTManager(groupMap);
						}
						
						map.put("ENABLE", "Y");
						dao.insertSKTManager(map);
					} else {						// 상위 그룹이 존재
						map.put("ENABLE", "N");
						dao.insertSKTManager(map);
					}
					
					for(int j=0 ; j < groupUserList.size() ; j++) {
						Map<String, Object> groupUserMap = new HashMap<String, Object>();
						
						String groupUserInsaCode = map.get("INSA_CODE").toString();
						String groupUserNo = map.get("USER_NO").toString();
						String ap = groupUserList.get(j).get("AP_NO").toString();
						String target_id = groupUserList.get(j).get("TARGET_ID").toString();
						
						groupUserMap.put("INSA_CODE", groupUserInsaCode);
						groupUserMap.put("USER_NO", groupUserNo);
						groupUserMap.put("AP_NO", ap);
						groupUserMap.put("TARGET_ID", target_id);
						
						dao.insertSKTManagerUser(groupUserMap);
					}
					
					resultMap.put("resultCode", 0);
					resultMap.put("resultMeassage", "중간관리자 지정 성공");
				}else {
					++chk;
					/*resultMap.put("resultCode", -2);
					resultMap.put("resultMeassage", map.get("USER_NAME").toString() + "님은 이미 " + map.get("TEAM_NAME").toString() + "의 중간관리자 입니다.");*/
				}
			}
			resultMap.put("resultMapSize", jsonarry.size());
			resultMap.put("resultValue", chk);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> updateSKTManagerGrade(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			dao.updateSKTManagerGrade(map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> selectPcManagerList(HttpServletRequest request) throws Exception {
		return dao.selectPCManagerList();
	}

	@Override
	public List<Map<String, Object>> selectVersionList(HttpServletRequest request) throws Exception {
		return dao.selectVersionList();
	}
	
	private String replaceParameter(String param) {
		String result = param;
		if(param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}
	      
	return result;
	}

	@Override
	public List<Map<String, Object>> apServerList(HttpServletRequest request) throws Exception {
		return dao.apServerList();
	}
	
	@Override
	public List<Map<String, Object>> selectMngrList(HttpServletRequest request) {
		
		List<Map<String, Object>> resulList = new ArrayList<>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		/*String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");*/
		String target_id = request.getParameter("target_id");
		String ap_no = request.getParameter("ap_no");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target_id", target_id);
		map.put("ap_no", ap_no);
		logger.info(map.toString());
		
		List<Map<String, Object>> targetMngrList = dao.selectMngrList(map);
		
		if(targetMngrList.size() > 0) {
			String SERVICE_MNGR3_NO = (String) targetMngrList.get(0).get("SERVICE_MNGR3_NO");
			String SERVICE_MNGR3_NM = (String) targetMngrList.get(0).get("SERVICE_MNGR3_NM");
			String SERVICE_MNGR3_TEAM = (String) targetMngrList.get(0).get("SERVICE_MNGR3_TEAM");
			
			map.put("NUM", "3");
			map.put("USER_NO", SERVICE_MNGR3_NO);
			map.put("USER_NAME", SERVICE_MNGR3_NM);
			map.put("USER_SOSOK", SERVICE_MNGR3_TEAM);
			resulList.add(map);
			
			String SERVICE_MNGR4_NO = (String) targetMngrList.get(0).get("SERVICE_MNGR4_NO");
			String SERVICE_MNGR4_NM = (String) targetMngrList.get(0).get("SERVICE_MNGR4_NM");
			String SERVICE_MNGR4_TEAM = (String) targetMngrList.get(0).get("SERVICE_MNGR4_TEAM");
			
			map = new HashMap<String, Object>();
			map.put("NUM", "4");
			map.put("USER_NO", SERVICE_MNGR4_NO);
			map.put("USER_NAME", SERVICE_MNGR4_NM);
			map.put("USER_SOSOK", SERVICE_MNGR4_TEAM);
			resulList.add(map);
			
			String SERVICE_MNGR5_NO = (String) targetMngrList.get(0).get("SERVICE_MNGR5_NO");
			String SERVICE_MNGR5_NM = (String) targetMngrList.get(0).get("SERVICE_MNGR5_NM");
			String SERVICE_MNGR5_TEAM = (String) targetMngrList.get(0).get("SERVICE_MNGR5_TEAM");
			
			map = new HashMap<String, Object>();
			map.put("NUM", "5");
			map.put("USER_NO", SERVICE_MNGR5_NO);
			map.put("USER_NAME", SERVICE_MNGR5_NM);
			map.put("USER_SOSOK", SERVICE_MNGR5_TEAM);
			resulList.add(map);
			
		}else {
			for(int i=3 ; i < 6 ; i++) {
				map = new HashMap<String, Object>();
				map.put("NUM", i);
				map.put("USER_NO", null);
				map.put("USER_NAME", null);
				map.put("USER_SOSOK", null);
				resulList.add(map);
			}
		}
		return resulList;
	}

	@Override
	public List<Map<String, Object>> selectInaccessibleList(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String host_name = request.getParameter("host_name");
		String path = request.getParameter("path");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("host_name", host_name);
		map.put("path", path);

		return dao.selectInaccessibleList(map);
	}
	
	@Override
	public void updateChkStatus(HashMap<String, Object> params) throws Exception {
		
		logger.info("regResultList ::: " + params.get("regResultList"));
		logger.info("chkResultList ::: " + params.get("chkResultList"));
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		Map<String, Object> map = new HashMap<String,Object>();
		
//		등록 check List
		List<HashMap<String, String>> regResultList = (List<HashMap<String, String>>)params.get("regResultList");
		
//		확인 check List
		List<HashMap<String, String>> chkResultList = (List<HashMap<String, String>>)params.get("chkResultList");
		
		
		// 등록
		for (HashMap<String, String> rmap : regResultList) {
			
			logger.info("==================");
			logger.info( rmap.get("ap_no").getClass().getName());
			try {
			String target_id = rmap.get("target_id");
			String agent_id = rmap.get("agent_id");
			String path = rmap.get("path");
//			int ap_no = rmap.get("ap_no");
			int ap_no = Integer.parseInt(rmap.get("ap_no"));
			
			
			map = new HashMap<String,Object>();
			
			String location_id = null;
			
				
				Properties properties = new Properties();
				String resource = "/property/config.properties";
				Reader reader = Resources.getResourceAsReader(resource);
				properties.load(reader);
				
				this.recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
				this.recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
				this.recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
				this.api_ver = properties.getProperty("recon.api.version");
				
				if(rmap.get("rowStatus").equals("Y")) { // 신규 등록
					
					JSONObject jObject = new JSONObject();
					jObject.put("protocol", "mount");
					jObject.put("proxy_id", agent_id);
					jObject.put("path", path);
					
					String data = jObject.toString();
					
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/"+ this.api_ver + "/targets/"+target_id+"/locations", "POST", data);
					
					String HttpsResponseDataMessage = "";
					try {
						HttpsResponseDataMessage = httpsResponse.get("HttpsResponseDataMessage").toString();
					}catch (NullPointerException e) {
						logger.error(e.toString());
					}
					logger.info("HttpsResponseDataMessage : " + HttpsResponseDataMessage);
					
					int resultCode = Integer.parseInt(httpsResponse.get("HttpsResponseCode").toString());
					logger.info("resultCode : " + resultCode);
					
					if(resultCode == 201) {
						
						JSONObject resultObject = JSONObject.fromObject(HttpsResponseDataMessage);
						logger.info("getMatchObjects jsonObject : " + resultObject);
						
						location_id = resultObject.get("id").toString();
						
						map.put("location_id", location_id);
						map.put("path", path);
						map.put("target_id", target_id);
						map.put("agent_id", agent_id);
						map.put("reg_status", "Y");
						map.put("chk_status", "Y");
					}
				}else { // 삭제
					
					location_id = rmap.get("location_id");
					
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/"+ this.api_ver + "/targets/"+target_id+"/locations/" + location_id, "DELETE", null);
					
					int resultCode = Integer.parseInt(httpsResponse.get("HttpsResponseCode").toString());
					logger.info("resultCode : " + resultCode);
					
					if(resultCode == 204) {
						map.put("location_id", location_id);
						map.put("path", path);
						map.put("target_id", target_id);
						map.put("agent_id", agent_id);
						map.put("reg_status", "N");
					}
				}
				if(map.size() > 0)	dao.updateChkStatus(map);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		// 확인 여부
		for (HashMap<String, String> cmap : chkResultList) {
			
			String target_id = cmap.get("target_id");
			String agent_id = cmap.get("agent_id");
			String path = cmap.get("path");
			String status = cmap.get("rowStatus");
			int ap_no = Integer.parseInt(cmap.get("ap_no"));
			
			try {
				
				map = new HashMap<String,Object>();
				map.put("path", path);
				map.put("target_id", target_id);
				map.put("agent_id", agent_id);
				map.put("chk_status", status);
				if(map.size() > 0)	dao.updateChkStatus(map);
				
			} catch (Exception e) {
				e.printStackTrace();
				
				map = new HashMap<String,Object>();
				map.put("path", path);
				map.put("target_id", target_id);
				map.put("agent_id", agent_id);
				map.put("chk_status", status.equals("Y") ? "N" : "Y");
				if(map.size() > 0)	dao.updateChkStatus(map);
			}

		}
		
//		String id = request.getParameter("id");
//		String path = request.getParameter("path");
//		String value = request.getParameter("value");
//		
		
//		map.put("id", id);
//		map.put("path", path);
//		map.put("value", value);
		
//		dao.updateChkStatus(map);
	}
}

